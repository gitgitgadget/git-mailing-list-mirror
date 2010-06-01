From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v4 3/5] cache: Keep track of conversion mode changes.
Date: Tue,  1 Jun 2010 16:41:53 +0200
Message-ID: <a8e30003e2cb4697316b441d26297eadccfe7f64.1275309129.git.grubba@grubba.org>
References: <cover.1275309129.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 16:42:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJSfs-0004VS-OS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 16:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396Ab0FAOmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 10:42:14 -0400
Received: from mail.roxen.com ([212.247.29.220]:60526 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756222Ab0FAOmM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 10:42:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 4907862822E
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 16:42:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1jM3mKgbEERh for <git@vger.kernel.org>;
	Tue,  1 Jun 2010 16:42:11 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 2C513628209
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 16:42:11 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.14.4+Sun/8.14.4) with ESMTP id o51Eg72A021827;
	Tue, 1 Jun 2010 16:42:07 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.14.4+Sun/8.14.4/Submit) id o51Eg7CT021826;
	Tue, 1 Jun 2010 16:42:07 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1275309129.git.grubba@grubba.org>
In-Reply-To: <cover.1275309129.git.grubba@grubba.org>
References: <cover.1275309129.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148120>

The index now keeps track of the conversion mode that was active
when the entry was created. This can be used to detect the most
common cases of when the conversion mode has changed.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
Rebased on 0ed6711 (aka eb/core-eol).

The conversion mode flags are now based on the EOL_* set of flags,
and to avoid code duplication convert.c:get_output_conversion() and
convert.c:determine_action() are used to determine the eol conversion
mode.

The denormalized eol tests in t0025-crlf-auto.sh have been altered to
still test the intended eol conversion properties.

 cache.h              |   11 +++++++++++
 convert.c            |   46 ++++++++++++++++++++++++++++++++++++++++++=
++++
 read-cache.c         |   37 ++++++++++++++++++++++++++++++++++---
 t/t0025-crlf-auto.sh |   20 ++++++++++++--------
 4 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 004296d..263f4f3 100644
--- a/cache.h
+++ b/cache.h
@@ -151,10 +151,20 @@ struct cache_entry {
 	unsigned int ce_size;
 	unsigned int ce_flags;
 	unsigned char sha1[20];
+	unsigned int ce_conv_flags;
 	struct cache_entry *next;
 	char name[FLEX_ARRAY]; /* more */
 };
=20
+#define CONV_EOL_CRLF		EOL_CRLF
+#define CONV_EOL_LF		EOL_LF
+#define CONV_GIT_LF		0x0004
+#define CONV_GIT_AUTO		0x0008
+#define CONV_IDENT		0x0010
+#define CONV_FILT		0x0020
+#define CONV_MASK		0x003f
+#define CONV_NORM_NEEDED	0x010000
+
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_EXTENDED  (0x4000)
@@ -1016,6 +1026,7 @@ extern void trace_argv_printf(const char **argv, =
const char *format, ...);
=20
 /* convert.c */
 /* returns 1 if *dst was used */
+extern unsigned int git_conv_flags(const char *path);
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
                           struct strbuf *dst, enum safe_crlf checksafe=
);
 extern int convert_to_working_tree(const char *path, const char *src, =
size_t len, struct strbuf *dst);
diff --git a/convert.c b/convert.c
index 80d80b1..387a7c7 100644
--- a/convert.c
+++ b/convert.c
@@ -681,6 +681,52 @@ enum action determine_action(enum action text_attr=
, enum eol eol_attr) {
 	return text_attr;
 }
