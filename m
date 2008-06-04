From: Johan Herland <johan@herland.net>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 04 Jun 2008 10:16:25 +0200
Message-ID: <200806041016.26066.johan@herland.net>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
 <7vmym1zny4.fsf@gitster.siamese.dyndns.org>
 <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 10:18:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3oCQ-0004GL-L0
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 10:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbYFDIRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 04:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbYFDIRI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 04:17:08 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52705 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbYFDIRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 04:17:05 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K1X00D11J0CKP00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Jun 2008 10:17:00 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1X00437IZEBO70@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Jun 2008 10:16:26 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1X0099BIZETRJ1@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Jun 2008 10:16:26 +0200 (CEST)
In-reply-to: <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83759>

On Wednesday 04 June 2008, David wrote:
> > rebase --onto?
> 
> Thanks, I checked the manuals further, and it looks like this will
> (mostly) do what I need.
> 
> What's still missing is multiple cherry pick ;-)
> 
> In other words, is there a simple way to *copy* a large number of
> commits from one branch to another, without rebasing?

Depends on you definition of "simple". Here are 5 commands that gets the job done in a (IMHO) conceptually simple way.

Use

	git checkout -b [tmpBranch] [fromBranch]

to create (and checkout) a _new_ branch pointing to the same commit as the "from"-branch. Then use

	git rebase --onto [toBranch] [fromBranchStart] [tmpBranch]

to rebase all commits between [fromBranchStart] and [fromBranch] on top of [toBranch]. Since this was done with HEAD == [tmpBranch], the original [fromBranch] is not moved, and therefore *still* points to the old commits. [tmpBranch], however, have been moved to point at the rebased commits. This in effect *copies* the commits from [fromBranch] to [tmpBranch]. Now, all that remains is to reconcile [tmpBranch] and [toBranch], and finally remove [tmpBranch]:

	git checkout [toBranch]
	git merge [tmpBranch]
	git branch -d [tmpBranch]

The merge should be a simple fast-forward without any conflicts.

Here is an illustrated version of what's going on:

Initial layout:

	          G---H---I  <---- [fromBranch]
	         /
	A---B---C---D---E---F  <-- [toBranch]
	        ^----------------- [fromBranchStart]

git checkout -b [tmpBranch] [fromBranch]

	          G---H---I  <---- [fromBranch]
	         /        ^------- [tmpBranch]      
	A---B---C---D---E---F  <-- [toBranch]
	        ^----------------- [fromBranchStart]

git rebase --onto [toBranch] [fromBranchStart] [tmpBranch]

	          G---H---I  <------------------- [fromBranch]
	         /              
	A---B---C---D---E---F---G'---H'---I'  <-- [tmpBranch]
	        ^           ^-------------------- [toBranch]
	        --------------------------------- [fromBranchStart]

git checkout [toBranch]
git merge [tmpBranch]
git branch -d [tmpBranch]

	          G---H---I  <------------------- [fromBranch]
	         /              
	A---B---C---D---E---F---G'---H'---I'  <-- [toBranch]
	        ^-------------------------------- [fromBranchStart]


This should also work even if your commit graphs are considerably more complicated.

If you need to drop/edit/squash any commits between [fromBranchStart] and [fromBranch], simply add a "--interactive" to the rebase command.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
