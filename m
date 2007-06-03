From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-filter-branch
Date: Mon, 4 Jun 2007 00:07:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706040006470.4046@racer.site>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <f3t2mm$f0$1@sea.gmane.org>
 <Pine.LNX.4.64.0706030147520.4046@racer.site> <200706031228.58779.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 01:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuzCz-00061Y-9i
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 01:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbXFCXJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 19:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbXFCXJz
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 19:09:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:55502 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751051AbXFCXJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 19:09:55 -0400
Received: (qmail invoked by alias); 03 Jun 2007 23:09:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 04 Jun 2007 01:09:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+AmdmH6f+lsQld8eHPs/XeONBRyv9sy80TAbueD
	tmneEVvjeYGt6+
X-X-Sender: gene099@racer.site
In-Reply-To: <200706031228.58779.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49049>

Hi,

On Sun, 3 Jun 2007, Jakub Narebski wrote:

> On Sun, 3 Jun 2007, Johannes Schindelin wrote:
> > On Sun, 3 Jun 2007, Jakub Narebski wrote:
> >> Johannes Schindelin wrote:
> >> 
> >>> This script is derived from Pasky's cg-admin-rewritehist.
> >>> 
> >>> In fact, it _is_ the same script, minimally adapted to work without cogito.
> >>> It _should_ be able to perform the same tasks, even if only relying on
> >>> core-git programs.
> >>> 
> >>> All the work is Pasky's, just the adaption is mine.
> >> 
> >> I was thinking about rewriting cg-adin-rewritehist as git-rewritehist
> >> using Perl (IIRC it needs bash, not only POSIX shell), and make it
> >> use git-fast-import.
> 
> By the way, why did you change name to git-filter-branch, instead of
> leaving it [almost] as is, i.e. git-rewritehist. Or if you wanted to
> emphasize that it rewrites only one branch at a time, git-rewrite-branch?

It does not rewrite the branch. It writes a filtered _copy_. That is what 
I wanted to make clear by that renaming.

> Note that history (branch) gets rewritten also in absence of filters, if 
> there are any grafts in place. But I might be mistaken.

Actually, if you check the first non-setup test in the provide test 
script, no. It is not _really_ rewritten. As the commit names stay exactly 
the same.

> > First, it does not need Perl.
> > 
> > Second, it does not even need bash.
> 
> If I remember correctly (but I can be wrong here) Pasky said that he had
> to use arrays in cg-admin-rewritehist. Because introducing dependency on
> bash would be bad, that was the cause of thought to rewrite it in Perl
> (which we depend on anyway). 

I rewrote the only instance where arrays were used:

> > At least that is what I tried to make sure. I replaced the only 
> > instance of a bashim I was aware, namely the arrayism of $unchanged. 
> > It can be a string just as well, as we are only storing object names 
> > in it.
> 
> I'm sorry, I haven't reviewed your patch carefully enough, it seems 
> like. If you can translate cg-admin-rewritehist to POSIX shell, more 
> power to you.

Actually, that is my understanding.

> Few notes of lesser importance (meaning they can go into subsequent 
> commits).
> 
> 1. Documentation: Cogito had documentation together with the command
>    described, similarly to Perl POD, or LaTeX doc package + DocStrip,
>    etc. It has IIRC rules in Makefile to extract documentation.
> 
>    In git we have documentation in separate files. The commands
>    themselves have only usage, and sometimes long usage embedded.
>    It would be nice of git-filter-branch / git-rewrite-branch also
>    followed this convention.

Yes, I did not plan to provide documentation with the first patch, since I 
wanted to encourage _review_ of the patch. Obviously, I failed ;-)

> 2. Using fast-import.
> 
>    >> +# Note that since this operation is extensively I/O expensive, it might
>    >> +# be a good idea to do it off-disk, e.g. on tmpfs. Reportedly the speedup
>    >> +# is very noticeable.
> 
>    Would it be possible to use git-fast-import to reduce I/O in this
>    command? Cogito didn't use it because it is quite new, but there
>    is no reason to not to use it now, I think.

It is overkill, usually.

The only thing that could benefit from it, would be complicated tree 
filters.

But _the_ main usage for this script (in my expectation, at least) will be 
to split projects into subprojects.

For this, we _still_ don't need fast-import, but maybe a better 
tree-filter (something like --subdir-filter, which only checks out the 
subdir (in the root), and also only takes those revisions into account 
that actually touch that subdir).

Ciao,
Dscho