=20
+unsigned int git_conv_flags(const char *path)
+{
+	struct git_attr_check check[5];
+	enum action action =3D CRLF_GUESS;
+	enum eol eol_attr =3D EOL_UNSET;
+	int ident =3D 0;
+	unsigned ret =3D 0;
+	struct convert_driver *drv =3D NULL;
+
+	setup_convert_check(check);
+	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
+		action =3D git_path_check_crlf(path, check + 4);
+		if (action =3D=3D CRLF_GUESS)
+			action =3D git_path_check_crlf(path, check + 0);
+		ident =3D git_path_check_ident(path, check + 1);
+		drv =3D git_path_check_convert(path, check + 2);
+		eol_attr =3D git_path_check_eol(path, check + 3);
+	}
+
+	ret =3D get_output_conversion(action);
+
+	action =3D determine_action(action, eol_attr);
+
+	switch(action) {
+	case CRLF_BINARY:
+		break;
+	case CRLF_GUESS:
+		if (auto_crlf =3D=3D AUTO_CRLF_FALSE)
+			break;
+		ret |=3D CONV_GIT_AUTO;
+		break;
+	case CRLF_AUTO:
+		ret |=3D CONV_GIT_AUTO|CONV_GIT_LF;
+		break;
+	default:
+		ret |=3D CONV_GIT_LF;
+		break;
+	}
+
+	if (ident)
+		ret |=3D CONV_IDENT;
+	if (drv)
+		ret |=3D CONV_FILT;
+	return ret;
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
diff --git a/read-cache.c b/read-cache.c
index f1f789b..eeda928 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -88,12 +88,38 @@ void fill_stat_cache_info(struct cache_entry *ce, s=
truct stat *st)
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
 {
 	int match =3D -1;
-	int fd =3D open(ce->name, O_RDONLY);
-
+	int fd;
+	unsigned char norm_sha1[20];
+	unsigned int conv_flags =3D git_conv_flags(ce->name);
+	const unsigned char *cmp_sha1 =3D ce->sha1;
+
+	if ((conv_flags ^ ce->ce_conv_flags) & CONV_MASK) {
+		if (ce->ce_conv_flags & CONV_NORM_NEEDED) {
+			/* Smudge the entry since it was only correct
+			 * for the old conversion mode. */
+			ce->ce_size =3D 0;
+		}
+		ce->ce_conv_flags =3D conv_flags;
+	} else
+		conv_flags =3D ce->ce_conv_flags & CONV_NORM_NEEDED;
+
+	if (conv_flags) {
+		index_blob(norm_sha1, ce->sha1, 0, ce->name);
+		if (!(conv_flags & CONV_NORM_NEEDED) &&
+		    hashcmp(norm_sha1, ce->sha1)) {
+			ce->ce_conv_flags =3D conv_flags | CONV_NORM_NEEDED;
+			/* Smudge the entry since we don't know
+			 * the correct value. */
+			ce->ce_size =3D 0;
+		}
+		cmp_sha1 =3D norm_sha1;
+	}
+=09
+	fd =3D open(ce->name, O_RDONLY);
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, 0, OBJ_BLOB, ce->name))
-			match =3D hashcmp(sha1, ce->sha1);
+			match =3D hashcmp(sha1, cmp_sha1);
 		/* index_fd() closed the file descriptor already */
 	}
 	return match;
@@ -227,6 +253,11 @@ static int ce_match_stat_basic(struct cache_entry =
*ce, struct stat *st)
 		changed |=3D INODE_CHANGED;
 #endif
=20
+	/* ce_size can not be trusted if the conversion mode has changed. */
+	if ((ce->ce_mode & S_IFMT) =3D=3D S_IFREG &&
+	    ((ce->ce_conv_flags ^ git_conv_flags(ce->name)) & CONV_MASK))
+		return changed;
+
 	if (ce->ce_size !=3D (unsigned int) st->st_size)
 		changed |=3D DATA_CHANGED;
=20
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index f5f67a6..1bcf3dd 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -47,9 +47,10 @@ test_expect_success 'crlf=3Dtrue causes a CRLF file =
to be normalized' '
 	git read-tree --reset -u HEAD &&
=20
 	# Note, "normalized" means that git will normalize it if added
+	echo >>two &&
 	has_cr two &&
-	twodiff=3D`git diff two` &&
-	test -n "$twodiff"
+	twodiff=3D`git diff --numstat two | cut -f1` &&
+	test -n "$twodiff" -a "$twodiff" -gt 1
 '
=20
 test_expect_success 'text=3Dtrue causes a CRLF file to be normalized' =
'
@@ -59,9 +60,10 @@ test_expect_success 'text=3Dtrue causes a CRLF file =
to be normalized' '
 	git read-tree --reset -u HEAD &&
=20
 	# Note, "normalized" means that git will normalize it if added
+	echo >>two &&
 	has_cr two &&
-	twodiff=3D`git diff two` &&
-	test -n "$twodiff"
+	twodiff=3D`git diff --numstat two | cut -f1` &&
+	test -n "$twodiff" -a "$twodiff" -gt 1
 '
=20
 test_expect_success 'eol=3Dcrlf gives a normalized file CRLFs with aut=
ocrlf=3Dfalse' '
@@ -107,11 +109,12 @@ test_expect_success 'autocrlf=3Dtrue does not nor=
malize CRLF files' '
 	git read-tree --reset -u HEAD &&
=20
 	has_cr one &&
+	echo >>two &&
 	has_cr two &&
 	onediff=3D`git diff one` &&
-	twodiff=3D`git diff two` &&
+	twodiff=3D`git diff --numstat two | cut -f1` &&
 	threediff=3D`git diff three` &&
-	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
+	test -z "$onediff" -a -n "$twodiff" -a -z "$threediff" -a "$twodiff" =
-eq 1
 '
=20
 test_expect_success 'text=3Dauto, autocrlf=3Dtrue _does_ normalize CRL=
=46 files' '
@@ -122,11 +125,12 @@ test_expect_success 'text=3Dauto, autocrlf=3Dtrue=
 _does_ normalize CRLF files' '
 	git read-tree --reset -u HEAD &&
=20
 	has_cr one &&
+	echo >>two &&
 	has_cr two &&
 	onediff=3D`git diff one` &&
-	twodiff=3D`git diff two` &&
+	twodiff=3D`git diff --numstat two | cut -f1` &&
 	threediff=3D`git diff three` &&
-	test -z "$onediff" -a -n "$twodiff" -a -z "$threediff"
+	test -z "$onediff" -a -n "$twodiff" -a -z "$threediff" -a "$twodiff" =
-gt 1
 '
=20
 test_expect_success 'text=3Dauto, autocrlf=3Dtrue does not normalize b=
inary files' '
--=20
1.7.0.4.369.g81e89
