From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach git-reset to let others override its reflog entry.
Date: Wed, 27 Dec 2006 22:13:58 -0800
Message-ID: <7vslf0zgwp.fsf@assigned-by-dhcp.cox.net>
References: <20061228014336.GA16790@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 07:14:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzoWm-0001kp-OX
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 07:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWL1GOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 01:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWL1GOE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 01:14:04 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57663 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964940AbWL1GOD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 01:14:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228061359.FXKF29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 01:13:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 46EC1W00X1kojtg0000000; Thu, 28 Dec 2006 01:14:13 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061228014336.GA16790@spearce.org> (Shawn O. Pearce's message
	of "Wed, 27 Dec 2006 20:43:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35520>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The new --reflog-action for git-reset behaves like the same option
> to git-merge; it can be used by the caller to override the message
> entry in the reflog and is intended to be used only when git-reset
> is acting as plumbing, not porcelain.

Honestly, I hate these --reflog-action options everywhere.

I wonder if something like this would be easier to manage in the
longer run:

 * In git-sh-setup.sh, have this shell function.

	set_reflog_action () {
		if test -z "${GIT_REFLOG_ACTION+set}"
                then
                	GIT_REFLOG_ACTION="$*"
                        export GIT_REFLOG_ACTION
		fi
	}

 * Begin git-reset.sh with something like this:

	#!/bin/sh

	. git-sh-setup
	set_reflog_action "reset $*"

 * Update Porcelain-ish commands that use git-reset in the same
   way.  For example, git-rebase could say:

	#!/bin/sh

	. git-sh-setup
	set_reflog_action "rebase $*"

Then calls to "git-update-ref -m" could use the value of
"$GIT_REFLOG_ACTION", without explicit --reflog-action=
parameters and $rloga variables.

Hmm?
