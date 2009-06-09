From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH] Shift object enumeration out of upload-pack
Date: Wed, 10 Jun 2009 01:50:18 +0200
Message-ID: <c77435a80906091650j7709d006j64749c9692c25b29@mail.gmail.com>
References: <c77435a80906071834m1600d23dpb4a1b58c7a61361d@mail.gmail.com>
	 <7vvdn78n98.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, sam@vilain.net, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEB5O-0005DX-6o
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 01:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbZFIXuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 19:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755665AbZFIXuT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 19:50:19 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:44138 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbZFIXuR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 19:50:17 -0400
Received: by ewy6 with SMTP id 6so453601ewy.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 16:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kmj50rWpEVHCm575Tnh+fTa8lVcB+m3+u8QAgrLZcH8=;
        b=k2rHa0RIbYcTPV5EuNw7K7J0tq04rWGh8JRRtLTGBAtn0IvQ0gnbSlVN5k407Rf2Xq
         I2vIu1OB5R1PSpbuXXPDuz6lFREEJud0C6aQ7UbbwA7vxIFUbdVOvEHaYs5eC7EeWs5f
         JbZGI/0uKNaMg7OszWTJpn+8QfG+ICz8LNXvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w5j7hvduPVgUH6gOae/Ljc1BaFUlvMQvUEIqq5InsKECJSuki4Tddl3IltCehqCCwN
         gUzbHPvUTcfIEoRSB0gjcFpxe1IJFnNX6Z+4Zz5utyu5xbzX3E6ZTMdETt7tX1qwSyxe
         /hVV8hZ6Xyz70awQHuCW9W4aNU/zqH/PlQ1fc=
Received: by 10.216.18.199 with SMTP id l49mr265443wel.23.1244591418311; Tue, 
	09 Jun 2009 16:50:18 -0700 (PDT)
In-Reply-To: <7vvdn78n98.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121238>

Offload object enumeration in upload-pack to pack-objects, but fall
back on internal revision walker for shallow interaction.   Aside from
architecturally making more sense, this also leaves the door open for
pack-objects to employ a revision cache mechanism.  Test t5530 updated
in order to explicitly check both enumeration methods.

Signed-off-by: Nick Edelen <sirnot@gmail.com>
Acked-by: Nicolas Pitre <nico@cam.org>

---
 err, I guess you wanted me to resubmit this?

 t/t5530-upload-pack-error.sh |   14 ++++++++++-
 upload-pack.c                |   49 +++++++++++++++++++++++++++++++++--------
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index f5102b9..22eec24 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -30,11 +30,12 @@ test_expect_success 'fsck fails' '
 	test_must_fail git fsck
 '

-test_expect_success 'upload-pack fails due to error in pack-objects' '
+test_expect_success 'upload-pack fails due to error in pack-objects packing' '

 	! echo "0032want $(git rev-parse HEAD)
 00000009done
 0000" | git upload-pack . > /dev/null 2> output.err &&
+	grep "unable to read" output.err &&
 	grep "pack-objects died" output.err
 '

@@ -51,11 +52,20 @@ test_expect_success 'fsck fails' '
 test_expect_success 'upload-pack fails due to error in rev-list' '

 	! echo "0032want $(git rev-parse HEAD)
-00000009done
+0034shallow $(git rev-parse HEAD^)00000009done
 0000" | git upload-pack . > /dev/null 2> output.err &&
 	grep "waitpid (async) failed" output.err
 '

+test_expect_success 'upload-pack fails due to error in pack-objects
enumeration' '
+
+	! echo "0032want $(git rev-parse HEAD)
+00000009done
+0000" | git upload-pack . > /dev/null 2> output.err &&
+	grep "bad tree object" output.err &&
+	grep "pack-objects died" output.err
+'
+
 test_expect_success 'create empty repository' '

 	mkdir foo &&
diff --git a/upload-pack.c b/upload-pack.c
index edc7861..397cada 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -29,6 +29,7 @@ static unsigned long oldest_have;
 static int multi_ack, nr_our_refs;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress;
