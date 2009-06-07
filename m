From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Sun, 7 Jun 2009 20:55:48 +0200
Message-ID: <c77435a80906071155g5530ccdel286907b7c6022838@mail.gmail.com>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
	 <alpine.LFD.2.00.0906051224510.3906@xanadu.home>
	 <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
	 <alpine.LFD.2.00.0906071225060.3906@xanadu.home>
	 <c77435a80906070947u9bf8ce9m9d59f86e5a5f18ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sam@vilain.net, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 20:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDNXP-0001aj-A3
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 20:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbZFGSzt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 14:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbZFGSzs
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 14:55:48 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:63441 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbZFGSzr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 14:55:47 -0400
Received: by ewy6 with SMTP id 6so3597094ewy.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BOc1YF7DhYzG8DBaRxkHozHamRovr32FbI9qiWrUUv8=;
        b=sj4NT7NCcRHnnwk88E5DgnDOLOdrrPzwjs1XXeUNZeuQhvkayAAX3isX5eVuhFbvyW
         dIC1AytYc1hkVG1Cmb4dFAckbogMGqeUhgF8YCahVHP1l6D17RVqBgcHhe+w9KqjVunP
         8YWjCjiCUazZfKrvirT42J0tJMW3hZel0ssIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qH0543QGtitazoGAfTh/zVrEhJF0nodA4ETCBcnXHadLlaxt9QH4qDeoG85NhxZi/X
         yt+Kuj7fZ1uYA4+/AD0IeUndULgZaU73edOBP6Opt3SvbY2n7Lr7I5v5wYg1J17XCkdc
         osEwfWdELatDEcCjzInBzbe+2/RFg1DklM/Bo=
Received: by 10.216.20.210 with SMTP id p60mr2010416wep.172.1244400948482; 
	Sun, 07 Jun 2009 11:55:48 -0700 (PDT)
In-Reply-To: <c77435a80906070947u9bf8ce9m9d59f86e5a5f18ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120991>

how does this look?

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
 t/t5530-upload-pack-error.sh |    2 +-
 upload-pack.c                |   50 +++++++++++++++++++++++++++++++++-=
-------
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.s=
h
index f5102b9..26bcd1e 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -51,7 +51,7 @@ test_expect_success 'fsck fails' '
 test_expect_success 'upload-pack fails due to error in rev-list' '

 	! echo "0032want $(git rev-parse HEAD)
-00000009done
+0034shallow $(git rev-parse HEAD^)00000009done
 0000" | git upload-pack . > /dev/null 2> output.err &&
 	grep "waitpid (async) failed" output.err
 '
diff --git a/upload-pack.c b/upload-pack.c
index edc7861..c8f2dca 100644
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
@@ -107,8 +108,6 @@ static int do_rev_list(int fd, void *create_full_pa=
ck)
 	struct rev_info revs;

 	pack_pipe =3D fdopen(fd, "w");
-	if (create_full_pack)
-		use_thin_pack =3D 0; /* no point doing it */
 	init_revisions(&revs, NULL);
 	revs.tag_objects =3D 1;
 	revs.tree_objects =3D 1;
@@ -155,13 +154,22 @@ static void create_pack_file(void)
 	const char *argv[10];
 	int arg =3D 0;

-	rev_list.proc =3D do_rev_list;
-	/* .data is just a boolean: any non-NULL value will do */
-	rev_list.data =3D create_full_pack ? &rev_list : NULL;
-	if (start_async(&rev_list))
-		die("git upload-pack: unable to fork git-rev-list");
+	if (shallow_nr) {
+		rev_list.proc =3D do_rev_list;
+		rev_list.data =3D 0;
+		if (start_async(&rev_list))
+			die("git upload-pack: unable to fork git-rev-list");
+		argv[arg++] =3D "pack-objects";
+	} else {
+		argv[arg++] =3D "pack-objects";
+		argv[arg++] =3D "--revs";
+		argv[arg++] =3D "--include-tag";
+		if (create_full_pack)
+			argv[arg++] =3D "--all";
+		if (use_thin_pack)
+			argv[arg++] =3D "--thin";
+	}

