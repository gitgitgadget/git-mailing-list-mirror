From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess,iffy] Re: [spf:guess,iffy] [PATCH] git-svn: teach
 git-svn to populate svn:mergeinfo
Date: Fri, 02 Sep 2011 12:01:09 -0700
Message-ID: <4E6127F5.5070009@vilain.net>
References: <20110902140702.066a4668@robyn.woti.com> <4E612319.7030006@vilain.net> <20110902144922.383ed0f1@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 21:01:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzYzP-0002bn-1T
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 21:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab1IBTBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 15:01:13 -0400
Received: from uk.vilain.net ([92.48.122.123]:52782 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827Ab1IBTBL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 15:01:11 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id A8282824E; Fri,  2 Sep 2011 20:01:10 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.112.205] (unknown [64.125.143.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id C68678176;
	Fri,  2 Sep 2011 20:01:07 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.1) Gecko/20110830 Thunderbird/6.0.1
In-Reply-To: <20110902144922.383ed0f1@robyn.woti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180632>

On 9/2/11 11:49 AM, Bryan Jacobs wrote:
> I could do a pass through all the commits which are about to be sent
> out to SVN to check if this is going to happen, yes. But I think a
> better solution would be to change how the changes are replayed by
> git-svn dcommit: right now, all changes are applied to the WC, then it
> sequentially does an add+dcommit for each patch? Right? I think it might
> be better to reset --hard to the parent, then pick each change into the
> WC+index before committing. That way if you abort early, cleaning up
> just consists of rebasing the stack onto the last change you sent
> upstream.

That's one way to do it; in fact, if the trees match you don't need to 
do anything complicated like cherry-pick.

ie, say you're committing

    r1---A---B---C---D

and it blows up at

    r1--r2--r3--C---D

So long as the tree from the fetched r3 == the tree from B, then you can 
just go ahead and write out new commits for C and D without doing any 
merging (ie cherry-pick or rebase).  You could also put merge commits 
back the way they were, too.

If they don't match, then something went wrong with the push really, or 
there is something weird going on.  I'd try to avoid using cherry pick 
automatically in situations like this.  There are too many error modes, 
and if it only happens when you don't know what's going on, it's not a 
good idea to try to fix that.  If it /is/ a sufficiently unlikely error 
(ie, the trees not matching as above), then it would be better to simply 
bomb out and provide two commands:

* a 'git reset' command to restore to previous state (ie, before the 
dcommit)
* a 'git rebase' command to attempt to put the new history on top of the 
new upstream.  Rebase doesn't work with merges of course but it still 
should help the user figure out what to do.

Another benefit of this approach is that you don't need to muck with the 
WC + index at all, no matter what happens.

Sam
