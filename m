From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] Use clean.requireforce to protect untracked files.
Date: Fri, 03 Jun 2011 19:12:46 +0800
Message-ID: <4DE8C1AE.4000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 13:13:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSSJJ-0001zh-S1
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 13:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab1FCLM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 07:12:56 -0400
Received: from mail-px0-f170.google.com ([209.85.212.170]:52941 "EHLO
	mail-px0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab1FCLMz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 07:12:55 -0400
Received: by pxi19 with SMTP id 19so1080239pxi.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:content-type:content-transfer-encoding;
        bh=B4kkHef7BFkAHJz54QU+skm7GV4/4dX/AhNZib3Pw5g=;
        b=sjiZVMPpwmYagHU+BPPpRewSBVyjrB8p2yL36sYnLgJQLqIRwt38LZyHTNXKzeHDGI
         P/5B7xNGAMQSe+IvZs5QdtAhDzpeiXwWAqfopibuHT0sXcvGPytRAhnb7Xet5gJcVeiL
         Yi1RFd4e9331CUtPn+7NfiLK2CLVbDM4vNOhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=lA02CBisJoL+8MB9z+cKDbXP1holG25phHTD5W0g/4e9JDC1VOoGHY9OR7yk8p4OWt
         vGyr14CtsKSql9EIRLzHh9Pwno8c1YBBsqz1iR4+Mm+j3F+C+WKw14+ZInAHLsBzXZRs
         vc3G07WmiqBDAL/m+07cyFRTTZGKVnAFH34VA=
Received: by 10.142.247.36 with SMTP id u36mr299413wfh.39.1307099574983;
        Fri, 03 Jun 2011 04:12:54 -0700 (PDT)
Received: from [192.168.0.100] ([114.241.211.155])
        by mx.google.com with ESMTPS id l15sm991572wfe.8.2011.06.03.04.12.49
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 04:12:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; zh-CN; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175004>

Untracked files may be significant for certain repositories, but if run the
command "git clean -fdx" by accident, all untracked files will be lost.

This hack adds three values in addtion to true/false to "clean.requireforce",
which can protect untracked files from cleaning:

* true or unset : can not clean without -f/--force option provided.
* false         : clean untracked files just as -f/--force option provided.
* lockignored   : can not clean untracked ignored files.
* lockunignored : can not clean untracked unignored files.
* lockall       : can not clean anything.

Signed-off-by: Jiang Xin <jiangxin@ossxp.com>
---
 Documentation/config.txt |    7 +++-
 builtin/clean.c          |   29 ++++++++++++++++++-
 t/t7300-clean.sh         |   69 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b93777..b930f42 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -684,8 +684,11 @@ browser.<tool>.path::
 	working repository in gitweb (see linkgit:git-instaweb[1]).
 
 clean.requireForce::
-	A boolean to make git-clean do nothing unless given -f
-	or -n.   Defaults to true.
+	When set to `LockIgnored`, cleaning untracked ignored files is
+	denied. When set to `LockUnIgnored`, only allow cleaning untracked
+	ignored files using -X option. When set to `LockAll`, no files
+	can be cleaned until unset this variable. A boolean to make
+	git-clean do nothing unless given -f or -n. Defaults to true.
 
 color.branch::
 	A boolean to enable/disable color in the output of
diff --git a/builtin/clean.c b/builtin/clean.c
index 75697f7..441f35a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -13,7 +13,11 @@
 #include "string-list.h"
 #include "quote.h"
 
+#define LOCK_IGNORED	01
+#define LOCK_UNIGNORED	02
+
 static int force = -1; /* unset */
+static int lock_flag = 0;
 
 static const char *const builtin_clean_usage[] = {
 	"git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>...",
@@ -22,8 +26,17 @@ static const char *const builtin_clean_usage[] = {
 
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "clean.requireforce"))
-		force = !git_config_bool(var, value);
+	if (!strcmp(var, "clean.requireforce")) {
+		if (value && !strcasecmp(value, "LockIgnored"))
+			lock_flag = LOCK_IGNORED;
+		else if (value && !strcasecmp(value, "LockUnIgnored"))
+			lock_flag = LOCK_UNIGNORED;
+		else if (value && !strcasecmp(value, "LockAll"))
+			lock_flag = LOCK_IGNORED | LOCK_UNIGNORED;
+		else
+			force = !git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -77,6 +90,18 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
 
+	if (!show_only && lock_flag) {
+		if (lock_flag & LOCK_IGNORED && lock_flag & LOCK_UNIGNORED)
+			die(_("clean.requireForce set to LockAll; "
+				  "refusing to clean until reset clean.requireForce"));
+		else if (lock_flag & LOCK_IGNORED && (ignored_only || ignored))
+			die(_("clean.requireForce set to LockIgnored and conflict with -x or -X; "
+				  "refusing to clean"));
+		else if (lock_flag & LOCK_UNIGNORED && !ignored_only)
+			die(_("clean.requireForce set to LockUnIgnored and can only work with -X; "
+				  "refusing to clean"));
+	}
+
 	if (!show_only && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -n nor -f given; "
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 800b536..b4f38dd 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -460,4 +460,73 @@ test_expect_success SANITY 'git clean -d with an unreadable empty directory' '
 	! test -d foo
 '
 
+test_expect_success 'clean.requireForce LockIgnored' '
+
+	git config clean.requireForce LockIgnored &&
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	test_must_fail git clean &&
+	test_must_fail git clean -f -x &&
+	test_must_fail git clean -f -X &&
+	git clean -f &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f src/part3.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so &&
+	git clean -f -d &&
+	test ! -f docs/manual.txt &&
+	test -f build/lib.so &&
+	git config clean.requireForce true
+'
+
+test_expect_success 'clean.requireForce LockUnIgnored' '
+
+	git config clean.requireForce LockUnIgnored &&
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	test_must_fail git clean &&
+	test_must_fail git clean -f &&
+	test_must_fail git clean -f -x &&
+	git clean -f -X &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f src/part3.c &&
+	test -f docs/manual.txt &&
+	test ! -f obj.o &&
+	test -f build/lib.so &&
+	git clean -f -d -X &&
+	test ! -f build/lib.so &&
+	test -f src/part3.c &&
+	git config clean.requireForce true
+'
+
+test_expect_success 'clean.requireForce LockAll' '
+
+	git config clean.requireForce lockall &&
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	test_must_fail git clean -f &&
+	test_must_fail git clean -f -x &&
+	test_must_fail git clean -f -X &&
+	git clean -ndx &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f src/part3.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so &&
+	git config clean.requireForce true
+'
+
 test_done
-- 
1.7.5.4.1.g6c49.dirty
