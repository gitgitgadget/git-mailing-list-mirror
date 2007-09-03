From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 03 Sep 2007 15:49:50 +0200
Message-ID: <46DC10FE.1080805@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 15:50:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISCJs-0005nZ-9f
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 15:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbXICNt4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 09:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbXICNt4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 09:49:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48485 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbXICNtz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 09:49:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ISCJK-0007Cx-LJ; Mon, 03 Sep 2007 15:49:52 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DB69F9614; Mon,  3 Sep 2007 15:49:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46DBFA2A.7050003@trolltech.com>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.365, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57485>

Marius Storm-Olsen schrieb:
> There was a problem with racy conditions, which this revision fixes.
> The problem was that fstat was using the builtin implementation, which for
> for some reason is off by some amount of seconds. (This is probably due to
> some leap-year issue in one of the implementations. However, Microsoft 
> tells
> us to use 116444736000000000 in http://support.microsoft.com/kb/167296, so
> I'll stick with that.)

Thanks for the analysis and new patch. Indeed, FILETIME is UTC, which is 
good; the native implementation returns local time, if I read the code 
(of msvcrt) correctly.

> With the our own implementations of lstat & fstat, the following test cases
> are now fixed:
>     t4116-apply-reverte.sh
>         ok 3: apply in reverse
>     t4200-rerere.sh
>         ok 17: young records still live
> However, the following test cases seems to fail now:
>     t6024-recursive-merge.sh
>         FAIL 1: setup tests
>         FAIL 3: result contains a conflict
>         FAIL 4: virtual trees were processed
>         FAIL 5: refuse to merge binaries
> 
> See attached test case logs.
> Are some of these test cases unstable, so the result will fluctuate on
> Windows?

I see many more failures. in:

t4001-diff-rename.sh: 5
t4101-apply-nonl.sh: all
t4102-apply-rename.sh: 2,3,4
t4116-apply-reverse.sh: 3
t4200-rerere.sh: 12,13,17
t5515-fetch-merge-logic.sh: 54
etc...

There is something fishy going on.

But at least the failure in t4116 is easy to work around:

diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index fc2f622..f3e0c4a 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -43,7 +43,8 @@ test_expect_success 'apply in reverse' '
         git reset --hard second &&
         git apply --reverse --binary --index patch &&
         git diff >diff &&
-       git diff /dev/null diff
+       : > empty &&
+       git diff empty diff

  '

-- Hannes
