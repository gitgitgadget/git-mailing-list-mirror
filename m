From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/16] send-pack: support pushing to a shallow clone
Date: Sat, 20 Jul 2013 16:58:01 +0700
Message-ID: <1374314290-5976-8-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Tw8-0001QB-4N
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3GTJ6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:58:42 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48087 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3GTJ6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:58:41 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so11345816iet.37
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=a6AN+HU3e7kmAP5RJlxgYMGkpB7oGsfkRKU2OMMdpwc=;
        b=xGXnzvUJpE686XkwasBP+Dzk2tP+2PYxul/abtBXD/475V/upP3vSDr0IQ49HQVd4r
         vT8K6I4/E+vDAwDfpXFkmo9KFgw3JAOFhpkLikkfc2u4MzAa4jYFZOfJgxjJOPyKCUMS
         EVK1KVRplM8eUpaJEDEn/DaDI1dVRTvQ8fmOFEp7XKnJZ57pBLhO9XjB9m8knEvBLNc4
         31mT7kBm0ndlxWKpGSV/VTq0wjnrJ25oFvrcFcEecYus00TM/6HkEkCm34lK2ByoVOru
         aI3cTaNKs+KMpNNtIYQ4Ucwzxv2sre1dJubKpL2oW7SQccFCe6k1Hq6h01RYqSUu9okb
         8D3g==
X-Received: by 10.50.16.99 with SMTP id f3mr5397432igd.13.1374314320867;
        Sat, 20 Jul 2013 02:58:40 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id k14sm44190612igf.8.2013.07.20.02.58.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:58:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:58:59 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230884>

When send-pack receives "shallow" lines from receive-pack, it knows
the other end does not have a complete commit chains. It restrict
itself to the commits that are not cut out by either end to make sure
the result pack is usuable by receive-pack.

The same technique here, using setup_alternate_shallow() and
--shallow-file, might simplify similar code in upload-pack.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c     |  7 +++++--
 send-pack.c             | 37 ++++++++++++++++++++++++++++++++-----
 send-pack.h             |  4 +++-
 t/t5537-push-shallow.sh | 36 ++++++++++++++++++++++++++++++++++++
 transport.c             |  7 +++----
 5 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7dd254f..14a73ba 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -94,6 +94,7 @@ int cmd_send_pack(int argc, const char **argv, const =
char *prefix)
 	int fd[2];
 	struct child_process *conn;
 	struct extra_have_objects extra_have;
+	struct extra_have_objects shallow;
 	struct ref *remote_refs, *local_refs;
 	int ret;
 	int helper_status =3D 0;
@@ -209,8 +210,10 @@ int cmd_send_pack(int argc, const char **argv, con=
st char *prefix)
 	}
=20
 	memset(&extra_have, 0, sizeof(extra_have));
+	memset(&shallow, 0, sizeof(shallow));
=20
-	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_hav=
e, NULL);
+	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL,
+			 &extra_have, &shallow);
=20
 	transport_verify_remote_names(nr_refspecs, refspecs);
=20
@@ -230,7 +233,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 	set_ref_status_for_push(remote_refs, args.send_mirror,
 		args.force_update);
=20
-	ret =3D send_pack(&args, fd, conn, remote_refs, &extra_have);
+	ret =3D send_pack(&args, fd, conn, remote_refs, &extra_have, &shallow=
);
=20
 	if (helper_status)
 		print_helper_status(remote_refs);
