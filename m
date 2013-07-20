From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/16] {fetch,upload}-pack: support fetching from a shallow clone via smart http
Date: Sat, 20 Jul 2013 16:58:05 +0700
Message-ID: <1374314290-5976-12-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:59:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0TwX-0001bU-8M
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab3GTJ7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:59:08 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:51114 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3GTJ7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:59:06 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so11338719iea.18
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gE1kiyRxuaru1CHMoP0WsVnVXJdUVjAfc7VGLvME/7U=;
        b=FB3zXLmvYM8Sc3w9JayMahjI021iL9TYfDxOjG+RYF9xFvmmU4kesxh3aSDtF9KL1t
         m7qS5xhlm2dOh1y5e/M/sqTdxzBE9x5fC5msREgOnGJ+obRFZXkSbdjH9HPbJNxj/8K6
         UGfsMd6S33IkiqUDi/VUYHaCyqfbe8jkynw7Hl2vhmnr5dc20lgypGdidfF4HsboB3MB
         OV/+zCs9vLkMDbRbt162nP0Pr2H15zJazpQ97n33LkuTJPYW59lX5zQtQgysR9juu9rW
         YCLsQatJ/uHx0mGhwgLs0vv+Dj9TZNahxk76HOiE+3VLjCYgLiGRMOvFz7UNlWDwHG80
         ZO1Q==
X-Received: by 10.43.181.136 with SMTP id pi8mr12905370icc.10.1374314346471;
        Sat, 20 Jul 2013 02:59:06 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id y2sm21063486igl.10.2013.07.20.02.59.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:59:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:59:25 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230889>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt |  3 +++
 builtin/fetch-pack.c                      |  3 +--
 remote-curl.c                             |  4 +++-
 t/t5536-fetch-shallow.sh                  | 27 +++++++++++++++++++++++=
++++
 upload-pack.c                             |  2 --
 5 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index a1672bc..5013652 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -574,6 +574,7 @@ respectively. The output is in pkt-line format.
   advertised-refs  =3D  service
 		      flush-pkt
 		      (no-refs / list-of-refs)
+		      *shallow
 		      flush-pkt
=20
   service          =3D  PKT-LINE("# service=3D" service-name)
@@ -590,6 +591,8 @@ respectively. The output is in pkt-line format.
   other-tip        =3D  obj-id SP refname LF
   other-peeled     =3D  obj-id SP refname "^{}" LF
=20
+  shallow           =3D  PKT-LINE("shallow" SP obj-id)
+
   capability-list  =3D  capability *(SP capability)
   capability       =3D  1*(LC_ALPHA / DIGIT / "-" / "_")
   LC_ALPHA         =3D  %x61-7A
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index f6a6d76..b89d753 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -146,8 +146,7 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 	}
=20
 	memset(&shallow, 0, sizeof(shallow));
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL,
-			 args.stateless_rpc ? NULL : &shallow);
+	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
=20
 	ref =3D fetch_pack(&args, fd, conn, ref, dest,
 			 sought, nr_sought, &shallow, pack_lockfile_ptr);
diff --git a/remote-curl.c b/remote-curl.c
index c329bd3..de2cc8a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -78,6 +78,7 @@ struct discovery {
 	char *buf;
 	size_t len;
 	struct ref *refs;
+	struct extra_have_objects shallow;
 	unsigned proto_git : 1;
 };
 static struct discovery *last_discovery;
@@ -86,7 +87,7 @@ static struct ref *parse_git_refs(struct discovery *h=
eads, int for_push)
 {
 	struct ref *list =3D NULL;
 	get_remote_heads(-1, heads->buf, heads->len, &list,
-			 for_push ? REF_NORMAL : 0, NULL, NULL);
+			 for_push ? REF_NORMAL : 0, NULL, &heads->shallow);
 	return list;
 }
=20
@@ -146,6 +147,7 @@ static void free_discovery(struct discovery *d)
 	if (d) {
 		if (d =3D=3D last_discovery)
 			last_discovery =3D NULL;
+		free(d->shallow.array);
 		free(d->buf_alloc);
 		free_refs(d->refs);
 		free(d);
diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
index 15a8208..6ea6347 100755
--- a/t/t5536-fetch-shallow.sh
+++ b/t/t5536-fetch-shallow.sh
@@ -102,4 +102,31 @@ EOF
=20
 '
=20
+if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
+	say 'skipping remaining tests, git built without http support'
+	test_done
+fi
+
+LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5536'}
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'clone http repository' '
+	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.g=
it" &&
+	git clone --quiet $HTTPD_URL/smart/repo.git clone &&
+	(
+	cd clone &&
+	git fsck &&
+	git log --format=3D%s origin/master >actual &&
+	cat <<EOF >expect &&
+6
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+stop_httpd
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index c3e68ae..263ae08 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -770,8 +770,6 @@ int main(int argc, char **argv)
=20
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
-	if (is_repository_shallow() && stateless_rpc)
-		die("attempt to push into a shallow repository");
=20
 	git_config(upload_pack_config, NULL);
 	upload_pack();
--=20
1.8.2.83.gc99314b
