From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC 3/3] Add per-repository eol normalization
Date: Fri,  7 May 2010 00:27:35 +0200
Message-ID: <97a8241cefd924a56bfb22315844e9dc0e0de21a.1273183206.git.eyvind.bernhardsen@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Cc: hasan.aljudy@gmail.com, kusmabite@googlemail.com,
	torvalds@linux-foundation.org, prohaska@zib.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 00:27:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9Xw-0003zw-DH
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab0EFW1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:27:51 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:35902 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab0EFW1r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:27:47 -0400
Received: by ewy20 with SMTP id 20so136758ewy.1
        for <git@vger.kernel.org>; Thu, 06 May 2010 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BMc8ael20clVC7pRMZWIdWh9yi7UrZviVWQTVZD+kdI=;
        b=jlCnxuXvKLRX610cgIpT+FwrGWz2n+W+LIBF2khKQ6T6ruzhpANE43BJOz9mDOHGFX
         kzJICXPngKqbYNCeCKz9FaDIGy1jEkr+BsrtXUP4V4WdOn9oI6xezWnuUobPx2WQX7Lb
         nbMcrsD+/qescX4tiUqwO1MzOgAdGBT6ETyjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=owYzx7ji/rouUiyHdFK6xRPTo9PUr77Vij/RTWS0ofAOnw3VV0vS4iDj3ysqJ12jW1
         YmlNSiJQ1FU1q70On2YLSKcbgj9vFWOQXTuWEdu1KDW+qpuN+xHqBunROejJBKuC1bLB
         oNOrqdwNgCtuuWsqMTAdH/4JZzIJ4lENmZtj0=
Received: by 10.213.42.82 with SMTP id r18mr1797252ebe.59.1273184866274;
        Thu, 06 May 2010 15:27:46 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm843521ewy.15.2010.05.06.15.27.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 15:27:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.3.gb95c9
In-Reply-To: <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146504>

Implement an alternative end-of-line conversion setting which uses a new
attribute, "auto-eol", and a new config variable, "core.eolStyle" to
enable end-of-line conversion.

The auto-eol attribute enables automatic line ending detection and
conversion for files on which it is set.  Since attributes are under
version control, this setting is copied when the repository is cloned.
It can also be changed over the history of a repository, with some
caveats.

The core.eolStyle variable is used to decide if LF or CRLF line endings
are preferred in the working directory.  It is only used when auto-eol
is set, and defaults to the platform-native line ending.

"core.autocrlf" overrides auto-eol when set to anything but "false".

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/config.txt        |   11 ++++-
 Documentation/gitattributes.txt |   92 +++++++++++++++++++++++++++++++++------
 convert.c                       |   48 ++++++++++++++------
 t/t0025-auto-eol.sh             |    4 +-
 4 files changed, 123 insertions(+), 32 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92f851e..7bbf8a0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -207,9 +207,16 @@ core.autocrlf::
 	the file's `crlf` attribute, or if `crlf` is unspecified,
 	based on the file's contents.  See linkgit:gitattributes[5].
 
+core.eolStyle::
+	Sets the line ending type to use for text files in the working
+	directory when the `auto-eol` property is set.  Alternatives are
+	'lf', 'crlf', 'native' and 'false'.  'native', the default, uses
+	the platform's native line ending.  'false' disables `auto-eol`
+	line ending conversion.  See linkgit:gitattributes[5].
+
 core.safecrlf::
-	If true, makes git check if converting `CRLF` as controlled by
-	`core.autocrlf` is reversible.  Git will verify if a command
+	If true, makes git check if converting `CRLF` is reversible when
+	end-of-line conversion is active.  Git will verify if a command
 	modifies a file in the work tree either directly or indirectly.
 	For example, committing a file followed by checking out the
 	same file should yield the original file in the work tree.  If
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d892e64..1c52ae9 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -92,6 +92,46 @@ such as 'git checkout' and 'git merge' run.  They also affect how
 git stores the contents you prepare in the working tree in the
 repository upon 'git add' and 'git commit'.
 
+`auto-eol`
+^^^^^^^^^^
+
+This attribute enables automatic end-of-line conversion (see below).
+When `auto-eol` is used, it should in most cases be set for all files in
+the repository.
+
+Set::
+
+	Setting the `auto-eol` attribute turns on automatic
+	conversion of line endings.  When `auto-eol` is set,
+	line endings are converted to LF on checkin, and if
+	`core.eolStyle` is set to "crlf", line endings are
+	also converted to CRLF on checkout.
+
+Unset::
+
+	No line-ending conversion is performed.
+
+NOTE: When committing a change that sets this attribute in an existing
+repository, line endings should be normalized as part of the same
+commit.  From a clean working directory:
+
+-------------------------------------------------
+$ echo "* auto-eol" >.gitattributes
+$ rm .git/index     # Remove the index to force git to
+$ git reset         # re-scan the working directory
+$ git status        # Show files that will be normalized
+$ git add -u
+$ git add .gitattributes
+$ git commit -m "Introduce end-of-line normalization"
+-------------------------------------------------
+
+If any files that should not be normalized show up in 'git status',
+unset their `crlf` attribute in `.gitattributes` before 'git add -u'.
+
+`core.autocrlf` overrides `auto-eol` if set to "true" or "input".
+Setting `core.eolStyle` to "false" prevents line ending conversion even
+when `auto-eol` is set.
+
 `crlf`
 ^^^^^^
 
