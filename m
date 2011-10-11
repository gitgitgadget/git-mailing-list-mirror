From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v4] attr.c: respect core.ignorecase when matching attribute patterns
Date: Tue, 11 Oct 2011 10:53:31 -0500
Message-ID: <HBn1XX5GLcGG9WPqS0RC9Uscll_6Kbd741mHOR7uc_IFxdOpGSDGF7qEBPF66SbtO3keG4GcnkbtEvKDQ5D3bCDNiV9EPgEh-CMLKgbfFJcpVD5Gcb69-QoqTpHG_J9pDQG844LtNZU@cipher.nrlssc.navy.mil>
References: <4E93BBA8.6080403@alum.mit.edu>
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 11 17:54:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDeeg-0000Ed-At
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 17:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab1JKPyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 11:54:04 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:49263 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753874Ab1JKPyD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 11:54:03 -0400
Received: by mail3.nrlssc.navy.mil id p9BFrsIe005653; Tue, 11 Oct 2011 10:53:54 -0500
In-Reply-To: <4E93BBA8.6080403@alum.mit.edu>
X-OriginalArrivalTime: 11 Oct 2011 15:53:52.0130 (UTC) FILETIME=[F91DFE20:01CC882D]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183300>

From: Brandon Casey <drafnel@gmail.com>

When core.ignorecase is true, the file globs configured in the
.gitattributes file should be matched case-insensitively against the paths
in the working directory.  Let's do so.

Plus, add some tests.

The last set of tests is performed only on a case-insensitive filesystem.
Those tests make sure that git handles the case where the .gitignore file
resides in a subdirectory and the user supplies a path that does not match
the case in the filesystem.  In that case^H^H^H^Hsituation, part of the
path supplied by the user is effectively interpreted case-insensitively,
and part of it is dependent on the setting of core.ignorecase.  git will
currently only match the portion of the path below the directory holding
the .gitignore file according to the setting of core.ignorecase.

This is also partly future-proofing.  Currently, git builds the attr stack
based on the path supplied by the user, so we don't have to do anything
special (like use strcmp_icase) to handle the parts of that path that don't
match the filesystem with respect to case.  If git instead built the attr
stack by scanning the repository, then the paths in the origin field would
not necessarily match the paths supplied by the user.  If someone makes a
change like that in the future, these tests will notice.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


On Mon, Oct 10, 2011 at 10:44 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 10/10/2011 08:01 PM, Brandon Casey wrote:
>> On Sun, Oct 9, 2011 at 10:16 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Maybe my commit message is not clear that it is describing the current
>> behavior and not defining it.  Instead of
>>
>>    git should only match the portion of the path below the directory
>>    holding the .gitignore file according to the setting of
>>    core.ignorecase.
>>
>> maybe I should say
>>
>>     git will currently only match the portion of the path...
>>
>> I could also remove the following test from the CASE_INSENSITIVE_FS
>> tests since it is really a dontcare:
>>
>>    attr_check A/b/h a/b/h "-c core.ignorecase=0"
>>
>> We don't care what happens when the user supplies A/b/h and a/b/h
>> exists on disk when core.ignorecase=0, we only care that A/b/h is
>> interpreted correctly when core.ignorecase=1.
>
> Sounds good to me.

Ok, here it is.

Minor tweak which, hopefully, adds clarity to the commit message and
removes an unnecessary test.

On top of bc/attr-ignore-case^ 64589a03a8ffb3eb4fb2ff8f416ff638a9aaa439.

-Brandon


 attr.c                |    5 ++-
 t/t0003-attributes.sh |   59 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 124337d..76b079f 100644
--- a/attr.c
+++ b/attr.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -631,7 +632,7 @@ static int path_matches(const char *pathname, int pathlen,
 		/* match basename */
 		const char *basename = strrchr(pathname, '/');
 		basename = basename ? basename + 1 : pathname;
-		return (fnmatch(pattern, basename, 0) == 0);
+		return (fnmatch_icase(pattern, basename, 0) == 0);
 	}
 	/*
 	 * match with FNM_PATHNAME; the pattern has base implicitly
@@ -645,7 +646,7 @@ static int path_matches(const char *pathname, int pathlen,
 		return 0;
 	if (baselen != 0)
 		baselen++;
-	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
+	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) == 0;
 }
 
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index ae2f1da..6946c4b 100755
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
@@ -93,6 +94,62 @@ test_expect_success 'attribute test' '
 
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
+	attr_check A/b/h a/b/h "-c core.ignorecase=1" &&
+	attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=1" &&
+	attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=1"
+'
+
 test_expect_success 'unnormalized paths' '
 
 	attr_check ./f f &&
-- 
1.7.7.138.g7f41b6
