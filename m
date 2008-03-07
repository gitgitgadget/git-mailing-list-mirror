From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] get_pathspec(): die when an out-of-tree path is given
Date: Fri,  7 Mar 2008 00:38:36 -0800
Message-ID: <1204879119-7528-2-git-send-email-gitster@pobox.com>
References: <1204879119-7528-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 09:46:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXYDV-0003XZ-52
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 09:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbYCGIpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 03:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbYCGIpe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 03:45:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbYCGIpe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 03:45:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2781B2ACE
	for <git@vger.kernel.org>; Fri,  7 Mar 2008 03:45:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1FBC02ACD for <git@vger.kernel.org>; Fri,  7 Mar 2008 03:45:30 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.587.g0bdd73
In-Reply-To: <1204879119-7528-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76470>

An earlier commit d089ebaa (setup: sanitize absolute and funny paths) made
get_pathspec() aware of absolute paths, but with a botched interface that
forced the callers to count the resulting pathspecs in order to detect
an error of giving a path that is outside the work tree.

This fixes it, by dying inside the function.

We had ls-tree test that relied on a misfeature in the original
implementation of its pathspec handling.  Leading slashes were silently
removed from them.  However we allow giving absolute pathnames (people
want to cut and paste from elsewhere) that are inside work tree these
days, so a pathspec that begin with slash _should_ be treated as a full
path.  The test is adjusted to match the updated rule for get_pathspec().

Earlier I mistook three tests given by Robin that they should succeed, but
these are attempts to add path outside work tree, which should fail
loudly.  These tests also have been fixed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c                    |    2 ++
 t/t3101-ls-tree-dirname.sh |    2 +-
 t/t7010-setup.sh           |    7 ++++---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 89c81e5..c7b1080 100644
--- a/setup.c
+++ b/setup.c
@@ -202,6 +202,8 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 		const char *p = prefix_path(prefix, prefixlen, *src);
 		if (p)
 			*(dst++) = p;
+		else
+			exit(128); /* error message already given */
 		src++;
 	}
 	*dst = NULL;
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 39fe267..70f9ce9 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -120,7 +120,7 @@ EOF
 # having 1.txt and path3
 test_expect_success \
     'ls-tree filter odd names' \
-    'git ls-tree $tree 1.txt /1.txt //1.txt path3/1.txt /path3/1.txt //path3//1.txt path3 /path3/ path3// >current &&
+    'git ls-tree $tree 1.txt ./1.txt .//1.txt path3/1.txt path3/./1.txt path3 path3// >current &&
      cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	path3/1.txt
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index e809e0e..bc8ab6a 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -142,15 +142,16 @@ test_expect_success 'setup deeper work tree' '
 test_expect_success 'add a directory outside the work tree' '(
 	cd tester &&
 	d1="$(cd .. ; pwd)" &&
-	git add "$d1"
+	test_must_fail git add "$d1"
 )'
 
+
 test_expect_success 'add a file outside the work tree, nasty case 1' '(
 	cd tester &&
 	f="$(pwd)x" &&
 	echo "$f" &&
 	touch "$f" &&
-	git add "$f"
+	test_must_fail git add "$f"
 )'
 
 test_expect_success 'add a file outside the work tree, nasty case 2' '(
@@ -158,7 +159,7 @@ test_expect_success 'add a file outside the work tree, nasty case 2' '(
 	f="$(pwd | sed "s/.$//")x" &&
 	echo "$f" &&
 	touch "$f" &&
-	git add "$f"
+	test_must_fail git add "$f"
 )'
 
 test_done
-- 
1.5.4.3.587.g0bdd73

