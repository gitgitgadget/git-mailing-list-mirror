From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [RFC] grep should detect binary files like diff
Date: Sat, 13 Aug 2011 16:51:32 -0700
Message-ID: <1313279492-7241-1-git-send-email-conrad.irwin@gmail.com>
Cc: conrad.irwin@gmail.com, gitster@pobox.com,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 01:52:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsO08-0000ET-Iy
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 01:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab1HMXwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 19:52:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60800 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1HMXwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 19:52:05 -0400
Received: by yxj19 with SMTP id 19so2659418yxj.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 16:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=AaePw1FXiJjGTXhB0zDq2wmshokcyLd7PdjX8AVlA+Y=;
        b=kDS155jipXM9Qd+FOgoYFrgBPphllfAHMU5owqag0da1TsVYO6zRgXnxAo7nzExcwS
         UfzwQL6jBWogKTc+oX3Zooi/fYUHZZO5IpP9dE8XC6mckoj1A5kuah6XJrKm2/XokjRR
         Qx3kH3aAZ1wuYmGOq1pylDfDvAYcY5scNyKXc=
Received: by 10.236.157.137 with SMTP id o9mr8469691yhk.32.1313279524145;
        Sat, 13 Aug 2011 16:52:04 -0700 (PDT)
Received: from localhost.localdomain (75-149-63-189-SFBA.hfc.comcastbusiness.net [75.149.63.189])
        by mx.google.com with ESMTPS id j45sm2046337yhe.64.2011.08.13.16.52.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 16:52:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.409.ge7a85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179299>

Hi all,

The problem I have is a large number of fixture files, in text-based
formats, that pollute the output of various git commands. I can mitigate
this in git-diff using gitattributes mechanism, but there's no similar
configuration for git-grep.

There are two issues with the naive approach to implementing this that
I've attached below. Firstly the configuration variable is namespaced
under "diff", and secondly the attributes mechanism is not thread-safe.

I'm inclined to think that the namespacing issue is not too significant;
it would just require some documentation. If it is an issue then maybe a
new "grep" attribute could be created. Are there any places where you
might want git-grep and git-diff to treat different sets of files as
binary?

The thread-safety of the attributes mechanism is a much bigger problem,
and is the only reason I made the behaviour depend on a configuration
option below. You can either have a multi-threaded grep, or a grep that
detects binary files properly :(. I'm not sure how to even start
resolving an issue like that, though I'm happy to accept pointers. Does
anyone, Junio?, know what it would take to fix?

Conrad

---
 Documentation/config.txt        |    5 ++++
 Documentation/git-grep.txt      |    5 ++++
 Documentation/gitattributes.txt |    3 ++
 builtin/grep.c                  |    5 ++++
 grep.c                          |   48 +++++++++++++++++++++-----------------
 grep.h                          |    1 +
 t/t7008-grep-binary.sh          |   18 ++++++++++++++
 7 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0658ffb..b7d65b3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1070,6 +1070,11 @@ grep.lineNumber::
 grep.extendedRegexp::
 	If set to true, enable '--extended-regexp' option by default.
 
+grep.binaryFiles::
+	If set to true, linkgit:git-grep[1] will treat files as binary under
+	the same circumstances as linkgit:git-diff[1]. See the
+	"Marking files as binary" section of linkgit:gitattributes[5].
+
 gui.commitmsgwidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index e44a498..fd9ebc4 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -41,6 +41,11 @@ grep.lineNumber::
 grep.extendedRegexp::
 	If set to true, enable '--extended-regexp' option by default.
 
+grep.binaryFiles::
+	If set to true, linkgit:git-grep[1] will treat files as binary under
+	the same circumstances as linkgit:git-diff[1]. See the
+	"Marking files as binary" section of linkgit:gitattributes[5].
+
 
 OPTIONS
 -------
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2bbe76b..180aa2f 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -644,6 +644,9 @@ attribute in the `.gitattributes` file:
 
 This will cause git to generate `Binary files differ` (or a binary
 patch, if binary patches are enabled) instead of a regular diff.
+If the grep.binaryFiles configuration variable is set, linkgit:git-grep[1]
+will also treat such files as binary, by default printing
+`Binary file matches` instead of the matching line.
 
 However, one may also want to specify other diff driver attributes. For
 example, you might want to use `textconv` to convert postscript files to
diff --git a/builtin/grep.c b/builtin/grep.c
index 1851797..e9d9003 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -324,6 +324,11 @@ static int grep_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "grep.binaryfiles")) {
+		opt->userdiff_binary = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value, -1);
 	else if (!strcmp(var, "color.grep.context"))