+static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout;
@@ -107,8 +108,6 @@ static int do_rev_list(int fd, void *create_full_pack)
 	struct rev_info revs;

 	pack_pipe = fdopen(fd, "w");
-	if (create_full_pack)
-		use_thin_pack = 0; /* no point doing it */
 	init_revisions(&revs, NULL);
 	revs.tag_objects = 1;
 	revs.tree_objects = 1;
@@ -155,13 +154,21 @@ static void create_pack_file(void)
 	const char *argv[10];
 	int arg = 0;

-	rev_list.proc = do_rev_list;
-	/* .data is just a boolean: any non-NULL value will do */
-	rev_list.data = create_full_pack ? &rev_list : NULL;
-	if (start_async(&rev_list))
-		die("git upload-pack: unable to fork git-rev-list");
+	if (shallow_nr) {
+		rev_list.proc = do_rev_list;
+		rev_list.data = 0;
+		if (start_async(&rev_list))
+			die("git upload-pack: unable to fork git-rev-list");
+		argv[arg++] = "pack-objects";
+	} else {
+		argv[arg++] = "pack-objects";
+		argv[arg++] = "--revs";
+		if (create_full_pack)
+			argv[arg++] = "--all";
+		else if (use_thin_pack)
+			argv[arg++] = "--thin";
+	}

-	argv[arg++] = "pack-objects";
 	argv[arg++] = "--stdout";
 	if (!no_progress)
 		argv[arg++] = "--progress";
@@ -172,7 +179,7 @@ static void create_pack_file(void)
 	argv[arg++] = NULL;

 	memset(&pack_objects, 0, sizeof(pack_objects));
-	pack_objects.in = rev_list.out;	/* start_command closes it */
+	pack_objects.in = shallow_nr ? rev_list.out : -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
 	pack_objects.git_cmd = 1;
@@ -181,6 +188,24 @@ static void create_pack_file(void)
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");

+	/* pass on revisions we (don't) want */
+	if (!shallow_nr) {
+		FILE *pipe_fd = fdopen(pack_objects.in, "w");
+		if (!create_full_pack) {
+			int i;
+			for (i = 0; i < want_obj.nr; i++)
+				fprintf(pipe_fd, "%s\n", sha1_to_hex(want_obj.objects[i].item->sha1));
+			fprintf(pipe_fd, "--not\n");
+			for (i = 0; i < have_obj.nr; i++)
+				fprintf(pipe_fd, "%s\n", sha1_to_hex(have_obj.objects[i].item->sha1));
+		}
+
+		fprintf(pipe_fd, "\n");
+		fflush(pipe_fd);
+		fclose(pipe_fd);
+	}
+
+
 	/* We read from pack_objects.err to capture stderr output for
 	 * progress bar, and pack_objects.out to capture the pack data.
 	 */
@@ -276,7 +301,7 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (finish_async(&rev_list))
+	if (shallow_nr && finish_async(&rev_list))
 		goto fail;	/* error was already reported */

 	/* flush the data */
@@ -451,6 +476,7 @@ static void receive_needs(void)
 	static char line[1000];
 	int len, depth = 0;

+	shallow_nr = 0;
 	if (debug_fd)
 		write_in_full(debug_fd, "#S\n", 3);
 	for (;;) {
@@ -534,6 +560,7 @@ static void receive_needs(void)
 				packet_write(1, "shallow %s",
 						sha1_to_hex(object->sha1));
 				register_shallow(object->sha1);
+				shallow_nr++;
 			}
 			result = result->next;
 		}
@@ -567,6 +594,8 @@ static void receive_needs(void)
 			for (i = 0; i < shallows.nr; i++)
 				register_shallow(shallows.objects[i].item->sha1);
 		}
+
+	shallow_nr += shallows.nr;
 	free(shallows.objects);
 }

-- 
tg: (503f464..) t/revcache/upload-pack-dont-enumerate (depends on: master)
