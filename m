From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Teach git submodule update to use distributed
	repositories
Date: Thu, 17 Jul 2008 16:38:33 +0200
Message-ID: <20080717143833.GV32184@machine.or.cz>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJUds-0003Zu-Ge
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 16:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566AbYGQOig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbYGQOig
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:38:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56477 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755978AbYGQOif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 10:38:35 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6C3C02C4C025; Thu, 17 Jul 2008 16:38:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88859>

On Thu, Jul 17, 2008 at 01:08:19PM +0100, Nigel Magnay wrote:
> When doing a git submodule update, it fetches any missing submodule
> commits from the repository specified in .gitmodules. If you instead
> want to pull from another repository, you currently need to do a fetch
> in each submodule by hand.
> 
> Signed-off-by: Nigel Magnay <nigel.magnay@gmail.com>

I don't think it is good idea to hijack git submodule update for this.
This command has a specific purpose:

	"When I pulled new version of the main tree, bring my
	submodule checkouts in line with whatever is specified
	within the new tree revision."

Your usage scenario has nothing to do with that, it is about "batch
manipulation" of all the submodules at once in a certain way. I think
using the same command for two conceptually pretty much unrelated
purposes will only clutter up the UI, and we should think of a better
general interface pattern for these operations.

In the new git-submodule description, it is said that

	"This command will manage the tree entries and contents of the
	gitmodules file for you."

and I think we should keep it at this; anything that is related to
submodules, but does not do this directly, would IMHO live better
as some kind of "submodule-recursive" extension of other existing
commands. Say, would this particular need of yours be served by a
hypothetical command like

	git checkout --submodules nifty

to check out branch nifty of all submodules or am I misunderstanding
what are you trying to achieve?

If not, then actually even _much_ more elegant solution for this
particular problem would be to store submodule.*.branch in .gitmodules
appropriate to the -b parameter of git submodule add. Then, in branch
'nifty' of the main project, you would set submodule.*.branch to 'nifty'
too.  Then, in order to bring all the submodules to the latest version,
I could imagine something like

	git pull --submodules

(and possibly just abort at the first sight of a conflict, for
starters).

Let's figure up some UI that is nifty and clean. ;-)

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
