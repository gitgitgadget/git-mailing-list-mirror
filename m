Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412631FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 19:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbcFUTpD (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 15:45:03 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:52198 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbcFUTpB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 15:45:01 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 29D3234081F
	for <git@vger.kernel.org>; Tue, 21 Jun 2016 19:44:55 +0000 (UTC)
Received: (qmail 15443 invoked by uid 10000); 21 Jun 2016 19:44:55 -0000
Date:	Tue, 21 Jun 2016 19:44:55 +0000
From:	"Robin H. Johnson" <robbat2@gentoo.org>
To:	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Cc:	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes
 >= 8GB
Message-ID: <robbat2-20160621T185126-722667990Z@orbis-terrarum.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160616043733.GA18323@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 12:37:33AM -0400,  Jeff King wrote:
> We could ship just the resulting compressed object data as a
> loose object, but even that takes 64MB. So sadly, this code
> path remains untested in the test suite.
Additionally compress the object data, and insert it for the purpose of
testing? It's still an expensive test time-wise, but repeated
gzip compression on zeros does still help; to that end, here's the
pieces to add a testcase while only being <9KiB.

t5005-archive-hugefile.sh:
...
mkdir t
zcat t5005-barerepo-64gb-obj.tar.gz.gz | tar xzf - -C t
GIT_DIR=t git archive HEAD | head -c 10000 | tar tvf - 2>/dev/null
...

Test repo attached, it's only 8KiB.

Test repo can be recreated with:
truncate -s 64g bigfile
git add bigfile # takes 10 mins
git commit -q -m foo # takes another 10 minutes
tar cf - -C .git . |gzip -9 --no-name |gzip -9f --no-name >barerepo.tar.gz.gz


-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
