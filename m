From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Default remote branch for local branch
Date: Sun, 2 Apr 2006 18:17:29 +0200
Message-ID: <200604021817.30222.Josef.Weidendorfer@gmx.de>
References: <1143856098.3555.48.camel@dv> <7vodzmngfp.fsf@assigned-by-dhcp.cox.net> <1143865123.14465.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 18:17:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ5Gn-0003c0-Mo
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 18:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWDBQRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWDBQRj
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 12:17:39 -0400
Received: from mail.gmx.de ([213.165.64.20]:24036 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932377AbWDBQRi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 12:17:38 -0400
Received: (qmail invoked by alias); 02 Apr 2006 16:17:32 -0000
Received: from p5496B76B.dip0.t-ipconnect.de (EHLO linux) [84.150.183.107]
  by mail.gmx.net (mp023) with SMTP; 02 Apr 2006 18:17:32 +0200
X-Authenticated: #352111
To: Pavel Roskin <proski@gnu.org>
User-Agent: KMail/1.9.1
In-Reply-To: <1143865123.14465.26.camel@dv>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Saturday 01 April 2006 06:18, Pavel Roskin wrote:
> On Fri, 2006-03-31 at 19:05 -0800, Junio C Hamano wrote:
> > Maybe you would want something like this.
> >
> > In $GIT_DIR/config:
> > 
> > 	[pull]
> > 	origin = linus for master
> >         origin = irq-pio of libata for ata-irq-pio
> >         origin = pata-drivers of libata for ata-pata

Let me try to understand this: the general idea is that

  pull.origin = [<refspec> of] <remote> for <branch>

specifies the default action of git-pull if we are on <branch>, ie.
a "git pull" then runs "git pull <remote> [<refspec>]".

So the example above, if .git/remotes/linus would contain two
refspecs, and you are on the branch of the 2nd refspec, it would
do the wrong thing: merge the 1st refspec with current branch.
So I think this is not useful, and if we use above syntax, we
should make the refspec mandatory.

However. I think a syntax mentioning only 2 local branches is better:

  pull.origin = <local upstream for branch> for <branch>

Perhaps I have misunderstood the proposal?

> First of all, using "origin" on every line carries to little
> information.

"origin" is part of the case-insensitive alphanum key, which is the same
for all config values in Junio's proposal. Especially, you can
not use it for head names. So this is fine.

Perhaps we could make a shorther alternative form for the above where
the key part has not to be specified on every line with a rule like

  if the line does not match /^\S+="/, the full line is the value

Then, above could be written as

  [pull.origin]
  linus for master
  irq-pio of libata for ata-irq-pio
  pata-drivers of libata for ata-pata

However, that's only syntactical sugar.
 
> Secondly, I think the relationship should be between a local development
> branch and a local tracking branch.

Agree.
It is also useful to specify this relation if the upstream is purely a
local branch, e.g. when branching off a local branch, and you want to
pull in changes from the local upstream.

This works automatically if git-pull only does upstream fetching if
there is a remote branch associated. The default action of git-fetch
similar could be "fetch the upstream branch, if that tracks a remote
branch", using the same configuration.

> After all, all remote data is 
> placed on a local tracking branch first.  It's better not to jump over
> layers of abstraction.  Suppose I want to update "masterB".  I tell git
> to sync "originB" first.  git already has rules what to do if it should
> sync "originB".  Let's not supersede those rules.

Junio's proposal has the advantage that you do not have to search in all
files in .git/remotes (and even .git/branches) for the remote branch that
maps to a given local branch.
But that is not the big issue.

> I would write the config like this:
> 
> [branch-upstream]
> master = linus
> ata-irq-pio = irq-pio
> ata-pata = pata-drivers

That is not working, as said above. But with above syntax extension,
with s/=/for/ it would be fine.

It would be nice to also support the topic branches, ie. to be able
to specify all topic branches for a branch, and make "git-pull" default
to an octopus merge of the topic branches.
However, "git-pull" can not distinguish between "merge upstream" and
"merge topic branches". Yet, specifying multiple default branches should
be possible.

> > While we are on the topic, it _might_ be worthwhile to think
> > about revamping the syntax of $GIT_DIR/remotes file, maybe even
> > breaking backward compatibility.  The Pull: lines can be
> > independently specified which gives flexibility, but I suspect
> > local tracking branches from the same remote tend to live in the
> > same place; IOW, you would probably not do something like:
> > 
> > 	URL: git://git.kernel.org/.../jgarzik/libata-dev.git
> > 	Pull: refs/heads/irq-pio:refs/remotes/libata/irq-pio
> > 	Pull: refs/heads/pata-drivers:refs/heads/pata-drivers
> > 
> > in practice.

What is the idea instead?
I think the current syntax is fine, as it is very flexible.
The reasoning about tracking remote branches in the same place
is a porcelain issue to be set up by git-clone.

Perhaps you are missing a remotes editor command?

Josef

> 
> Sorry, I don't understand this part.
