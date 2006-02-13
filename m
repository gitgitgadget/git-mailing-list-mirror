From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Mon, 13 Feb 2006 14:40:27 +0000
Message-ID: <tnxy80fe2zo.fsf@arm.com>
References: <20060210195914.GA1350@spearce.org>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 13 15:40:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8esb-0003gv-Tc
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 15:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWBMOkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 09:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWBMOkg
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 09:40:36 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:28076 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932441AbWBMOkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 09:40:35 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k1DEeT6s026635;
	Mon, 13 Feb 2006 14:40:29 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 13 Feb 2006 14:40:29 +0000
To: git@vger.kernel.org
In-Reply-To: <20060210195914.GA1350@spearce.org> (Shawn Pearce's message of
 "Fri, 10 Feb 2006 14:59:14 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 13 Feb 2006 14:40:29.0193 (UTC) FILETIME=[6F539F90:01C630AB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16071>

Shawn Pearce <spearce@spearce.org> wrote:
> I just posted the first public version of pg, a GIT porcelain for
> managing patches.  Think StGIT, but better in some ways:

Couldn't help replying to such a topic :-) (only that the ":" ending
of the above phrase might make people think that some features you
listed are not available in StGIT).

Without much testing, I think pg is a good tool but it is different
from StGIT in many ways. It mainly resembles the topic branches way of
working with the advantage of having them stacked on each-other. Each
patch seems to be equivalent to a topic branch where you can commit
changes. Rebasing a patch is equivalent to a merge in a branch with
the merge commit having a general description like "Refreshed patch
..." and two parents - the new base and the old top.

While I don't say the above is a bad thing, it is pretty different
from StGIT. With StGIT, the history of the tree only shows one commit
per patch with the patch description chosen by the user. If you edit
the description or modify the patch, the old patch or description is
dropped from the main branch (visible via HEAD) and you only get the
latest one. This clean history has many advantages when sending
patches upstream either via e-mail or by asking for a pull.

> - Simplified command line user interface.
>
>     pg tries to simplify GIT by 'hiding' the index and behaving like
>     more traditional SCMs which only look at `HEAD` (last commit)
>     and the working directory (files).

This is the case with StGIT as well. It doesn't usually require the
use of GIT commands directly.

> - Preserves change history of patches.
>
>     The complete change history associated with each patch is
>     maintained directly within GIT.  By storing the evolution of a
>     patch as a sequence of GIT commits standard GIT history tools
>     such as gitk can be used.

There have been discussions to adding this to StGIT as well (and there
is a patch already from Chuck). It is a good thing to have but I'm
opposed to the idea of having the history accessible from the top of
the patch. Since the patch can be refreshed indefinitely, it would
make the main history (visible from HEAD) really ugly and also cause
problems with people pulling from a tree. I prefer to have a separate
command (like 'stg id patch/log') that gives access to the history.

> - Its prune proof.
>
>     The metadata structure is stored entirely within the refs
>     directory and the object database, which means you can safely use
>     git-prune without damaging your work, even for unapplied
>     patches.

That's missing indeed in StGIT but it will be available in the next
release. I didn't push this yet because I wasn't sure what to do with
the refresh history of a patch.

> - Automatic detection (and cancellation) of returning patches.
>
>     pg automatically detects when a patch is received from
>     the upstream GIT repository during a pg-rebase and deletes
>     (cancels) the local version of the patch from the patch series.
>     The automatic cancelling makes it easy to use pg to track and
>     develop changes on top of a GIT project.

StGIT has been doing this from the beginning. You would need to run a
'stg clean' after a rebase (or push). I prefer to run this command
manually so that 'stg series -e' would show the empty patches and let
me decided what to do with them.

> - Fast
>
>     pg operations generally perform faster than StGIT operations,
>     at least on my large (~7000 file) repositories.

Might be possible but I haven't done any tests. There are some
optimisations in StGIT that make it pretty fast: (1) if the base of
the patch has not changed, it can fast-forward the pushed patches
which is O(1) and (2) StGIT first tries to use git-apply when pushing
a patch and use a three-way merge only if this fails (the operation
usually succeeds for most of the patches). There are some speed
problems with three-way merging if there are many file
removals/additions because the external merge tool is called for each
of them but the same problem exists for any other tool.

-- 
Catalin
