From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] upload-pack: allow shallow fetching from a read-only repository
Date: Thu, 27 Feb 2014 14:13:03 +0700
Message-ID: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 08:13:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIv9o-0001et-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 08:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbaB0HNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 02:13:14 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:60153 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbaB0HNM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 02:13:12 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so2040138pdj.26
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 23:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Ep2mOLDvQtIKJL9CfrvQfQYwxdHQuYZyProvokm6ixE=;
        b=tT58hV6zPQjR/suBG/STOtCKlpyOFh2j1K2J7fjQ8Tux0RkqkZg3TZG26zunJMzT5d
         zLRpcKKIDYzUal94xtmYYJ7jSMRxkHCfj4mwNLB/CtIpvg1EI7kPIRj/zS6dkLCehKpo
         466N49bZGGtTD9obgvLCTda4JuIz7huR0BFJbvvNBcDNYDCMiUWNgdf2J49DRb97uLA6
         0yrC3i06oAmRdXHHrWL5CxjEl7ltqKRl8FNOdW+edlHzx+qtVD0fBCF2rOtyy0WDG9uC
         GbY7qDWsg8ZGxq64YAkTYaLepTpRIeTZJ7S/Q8WNAAnC33rCzeB4rrD8MD22wbw5BrX8
         GhDQ==
X-Received: by 10.66.191.131 with SMTP id gy3mr13556166pac.152.1393485191138;
        Wed, 26 Feb 2014 23:13:11 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id oz7sm10232801pbc.41.2014.02.26.23.13.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 23:13:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 27 Feb 2014 14:13:04 +0700
X-Mailer: git-send-email 1.9.0.66.g14f785a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242787>

Before cdab485 (upload-pack: delegate rev walking in shallow fetch to
pack-objects - 2013-08-16) upload-pack does not write to the source
repository. cdab485 starts to write $GIT_DIR/shallow_XXXXXX if it's a
shallow fetch, so the source repo must be writable.

=46all back to $TMPDIR if $GIT_DIR/shallow_XXXXXX cannot be created in
this case. Note that in other cases that write $GIT_DIR/shallow_XXXXXX
and eventually rename it to $GIT_DIR/shallow, there is no fallback to
$TMPDIR.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c   |  2 +-
 commit.h                 |  2 +-
 fetch-pack.c             |  2 +-
 shallow.c                | 13 +++++++++++--
 t/t5537-fetch-shallow.sh | 13 +++++++++++++
 upload-pack.c            |  2 +-
 6 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 85bba35..9d96f2c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -936,7 +936,7 @@ static const char *unpack(int err_fd, struct shallo=
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
index 16d9c43..44a40ad 100644
--- a/commit.h
+++ b/commit.h
@@ -209,7 +209,7 @@ extern int write_shallow_commits(struct strbuf *out=
, int use_pack_protocol,
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
 				    const char **alternate_shallow_file,
 				    const struct sha1_array *extra);
-extern char *setup_temporary_shallow(const struct sha1_array *extra);
+extern char *setup_temporary_shallow(const struct sha1_array *extra, i=
nt read_only);
 extern void advertise_shallow_grafts(int);
=20
 struct shallow_info {
diff --git a/fetch-pack.c b/fetch-pack.c
index 90fdd49..382b825 100644
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
index bbc98b5..3adfbd5 100644
--- a/shallow.c
+++ b/shallow.c
@@ -216,7 +216,7 @@ int write_shallow_commits(struct strbuf *out, int u=
se_pack_protocol,
 	return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
 }
=20
-char *setup_temporary_shallow(const struct sha1_array *extra)
+char *setup_temporary_shallow(const struct sha1_array *extra, int read=
_only)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	int fd;
@@ -224,7 +224,16 @@ char *setup_temporary_shallow(const struct sha1_ar=
ray *extra)
 	if (write_shallow_commits(&sb, 0, extra)) {
 		struct strbuf path =3D STRBUF_INIT;
 		strbuf_addstr(&path, git_path("shallow_XXXXXX"));
-		fd =3D xmkstemp(path.buf);
+		if (read_only) {
+			fd =3D mkstemp(path.buf);
+			if (fd < 0) {
+				char buf[PATH_MAX];
+				fd =3D git_mkstemp(buf, sizeof(buf), "shallow_XXXXXX");
+			}
+			if (fd < 0)
+				die_errno("Unable to create temporary shallow file");
+		} else
+			fd =3D xmkstemp(path.buf);
 		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
 			die_errno("failed to write to %s",
 				  path.buf);
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
index 0c44f6b..11404b4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -84,7 +84,7 @@ static void create_pack_file(void)
 	char *shallow_file =3D NULL;
=20
 	if (shallow_nr) {
-		shallow_file =3D setup_temporary_shallow(NULL);
+		shallow_file =3D setup_temporary_shallow(NULL, 1);
 		argv[arg++] =3D "--shallow-file";
 		argv[arg++] =3D shallow_file;
 	}
--=20
1.9.0.66.g14f785a
