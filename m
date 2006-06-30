From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating diff from 2.6.16 from cryptodev-2.6 git tree
Date: Thu, 29 Jun 2006 19:25:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606291904250.12404@g5.osdl.org>
References: <44A47BE0.9060504@logix.cz> <20060630013627.GA27527@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michal Ludvig <michal@logix.cz>, linux-crypto@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 04:25:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw8h9-0006PG-5B
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 04:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWF3CZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 22:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWF3CZS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 22:25:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751416AbWF3CZQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 22:25:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5U2P2nW009852
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 19:25:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5U2P19Z022015;
	Thu, 29 Jun 2006 19:25:01 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20060630013627.GA27527@gondor.apana.org.au>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22945>



On Fri, 30 Jun 2006, Herbert Xu wrote:
>
> On Fri, Jun 30, 2006 at 01:18:24PM +1200, Michal Ludvig wrote:
> > 
> > just a quick question: how can I create a patch with all changes in
> > cryptodev-2.6 tree against tag v2.6.16 in Linus tree? I've got
> > git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> > cloned here and want to extract all your commits in this tree since
> > 2.6.16. Is there a way to do it in Git/Cogito?
> 
> OK, it's easier if you break this into three problems.
> 
> You start by getting all the changes merged right after 2.6.16.  This
> can be done by locating the merge changeset in Linus's tree.  It looks
> like this:

Actually, there are certainly other, potentially easier, ways to do this.

It depends a bit on what Michal wants, though. Since the current trees 
(both mine and the cryptodev tree) have been merging things back and 
forth, it's _not_ as easy as just saying "pick all commits that exist in 
one branch but not the other", but depending on what Michal wants to do, 
git gives other ways to prune out just the info he wants.

The easiest by far is if you only care about a certain sub-directory. 
Then, assuming the branch "crypto" is the top-most commit of the cryptodev 
repo, just do

	git diff v2.6.16..crypto -- crypto/

and that will give you a diff of all the changes since v2.6.16 inside that 
subdirectory. That may or may not be sufficient and what Michal wants.

Now, the cryptodev-2.6.git tree doesn't even contain the v2.6.16 tags, but 
you can fix that by just doing

	git fetch --tags git://git.kernel.org//pub/scm/linux/kernel/git/torvalds/linux-2.6

even if your clone is actually from just the cryptodev-2.6 archive.

Alternatively, if you want to see the individual changes, you can just do

	git log -p --full-diff v2.6.16..crypto -- crypto/

which shows you all the commits that changed the crypto/ subdirectory, AND 
it shows the other changes those same commits did to other subdirectories 
too (which is usually something you want in a case like this).

Finally, what you can also do is that instead of matching for stuff that 
changed the crypto/ subdirectory, you could try to match commits where the 
committer is somebody special, eg Herbert Xu. We don't have that kind of 
thing automated, but here's one way to do it:

	git-rev-list --header v2.6.16..crypto |
		grep -z 'committer Herbert Xu' |
		tr '\0' '\n' |
		sed -n '/^[a-f0-9][a-f0-9]*$/p' |
		git diff-tree --pretty -p --stdin |
		less -S

where the "git-rev-list --header | grep -z" part picks out any commits 
committed by Herbert, the "tr '\0' '\n' | sed -n" part then picks up just 
the commit ID's from those lines, and the "git-diff-tree" part then shows 
those commits as diffs.

(The above should really be quite possible to shorten as

	git log -p --committer="Herbert Xu"

but we don't actually support git-rev-list doing matching on 
committer/author names - although it should be easy to do in case somebody 
wants to have a small git project to get their toes wet, hint hint)

			Linus
