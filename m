From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Mon, 12 Feb 2007 22:47:04 +0100
Message-ID: <20070212214704.GS5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net> <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com> <20070212202634.GX4266@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 22:48:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGj2Q-0006Sg-91
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 22:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbXBLVs0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 16:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbXBLVs0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 16:48:26 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:37543 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030187AbXBLVsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 16:48:25 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 0710955DC;
	Mon, 12 Feb 2007 22:48:24 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id ACFCC1F084; Mon, 12 Feb 2007 22:47:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070212202634.GX4266@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39442>

On Mon, Feb 12, 2007 at 09:26:34PM +0100, Yann Dirson wrote:
> On Mon, Feb 12, 2007 at 09:31:28AM +0000, Catalin Marinas wrote:
> > On 12/02/07, Pavel Roskin <proski@gnu.org> wrote:
> > >I have been bitten by a strange bug/feature of StGIT, and it looks like
> > >it's not only counterintuitive, but also inconsistent with git.
> > >
> > >I have a repository available over ssh and I push to it from several
> > >places. Sometimes I make a commit and forget to push it.  Then I run "stg
> > >pull" to make sure my repository is up to date.
> > >
> > >The result is that the repository is rebased back to the last remote
> > >commit. It's very easy to miss.  There is no warning.  Everything looks
> > >just like an update from the remote.
> > >
> > >The example below shows that git-pull keeps my commit, but "stg pull"
> > >discards it by rebasing back to the remote ID.
> > 
> > I think this is a "feature"
> 
> No, I agree it's a bug.  Rebasing after a fetch should allow this
> workflow to work as well.  If the parent branch is not a rewinding
> one, we should ensure there is nothing lost.  And even for rewinding
> branches, we should probably keep track of the existence of commits,
> so we can warn and nothing gets lost without knowing.

Thinking about it, detecting whether we're going to lose a commit is
just checking *before pulling* whether the current base is reachable
from the parent's current head.

In git-fetch-based workflows, proceeding further should be simply
refused.  I'm not sure about the git-pull-based workflows; here is at
least one problem with git-pull I can think of:

AFAICT, someone using git-pull would in this case get a merge commit,
so under 0.11 (or with the compat settings outlined by Catalin) you
should now have your stack based on a merge commit, with as parents
the new parent-branch head and the commits you did not push yet, right ?
So how did you proceed from there using 0.11 ?

I'd think you still want to push your patch into the parent repo, but
the situtation is cumbersome: it would have been far easier IMHO to
"stg pull" first, in which case the fetch-and-rebase model is what you
wanted, and then do a "stg commit && git push".

That makes me think that indeed we should have an stgit command doing
precisely this "stg commit && git push" (suggested in previous mail)
as an atomic operation, rolling back the commit if the push failed
because you were out of date.


Since that looks like a pathological case, I suppose this may not be
what you were trying to do.  Can you please give more information if
that is the case ?

Best regards,
-- 
Yann.
