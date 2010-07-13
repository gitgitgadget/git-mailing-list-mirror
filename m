From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: VERY slow git format-patch (tens on minutes) during rebase and
 rev-list during rebase -i
Date: Tue, 13 Jul 2010 10:12:25 +0200
Message-ID: <4C3C1FE9.40605@drmicha.warpmail.net>
References: <loom.20100713T082913-327@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Jul 13 10:14:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYacq-0002bF-FZ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 10:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab0GMINb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 04:13:31 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51098 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754214Ab0GMIN0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 04:13:26 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9577916D1E9;
	Tue, 13 Jul 2010 04:13:25 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 13 Jul 2010 04:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=tfqPjlG0JHHrC3bPa4KfFlhta88=; b=PJSWEH/bOBTUoLzOwyTJE65HpNkriUBiTIngmnN8OLic/sqr7fXnPZ9a3WJ0N4OQuzTxQviW4NxuUalvBWC5+cJNqkKtdH9ttX9tO0XzTd9xminqVM1mnNyrVhMFwIMm2n6urEwtUrUGTIknFRPQmaww5CLF7mni8CDF2//Z7mo=
X-Sasl-enc: ncpEHr7H3YKHVSZ3ALaX1em75/hmG3PnU3oKb/HHOOAh 1279008805
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F1E704F4182;
	Tue, 13 Jul 2010 04:13:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <loom.20100713T082913-327@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150886>

Marat Radchenko venit, vidit, dixit 13.07.2010 08:56:
> Hi.
> 
> My setup:
> 0. Quad-code machine with 8GB of ram, 10K RPM hdd.
> 1. SVN repo that i periodically fetch into origin/trunk branch. Has ~200 
> commits/day.
> 2. My local branch with 1-5 commits which i often rebase against trunk.
> 3. I haven't rebased for 2 days, so i'm rebasing 3 (three) commits in my branch 
> over 453 commits in trunk using "git rebase trunk".
> 4. trunk does contain "bad" from diff POV files (big & binary).
> 5. Sadly, data in repo is confidential.
> 
> Expected: rebase takes some reasonable amount of time (< 1 min?).
> 
> Actual: rebase takes 20 mins.
> 
> Almost all of that time was spent doing `git format-patch -k --stdout --full-
> index --ignore-if-in-upstream 
> 80bb0dfe3d86f3cc9095ea616d9d1b1530fbe7b8..d3fde4ae7497981a6fe61b0366b105477896cf
> 52` (that's three commits from my branch) at 100% of one CPU core.
> 
> Additional info:
> 
> Another similar rebase but over 4.5k of commits took 2 hours.
> 
> Running without --ignore-if-in-upstream:
> $ time git format-patch -k --stdout --full-index 
> 80bb0dfe3d86f3cc9095ea616d9d1b1530fbe7b8..d3fde4ae7497981a6fe61b0366b105477896cf
> 5 | wc -l
> 25823
> Is it 
> real	0m0.163s
> user	0m0.140s
> sys	0m0.020s
> 
> Proof there are only three commits:
> 
> $ git rev-list 
> 80bb0dfe3d86f3cc9095ea616d9d1b1530fbe7b8..d3fde4ae7497981a6fe61b0366b105477896cf
> 52d3fde4ae7497981a6fe61b0366b105477896cf52
> e18069258806bda6a6165822003f5e9fd958f906
> c8c2f2e157e615b73d0baab1d793a22991c9ba71
> 
> Questions:
> 1. Is it expected behavior (branch you rebase onto has binary files -> no 
> performance for you)?

Well, with "ignore-if-in-upstream" git has to compute a patch-id for
every upstream patch (merge-base..upstream) and compare to the ids of
the commits in mb..HEAD.

> 2. If [1] is yes, is it possible to prevent rebase from running --ignore-if-in-
> upstream?

Not currently, but with my upcoming patch ;)

This has the (side-) effect of not ignoring patches which have been
applied (with different sha1) upstream, of course.

> 3. If [1] is no, should i run some kind of profiler (how?) to determine what 
> exactly causes such performance drop?

It is the calculation of the patch-ids. Git first creates a "binary
diff" and then computes the patch-id (sha1) of that diff. I am sure we
could optimize the calculation of patch-ids for binary diffs, which may
be useful in addition to shutting off "cherry" with rebase.

Michael
