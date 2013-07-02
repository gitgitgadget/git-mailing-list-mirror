From: Martin Fick <mfick@codeaurora.org>
Subject: How to still kill git fetch with too many refs
Date: Mon, 1 Jul 2013 21:02:31 -0600
Organization: CAF
Message-ID: <201307012102.31384.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 05:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtqrW-0003l2-6y
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 05:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab3GBDCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 23:02:33 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:43699 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab3GBDCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 23:02:33 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id D2AB113EF13;
	Tue,  2 Jul 2013 03:02:32 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id C4F5213EFFB; Tue,  2 Jul 2013 03:02:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CD6B13EF13
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 03:02:32 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229355>

I have often reported problems with git fetch when there are 
many refs in a repo, and I have been pleasantly surprised 
how many problems I reported were so quickly fixed. :) With 
time, others have created various synthetic test cases to 
ensure that git can handle many many refs.  A simple 
synthetic test case with 1M refs all pointing to the same 
sha1 seems to be easily handled by git these days.  However, 
in our experience with our internal git repo, we still have 
performance issues related to having too many refs, in our 
kernel/msm instance we have around 400K.

When I tried the simple synthetic test case and could not 
reproduce bad results, so I tried something just a little 
more complex and was able to get atrocious results!!! 
Basically, I generate a packed-refs files with many refs 
which each point to a different sha1.  To get a list of 
valid but unique sha1s for the repo, I simply used rev-list.  
The result, a copy of linus' repo with a million unique 
valid refs and a git fetch of a single updated ref taking a 
very long time (55mins and it did not complete yet).  Note, 
with 100K refs it completes in about 2m40s.  It is likely 
not linear since 2m40s * 10 would be ~26m (but the 
difference could also just be how the data in the sha1s are 
ordered).


Here is my small reproducible test case for this issue:

git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
cp -rp linux linux.1Mrefs-revlist

cd linux
echo "Hello" > hello ; git add hello ; git ci -a -m 'hello'
cd ..

cd linux.1Mrefs-revlist
git rev-list HEAD | for nn in $(seq 0 100) ; do for c in 
$(seq 0 10000) ; do  read sha ; echo $sha refs/c/$nn/$c$nn ; 
done ; done > .git/packed-refs

time git fetch file:///$(dirname $PWD)/linux 
refs/heads/master

Any insights as to why it is so slow, and how we could 
possibly speed it up?

Thanks,

-Martin

PS: My tests were performed with git version 1.8.2.1 on 
linux 2.6.32-37-generic #81-Ubuntu SMP 


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
