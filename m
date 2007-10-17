From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] When renaming config sections delete conflicting sections
Date: Tue, 16 Oct 2007 20:55:17 -0400
Message-ID: <20071017005517.GJ13801@spearce.org>
References: <20071017003418.GA11013@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Oct 17 02:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhxC8-0003Kv-HN
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbXJQAzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbXJQAzV
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:55:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48947 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbXJQAzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 20:55:21 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhxBk-0007Kd-7Z; Tue, 16 Oct 2007 20:55:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DBB8220FBAE; Tue, 16 Oct 2007 20:55:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071017003418.GA11013@diku.dk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61295>

Jonas Fonseca <fonseca@diku.dk> wrote:
> The old behavior of keeping config sections matching the new name caused
> problems leading to warnings being emitted by git-remote when renaming
> branches where information about tracked remote branches differed. To
> fix this any config sections that will conflict with the new name are
> removed from the config file. Update test to check for this.
...
>  This command sequence was causing problems for me:
> 
> 	git checkout -b test madcoder/next
> 	git checkout -b test2 spearce/next
> 	git branch -M test

Ouch.  But this may cause the user to lose what they might consider
important settings relative to the old section named branch.test.

I think in the case you mention above where you are doing a
`branch -M` the user really does want the basic branch properties
to be forced over (branch.$name.remote, branch.$name.merge) but
they probably do not want other branch properties to be removed
or deleted.  Or maybe they do.

Its really hard to second guess the user's intent here.  I think
its too broad to whack an entire section when renaming.  For example
today lets say I do:

	cat >.git/config <<EOF
	[remote "many"]
		url = blah
		fetch = refs/heads/master
		fetch = refs/heads/next
	EOF

	$ git config remote.many.fetch refs/heads/pu
	Warning: remote.many.fetch has multiple values

	cat .git/config
	[remote "many"]
		url = blah
		fetch = refs/heads/master
		fetch = refs/heads/next

So we don't blindly replace multi-valued keys just because the
user asked us to.  I don't really see a section as being that much
different to warrant a potentially lossy behavior by default.

-- 
Shawn.
