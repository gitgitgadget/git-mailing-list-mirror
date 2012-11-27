From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v4 0/4] git-submodule add: Add --local-branch option
Date: Tue, 27 Nov 2012 19:31:25 +0100
Message-ID: <20121127183125.GA4185@book.hvoigt.net>
References: <20121123175402.GH2806@odin.tremily.us> <cover.1353962698.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Nov 27 19:31:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdPwj-0001yG-Vs
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 19:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756439Ab2K0Sbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 13:31:34 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:48566 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab2K0Sbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 13:31:34 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TdPwM-0002eW-7K; Tue, 27 Nov 2012 19:31:26 +0100
Content-Disposition: inline
In-Reply-To: <cover.1353962698.git.wking@tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210582>

Hi,

On Mon, Nov 26, 2012 at 04:00:15PM -0500, W. Trevor King wrote:
> From: "W. Trevor King" <wking@tremily.us>
> 
> On Fri, Nov 23, 2012 at 12:54:02PM -0500, W. Trevor King wrote:
> > We could add
> >
> >   $ git submodule update --branch
> >
> > to checkout the gitlinked SHA1 as submodule.<name>.branch in each of
> > the submodules, leaving the submodules on the .gitmodules-configured
> > branch.  Effectively (for each submodule):
> >
> >   $ git branch -f $branch $sha1
> >   $ git checkout $branch
> 
> I haven't gotten any feedback on this as an idea, but perhaps someone
> will comment on it as a patch series ;).

I am not sure I understand you correctly. You are suggesting that the
branch option as an alias for the registered SHA1 in the superproject?

I though the goal of your series was that you want to track submodules
branch which come from the remote side?

Doing the above does not assist you much in that does it?

I would think more of some convention like:

	$ git checkout -t origin/$branch

when first initialising the submodule with e.g.

	$ git submodule update --init --branch

Then later calls of

	$ git submodule update --branch

would have a branch configured to pull from. I imagine that results in
a similar behavior gerrit is doing on the server side?

> Changes since v3:
> 
> * --record=??? is now --local-branch=???
> * Dropped patches 2 ($submodule_ export) and 3 (motivating documentation)
> * Added local git-config overrides of .gitmodules' submodule.<name>.branch
> * Added `submodule update --branch`

I would prefer if we could squash all these commits together into one
since it seems to me one logical step, using the new variable for update
belongs together with its configuration on initialization.

How about reusing the -b|--branch option for add? Since we only change
the behavior when submodule.$name.update is set to branch it seems
reasonable to me. Opinions?

> Because you need to recurse through submodules for `update --branch`
> even if "$subsha1" == "$sha1", I had to amend the conditional
> controlling that block.  This broke one of the existing tests, which I
> "fixed" in patch 4.  I think a proper fix would involve rewriting
> 
>   (clear_local_git_env; cd "$sm_path" &&
>    ( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
>     test -z "$rev") || git-fetch)) ||
>   die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
> 
> but I'm not familiar enough with rev-list to want to dig into that
> yet.  If feedback for the earlier three patches is positive, I'll work
> up a clean fix and resubmit.

You probably need to separate your handling here. The comparison of the
currently checked out sha1 and the recorded sha1 is an optimization
which skips unnecessary fetching in case the submodules commits are
already correct. This code snippet checks whether the to be checked out
sha1 is already local and also skips the fetch if it is. We should not
break that.

Maybe we need an else block here and possibly extract the current code
inside the if statement into a function. E.g. that the final code looks
something like this:

	if test "$subsha1" != "$sha1"
	then
		handle_on_demand_fetch_update ...
	else
		handle_tracked_branch_update ...
	fi

Not sure about the function names though. If we decide to go that route:
The extraction into a function should go in an extra preparation patch
which does not change any functionality.

I will reply to the patches for further comments.

Cheers Heiko
