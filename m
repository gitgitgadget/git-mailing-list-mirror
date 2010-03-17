From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/16] tests: document cherry-pick behavior in face of
 conflicts
Date: Wed, 17 Mar 2010 07:13:54 -0500
Message-ID: <20100317121354.GJ25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:13:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrs7z-00023e-VT
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab0CQMNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 08:13:31 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:36252 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab0CQMNa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:13:30 -0400
Received: by pxi36 with SMTP id 36so449197pxi.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Fcivd9nd2KLqW2X53f9w39+bIwBfPbE6cKscPcBBOvY=;
        b=uzaAJx26aevDY1PCrpwe4rZToGFK0F/8stVBoWgMpPPlvlBF7VrBZVvIFeOJeYwacH
         Nv3gbXYxffNUTkkPqpGQQ8A3uLi6aP/s4WM3Q7wDi2KjvMMeUMNYG6h1fnhO1WG8YoSo
         P5uLgwix1fJzBtLMiFqJ5DXWSE867QntEFRF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CF/7+MnPAhyhQKiNB/TpK4vOru+60iFEKPhyasG7biH73Sd2ewzCZUyWn2fhcnYBYg
         jpbXoAqIrbxmA7bVWtgTj3WJNad99ZCfgk8U3fpm0VB1L2MOu5swS7i6iWIwu9Lgu9ui
         xmUMLQd8g9CxXmDLPpeUbYmOkfTWCmIItCoTg=
Received: by 10.114.8.7 with SMTP id 7mr559500wah.211.1268828010010;
        Wed, 17 Mar 2010 05:13:30 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm628912iwn.4.2010.03.17.05.13.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:13:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142385>

We are about to change the format of the conflict hunks that
cherry-pick and revert write.  Add tests checking the current behavior
first.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh |  198 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 198 insertions(+), 0 deletions(-)
 create mode 100644 t/t3507-cherry-pick-conflict.sh

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
new file mode 100644
index 0000000..e856356
--- /dev/null
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -0,0 +1,198 @@
+#!/bin/sh
+
+test_description='test cherry-pick and revert with conflicts
+
+  -
+  + picked: rewrites foo to c
+  + base: rewrites foo to b
+  + initial: writes foo as a, unrelated as unrelated
+
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo unrelated >unrelated &&
+	git add unrelated &&
+	test_commit initial foo a &&
+	test_commit base foo b &&
+	test_commit picked foo c &&
+	git config advice.detachedhead false
+
+'
+
+test_expect_success 'failed cherry-pick does not advance HEAD' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick picked &&
+	newhead=$(git rev-parse HEAD) &&
+
+	test "$head" = "$newhead"
+'
+
+test_expect_success 'failed cherry-pick produces dirty index' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+
+	test_must_fail git update-index --refresh -q &&
+	test_must_fail git diff-index --exit-code HEAD
+'
+
+test_expect_success 'failed cherry-pick registers participants in index' '
+
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+	{
+		git checkout base -- foo &&
+		git ls-files --stage foo &&
+		git checkout initial -- foo &&
+		git ls-files --stage foo &&
+		git checkout picked -- foo &&
+		git ls-files --stage foo
+	} > stages &&
+	sed "
+		1 s/ 0	/ 1	/
+		2 s/ 0	/ 2	/
+		3 s/ 0	/ 3	/
+	" < stages > expected &&
+	git checkout -f initial^0 &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+	git ls-files --stage --unmerged > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'failed cherry-pick describes conflict in work tree' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+	cat <<-EOF > expected &&
+	<<<<<<< HEAD
+	a
+	=======
+	c
+	>>>>>>> objid picked
+	EOF
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+
+	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'diff3 -m style' '
+
+	git config merge.conflictstyle diff3 &&
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+	cat <<-EOF > expected &&
+	<<<<<<< HEAD
+	a
+	|||||||
+	b
+	=======
+	c
+	>>>>>>> objid picked
+	EOF
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+
+	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'revert also handles conflicts sanely' '
+
+	git config --unset merge.conflictstyle &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+	cat <<-EOF > expected &&
+	<<<<<<< HEAD
+	a
+	=======
+	b
+	>>>>>>> objid picked
+	EOF
+	{
+		git checkout picked -- foo &&
+		git ls-files --stage foo &&
+		git checkout initial -- foo &&
+		git ls-files --stage foo &&
+		git checkout base -- foo &&
+		git ls-files --stage foo
+	} > stages &&
+	sed "
+		1 s/ 0	/ 1	/
+		2 s/ 0	/ 2	/
+		3 s/ 0	/ 3	/
+	" < stages > expected-stages &&
+	git checkout -f initial^0 &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git revert picked &&
+	newhead=$(git rev-parse HEAD) &&
+	git ls-files --stage --unmerged > actual-stages &&
+
+	test "$head" = "$newhead" &&
+	test_must_fail git update-index --refresh -q &&
+	test_must_fail git diff-index --exit-code HEAD &&
+	test_cmp expected-stages actual-stages &&
+	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'revert conflict, diff3 -m style' '
+	git config merge.conflictstyle diff3 &&
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+	cat <<-EOF > expected &&
+	<<<<<<< HEAD
+	a
+	|||||||
+	c
+	=======
+	b
+	>>>>>>> objid picked
+	EOF
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git revert picked &&
+
+	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.0
