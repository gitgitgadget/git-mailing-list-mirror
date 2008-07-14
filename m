From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Errors importing Apache Synapse SVN using Git
Date: Mon, 14 Jul 2008 01:16:15 -0700
Message-ID: <20080714081615.GB10304@hand.yhbt.net>
References: <4875F5D6.9080906@wso2.com> <4875FA23.30603@wso2.com> <48774A0F.2070805@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Mon Jul 14 10:18:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIJG6-00026t-6y
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 10:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954AbYGNIRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 04:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755976AbYGNIRK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 04:17:10 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38557 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754976AbYGNIRI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 04:17:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D90802DC095
	for <git@vger.kernel.org>; Mon, 14 Jul 2008 01:17:05 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6686D2DC095;
	Mon, 14 Jul 2008 01:16:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48774A0F.2070805@fastmail.fm>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DSPAM-Confidence: 0.9986
X-DSPAM-Probability: 0.0000
X-DSPAM-Processed: Mon Jul 14 01:16:35 2008
X-DSPAM-Result: Whitelisted
X-DSPAM-Signature: 487b0b63151027614567052
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on cpma
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=7.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	SPF_HELO_PASS autolearn=ham version=3.1.7-deb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88397>

Michael J Gruber <michaeljgruber+gmane@fastmail.fm> wrote:
> Asankha C. Perera venit, vidit, dixit 10.07.2008 14:01:
> >Hi All
> >
> >I am an Apache Synapse developer, and want to import the Synapse SVN 
> >repo into Git, so that Ohloh can properly get the Synapse history 
> >(http://www.ohloh.net/topics/1326?page=1#post_6287)
> >
> >However, when I try the command: "git svn clone --trunk=trunk 
> >--tags=tags --branches=branches http://svn.apache.org/repos/asf/synapse" 
> >it seems to take forever, (or at least until the next network glitch), 
> >and keeps filling up a file with just plain zeros ("0") : 
> >./.git/svn/trunk/.rev_db.13f79535-47bb-0310-9956-ffa450edef68

The latest versions of git-svn should be vastly more space efficient
with .rev_map files.
 
> Okay, besides the zero offset, there seems to be big problem with the 
> svn repo:
> 
> svn list -r 234478 http://svn.apache.org/repos/asf/synapse
> branches/
> site/
> tags/
> trunk/
> 
> svn list -r 234478 http://svn.apache.org/repos/asf|grep synapse

Ah, that's because it started off in the /incubator directory, not /synapse:

$ svn log -v -r 234478 http://svn.apache.org/repos/asf
------------------------------------------------------------------------
r234478 | dims | 2005-08-22 05:39:51 -0700 (Mon, 22 Aug 2005) | 3 lines
Changed paths:
   A /incubator/synapse/branches
   A /incubator/synapse/site
   A /incubator/synapse/tags
   A /incubator/synapse/trunk

init synapse SVN


------------------------------------------------------------------------

> Right, nothing returned.
> 
> git-svn insists on using http://svn.apache.org/repos/asf as the base 
> URL, which is basically correct, but doesn't work for this repo.
> 
> Even editing .git/config and .git/svn/metadata (after git svn init, 
> befire the first fetch) to change the url doesn't help. git svn still 
> uses .../asf. Is this as intended? cc'ing the git svn author.

Can you try using the latest git-svn and also --no-follow-parent?

--no-follow-parent won't traverse copy history so it may be faster,
but you'll get an incomplete history.

On the other hand, it looks like the asf repo is hopelessly slow
for history retrieval.

I'm pulling the asf log (svn log -v http://svn.apache.org/repos/asf >
tmp.log) but it's taking forever...  git-svn uses basically the same
operation as 'svn log -v' and I've yet to see an SVN server take this
long to show history.

I've gotten 70,000 revisions after over one hour with the above svn log
command.  I'm going to restart this from a server with a better
connection since I need to power off this one when I sleep.

-- 
Eric Wong
