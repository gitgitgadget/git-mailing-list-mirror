From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 4/4] attr.c: respect core.ignorecase when matching attribute patterns
Date: Wed, 14 Sep 2011 20:59:39 -0500
Message-ID: <1316051979-19671-5-git-send-email-drafnel@gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
 <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru,
	Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Thu Sep 15 04:01:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R41GK-0007Xs-Ul
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab1IOCBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 22:01:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54642 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1IOCBH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 22:01:07 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so1875627gyg.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qW2Q5Q9EFkKXqpxU2cy0kdOen0Js1ycvKQzmUoGkxAg=;
        b=FaeAEF5Urb4JhuvlMrb7aLNogF83/wkj6/veLAduFk3T9Ue87jyH5rz5cSBs9aM+fl
         RK5YVJIwZ68rb42e5+Z/hpsyWkubkg1lx2WZSp4COqkUJFfehCUce2FSKbJU8AuawIyx
         B9Vpk/hY0UmnZOnQfXEhlR1xSA/nLzHXr1NGo=
Received: by 10.236.37.134 with SMTP id y6mr2852933yha.113.1316052066662;
        Wed, 14 Sep 2011 19:01:06 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id e61sm2291412yhm.2.2011.09.14.19.01.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 19:01:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181425>

When core.ignorecase is true, the file globs configured in the
.gitattributes file should be matched case-insensitively against the paths
in the working directory.

---

Two points:

1)
I think these two changes of fnmatch to fnmatch_icase should be all
that is necessary.  There are a number of uses of strncmp where the
"origin" path of an attribute entry is compared to the prefix of a file
path, but since the attribute stack is built from the same path string
that it is being compared against, we shouldn't have to do
strncmp_icase everywhere.  The case of the two strings should
necessarily match.

This needs some testing by someone on a case-insensitive filesystem.

Also, notice some of the new tests are marked with a CASE_INSENSITIVE_FS
pre-requisite.  I tested on a USB thumb drive, but it would be nice if
someone tested on a platform that is natively case-insensitive.  Maybe
CASE_INSENSITIVE_FS should be moved to test-lib.sh, and t0005(others?)
should be updated to use it?


2)
The bad news, this breaks t8005.  The breakage is caused by
git_attr_config calling git_default_config, and stomping on the
git_log_output_encoding set by setup_revisions() when it parsed the
 --encoding command line option.

What happens is cmd_blame() calls git_config() which parses the config
files and sets up the global config variables like
git_log_output_encoding, then later blame calls setup_revisions() which
parses the command line option --encoding and overrides the value in
git_log_output_encoding, then, even later, userdiff looks up an
attribute on a path and calls git_check_attr() which calls git_config
_again_, which resets git_log_output_encoding to the value in the config
file (stomping on the value set by --encoding on the git blame command
line).

Since fnmatch_icase depends on the ignore_case global variable being set
correctly, the obvious thing for me to do was to allow
git_default_config to call git_default_core_config and parse the
core.ignorecase config option.  So I modified git_attr_config so it fell
back to git_default_config.  But that can have the undesired side effect
described above.

It's easy to work around this issue.  I could just parse core.ignorecase
in git_attr_config() and set ignore_case myself like:

   if (!strcmp(var, "core.ignorecase")) {
           ignore_case = git_config_bool(var, value);
           return 0;
   }

The big question is whether it should be safe to call git_config()
multiple times?  Right now, it is not.  We also don't protect against
git_config() being called multiple times either.

I suspect that setup_revisions() is not the only place where a command
line option overrides a global config variable and it would be a big
can of worms to try to fix them all.

Thoughts?

---
 attr.c                |    7 +++--
 t/t0003-attributes.sh |   60 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index 3359b39..b8ed7cf 100644
--- a/attr.c
+++ b/attr.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -499,7 +500,7 @@ static int git_attr_config(const char *var, const char *value, void *dummy)
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&attributes_file, var, value);
 
-	return 0;
+	return git_default_config(var, value, dummy);
 }
 
 static void bootstrap_attr_stack(void)
