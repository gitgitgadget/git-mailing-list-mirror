From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] reworking git-rebase
Date: Thu, 17 Nov 2005 02:57:51 -0800
Message-ID: <7v1x1fy21c.fsf@assigned-by-dhcp.cox.net>
References: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net>
	<20051117103027.GR8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 11:59:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EchTP-0006Os-Es
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 11:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVKQK5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 05:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKQK5y
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 05:57:54 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47334 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750746AbVKQK5y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 05:57:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117105755.TICI25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 05:57:55 -0500
To: skimo@liacs.nl
In-Reply-To: <20051117103027.GR8383MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Thu, 17 Nov 2005 11:30:27 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12097>

Sven Verdoolaege <skimo@kotnet.org> writes:

> Will the reworked rebase still support this use or is there
> a better way to do this ?

I think it is reasonable to assume that you would not usually
want to muck with commits that cleanly replay.  Further, you
would do that kind of irregular replaying (e.g. not replaying
all of them, or skipping some of them) only after one of the
commit fails to cleanly replay, and you would not mind (rather,
you would be happy) to keep the commits that have been already
cleanly replayed, and would start playing games like dropping
patches after the one that fails.

If the above is a reasonable assumption, then, the answer is
yes.  And if not, you can always resort to manual
"git-format-patch -k", followed by file editing, followed by
"git am -k -3", to reorder patches.  Although at that point you
should either be looking at StGIT or doing a just plain merge.

When "git am" first fails, all the rest of patches are kept in
.dotest/.  And after fixing up the failed one in your working
tree, you can restart it with interactive flag, like this: "git
am -i -3 --resolved".  It lets you tell it skip one patch, or
not apply any of the rest.  [Side note: it might be a good idea
to make --resolved imply --interactive].

Quite often, the reason why a rebased patch does not apply is
because an equivalent patch (or a set of patches whose
cumulative effect is the same as one of your patches) has been
thrown in to the new "master".  "git cherry" is too dumb (IOW,
git-patch-id is too strict) to notice such cases.  "git am -3"
first tries to do git-apply, and when it fails (and it will fail
if your working tree already has what the patch would do), it
falls back to 3-way merge by picking up the pre-image blob ids
recorded in the patch.  When seeing an already applied patch,
this 3-way merge often results in the same tree as you started.
When "git am" notices the situation, it throws away that patch
(it says "already applied") automatically.
