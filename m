From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC v2 4/4] Add per-repository eol normalization
Date: Sat,  8 May 2010 23:46:21 +0200
Message-ID: <abe2e2efb3c4e35270a08b912d0aa49aa600e5bc.1273352819.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
Cc: mat <matthieu.stigler@gmail.com>, hasen j <hasan.aljudy@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 23:47:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OArrP-0005mb-3j
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 23:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284Ab0EHVqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 17:46:43 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:59208 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab0EHVqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 17:46:38 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so578787ewy.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8k5auwhLjSARvRv05jKvCxHI+/lPhehK1ife3tZg7qw=;
        b=LWL43hN4ioa70PrV7iLbHikay60rZN16Brk34sfUx6RhztITsFJchSZ/1O9skuAkZx
         CEmJdGzKFC4v96T1SYWaI0aLztz4AxbynEV4WUqj/EuhS1rQBKkKyDUSBSuOYrVrrHPB
         gOZwLXoA9to1sMEheFAxhEijimQ1u43IF446c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FDd8HHlaHTA/5Gx0+Gou3fv0cf+73xJAFU8/flNkWU2BNUpKRgS6i1YKNn0I47Lgc0
         dU+wadu3ti5nKKlBoPIwcmfmoGgT/RXi8kQFgqzGx9W7ui65UeP4oXcfSAIPU6ICl+i8
         n2beS7m2Z6gaEaH9QbMmRidxOu5exWMzYo23A=
Received: by 10.213.74.13 with SMTP id s13mr808778ebj.35.1273355197096;
        Sat, 08 May 2010 14:46:37 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm1782464ewy.6.2010.05.08.14.46.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 14:46:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.3.gb95c9
In-Reply-To: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146678>

Change the semantics of the "crlf" attribute so that it enables
end-of-line normalization when it is set.  Add a new setting, "auto",
which enables end-of-line conversion but does not override the automatic
binary file detection.

The effect of this change is that a project can enable end-of-line
normalization for all files.  This is similar to the "core.autocrlf"
configuration variable, but since the setting is part of the content, it
is cloned when the project is cloned and can be changed if a previously
un-normalized repository is normalized.

Since the line ending style to be used in the working directory is a
user preference, the configuration variable "core.eolStyle" controls it.

"core.autocrlf" can still be used to enable conversion, and every effort
has been taken to avoid backwards incompatibility.  There is one small
semantic change: if "crlf" is set on a path, that file will now have its
line endings normalized.  Previously, they would only be normalized if
"core.autocrlf" was also set.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/config.txt        |    4 +-
 Documentation/gitattributes.txt |   71 +++++++++++++++++++++++++++-----------
 convert.c                       |   34 ++++++++++++++++--
 t/t0025-crlf-auto.sh            |    4 +-
 4 files changed, 84 insertions(+), 29 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3956ff7..7bbf8a0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -215,8 +215,8 @@ core.eolStyle::
 	line ending conversion.  See linkgit:gitattributes[5].
 
 core.safecrlf::
-	If true, makes git check if converting `CRLF` as controlled by
-	`core.autocrlf` is reversible.  Git will verify if a command
+	If true, makes git check if converting `CRLF` is reversible when
+	end-of-line conversion is active.  Git will verify if a command
 	modifies a file in the work tree either directly or indirectly.
 	For example, committing a file followed by checking out the
 	same file should yield the original file in the work tree.  If
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d892e64..18b07f6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -92,17 +92,28 @@ such as 'git checkout' and 'git merge' run.  They also affect how
 git stores the contents you prepare in the working tree in the
 repository upon 'git add' and 'git commit'.
 
+
 `crlf`
 ^^^^^^
 
-This attribute controls the line-ending convention.
+This attribute enables and controls end-of-line normalization.  When
+normalization is enabled for a file, its line endings are converted to
+LF when it is checked in, and the configuration variable
+`core.eolStyle` decides whether to convert line endings to CRLF on
+checkout.
+
+Set to string value "auto"::
+
+	When `crlf` is set to "auto", the file is marked for automatic
+	end-of-line normalization.  If git detects that the file is
+	a text file, its line endings are normalized to LF on checkin.
 
 Set::
 
-	Setting the `crlf` attribute on a path is meant to mark
-	the path as a "text" file.  'core.autocrlf' conversion
-	takes place without guessing the content type by
-	inspection.
+	Setting the `crlf` attribute on a path enables end-of-line
+	normalization and marks the path as a text file.
+	End-of-line conversion takes place without guessing the
+	content type by inspection.
 
 Unset::
 
@@ -111,34 +122,52 @@ Unset::
 
 Unspecified::
 
-	Unspecified `crlf` attribute tells git to apply the
-	`core.autocrlf` conversion when the file content looks
-	like text.
+	Unspecified `crlf` attribute tells git to apply end-of-line
+	conversion only if the `core.autocrlf` configuration variable
+	is set.
 
 Set to string value "input"::
 
 	This is similar to setting the attribute to `true`, but
