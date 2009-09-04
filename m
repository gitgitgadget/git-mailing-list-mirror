From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/9] apply --whitespace=fix: detect new blank lines at
 eof   correctly
Date: Fri, 04 Sep 2009 14:02:03 +0200
Message-ID: <4AA101BB.7010206@viscovery.net>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com> <1252061718-11579-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:02:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjXUm-0006cy-Fk
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 14:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbZIDMCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 08:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755579AbZIDMCO
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 08:02:14 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48539 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbZIDMCN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 08:02:13 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MjXUR-0002L6-VC; Fri, 04 Sep 2009 14:02:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AFC17A4A1; Fri,  4 Sep 2009 14:02:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1252061718-11579-3-git-send-email-gitster@pobox.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127723>

Junio C Hamano schrieb:
> The command tries to strip blank lines at the end of the file added by a
> patch.  However, if the original ends with blank lines, often the patch
> hunk ends like this:
> 
>     @@ -l,5 +m,7 @@$
>     _context$
>     _context$
>     -deleted$
>     +$
>     +$
>     +$
>     _$
>     _$
> 
> where _ stands for SP and $ shows a end-of-line.  This example patch adds
> three trailing blank lines, but the code fails to notice it, because it
> only pays attention to added blank lines at the very end of the hunk.  In
> this example, the three added blank lines do not appear textually at the
> end in the patch, even though you can see that they are indeed added at
> the end, if you rearrange the diff like this:
> 
>     @@ -l,5 +m,7 @@$
>     _context$
>     _context$
>     -deleted$
>     _$
>     _$
>     +$
>     +$
>     +$
> 
> Fix this by not resetting the number of (candidate) added blank lines at
> the end when the loop sees a context line that is empty.

After reading this explanation, I was worried that added blank lines that
are at the end of a patch but apply in the middle of a file would be
mis-attributed as blank lines at EOF. But appearently, they are not, i.e.
such added blank lines are not removed. Could you squash in this test case
that checks for this condition.

-- Hannes

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ba2b7f9..fedc8b9 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -189,4 +189,16 @@ test_expect_success 'blank at EOF with --whitespace=fix (3)' '
 	test_cmp expect one
 '

+test_expect_success 'blank at end of hunk, not at EOF with --whitespace=fix' '
+	{ echo a; echo b; echo; echo; echo; echo; echo; echo d; } >one &&
+	git add one &&
+	{ echo a; echo c; echo; echo; echo; echo; echo; echo; echo d; } >expect &&
+	cp expect one &&
+	git diff -- one >patch &&
+
+	git checkout one &&
+	git apply --whitespace=fix patch &&
+	test_cmp expect one
+'
+
 test_done