@@ -643,7 +644,7 @@ static int path_matches(const char *pathname, int pathlen,
 		/* match basename */
 		const char *basename = strrchr(pathname, '/');
 		basename = basename ? basename + 1 : pathname;
-		return (fnmatch(pattern, basename, 0) == 0);
+		return (fnmatch_icase(pattern, basename, 0) == 0);
 	}
 	/*
 	 * match with FNM_PATHNAME; the pattern has base implicitly
@@ -657,7 +658,7 @@ static int path_matches(const char *pathname, int pathlen,
 		return 0;
 	if (baselen != 0)
 		baselen++;
-	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
+	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) == 0;
 }
 
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index ae2f1da..47a70c4 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -9,7 +9,7 @@ attr_check () {
 	path="$1"
 	expect="$2"
 
-	git check-attr test -- "$path" >actual 2>err &&
+	git $3 check-attr test -- "$path" >actual 2>err &&
 	echo "$path: test: $2" >expect &&
 	test_cmp expect actual &&
 	test_line_count = 0 err
@@ -27,6 +27,7 @@ test_expect_success 'setup' '
 		echo "onoff test -test"
 		echo "offon -test test"
 		echo "no notest"
+		echo "A/e/F test=A/e/F"
 	) >.gitattributes &&
 	(
 		echo "g test=a/g" &&
@@ -93,6 +94,63 @@ test_expect_success 'attribute test' '
 
 '
 
+test_expect_success 'attribute matching is case sensitive when core.ignorecase=0' '
+
+	test_must_fail attr_check F f "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/F f "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/c/F f "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/G a/g "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/B/g a/b/g "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/b/G a/b/g "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/b/H a/b/h "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/b/D/g "a/b/d/*" "-c core.ignorecase=0" &&
+	test_must_fail attr_check oNoFf unset "-c core.ignorecase=0" &&
+	test_must_fail attr_check oFfOn set "-c core.ignorecase=0" &&
+	attr_check NO unspecified "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/b/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
+	attr_check a/b/d/YES a/b/d/* "-c core.ignorecase=0" &&
+	test_must_fail attr_check a/E/f "A/e/F" "-c core.ignorecase=0"
+
+'
+
+test_expect_success 'attribute matching is case insensitive when core.ignorecase=1' '
+
+	attr_check F f "-c core.ignorecase=1" &&
+	attr_check a/F f "-c core.ignorecase=1" &&
+	attr_check a/c/F f "-c core.ignorecase=1" &&
+	attr_check a/G a/g "-c core.ignorecase=1" &&
+	attr_check a/B/g a/b/g "-c core.ignorecase=1" &&
+	attr_check a/b/G a/b/g "-c core.ignorecase=1" &&
+	attr_check a/b/H a/b/h "-c core.ignorecase=1" &&
+	attr_check a/b/D/g "a/b/d/*" "-c core.ignorecase=1" &&
+	attr_check oNoFf unset "-c core.ignorecase=1" &&
+	attr_check oFfOn set "-c core.ignorecase=1" &&
+	attr_check NO unspecified "-c core.ignorecase=1" &&
+	attr_check a/b/D/NO "a/b/d/*" "-c core.ignorecase=1" &&
+	attr_check a/b/d/YES unspecified "-c core.ignorecase=1" &&
+	attr_check a/E/f "A/e/F" "-c core.ignorecase=1"
+
+'
+
+test_expect_success 'check whether FS is case-insensitive' '
+	mkdir junk &&
+	echo good >junk/CamelCase &&
+	echo bad >junk/camelcase &&
+	if test "$(cat junk/CamelCase)" != good
+	then
+		test_set_prereq CASE_INSENSITIVE_FS
+	fi
+'
+
+test_expect_success CASE_INSENSITIVE_FS 'additional case insensitivity tests' '
+	test_must_fail attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=0" &&
+	test_must_fail attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
+	attr_check A/b/h a/b/h "-c core.ignorecase=0" &&
+	attr_check A/b/h a/b/h "-c core.ignorecase=1" &&
+	attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=1" &&
+	attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=1"
+'
+
 test_expect_success 'unnormalized paths' '
 
 	attr_check ./f f &&
-- 
1.7.6
