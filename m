From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Sun, 11 Dec 2011 17:48:14 -0800
Message-ID: <4EE55D5E.1090908@pcharlan.com>
References: <4EDBF4D5.6030908@pcharlan.com> <7vbormn8vk.fsf@alter.siamese.dyndns.org> <4EDF1631.5090906@pcharlan.com> <7vvcpqj4vr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 02:49:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZv0m-0002UX-DR
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 02:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab1LLBs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 20:48:56 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:33951 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab1LLBsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 20:48:55 -0500
Received: from homiemail-a54.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id BAD9617D44A
	for <git@vger.kernel.org>; Sun, 11 Dec 2011 17:48:54 -0800 (PST)
Received: from homiemail-a54.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a54.g.dreamhost.com (Postfix) with ESMTP id 394F83A4065;
	Sun, 11 Dec 2011 17:48:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=oFNfVZr90L7jnSK7r6EqLGef/GKX6HNpbIPouuILgzxW4z0UbsHAcqSTloU0k
	ScqD/i70vRFKD8BTNBQZPCPi7VORzEz34GIOQBty+8WzgdzqAkyeRLFuEWcRKszx
	ybHE2HwoeWIawscQNClZhv7fXu7i8wCSq/OBXF72fAiYBE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=uODH
	713N5vEXzbepxVhudqdAwWo=; b=VSTpmnUO3en1DLTCSYg+2WBgTfV+WPjWrPA3
	AsiSE175LRchXTHY3pNDAC+tfgd1SV049O7X2HJF3APh26Ic14ngIPQ5l9ik1wEj
	Si14vs6Kbwjo5HfeFsFiC1I9cf/b/LGheb3hptufOHDjKgFYz7/baGx0j5wFkO5j
	1edE/SE=
Received: from [192.168.0.102] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pgit@pcharlan.com)
	by homiemail-a54.g.dreamhost.com (Postfix) with ESMTPSA id 25C853A4058;
	Sun, 11 Dec 2011 17:48:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <7vvcpqj4vr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186821>

On 12/08/2011 10:27 AM, Junio C Hamano wrote:
> Pete Harlan <pgit@pcharlan.com> writes:
> 
>> to "ours" and "theirs".  (The same thing happens in the 3-way merge
>> case.)
> 
> That is entirely expected. "checkout -m" does not know or care _how_ the
> index came to the conflicted state and reproduces the three-way conflicted
> state in the file in the working tree solely from the contents of the
> index which records only what the common thing looked like (stage #1),
> what one side looked like (stage #2) and what the other side looked like
> (stage #3) before the mergy operation began, so there is no way for it to
> say "the other side came from foo/blah branch". There are even cases where
> the conflict originally came not from any branch (think "am -3").

Thanks for taking the time to explain this.

Here's a test that strips branch info off the conflict lines before
verifying checkout -m, and it tests both the 2-way and 3-way cases.
The 3-way works before and after your patch; the 2-way fails before
your patch but passes after.  If the you think the test is worth
including feel free to fold it in to your patch.

--Pete

-------------------

>From a4522e06515231034c1ada65e1e91614a6c4809e Mon Sep 17 00:00:00 2001
From: Pete Harlan <pgit@pcharlan.com>
Date: Tue, 6 Dec 2011 23:01:28 -0800
Subject: [PATCH] Test 'checkout -m -- path'

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---
 t/t2023-checkout-m.sh |   47
+++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100755 t/t2023-checkout-m.sh

diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
new file mode 100755
index 0000000..1a40ce0
--- /dev/null
+++ b/t/t2023-checkout-m.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='checkout -m -- <conflicted path>
+
+Ensures that checkout -m on a resolved file restores the conflicted file'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	test_commit both.txt both.txt initial &&
+	git branch topic &&
+	test_commit modified_in_master both.txt in_master &&
+	test_commit added_in_master each.txt in_master &&
+	git checkout topic &&
+	test_commit modified_in_topic both.txt in_topic &&
+	test_commit added_in_topic each.txt in_topic
+'
+
+test_must_fail git merge master
+
+clean_branchnames () {
+	# Remove branch names after conflict lines
+	sed 's/^\([<>]\{5,\}\) .*$/\1/'
+}
+
+test_expect_success '-m restores 2-way conflicted+resolved file' '
+	cp each.txt each.txt.conflicted &&
+	echo resolved >each.txt &&
+	git add each.txt &&
+	git checkout -m -- each.txt &&
+	clean_branchnames <each.txt >each.txt.cleaned &&
+	clean_branchnames <each.txt.conflicted >each.txt.conflicted.cleaned &&
+	test_cmp each.txt.conflicted.cleaned each.txt.cleaned
+'
+
+test_expect_success '-m restores 3-way conflicted+resolved file' '
+	cp both.txt both.txt.conflicted &&
+	echo resolved >both.txt &&
+	git add both.txt &&
+	git checkout -m -- both.txt &&
+	clean_branchnames <both.txt >both.txt.cleaned &&
+	clean_branchnames <both.txt.conflicted >both.txt.conflicted.cleaned &&
+	test_cmp both.txt.conflicted.cleaned both.txt.cleaned
+'
+
+test_done
-- 
1.7.8