-	argv[arg++] =3D "pack-objects";
 	argv[arg++] =3D "--stdout";
 	if (!no_progress)
 		argv[arg++] =3D "--progress";
@@ -172,7 +180,7 @@ static void create_pack_file(void)
 	argv[arg++] =3D NULL;

 	memset(&pack_objects, 0, sizeof(pack_objects));
-	pack_objects.in =3D rev_list.out;	/* start_command closes it */
+	pack_objects.in =3D shallow_nr ? rev_list.out : -1;
 	pack_objects.out =3D -1;
 	pack_objects.err =3D -1;
 	pack_objects.git_cmd =3D 1;
@@ -181,6 +189,24 @@ static void create_pack_file(void)
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");

+	/* pass on revisions we (don't) want */
+	if (!shallow_nr) {
+		FILE *pipe_fd =3D fdopen(pack_objects.in, "w");
+		if (!create_full_pack) {
+			int i;
+			for (i =3D 0; i < want_obj.nr; i++)
+				fprintf(pipe_fd, "%s\n", sha1_to_hex(want_obj.objects[i].item->sha=
1));
+			fprintf(pipe_fd, "--not\n");
+			for (i =3D 0; i < have_obj.nr; i++)
+				fprintf(pipe_fd, "%s\n", sha1_to_hex(have_obj.objects[i].item->sha=
1));
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
@@ -276,7 +302,7 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (finish_async(&rev_list))
+	if (shallow_nr && finish_async(&rev_list))
 		goto fail;	/* error was already reported */

 	/* flush the data */
@@ -451,6 +477,7 @@ static void receive_needs(void)
 	static char line[1000];
 	int len, depth =3D 0;

+	shallow_nr =3D 0;
 	if (debug_fd)
 		write_in_full(debug_fd, "#S\n", 3);
 	for (;;) {
@@ -534,6 +561,7 @@ static void receive_needs(void)
 				packet_write(1, "shallow %s",
 						sha1_to_hex(object->sha1));
 				register_shallow(object->sha1);
+				shallow_nr++;
 			}
 			result =3D result->next;
 		}
@@ -567,6 +595,8 @@ static void receive_needs(void)
 			for (i =3D 0; i < shallows.nr; i++)
 				register_shallow(shallows.objects[i].item->sha1);
 		}
+
+	shallow_nr +=3D shallows.nr;
 	free(shallows.objects);
 }

--=20
tg: (503f464..) t/revcache/upload-pack-dont-enumerate (depends on: mast=
er)


On Sun, Jun 7, 2009 at 6:47 PM, Nick Edelen<sirnot@gmail.com> wrote:
> crap, your right. =A0somehow I managed to miss that...
>
> I'll go ahead and seperate them then...
>
> On Sun, Jun 7, 2009 at 6:41 PM, Nicolas Pitre<nico@cam.org> wrote:
>> On Sun, 7 Jun 2009, Nick Edelen wrote:
>>
>>> I'm using the --revs flag in pack-objects, which causes it to use
>>> get_object_list(). =A0you'll notice, regardless of whether --thin i=
s
>>> set, this function still calls
>>> =A0 =A0 =A0 mark_edges_uninteresting(revs.commits, &revs, show_edge=
);
>>> which sets uninteresting objects as preferred bases, which I'd thin=
k
>>> would create a thin pack. =A0I could be wrong though...
>>
>> Look at the arguments passed to setup_revisions().
>> When --thin is set, the --objects-edge flag is passed instead of
>> --objects. =A0Now see what effect this has on the third argument of
>> mark_edges_uninteresting().
>>
>>> as I mentioned in the comment and above, it's an easy fix, but even
>>> then I wasn't sure what to do with commit grafts. =A0as use_thin_pa=
ck
>>> seemed to be predominantly set on shallow interactions, I just didn=
't
>>> bother seperating the cases 'normal but thick pack' and 'shallow
>>> stuff'.
>>
>> Please do separate them. =A0In theory you could use thin packs with =
a
>> relative deepening of a shallow clone. =A0In other words, !thin and
>> shallow is a wrong association to make.
>>
>>
>> Nicolas
>>
>
