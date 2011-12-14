From: Brian Gernhardt <benji@silverinsanity.com>
Subject: t0090-cache-tree fails due to wc whitespace
Date: Wed, 14 Dec 2011 09:35:55 -0500
Message-ID: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Rast <trast@student.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 15:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raq3h-00038u-UA
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab1LNOnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 09:43:45 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50538 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1LNOno convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 09:43:44 -0500
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Dec 2011 09:43:44 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id A80B21FFC449; Wed, 14 Dec 2011 14:35:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [129.21.210.202] (bcg2784.student.rit.edu [129.21.210.202])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id A25FC1FFC447;
	Wed, 14 Dec 2011 14:35:53 +0000 (UTC)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187122>

It's time for my periodic complaint:  People assuming `wc -l` outputs just a number.  wc on OS X (and perhaps other BSD-like systems) always aligns the output in columns, even with the -l flag.  Generally this results in a quick patch from me to remove some unneeded quotes.  However, this time it's used in a more complex manner:

	echo "SHA " \
	    "($(git ls-files|wc -l) entries, 0 subtrees)" >expect &&
	cmp_cache_tree expect

This results in errors like:

--- expect	2011-12-14 14:26:26.000000000 +0000
+++ filtered	2011-12-14 14:26:26.000000000 +0000
@@ -1 +1 @@
-SHA  (       1 entries, 0 subtrees)
+SHA  (1 entries, 0 subtrees)

I was able to fix this by adding a sed command to remove leading spaces:

-           "($(git ls-files|wc -l) entries, 0 subtrees)" >expect &&
+           "($(git ls-files|wc -l|sed -e 's/^ *//') entries, 0 subtrees)" >expect &&

But I'm not sure if this is the best way to solve the issue.

~~ Brian Gernhardt