-	also forces git to act as if `core.autocrlf` is set to
-	`input` for the path.
+	prevents git from converting the line endings to CRLF when the
+	file is checked out.
 
 Any other value set to `crlf` attribute is ignored and git acts
 as if the attribute is left unspecified.
 
 
-The `core.autocrlf` conversion
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-If the configuration variable `core.autocrlf` is false, no
-conversion is done.
+End-of-line conversion
+^^^^^^^^^^^^^^^^^^^^^^
 
-When `core.autocrlf` is true, it means that the platform wants
-CRLF line endings for files in the working tree, and you want to
-convert them back to the normal LF line endings when checking
-in to the repository.
+While git normally leaves file contents alone, it can be configured to
+normalize line endings to LF in the repository and, optionally, to
+convert them to CRLF when files are checked out.  Binary files are
+detected automatically and will not be modified; this detection can be
+overridden with the `crlf` attribute.
+
+NOTE: This normalization requires the repository to be free of text
+files containing CRLFs.  When it is enabled on an existing repository,
+the index should be rebuilt to find any such files, and these files
+should either have their `crlf` attribute set to false ("-crlf"), or
+they should be checked in to the repository in normalized form.
+
+This example shows how to convert an existing repository with a mix of
+LF and CRLF contents into one with normalized line endings.  From a
+clean working directory:
+
+-------------------------------------------------
+$ echo "* crlf=auto" >.gitattributes
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
 
-When `core.autocrlf` is set to "input", line endings are
-converted to LF upon checkin, but there is no conversion done
-upon checkout.
 
 If `core.safecrlf` is set to "true" or "warn", git verifies if
 the conversion is reversible for the current setting of
diff --git a/convert.c b/convert.c
index 2eef2f6..6871896 100644
--- a/convert.c
+++ b/convert.c
@@ -15,6 +15,7 @@
 #define CRLF_BINARY	0
 #define CRLF_TEXT	1
 #define CRLF_INPUT	2
+#define CRLF_AUTO	3
 
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
@@ -392,6 +393,17 @@ static void setup_convert_check(struct git_attr_check *check)
 	check[2].attr = attr_filter;
 }
 
+static int choose_eol_conversion(int auto_eol)
+{
+	if (auto_crlf)
+		return auto_crlf;
+
+	if (auto_eol)
+		return eol_style;
+
+	return 0;
+}
+
 static int count_ident(const char *cp, unsigned long size)
 {
 	/*
@@ -546,6 +558,8 @@ static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 		;
 	else if (!strcmp(value, "input"))
 		return CRLF_INPUT;
+	else if (!strcmp(value, "auto"))
+		return CRLF_AUTO;
 	return CRLF_GUESS;
 }
 
@@ -575,7 +589,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 {
 	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
-	int ident = 0, ret = 0;
+	int ident = 0, ret = 0, auto_eol = 0;
 	const char *filter = NULL;
 
 	setup_convert_check(check);
@@ -586,6 +600,11 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		drv = git_path_check_convert(path, check + 2);
 		if (drv && drv->clean)
 			filter = drv->clean;
+		if (crlf > 0) {
+			auto_eol = 1;
+			if (crlf == CRLF_AUTO)
+				crlf = CRLF_GUESS;
+		}
 	}
 
 	ret |= apply_filter(path, src, len, dst, filter);
@@ -593,7 +612,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, crlf, checksafe, auto_crlf);
+	ret |= crlf_to_git(path, src, len, dst, crlf, checksafe,
+		choose_eol_conversion(auto_eol));
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -605,7 +625,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 {
 	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
-	int ident = 0, ret = 0;
+	int ident = 0, ret = 0, auto_eol = 0;
 	const char *filter = NULL;
 
 	setup_convert_check(check);
@@ -616,6 +636,11 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 		drv = git_path_check_convert(path, check + 2);
 		if (drv && drv->smudge)
 			filter = drv->smudge;
+		if (crlf > 0) {
+			auto_eol = 1;
+			if (crlf == CRLF_AUTO)
+				crlf = CRLF_GUESS;
+		}
 	}
 
 	ret |= ident_to_worktree(path, src, len, dst, ident);
@@ -623,7 +648,8 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_worktree(path, src, len, dst, crlf, auto_crlf);
+	ret |= crlf_to_worktree(path, src, len, dst, crlf,
+		choose_eol_conversion(auto_eol));
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index 367b459..e8e76f5 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -60,7 +60,7 @@ test_expect_success 'no crlf=auto, explicit eolstyle=native causes no changes' '
 	test -z "$onediff" -a -z "$twodiff"
 '
 
-test_expect_failure 'crlf=auto, eolStyle=crlf <=> autocrlf=true' '
+test_expect_success 'crlf=auto, eolStyle=crlf <=> autocrlf=true' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf false &&
@@ -81,7 +81,7 @@ test_expect_failure 'crlf=auto, eolStyle=crlf <=> autocrlf=true' '
 	test -z "$missing_cr"
 '
 
-test_expect_failure 'crlf=auto, eolStyle=lf <=> autocrlf=input' '
+test_expect_success 'crlf=auto, eolStyle=lf <=> autocrlf=input' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf false &&
-- 
1.7.1.3.gb95c9