diff --git a/grep.c b/grep.c
index 26e8d8e..84063eb 100644
--- a/grep.c
+++ b/grep.c
@@ -924,8 +924,8 @@ int grep_threads_ok(const struct grep_opt *opt)
 	 * machinery in grep_buffer_1. The attribute code is not
 	 * thread safe, so we disable the use of threads.
 	 */
-	if (opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
-	    !opt->name_only)
+	if ((opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
+	    !opt->name_only) || opt->userdiff_binary)
 		return 0;
 
 	return 1;
@@ -947,6 +947,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	unsigned count = 0;
 	int try_lookahead = 0;
 	int show_function = 0;
+	int load_userdiff_func;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
 
@@ -968,31 +969,34 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	}
 	opt->last_shown = 0;
 
-	switch (opt->binary) {
-	case GREP_BINARY_DEFAULT:
-		if (buffer_is_binary(buf, size))
-			binary_match_only = 1;
-		break;
-	case GREP_BINARY_NOMATCH:
-		if (buffer_is_binary(buf, size))
-			return 0; /* Assume unmatch */
-		break;
-	case GREP_BINARY_TEXT:
-		break;
-	default:
-		die("bug: unknown binary handling mode");
-	}
+	load_userdiff_func = opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
+	    !opt->name_only && !collect_hits;
 
 	memset(&xecfg, 0, sizeof(xecfg));
-	if (opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
-	    !opt->name_only && !binary_match_only && !collect_hits) {
+	if (opt->userdiff_binary || load_userdiff_func) {
+		/* we have to be careful not to call this if we're using threads */
 		struct userdiff_driver *drv = userdiff_find_by_path(name);
-		if (drv && drv->funcname.pattern) {
-			const struct userdiff_funcname *pe = &drv->funcname;
-			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
-			opt->priv = &xecfg;
+
+		if (opt->userdiff_binary && drv && drv->binary != -1)
+			binary_match_only = drv->binary;
+		else if (opt->binary != GREP_BINARY_TEXT)
+			binary_match_only = buffer_is_binary(buf, size);
+
+		if (load_userdiff_func && !binary_match_only) {
+			if (drv && drv->funcname.pattern) {
+				const struct userdiff_funcname *pe = &drv->funcname;
+				xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
+				opt->priv = &xecfg;
+			}
 		}
+	} else if (opt->binary != GREP_BINARY_TEXT) {
+		binary_match_only = buffer_is_binary(buf, size);
+	}
+
+	if (binary_match_only && opt->binary == GREP_BINARY_NOMATCH) {
+		return 0;
 	}
+
 	try_lookahead = should_lookahead(opt);
 
 	while (left) {
diff --git a/grep.h b/grep.h
index ae50c45..303cb78 100644
--- a/grep.h
+++ b/grep.h
@@ -90,6 +90,7 @@ struct grep_opt {
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
 	int binary;
+	int userdiff_binary;
 	int extended;
 	int pcre;
 	int relative;
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index e058d18..a88503b 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -99,4 +99,22 @@ test_expect_failure 'git grep y<NUL>x a' "
 	test_must_fail git grep -f f a
 "
 
+test_expect_success 'git -c grep.binaryFiles=1 grep ina a' "
+	echo 'a diff' > .gitattributes &&
+	printf 'binaryQfile' | q_to_nul >a &&
+	echo 'a:binaryQfile' | q_to_nul >expect &&
+	git -c grep.binaryFiles=1 grep ina a > actual &&
+	rm .gitattributes &&
+	test_cmp expect actual
+"
+test_expect_success 'git -c grep.binaryFiles=1 grep tex t' "
+	echo 'text' > t &&
+	git add t &&
+	echo 't -diff' > .gitattributes &&
+	echo Binary file t matches >expect &&
+	git -c grep.binaryFiles=1 grep tex t >actual &&
+	rm .gitattributes &&
+	test_cmp expect actual
+"
+
 test_done
-- 
1.7.6.409.ge7a85