diff --git a/send-pack.c b/send-pack.c
index dcd3345..1b828b0 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -27,14 +27,19 @@ static int feed_object(const unsigned char *sha1, i=
nt fd, int negative)
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
-static int pack_objects(int fd, struct ref *refs, struct extra_have_ob=
jects *extra, struct send_pack_args *args)
+static int pack_objects(int fd, struct ref *refs,
+			struct extra_have_objects *extra,
+			struct extra_have_objects *extra_shallow,
+			struct send_pack_args *args)
 {
 	/*
 	 * The child becomes pack-objects --revs; we feed
 	 * the revision parameters to it via its stdin and
 	 * let its stdout go back to the other end.
 	 */
-	const char *argv[] =3D {
+	const char *av[] =3D {
+		"--shallow-file",
+		NULL,
 		"pack-objects",
 		"--all-progress-implied",
 		"--revs",
@@ -45,10 +50,26 @@ static int pack_objects(int fd, struct ref *refs, s=
truct extra_have_objects *ext
 		NULL,
 		NULL,
 	};
+	const char **argv;
 	struct child_process po;
+	static struct lock_file shallow_lock;
+	const char *alternate_shallow_file =3D NULL;
 	int i;
=20
-	i =3D 4;
+	if (extra_shallow->nr) {
+		memset(&shallow_lock, 0, sizeof(shallow_lock));
+		/* just to load up .git/shallow if exists */
+		is_repository_shallow();
+		setup_alternate_shallow(&shallow_lock,
+					&alternate_shallow_file,
+					extra_shallow, 0);
+		av[1] =3D alternate_shallow_file;
+		argv =3D av;
+		i =3D 6;
+	} else {
+		argv =3D &av[2];
+		i =3D 4;
+	}
 	if (args->use_thin_pack)
 		argv[i++] =3D "--thin";
 	if (args->use_ofs_delta)
@@ -100,6 +121,10 @@ static int pack_objects(int fd, struct ref *refs, =
struct extra_have_objects *ext
=20
 	if (finish_command(&po))
 		return -1;
+
+	if (extra_shallow->nr)
+		rollback_lock_file(&shallow_lock);
+
 	return 0;
 }
=20
@@ -176,7 +201,8 @@ static int sideband_demux(int in, int out, void *da=
ta)
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
-	      struct extra_have_objects *extra_have)
+	      struct extra_have_objects *extra_have,
+	      struct extra_have_objects *extra_shallow)
 {
 	int in =3D fd[0];
 	int out =3D fd[1];
@@ -294,7 +320,8 @@ int send_pack(struct send_pack_args *args,
 	}
=20
 	if (new_refs && cmds_sent) {
-		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
+		if (pack_objects(out, remote_refs, extra_have, extra_shallow,
+				 args) < 0) {
 			for (ref =3D remote_refs; ref; ref =3D ref->next)
 				ref->status =3D REF_STATUS_NONE;
 			if (args->stateless_rpc)
diff --git a/send-pack.h b/send-pack.h
index 05d7ab1..1c8a343 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -16,6 +16,8 @@ struct send_pack_args {
=20
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
-	      struct ref *remote_refs, struct extra_have_objects *extra_have)=
;
+	      struct ref *remote_refs,
+	      struct extra_have_objects *extra_have,
+	      struct extra_have_objects *extra_shallow);
=20
 #endif
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index 37ad69b..beb85ce 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -71,4 +71,40 @@ EOF
 	test_cmp expect actual
 '
=20
+test_expect_success 'push from shallow to shallow' '
+	(
+	cd shallow &&
+	git push ../shallow2/.git +master:refs/remotes/shallow/master
+	) &&
+	(
+	cd shallow2 &&
+	git log --format=3D%s shallow/master >actual &&
+	git fsck &&
+	cat <<EOF >expect &&
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'push from full to shallow' '
+	! git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git hash-object=
 --stdin` &&
+	commit 1 &&
+	git push shallow2/.git +master:refs/remotes/top/master &&
+	(
+	cd shallow2 &&
+	git log --format=3D%s top/master >actual &&
+	git fsck &&
+	cat <<EOF >expect &&
+1
+4
+3
+EOF
+	test_cmp expect actual &&
+	git cat-file blob `echo 1|git hash-object --stdin` >/dev/null
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index f167ca5..d592e8d 100644
--- a/transport.c
+++ b/transport.c
@@ -802,11 +802,10 @@ static int git_transport_push(struct transport *t=
ransport, struct ref *remote_re
 		struct ref *tmp_refs;
 		connect_setup(transport, 1, 0);
=20
-		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL, NULL, =
NULL);
+		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
+				 NULL, &data->shallow);
 		data->got_remote_heads =3D 1;
 	}
-	if (data->shallow.nr)
-		die("pushing to a shallow repository is not supported");
=20
 	memset(&args, 0, sizeof(args));
 	args.send_mirror =3D !!(flags & TRANSPORT_PUSH_MIRROR);
@@ -819,7 +818,7 @@ static int git_transport_push(struct transport *tra=
nsport, struct ref *remote_re
 	args.porcelain =3D !!(flags & TRANSPORT_PUSH_PORCELAIN);
=20
 	ret =3D send_pack(&args, data->fd, data->conn, remote_refs,
-			&data->extra_have);
+			&data->extra_have, &data->shallow);
=20
 	close(data->fd[1]);
 	close(data->fd[0]);
--=20
1.8.2.83.gc99314b
