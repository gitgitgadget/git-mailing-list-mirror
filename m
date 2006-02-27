From: Junio C Hamano <junkio@cox.net>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 15:18:53 -0800
Message-ID: <7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060227011832.78359f0a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 00:19:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDreH-0003nn-4B
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 00:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWB0XTC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 18:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWB0XTB
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 18:19:01 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:23718 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751851AbWB0XTA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 18:19:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060227231513.SWIO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 18:15:13 -0500
To: Andrew Morton <akpm@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16892>

Andrew Morton <akpm@osdl.org> writes:

> That's not a good reason.  People will discover that git has started
> shouting at them and they'll work out how to make it stop.
>
> The problem is getting C users to turn the check on, not in getting python
> users to turn it off.

This whitespace policy should be at least per-project (people
working on both kernel and other things may have legitimate
reason to want trailing whitespace in the other project), so we
would need some configurability; the problem is *both*.

We could do one of two things, at least.

 - I modify the git-apply that is in the "next" branch further
   to make --whitespace=error the default, and push it out.  You
   convince people who feed things to you to update to *that*
   version or later.

 - I already have the added whitespace detection hook (a fixed
   one that actually matches what I use) shipped with git.  You
   convince people who feed things to you to update to *that*
   version or later, and to enable that hook.

I think you are arguing for the first one.  I am reluctant to do
so because it would not help by itself *anyway*.  In any case
you need to convince people who feed things to you to do
something to prevent later changes fed to you from being
contaminated with trailing whitespaces.

Having said that, I have a third solution, which consists of two
patches that come on top of what are already in "next" branch:

 - apply: squelch excessive errors and --whitespace=error-all
 - apply --whitespace: configuration option.

With these, git-apply used by git-applymbox and git-am would
refuse to apply a patch that adds trailing whitespaces, when the
per-repository configuration is set like this:

        [apply]
                whitespace = error

(Alternatively,

	$ git repo-config apply.whitespace error

would set these lines there for you).

I think there are three kinds of git users.

 * Linus, you, and the kernel subsystem maintainers.  The
   whitespace policy with this version of git-apply (with the
   configuration option set to apply.whitespace=error) gives
   would help these people by enforcing the SubmittingPatches
   and your "perfect patch" requirements.

 * People who feed patches to the above people.  They are helped
   by enabling the pre-commit hook that comes with git to
   conform to the kernel whitespace policy -- they need to be
   educated to do so.

 * People outside of kernel community, using git in projects to
   which the kernel whitespace policy does not have any
   relevance.

While I do consider the kernel folks a lot more important
customers than other users, I have to take flak from the third
kind of users, and to them, authority by Linus or you does not
weigh as much as the first two classes of people.  Making the
default to --whitespace=error means that you are making me
justify this kernel project policy as something applicable to
projects outside the kernel.  That is simply not fair to me.

You have to convince people you work with to update to at least
to this version anyway, so I do not think it is too much to ask
from you, while you are at it, to tell the higher echelon folks
to do:

	$ git repo-config apply.whitespace error

in their repositories (and/or set that in their templates so new
repositories created with git-init-db would inherit it).
