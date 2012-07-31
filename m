From: J Smith <dark.panda@gmail.com>
Subject: [PATCH/RFC] grep: add a perlRegexp configuration option
Date: Tue, 31 Jul 2012 12:57:34 -0400
Message-ID: <1343753854-66765-1-git-send-email-dark.panda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 18:58:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwFln-0003TL-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 18:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab2GaQ5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 12:57:38 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46017 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab2GaQ5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 12:57:37 -0400
Received: by vcbfk26 with SMTP id fk26so6042060vcb.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=1sfmpHVgBjYoeV1AjQlWDwpLTPmUR+duOLmO+o+ZYxs=;
        b=K7frXN8biZ1cdRICF5LQY+5ZXplRzX4jx+b4Kg+RQpHogGQVS6j3Y2UBLoPgvyxBz1
         5lQKICroNNpDfRBQcW6ZAYJ0sRe9nmGW1ZV8YVYoTrKiu2hRQxvZm7ntIMqYNzsYSqfn
         BOmxI4eDDL4buv0xyx5QgEuIQPo39tJCCj28i4jdx82RdYCHQoqBTgpYNaW618VN8/qw
         ZFgy6Ce5iIBl7rimglBkmnMRgraHkYXz4n62c0qZsA/42x233ExYPDMtUXZKulqlXisA
         DrTrzSBXiV8ffhpajTKW+62DvuVfNpt4GSJEZIgTEWU3QRYszgigszbTUOsEU9/A8O29
         9Jvw==
Received: by 10.59.7.138 with SMTP id dc10mr3093283ved.8.1343753856391;
        Tue, 31 Jul 2012 09:57:36 -0700 (PDT)
Received: from localhost.localdomain (surf3.net.rss.rogers.com. [24.114.255.3])
        by mx.google.com with ESMTPS id cz2sm539168vdb.3.2012.07.31.09.57.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2012 09:57:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202659>

Enables the -P flag for perl regexps by default. When both the
perlRegexp and extendedRegexp options are enabled, the last enabled
option wins.
---
 Documentation/config.txt   |  6 ++++++
 Documentation/git-grep.txt |  6 ++++++
 builtin/grep.c             | 17 +++++++++++++++--
 t/t7810-grep.sh            | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a95e5a4..ff3019b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1213,6 +1213,12 @@ grep.lineNumber::
 grep.extendedRegexp::
 	If set to true, enable '--extended-regexp' option by default.

+grep.perlRegexp::
+	If set to true, enable '--perl-regexp' option by default.
+
+When both the 'grep.extendedRegexp' and 'grep.perlRegexp' options
+are used, the last enabled option wins.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3bec036..8816968 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -45,6 +45,12 @@ grep.lineNumber::
 grep.extendedRegexp::
 	If set to true, enable '--extended-regexp' option by default.

+grep.perlRegexp::
+	If set to true, enable '--perl-regexp' option by default.
+
+When both the 'grep.extendedRegexp' and 'grep.perlRegexp' options
+are used, the last enabled option wins.
+

 OPTIONS
 -------
diff --git a/builtin/grep.c b/builtin/grep.c
index 29adb0a..b4475e6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -268,11 +268,24 @@ static int grep_config(const char *var, const char *value, void *cb)
 	if (userdiff_config(var, value) < 0)
 		return -1;

+	if (!strcmp(var, "grep.perlregexp")) {
+		if (git_config_bool(var, value)) {
+			opt->fixed = 0;
+			opt->pcre = 1;
+		} else {
+			opt->pcre = 0;
+		}
+		return 0;
+	}
+
 	if (!strcmp(var, "grep.extendedregexp")) {
-		if (git_config_bool(var, value))
+		if (git_config_bool(var, value)) {
 			opt->regflags |= REG_EXTENDED;
-		else
+			opt->pcre = 0;
+			opt->fixed = 0;
+		} else {
 			opt->regflags &= ~REG_EXTENDED;
+		}
 		return 0;
 	}

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 24e9b19..5479dc9 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -729,6 +729,40 @@ test_expect_success LIBPCRE 'grep -P pattern' '
 	test_cmp expected actual
 '

+test_expect_success LIBPCRE 'grep pattern with grep.perlRegexp=true' '
+	git \
+		-c grep.perlregexp=true \
+		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep pattern with grep.perlRegexp=true and then grep.extendedRegexp=true' '
+	test_must_fail git \
+		-c grep.perlregexp=true \
+		-c grep.extendedregexp=true \
+		grep "\p{Ps}.*?\p{Pe}" hello.c
+'
+
+test_expect_success LIBPCRE 'grep pattern with grep.extendedRegexp=true and then grep.perlRegexp=true' '
+	git \
+		-c grep.extendedregexp=true \
+		-c grep.perlregexp=true \
+		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -E pattern with grep.perlRegexp=true' '
+	test_must_fail git \
+		-c grep.perlregexp=true \
+		grep -E "\p{Ps}.*?\p{Pe}" hello.c
+'
+
+test_expect_success LIBPCRE 'grep -G pattern with grep.perlRegexp=true' '
+	test_must_fail git \
+		-c grep.perlregexp=true \
+		grep -G "\p{Ps}.*?\p{Pe}" hello.c
+'
+
 test_expect_success 'grep pattern with grep.extendedRegexp=true' '
 	>empty &&
 	test_must_fail git -c grep.extendedregexp=true \
--
1.7.11.3