@@ -100,7 +140,7 @@ This attribute controls the line-ending convention.
 Set::
 
 	Setting the `crlf` attribute on a path is meant to mark
-	the path as a "text" file.  'core.autocrlf' conversion
+	the path as a "text" file.  End-of-line conversion
 	takes place without guessing the content type by
 	inspection.
 
@@ -111,8 +151,8 @@ Unset::
 
 Unspecified::
 
-	Unspecified `crlf` attribute tells git to apply the
-	`core.autocrlf` conversion when the file content looks
+	Unspecified `crlf` attribute tells git to apply
+	end-of-line conversion when the file content looks
 	like text.
 
 Set to string value "input"::
@@ -125,20 +165,44 @@ Any other value set to `crlf` attribute is ignored and git acts
 as if the attribute is left unspecified.
 
 
-The `core.autocrlf` conversion
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-If the configuration variable `core.autocrlf` is false, no
-conversion is done.
-
-When `core.autocrlf` is true, it means that the platform wants
-CRLF line endings for files in the working tree, and you want to
-convert them back to the normal LF line endings when checking
-in to the repository.
+End-of-line conversion
+^^^^^^^^^^^^^^^^^^^^^^
 
-When `core.autocrlf` is set to "input", line endings are
-converted to LF upon checkin, but there is no conversion done
-upon checkout.
+While git normally leaves file contents alone, it can be configured to
+normalize line endings to LF in the repository and, optionally, to
+convert them to CRLF when files are checked out.  Binary files are
+detected automatically and will not be modified; this detection can be
+overridden with the `crlf` attribute.
+
+NOTE: This conversion requires the repository to be free of text files
+containing CRLFs.  When it is enabled on an existing repository, the
+index should be rebuilt to find any such files, and these files should
+either have their `crlf` attribute set to false ("-crlf"), or they
+should be checked in to the repository in normalized form.
+
+End-of-line conversion is controlled by the configuration variables
+`core.eolStyle` and `core.autocrlf` and the attributes `auto-eol` and
+`crlf`.
+
+When a repository is shared between users on platforms with different
+end-of-line conventions, using the `auto-eol` mechanism is probably the
+best choice.  A developer on a minority platform sharing a repository
+with a large group of users on an LF-native platform would want to set
+`core.autocrlf` instead.
+
+End-of-line conversion is enabled as follows:
+
+- If the attribute `auto-eol` is not set and the configuration variable
+  `core.autocrlf` is false, no conversion is done.
+
+- When the `auto-eol` attribute is set, or `core.autocrlf` is true or
+  "input", line endings are normalized as files are checked in to the
+  repository.
+
+- When the `auto-eol` attribute is set and `core.eolStyle` is "crlf", or
+  `core.autocrlf` is true, line endings in the repository are normalized
+  and will be converted to CRLF when files are checked out to the
+  working tree.
 
 If `core.safecrlf` is set to "true" or "warn", git verifies if
 the conversion is reversible for the current setting of
diff --git a/convert.c b/convert.c
index 4f8fcb7..f0f59e3 100644
--- a/convert.c
+++ b/convert.c
@@ -90,12 +90,13 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 }
 
 static void check_safe_crlf(const char *path, int action,
-                            struct text_stat *stats, enum safe_crlf checksafe)
+			    struct text_stat *stats, enum safe_crlf checksafe,
+			    int eol_conversion)
 {
 	if (!checksafe)
 		return;
 
-	if (action == CRLF_INPUT || auto_crlf <= 0) {
+	if (action == CRLF_INPUT || eol_conversion <= 0) {
 		/*
 		 * CRLFs would not be restored by checkout:
 		 * check if we'd remove CRLFs
@@ -106,7 +107,7 @@ static void check_safe_crlf(const char *path, int action,
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("CRLF would be replaced by LF in %s.", path);
 		}
-	} else if (auto_crlf > 0) {
+	} else if (eol_conversion > 0) {
 		/*
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
@@ -121,12 +122,13 @@ static void check_safe_crlf(const char *path, int action,
 }
 
 static int crlf_to_git(const char *path, const char *src, size_t len,
-                       struct strbuf *buf, int action, enum safe_crlf checksafe)
+		       struct strbuf *buf, int action, enum safe_crlf checksafe,
+		       int eol_conversion)
 {
 	struct text_stat stats;
 	char *dst;
 
-	if ((action == CRLF_BINARY) || !auto_crlf || !len)
+	if ((action == CRLF_BINARY) || !eol_conversion || !len)
 		return 0;
 
 	gather_stats(src, len, &stats);
@@ -147,7 +149,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
-	check_safe_crlf(path, action, &stats, checksafe);
+	check_safe_crlf(path, action, &stats, checksafe, eol_conversion);
 
 	/* Optimization: No CR? Nothing to convert, regardless. */
 	if (!stats.cr)
@@ -180,13 +182,13 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 }
 
 static int crlf_to_worktree(const char *path, const char *src, size_t len,
-                            struct strbuf *buf, int action)
+			    struct strbuf *buf, int action, int eol_conversion)
 {
 	char *to_free = NULL;
 	struct text_stat stats;
 
 	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
-	    auto_crlf <= 0)
+	    eol_conversion <= 0)
 		return 0;
 
 	if (!len)
