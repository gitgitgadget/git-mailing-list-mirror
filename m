From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] send-pack: support pushing to a shallow clone
Date: Wed, 17 Jul 2013 19:47:14 +0700
Message-ID: <1374065234-870-8-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 14:47:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzR95-0005HF-VK
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 14:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab3GQMrs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 08:47:48 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:59445 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900Ab3GQMrr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 08:47:47 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so1805284pdj.24
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9A6HoHVPTpf22MBh3MRqEl42gXr7dNMOER2mHXs/7Ns=;
        b=QrmEKjoYNC1duVA+ByMA27B4x05IVwfWs8QPUlXnDskf/m/KMBchZUGw6Ogp8LL6Xm
         QyoFu4MRBVpSBEKWMhnuuj7sMOrVBlq9Pwb5AyyFJCrXrVv+EANonta5C9ExSmRqKN+P
         VIAzWI02O8UeDk9sdNmWBVfziYet9nAkrZ4rBndqKcg7SkAVAJmOzHO/MgVfXg8cqAMK
         0pUxBdATyFWKAb6sVRVsILBsSYu6T4HDp6gQGQ2Mj8kY6IbYrcgRM42/0W7qXlf/ubTz
         STGQrvm8+TYpyb6YgbFDnr60dci8qlAukY+kXNmWxYZnQ4YnG9VSGCYtx9P8UgWQcQD5
         P8aA==
X-Received: by 10.68.196.134 with SMTP id im6mr6627106pbc.110.1374065266799;
        Wed, 17 Jul 2013 05:47:46 -0700 (PDT)
Received: from lanh ([115.73.197.79])
        by mx.google.com with ESMTPSA id z14sm7787118pbt.0.2013.07.17.05.47.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 05:47:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Jul 2013 19:48:00 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230619>

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
 send-pack.c             | 38 +++++++++++++++++++++++++++++++++-----
 send-pack.h             |  4 +++-
 t/t5537-push-shallow.sh | 18 ++++++++++++++++++
 transport.c             |  5 +++--
 5 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f0ad0ce..b177120 100644
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
@@ -206,8 +207,10 @@ int cmd_send_pack(int argc, const char **argv, con=
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
@@ -227,7 +230,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
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
index 81d4b1c..08de681 100644
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
@@ -45,10 +50,27 @@ static int pack_objects(int fd, struct ref *refs, s=
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
+					extra_shallow,
+					0);
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
@@ -100,6 +122,10 @@ static int pack_objects(int fd, struct ref *refs, =
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
@@ -176,7 +202,8 @@ static int sideband_demux(int in, int out, void *da=
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
@@ -294,7 +321,8 @@ int send_pack(struct send_pack_args *args,
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
index 30fdbc8..76d3d51 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -64,4 +64,22 @@ EOF
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
 test_done
diff --git a/transport.c b/transport.c
index 17fef16..d592e8d 100644
--- a/transport.c
+++ b/transport.c
@@ -802,7 +802,8 @@ static int git_transport_push(struct transport *tra=
nsport, struct ref *remote_re
 		struct ref *tmp_refs;
 		connect_setup(transport, 1, 0);
=20
-		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL, NULL, =
NULL);
+		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
+				 NULL, &data->shallow);
 		data->got_remote_heads =3D 1;
 	}
=20
@@ -817,7 +818,7 @@ static int git_transport_push(struct transport *tra=
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
