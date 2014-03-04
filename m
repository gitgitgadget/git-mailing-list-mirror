From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] upload-pack: allow shallow fetching from a read-only repository
Date: Tue,  4 Mar 2014 19:30:05 +0700
Message-ID: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 13:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKoTq-0001ch-L9
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 13:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189AbaCDM3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 07:29:40 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:49597 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184AbaCDM3j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 07:29:39 -0500
Received: by mail-pd0-f173.google.com with SMTP id z10so5073396pdj.32
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 04:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xZ6tk063ujBloj/zCCEkuePUCHr1az7RlLOLYbV9zEo=;
        b=WUOTMHCBL+asnEY2jO8pxtttekqE+pgvzNp4FvUTZYFj6i9/Hod8GTbsBsBrqd58aW
         gaBX2oEJEuLEpDKGmCQzzXzK8m2nUhh91dda9Ut9V4c/oiQX3vDciZz58EIUAhMx2xRg
         eXJOxFhJuXfh/GMkunhnSaGc4G/xt8R0fjV3Vd7TSTtsmMlXw1K1Oo3WlAzIqrs64k+a
         /KhJXzrZN7OmgUQuU1iEHuhnQdCrK35b0JWugNX5TVj4rjbCY1lVrbcEblRVun39VxC5
         AqrJlRptm4Yna1FoKGq6JSE9Cr7Wu1ZsaXz80ohWCXNShN2OE8ONf3JW8pA9uH9hePh7
         gg+Q==
X-Received: by 10.67.13.226 with SMTP id fb2mr5693447pad.146.1393936178764;
        Tue, 04 Mar 2014 04:29:38 -0800 (PST)
Received: from lanh ([115.73.245.149])
        by mx.google.com with ESMTPSA id pp5sm47357144pbb.33.2014.03.04.04.29.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 04:29:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 04 Mar 2014 19:30:06 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243339>

Before cdab485 (upload-pack: delegate rev walking in shallow fetch to
pack-objects - 2013-08-16) upload-pack does not write to the source
repository. cdab485 starts to write $GIT_DIR/shallow_XXXXXX if it's a
shallow fetch, so the source repo must be writable.

git:// servers do not need write access to repos and usually don't,
which mean cdab485 breaks shallow clone over git://

=46all back to $TMPDIR if $GIT_DIR/shallow_XXXXXX cannot be created in
this case. Note that in other cases that write $GIT_DIR/shallow_XXXXXX
and eventually rename it to $GIT_DIR/shallow, there is no fallback to
$TMPDIR.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Rebased on top of jk/shallow-update-fix

 builtin/receive-pack.c   |  2 +-
 commit.h                 |  2 +-
 fetch-pack.c             |  2 +-
 shallow.c                | 13 +++++++++++--
 t/t5537-fetch-shallow.sh | 13 +++++++++++++
 upload-pack.c            |  2 +-
 6 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..d723099 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -932,7 +932,7 @@ static const char *unpack(int err_fd, struct shallo=
w_info *si)
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
=20
 	if (si->nr_ours || si->nr_theirs) {
-		alt_shallow_file =3D setup_temporary_shallow(si->shallow);
+		alt_shallow_file =3D setup_temporary_shallow(si->shallow, 0);
 		argv_array_pushl(&av, "--shallow-file", alt_shallow_file, NULL);
 	}
=20
diff --git a/commit.h b/commit.h
index 55631f1..d38e996 100644
--- a/commit.h
+++ b/commit.h
@@ -209,7 +209,7 @@ extern int write_shallow_commits(struct strbuf *out=
, int use_pack_protocol,
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
 				    const char **alternate_shallow_file,
 				    const struct sha1_array *extra);
-extern const char *setup_temporary_shallow(const struct sha1_array *ex=
tra);
+extern const char *setup_temporary_shallow(const struct sha1_array *ex=
tra, int read_only);
 extern void advertise_shallow_grafts(int);
=20
 struct shallow_info {
diff --git a/fetch-pack.c b/fetch-pack.c
index ae8550e..b71d186 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -853,7 +853,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
 	else if (si->nr_ours || si->nr_theirs)
-		alternate_shallow_file =3D setup_temporary_shallow(si->shallow);
+		alternate_shallow_file =3D setup_temporary_shallow(si->shallow, 0);
 	else
 		alternate_shallow_file =3D NULL;
 	if (get_pack(args, fd, pack_lockfile))
diff --git a/shallow.c b/shallow.c
index c7602ce..ad28af6 100644
--- a/shallow.c
+++ b/shallow.c
@@ -224,7 +224,8 @@ static void remove_temporary_shallow_on_signal(int =
signo)
 	raise(signo);
 }
=20
-const char *setup_temporary_shallow(const struct sha1_array *extra)
+const char *setup_temporary_shallow(const struct sha1_array *extra,
+				    int read_only)
 {
 	static int installed_handler;
 	struct strbuf sb =3D STRBUF_INIT;
@@ -235,7 +236,15 @@ const char *setup_temporary_shallow(const struct s=
ha1_array *extra)
=20
 	if (write_shallow_commits(&sb, 0, extra)) {
 		strbuf_addstr(&temporary_shallow, git_path("shallow_XXXXXX"));
-		fd =3D xmkstemp(temporary_shallow.buf);
+		fd =3D mkstemp(temporary_shallow.buf);
+		if (read_only && fd < 0) {
+			strbuf_grow(&temporary_shallow, PATH_MAX);
+			fd =3D git_mkstemp(temporary_shallow.buf, PATH_MAX,
+					 "shallow_XXXXXX");
+		}
+		if (fd < 0)
+			die_errno("Unable to create temporary file '%s'",
+				  temporary_shallow.buf);
=20
 		if (!installed_handler) {
 			atexit(remove_temporary_shallow);
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index b0fa738..171db88 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -173,6 +173,19 @@ EOF
 	)
 '
=20
+test_expect_success POSIXPERM 'shallow fetch from a read-only repo' '
+	cp -R .git read-only.git &&
+	find read-only.git -print | xargs chmod -w &&
+	test_when_finished "find read-only.git -type d -print | xargs chmod +=
w" &&
+	git clone --no-local --depth=3D2 read-only.git from-read-only &&
+	git --git-dir=3Dfrom-read-only/.git log --format=3D%s >actual &&
+	cat >expect <<EOF &&
+add-1-back
+4
+EOF
+	test_cmp expect actual
+'
+
 if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
 	say 'skipping remaining tests, git built without http support'
 	test_done
diff --git a/upload-pack.c b/upload-pack.c
index a3c52f6..b538f32 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -84,7 +84,7 @@ static void create_pack_file(void)
 	const char *shallow_file =3D NULL;
=20
 	if (shallow_nr) {
-		shallow_file =3D setup_temporary_shallow(NULL);
+		shallow_file =3D setup_temporary_shallow(NULL, 1);
 		argv[arg++] =3D "--shallow-file";
 		argv[arg++] =3D shallow_file;
 	}
--=20
1.9.0.40.gaa8c3ea
