From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Mon, 8 Jun 2009 00:04:57 +0200
Message-ID: <c77435a80906071504u16a46e03w6dfde9a3e694a5ec@mail.gmail.com>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
	 <alpine.LFD.2.00.0906051224510.3906@xanadu.home>
	 <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
	 <alpine.LFD.2.00.0906071225060.3906@xanadu.home>
	 <c77435a80906070947u9bf8ce9m9d59f86e5a5f18ab@mail.gmail.com>
	 <c77435a80906071155g5530ccdel286907b7c6022838@mail.gmail.com>
	 <alpine.LFD.2.00.0906071637530.3906@xanadu.home>
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
X-From: git-owner@vger.kernel.org Mon Jun 08 00:05:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQUF-0002iD-8Q
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 00:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbZFGWE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 18:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755645AbZFGWE7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 18:04:59 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:49827 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147AbZFGWE6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 18:04:58 -0400
Received: by ewy6 with SMTP id 6so3686357ewy.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ikPmkzn+3lOxdDS512I4g7IGCYPe7Dzjdc86/Jnugxg=;
        b=Uup5jLq6DODL9LL32kr3J2o8tIjwUQk7cMovNCDbvPkf5oKojma9CX1NF2+LM1vtz0
         mRmKD1TW+J/BIMXZl7PPGxQ/Xdu3oTsRt0nRLnRkfK7bfrIgZ840s1OjGMdxZmgIjLg1
         RD24C5/ERLtttEmbP2YaQqh0eSJyq5zGmTZvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QVD7NiRMs+VjlWpjdD87vvIduwffd8rjZ4nSV4h6jWApyFkDGVTwY/SBCXklbyoPii
         HxHyDPbhu2YoPwkyAM1ZVJtzyie+2QYK1+OfhlXB4eEDg0TOJdvF8wwRhWT3XD/P7VwP
         nqtuQ2Sl9xfjtX2FkZp/kCD00Ln9d80Ik+ljo=
Received: by 10.216.29.213 with SMTP id i63mr2086138wea.90.1244412297684; Sun, 
	07 Jun 2009 15:04:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0906071637530.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121013>

man I can sure be blind at times...  alright fixed the latter two
comments.  I changed the test file because that particular test wanted
upload-pack to fail through the revision walker, which it could only
now do if shallow objects were involved.

@sam: oops, sorry about that.

=46rom: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH] Shift object enumeration out of upload-pack

Offload object enumeration in upload-pack to pack-objects, but fall
back on internal revision walker for shallow interaction.  Test t5530
updated to reflect mechanism change.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
 t/t5530-upload-pack-error.sh |    2 +-
 upload-pack.c                |   49 +++++++++++++++++++++++++++++++++-=
-------
 2 files changed, 40 insertions(+), 11 deletions(-)

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
@@ -107,8 +108,6 @@ static int do_rev_list(int fd, void *create_full_pa=
ck)
 	struct rev_info revs;

 	pack_pipe =3D fdopen(fd, "w");
-	if (create_full_pack)
-		use_thin_pack =3D 0; /* no point doing it */
 	init_revisions(&revs, NULL);
 	revs.tag_objects =3D 1;
 	revs.tree_objects =3D 1;
@@ -155,13 +154,21 @@ static void create_pack_file(void)
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
+		if (create_full_pack)
+			argv[arg++] =3D "--all";
+		else if (use_thin_pack)
+			argv[arg++] =3D "--thin";
+	}

-	argv[arg++] =3D "pack-objects";
 	argv[arg++] =3D "--stdout";
 	if (!no_progress)
 		argv[arg++] =3D "--progress";
@@ -172,7 +179,7 @@ static void create_pack_file(void)
 	argv[arg++] =3D NULL;

 	memset(&pack_objects, 0, sizeof(pack_objects));
-	pack_objects.in =3D rev_list.out;	/* start_command closes it */
+	pack_objects.in =3D shallow_nr ? rev_list.out : -1;
 	pack_objects.out =3D -1;
 	pack_objects.err =3D -1;
 	pack_objects.git_cmd =3D 1;
@@ -181,6 +188,24 @@ static void create_pack_file(void)
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
 	int len, depth =3D 0;

