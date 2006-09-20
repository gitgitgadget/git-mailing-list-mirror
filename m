From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 09:15:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609200902190.4388@g5.osdl.org>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:23:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4qZ-0004Nv-IG
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWITQWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWITQWt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:22:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751736AbWITQWs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:22:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KGF5nW021017
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 09:15:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KGF4qv002666;
	Wed, 20 Sep 2006 09:15:04 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060920155431.GO8259@pasky.or.cz>
X-Spam-Status: No, hits=-0.507 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27366>



On Wed, 20 Sep 2006, Petr Baudis wrote:
> 
> This is really a wrong way of describing the problem - I'd say that Git
> is being difficult here.

I'm sorry, but no.

Git has been designed from the ground up for safety and security. 
Performance was one big issue, but at every turn, _integrity_ of the 
archive has always been a much more important one.

I realize that a lot of people don't think "integrity" matters. I'm sorry, 
but those people are simply wrong. In an SCM, "integrity" is the _only_ 
thing that matters. Everything else is just fluff.

> The point is, the subsystem maintainers need to maintain stacks of 
> patches and rebase against the main kernel branch regularily, and they 
> want to still publish their current state.

And git supports that.

> So it's not really any of them being strange or difficult, but Git being 
> so because it has no seamless support for tracking those branches.

It _does_ have seamless support for tracking those branches, but git had 
DAMN WELL BETTER MAKE SURE THAT NO INFORMATION GETS LOST!

That's the one and _only_ thing a SCM had better always guarantee.

The fact that very few systems guarantee it, and that you can mess around 
any which way you damn well want in most other systems, without the user 
being any wiser is a BUG in those systems. The fact that you can edit 
(and/or move around) the raw CVS files after-the-fact, and nobody will 
ever know is _bad_. That other systems allow it even today is just a 
disgrace.

We may have some bugs in git, but modulo those, I hope the design is 
actually very reliable. If you pull from some other repository, you're 
guaranteed that you won't suddenly have lost your old state just because 
the other end had a mistake.

People had better understand that git does support rebasing, but also 
understand that THAT DESTROYS HISTORY. If you don't understand that, then 
you shouldn't be told about it. Which is exactly what git does.

The thing is, if you don't understand how rebasing etc destroys history, 
you may do things like do a "git pull" or a "git merge" of a branch that 
the other side WILL THROW AWAY! That will later result in major pain, 
because when you then try to merge it later, you will get all kinds of 
nasty behaviour, because the history you merged earlier no longer matches 
the history you're now trying to merge again, and the work you merged 
earlier is simply not there any more.

See? A "git rebase" has _major_ implications for the receiving end. If git 
just silently rebased on the receiving end too, THAT WOULD BE A BUG!

Once you understand this, and you understand what it _means_, you can then 
add a "+" in your local .git/remotes/xyzzy file. But git should sure as 
hell not allow it by default. 

You may think git is being difficult, but the fact is, git is protecting 
your data integrity, and protecting your sanity. And if you don't 
understand that, then git _should_ refuse to update a branch that you may 
have depended on the old contents for, and inform you that something 
strange has happened.

All of git depends on history being append-only. The fact that you -can- 
rebase does not change that. A rebase is really "create a totally new 
branch, delete the old one, and call the new one the same name as you did 
the old one".

So it's really no different from you renaming an unrelated branch to a 
name that you already used earlier. The recipient really _should_ be told 
that the old branch is gone, and replaced with something totally 
unrelated.

			Linus
