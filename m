From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/14] tests: document cherry-pick behavior in face of
 conflicts
Date: Sat, 20 Mar 2010 19:28:14 -0500
Message-ID: <20100321002813.GC23681@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:27:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt90j-0005hF-Aa
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab0CUA1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 20:27:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43028 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab0CUA1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:27:16 -0400
Received: by gyg8 with SMTP id 8so2109512gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LQrxmbgi0Qlq/gnNlnE8Pxz1LvQXuv1C4hciRdXNuWo=;
        b=efTehwj08tD4oOs1I9fd5/8ApL4M8fb2vXZ8+By10QfgcWfVI+LJC7YQ0QnKW+NkK+
         hvl30OKSOvtxiJPV4i75Ntckq5CYRzoBov0JR22UpSF4hgFcDcbcPh9k25XMiCXP9cDT
         2qtG5LYGhhgb/lrbcUVIiaMOjyo4siXUvMcTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=x7fnOLB5YKK7vvwMtg2/XiIPftlLKrspsgvdzgoTnQ9yBp5nnwh/R+GIs+PvjMFTr+
         J/NehwGZLPk5Y3sLr9w147J5dVSZEPm1TLnsRCFtWlZzyq8yBT9Xndqap1NetSTaAiFa
         8K74goxY6wK95rJUopWIWBzRBvkYdb7Rp1Y6Y=
Received: by 10.91.9.18 with SMTP id m18mr1979456agi.63.1269131234219;
        Sat, 20 Mar 2010 17:27:14 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1856742iwn.7.2010.03.20.17.27.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:27:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142770>

We are about to change the format of the conflict hunks that
cherry-pick and revert write.  Add tests checking the current behavior
first.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
From http://thread.gmane.org/gmane.comp.version-control.git/142374/focus=142385

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
1.7.0.2