+	shallow_nr =3D 0;
 	if (debug_fd)
 		write_in_full(debug_fd, "#S\n", 3);
 	for (;;) {
@@ -534,6 +560,7 @@ static void receive_needs(void)
 				packet_write(1, "shallow %s",
 						sha1_to_hex(object->sha1));
 				register_shallow(object->sha1);
+				shallow_nr++;
 			}
 			result =3D result->next;
 		}
@@ -567,6 +594,8 @@ static void receive_needs(void)
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


On Sun, Jun 7, 2009 at 10:48 PM, Nicolas Pitre<nico@cam.org> wrote:
> On Sun, 7 Jun 2009, Nick Edelen wrote:
>
>> how does this look?
>
> Comments below.
>
>> Signed-off-by: Nick Edelen <sirnot@gmail.com>
>>
>> ---
>> =A0t/t5530-upload-pack-error.sh | =A0 =A02 +-
>> =A0upload-pack.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 50 +++++++++++=
++++++++++++++++++++++--------
>> =A02 files changed, 41 insertions(+), 11 deletions(-)
>>
>> diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-erro=
r.sh
>> index f5102b9..26bcd1e 100755
>> --- a/t/t5530-upload-pack-error.sh
>> +++ b/t/t5530-upload-pack-error.sh
>> @@ -51,7 +51,7 @@ test_expect_success 'fsck fails' '
>> =A0test_expect_success 'upload-pack fails due to error in rev-list' =
'
>>
>> =A0 =A0 =A0 ! echo "0032want $(git rev-parse HEAD)
>> -00000009done
>> +0034shallow $(git rev-parse HEAD^)00000009done
>
> Why did you modify this?
>
>> =A00000" | git upload-pack . > /dev/null 2> output.err &&
>> =A0 =A0 =A0 grep "waitpid (async) failed" output.err
>> =A0'
>> diff --git a/upload-pack.c b/upload-pack.c
>> index edc7861..c8f2dca 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -29,6 +29,7 @@ static unsigned long oldest_have;
>> =A0static int multi_ack, nr_our_refs;
>> =A0static int use_thin_pack, use_ofs_delta, use_include_tag;
>> =A0static int no_progress;
>> +static int shallow_nr;
>> =A0static struct object_array have_obj;
>> =A0static struct object_array want_obj;
>> =A0static unsigned int timeout;
>> @@ -107,8 +108,6 @@ static int do_rev_list(int fd, void *create_full=
_pack)
>> =A0 =A0 =A0 struct rev_info revs;
>>
>> =A0 =A0 =A0 pack_pipe =3D fdopen(fd, "w");
>> - =A0 =A0 if (create_full_pack)
>> - =A0 =A0 =A0 =A0 =A0 =A0 use_thin_pack =3D 0; /* no point doing it =
*/
>> =A0 =A0 =A0 init_revisions(&revs, NULL);
>> =A0 =A0 =A0 revs.tag_objects =3D 1;
>> =A0 =A0 =A0 revs.tree_objects =3D 1;
>> @@ -155,13 +154,22 @@ static void create_pack_file(void)
>> =A0 =A0 =A0 const char *argv[10];
>> =A0 =A0 =A0 int arg =3D 0;
>>
>> - =A0 =A0 rev_list.proc =3D do_rev_list;
>> - =A0 =A0 /* .data is just a boolean: any non-NULL value will do */
>> - =A0 =A0 rev_list.data =3D create_full_pack ? &rev_list : NULL;
>
> I'm glad you got rid of that.
>
>> - =A0 =A0 if (start_async(&rev_list))
>> - =A0 =A0 =A0 =A0 =A0 =A0 die("git upload-pack: unable to fork git-r=
ev-list");
>> + =A0 =A0 if (shallow_nr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 rev_list.proc =3D do_rev_list;
>> + =A0 =A0 =A0 =A0 =A0 =A0 rev_list.data =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (start_async(&rev_list))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("git upload-pack: unab=
le to fork git-rev-list");
>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "pack-objects";
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "pack-objects";
>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "--revs";
>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "--include-tag";
>
> Why this unconditional --include-tags here? =A0Isn't it handled alrea=
dy a
> couple lines down already?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (create_full_pack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "--all";
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (use_thin_pack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "--thin";
>
> Please turn this "if (use_thin_pack)" into an "else if (use_thin_pack=
)"
> instead. =A0No point using --thin for a full pack.
>
> The rest looks fine to me.
>
>
> Nicolas
>
