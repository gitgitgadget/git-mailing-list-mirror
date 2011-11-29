From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Git Submodule Problem - Bug?
Date: Tue, 29 Nov 2011 23:03:18 +0100
Message-ID: <20111129220303.GA2812@sandbox-rc.fritz.box>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com>
 <201111291024.01230.trast@student.ethz.ch>
 <20111129101546.GB2829@kolya>
 <201111291125.41943.trast@student.ethz.ch>
 <20111129104105.GA10839@kolya>
 <4ED5196B.5030200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Manuel Koller <koller.manuel@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 29 23:03:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVlt-0003oH-K3
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 23:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab1K2WDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 17:03:20 -0500
Received: from darksea.de ([83.133.111.250]:48198 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754298Ab1K2WDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 17:03:19 -0500
Received: (qmail 3025 invoked from network); 29 Nov 2011 23:03:18 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Nov 2011 23:03:18 +0100
Content-Disposition: inline
In-Reply-To: <4ED5196B.5030200@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186091>

Hi,

On Tue, Nov 29, 2011 at 06:42:03PM +0100, Jens Lehmann wrote:
> Am 29.11.2011 11:41, schrieb Fredrik Gustafsson:
> > On Tue, Nov 29, 2011 at 11:25:41AM +0100, Thomas Rast wrote:
> >> So maybe the right questions to ask would be: what's the *official*
> >> way of removing a submodule completely?  Do we support overwriting
> >> submodules in the way Manuel wanted to?  Why not? :-)
> > 
> > I suggest that we add a command for that;
> > git submodule remove <submodule>
> 
> Hmm, to me it looks like the problem is in "git submodule add". It
> doesn't check if the submodule repo it finds in .git/modules matches
> the one the user wants to create. So we end up reviving the first
> submodule although the user wants to use a completely different repo.
> 
> One solution could be to only let "git submodule update" revive
> submodules from .git/modules and make "git submodule add" error out
> if it finds the git directory of a submodule with the same name in
> .git/modules. But currently there is no way to tell "git submodule add"
> to use a different submodule name (it always uses the path as a name),
> so we might have to add an option to do that and tell the user in the
> error message how he can add a different submodule under the same
> path.

I think this is the way to go. We teached submodule add to revive a
local submodule. Further thinking about it this is probably not what the
users wants in most cases. For update its the right thing but for add we
should probably tell the user that there is already a local submodule in
the way and give him the option to take it or that he should remove it.

> Another solution could be that "git submodule add" detects that a
> submodule with the name "sub" did exist and chooses a different name
> (say "sub2") for the the new one. Then the user wouldn't have to
> cope with the problem himself.

In my opinion this is too much automatism. We could prompt for a new
name to support the user but I do not think this mechanism should be
automatic.

How about this:

The user issues 'git submodule add foo' and we discover that there is
already a local clone under the name foo. Git then asks something like
this

	Error when adding: There is already a local submodule under the
	name 'foo'.

	You can either rename the submodule to be added to a different
	name or manually remove the local clone underneath
	.git/modules/foo. If you want to remove the local clone please
	quit now.

	We strongly suggest that you give each submodule a unique name.
	Note: This name is independent from the path it is bound to.

	What do you want me to do ([r]ename it, [Q]uit) ?

When the user chooses 'rename' git will prompt for a new name.

If we are going to support the remove use case with add we additionally
need some logic to deal with it during update (which is not supported
yet AFAIK). But we probably need this support anyway since between
removal and adding a new submodule under the same can be a long time.
If users switch between such ancient history and the new history we
would have the same conflict.

We could of course just error out and tell the user that he has to give
the submodule an uniqe name. If the user does not do so leave it to him
to deal with the situation manually.

What do you think?

Cheers Heiko
