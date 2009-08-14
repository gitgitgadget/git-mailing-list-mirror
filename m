From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: merging individual files
Date: Fri, 14 Aug 2009 09:55:51 +0200
Message-ID: <4A851887.5010701@drmicha.warpmail.net>
References: <loom.20090813T192334-7@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Marshall <christopher.marshall@merchantlink.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbre5-0007WF-Qi
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483AbZHNH4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 03:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756474AbZHNH4J
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:56:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36916 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756470AbZHNH4I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 03:56:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 53DC84CF8C;
	Fri, 14 Aug 2009 03:56:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 14 Aug 2009 03:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dSij+qK8bnrGcPKT33xr8CMnkwc=; b=U24qgsBaQPKBB+tByLl7V0N9MYbpHZ6dcja7dECVzas+z5Gs38vuFAjims32KD4UmP97QR4mhQdYCiV/FmVeATwD1bzTT4xN+adW/Tnj2BBu5qUxoNVZ/nPXO06VxOJiMbzf7ahHWHZ4/WWnSvOKE7Z7u0KyK9vRy6JsnkFvOws=
X-Sasl-enc: datCxLRzanixOwU357K5podWsOgSE+x75z6xwI1w2Xbi 1250236565
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A019E2B8B5;
	Fri, 14 Aug 2009 03:56:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <loom.20090813T192334-7@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125917>

Chris Marshall venit, vidit, dixit 13.08.2009 22:16:
> Suppose that merging branch dev1 into master would result in three files, f1,
> f2, and f3 being changed, and that I only want to merge the changes for f1 and
> f2 and not the changes for f3 currently.  Later on, I want to accept the f3
> changes.  Suppose further that the changes to f1, f2, and f3 occurred in a
> single commit to branch dev1.
> 
> What is the simplest way to use git to achieve that effect?
> 
> More generally, I need a way to accept the changes for one or two files while
> rejecting the changes for a potentially large number of files, then later on 
> accepting the changes for the large number of files.
> 
> I work at a company where perforce is currently used for all development and am
> trying to work out the git equivalents to all of the perforce flows we use. 
> This workflow is the only one that I am stumped on.
> 
> One solution that occurs to me is to create a temporary branch off of the (most
> recent) common ancestor of master and br1, let's say br2, checkout the files
> from br1 that I want to merge into master and commit those to br2, then merge
> br2 into master:
> 
> git checkout common_ancestor_commit
> git checkout -b br2
> git checkout br1 f1 f2
> git commit
> git checkout master
> git merge br2
> git branch -d br2
> 
> This strikes me as not too bad of a procedure, as long as there is a graceful
> way of determining the most recent common ancestor of br1 and master.  What's
> the simplest way of doing that?
> 

That would be simply git merge-base master br1.

BUT: The main problem here is that git is not file based, but
revision/commit/tree based. In the above, you're basically losing all
the history common_ancestor_commit..br1 which produced br1's version of
f1 and f2, in the sense that a git log master will not show that part of
the history at all.

If it makes sense to change f1 and f2 without changing f3 that probably
means that the pertinent commit should have been split. Is it an option
for you to rewrite br1's history? That would be the most gittish solution.

Alternatively, you could
git checkout master
git merge --no-commit br1
git checkout --ours f3
git commit # add a note about f3 in the commit message

That way at least you have the full history on master. Note that this
will tell git that br1 is merged in, that is you can't use merge later
on to pull in the changes to f3.
Then, when you want to get that change to f3, you can br1's version of
f3 using git checkout br1 -- f3 and committing that to master. But you
should really rewrite br1 ;)

Michael
