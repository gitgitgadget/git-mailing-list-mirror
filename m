From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Wed, 28 Jul 2010 09:36:34 -0400
Message-ID: <4C503262.80702@xiplink.com>
References: <4C472B48.8050101@gmail.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> <AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> <201007261056.58985.jnareb@gmail.com> <20100727183658.GB25124@worldvisions.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, skillzero@gmail.com,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 15:36:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe6o5-0004gC-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 15:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab0G1NgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 09:36:20 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:59125 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab0G1NgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 09:36:20 -0400
Received: from relay7.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 100961DEC6E;
	Wed, 28 Jul 2010 09:36:19 -0400 (EDT)
Received: by relay7.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8804D1DEC3F;
	Wed, 28 Jul 2010 09:36:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <20100727183658.GB25124@worldvisions.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152085>

On 10-07-27 02:36 PM, Avery Pennarun wrote:
> 
> For "recursive" commit, for my own workflow, I would rather have it work
> like this: from the toplevel, I can 'git commit' any set of files, as long
> as they all fall inside a particular submodule.  That is, if I do
> 
> 	git commit mod1/*.c mod2/*.c
> 	
> it should reject it (with a helpful message), because the commit would cross
> submodule boundaries.  But if I do
> 
> 	git commit mod1/*.c
> 	
> I think it should create a new commit in mod1, leave my superproject
> pointing at that new commit, and stop (ie. without the superproject having
> committed the new commit pointer).

I think that makes perfect sense.  I'd also want the updated pointer to be
unstaged.

> Why?  Because my normal workflow is:
> 
>   - make a bunch of superproject/submodule changes until they work.
>   - commit the submodule changes with a submodule-relevant message
>   - commit the superproject change with a supermodule-relevant message
>   
> I wouldn't want to share commit messages between the two, so actually having
> a single commit process be "recursive" would not do me any good.

That's the workflow I'd like to follow as well.

In terms of achieving this workflow with submodules and branching, what's
required is that branching in the superproject takes the submodules off of
the detached HEAD and onto something that won't get automatically
garbage-collected in a few weeks.

That could be done simply by applying the superproject's branch to all the
submodules.  A command like

	superproject/$ git branch foo origin/master

would create the submodule branches on the commits identified for the
submodules in the superproject's origin/master commit.  To make that work
smoothly I think requires all the submodules' .git directories, so the branch
name can be recorded in all of them.

And so I think that either "git fetch" has to recursively obtain (and update)
all submodule repos, or there needs to be some kind of on-demand retrieval
mechanism.  Other ideas for grand-unified object stores (which I haven't been
following too closely) could work as well.

So with unified branching and available .git directories, I think a recursive
checkout is doable and makes sense.  I'd still like to control which
submodules a checkout might recurse through, but I think the sparse-checkout
system is the way to handle that.

I also suspect that non-fast-forward submodule merges could be workable,
where regular merges are performed individually in the submodules before
merging in the superproject.

One final, somewhat orthogonal thought:  I think that "git commit
submodule-dir" should require -f if the remote associated with the submodule
doesn't have the commit ID you're trying to commit.

> However, pushing is a separate issue entirely.  Having push be recursive
> would be easy, but it doesn't solve the *real* problem with pushing: git
> doesn't know what branch to push to in the submodule, and the submodule most
> likely isn't pointing at a pushable repo at all, even if the supermodule is. 
> This is why I keep coming back to the idea that I really want to push all
> the submodule objects into the superproject's repo.

I agree that recursive pushing doesn't make much sense, so there's no need to
try to implement it.  I think having "git commit" reject unpushed submodule
updates in the superproject goes a long way to alleviating misordered pushing.

		M.