@@ -377,17 +379,31 @@ static void setup_convert_check(struct git_attr_check *check)
 	static struct git_attr *attr_crlf;
 	static struct git_attr *attr_ident;
 	static struct git_attr *attr_filter;
+	static struct git_attr *attr_auto_eol;
 
 	if (!attr_crlf) {
 		attr_crlf = git_attr("crlf");
 		attr_ident = git_attr("ident");
 		attr_filter = git_attr("filter");
+		attr_auto_eol = git_attr("auto-eol");
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
 	check[0].attr = attr_crlf;
 	check[1].attr = attr_ident;
 	check[2].attr = attr_filter;
+	check[3].attr = attr_auto_eol;
+}
+
+static int choose_eol_conversion(int auto_eol)
+{
+	if (auto_crlf)
+		return auto_crlf;
+
+	if (auto_eol)
+		return eol_style;
+
+	return 0;
 }
 
 static int count_ident(const char *cp, unsigned long size)
@@ -571,9 +587,9 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
-	struct git_attr_check check[3];
+	struct git_attr_check check[4];
 	int crlf = CRLF_GUESS;
-	int ident = 0, ret = 0;
+	int ident = 0, ret = 0, auto_eol = 0;
 	const char *filter = NULL;
 
 	setup_convert_check(check);
@@ -584,6 +600,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		drv = git_path_check_convert(path, check + 2);
 		if (drv && drv->clean)
 			filter = drv->clean;
+		auto_eol = git_path_check_ident(path, check + 3);
 	}
 
 	ret |= apply_filter(path, src, len, dst, filter);
@@ -591,7 +608,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, crlf, checksafe);
+	ret |= crlf_to_git(path, src, len, dst, crlf, checksafe,
+		choose_eol_conversion(auto_eol));
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -601,9 +619,9 @@ int convert_to_git(const char *path, const char *src, size_t len,
 
 int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	struct git_attr_check check[3];
+	struct git_attr_check check[4];
 	int crlf = CRLF_GUESS;
-	int ident = 0, ret = 0;
+	int ident = 0, ret = 0, auto_eol = 0;
 	const char *filter = NULL;
 
 	setup_convert_check(check);
@@ -614,6 +632,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 		drv = git_path_check_convert(path, check + 2);
 		if (drv && drv->smudge)
 			filter = drv->smudge;
+		auto_eol = git_path_check_ident(path, check + 3);
 	}
 
 	ret |= ident_to_worktree(path, src, len, dst, ident);
@@ -621,7 +640,8 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_worktree(path, src, len, dst, crlf);
+	ret |= crlf_to_worktree(path, src, len, dst, crlf,
+		choose_eol_conversion(auto_eol));
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/t/t0025-auto-eol.sh b/t/t0025-auto-eol.sh
index 5acee2d..5195885 100755
--- a/t/t0025-auto-eol.sh
+++ b/t/t0025-auto-eol.sh
@@ -60,7 +60,7 @@ test_expect_success 'no auto-eol, explicit eolstyle=native causes no changes' '
 	test -z "$onediff" -a -z "$twodiff"
 '
 
-test_expect_failure 'auto-eol=true, eolStyle=crlf <=> autocrlf=true' '
+test_expect_success 'auto-eol=true, eolStyle=crlf <=> autocrlf=true' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf false &&
@@ -81,7 +81,7 @@ test_expect_failure 'auto-eol=true, eolStyle=crlf <=> autocrlf=true' '
 	test -z "$missing_cr"
 '
 
-test_expect_failure 'auto-eol=true, eolStyle=lf <=> autocrlf=input' '
+test_expect_success 'auto-eol=true, eolStyle=lf <=> autocrlf=input' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf false &&
-- 
1.7.1.3.gb95c9
