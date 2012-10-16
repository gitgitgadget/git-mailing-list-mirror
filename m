From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/5] Add tests for using symbolic refs as branch name aliases.
Date: Tue, 16 Oct 2012 15:44:53 +0200
Message-ID: <1350395094-11404-5-git-send-email-johan@herland.net>
References: <CAPc5daUws-MfzC9imkytTrLaHyyywE4_OX1jAUVPCTK2WyUF=w@mail.gmail.com>
 <1350395094-11404-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 16 15:45:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7Se-0004f2-6v
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 15:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210Ab2JPNpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 09:45:13 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51720 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab2JPNpM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 09:45:12 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so3506445eek.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 06:45:11 -0700 (PDT)
Received: by 10.14.209.129 with SMTP id s1mr21189681eeo.24.1350395111645;
        Tue, 16 Oct 2012 06:45:11 -0700 (PDT)
Received: from gamma.cisco.com (64-103-25-233.cisco.com. [64.103.25.233])
        by mx.google.com with ESMTPS id o47sm11333415eem.11.2012.10.16.06.45.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 06:45:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.609.g5cd6968
In-Reply-To: <1350395094-11404-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207826>

A branch name alias is an alternative name for a branch, that is in most
respects equivalent to using the proper branch name. It is implemented as
a symbolic ref from the alias to the proper branch name.

Currently branch aliases work well up to the point where you try to delete
them (with "git branch -d"), at which point they incorrectly delete the
proper branch name instead of the alias. This is reflected in these tests,
and will be fixed in a subsequent patch.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3220-symbolic-ref-as-branch-alias.sh | 53 +++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 t/t3220-symbolic-ref-as-branch-alias.sh

diff --git a/t/t3220-symbolic-ref-as-branch-alias.sh b/t/t3220-symbolic-ref-as-branch-alias.sh
new file mode 100755
index 0000000..39f3a33
--- /dev/null
+++ b/t/t3220-symbolic-ref-as-branch-alias.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='Using a symbolic ref as a branch name alias
+
+This test uses refs/heads/alias as a symbolic ref to refs/heads/master, and
+verifies that it works as a branch name alias, namely:
+ - commits on "master" are automatically reflected on "alias"
+ - creating or deleting "alias" does not affect "master"
+ - the "alias" is not broken by "git gc"
+'
+. ./test-lib.sh
+
+test_expect_success 'prepare a trivial repository' '
+	echo Hello > A &&
+	git add A &&
+	git commit -m "Hello" &&
+	git rev-parse --verify HEAD > expect
+'
+
+test_expect_success 'create symref: refs/heads/alias -> refs/heads/master' '
+	git symbolic-ref refs/heads/alias refs/heads/master &&
+	git rev-parse --verify master > master &&
+	git rev-parse --verify alias > alias &&
+	test_cmp expect master &&
+	test_cmp expect alias
+'
+
+test_expect_success '"git gc" does not change "alias" symref' '
+	git gc &&
+	git rev-parse --verify master > master &&
+	git rev-parse --verify alias > alias &&
+	test_cmp expect master &&
+	test_cmp expect alias
+'
+
+test_expect_success 'commits are reflected through "alias" symref' '
+	echo World >> A &&
+	git commit -am "A" &&
+	git rev-parse --verify HEAD > expect &&
+	git rev-parse --verify master > master &&
+	git rev-parse --verify alias > alias &&
+	test_cmp expect master &&
+	test_cmp expect alias
+'
+
+test_expect_failure '"branch -d" deletes the "alias" symref' '
+	git branch -d alias &&
+	git rev-parse --verify master > master &&
+	test_must_fail git rev-parse --verify alias &&
+	test_cmp expect master
+'
+
+test_done
-- 
1.7.12.1.609.g5cd6968
