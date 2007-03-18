From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-init: set core.workdir when GIT_WORK_DIR is specified
Date: Sun, 18 Mar 2007 01:47:18 -0700
Message-ID: <7vr6rnlyzt.fsf@assigned-by-dhcp.cox.net>
References: <20070317015855.GB19305@moooo.ath.cx>
	<7vbqiss4yw.fsf@assigned-by-dhcp.cox.net>
	<20070317143452.GA21140@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 09:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSr2y-0003Sg-MM
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 09:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbXCRIrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 04:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbXCRIrV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 04:47:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60941 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbXCRIrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 04:47:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318084719.IJKO321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 18 Mar 2007 04:47:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c8nJ1W0041kojtg0000000; Sun, 18 Mar 2007 04:47:19 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42481>

Matthias Lederhofer <matled@gmx.net> writes:

> Here is a new patch series replacing ml/workdir.
>
> Changes:
>  * rename GIT_WORK_DIR to GIT_WORK_TREE, --work-dir to --work-tree and
>    core.workdir to core.worktree
>  * use getcwd and prefixcmp instead of stat to check if cwd is below
>    GIT_DIR or GIT_WORK_TREE
>  * rename 'has_working_directory' to 'inside_working_tree'
>
> The first two patches have not changed except for their order in the
> series but I repost them anyway for easier review.

Thanks.  I somehow felt funny to see my sign-off on some of your
patches, but it makes perfect sense with the above explanation.

A word of caution when working with me.  

Almost always, I haven't thought things through more thoroughly
than the contributor did, so many of my comments of course show
a lot of cluelessness.  Your explanation on the reason why you
structured is_bare_repository() check that way illustrated
issues to me and the list very well.

I often mix comments that are not serious suggestions and
questions, just to play devil's advocate.  An earlier example
was "should the relative directory (either --work-dir option or
environment) be taken relative to GIT_DIR?"  The expected answer
was "it should be relative to `pwd`, because expected use of
relative path at runtime (as opposed to setting in
$GIT_DIR/config) is one-shot, like this:

	$ cd top-of-project/some/where
        $ git --work-dir=../.. do-something

and making it relative to $GIT_DIR is just crazy, because the
top may not be related with $GIT_DIR in any easy-to-remember way
at all."  I want to hear such rebuttal to make sure that the
contributor thought things through.  Not amending certain parts
of the patch, with clear explanation to defend it, is always
better.  Amending a patch only to satisfy such a non-serious
comment is to fail the test.

> Things I'm not sure about how/if to change (see my last mail too)
>  * is_bare_repository() uses the old check
>        /* definitely bare */
>        if (is_bare_repository_cfg == 1)
>                return 1;
>        /* GIT_WORK_TREE is set, bare if cwd is outside */
>        if (inside_working_tree >= 0)
>                return !inside_working_tree;
>        /* configuration says it is not bare */
>        if (is_bare_repository_cfg == 0)
>                return 0;
>  * is_bare_repository() in general

There is a bit of chicken and egg involved in is_bare, because
we need to find out where GIT_DIR is in order to find where to
read GIT_DIR/config from, and only after reading the file we
would know if the user explicitly told us the repository is
bare, and setup_gently does not want to cd-up if the repository
is bare (i.e. there is no "top" to move to).

>  * git init does not show the expansion of GIT_WORK_TREE to an
>    absolute path, this might confuse the user

If the feature might confuse the user without extra output, it
probably is confusing to begin with, with or without it, so one
option might be to refuse relative path when running git-init.

However, as long as the expansion to absolute path is done
correctly, I do not think there is any room for confusion.  Who
would want a feature that lets you set work-tree to ../.., so
that no matter where in the working tree you cd around, git
assumes that the toplevel is two level up?  If you record the
work tree location in the configuration, you would want it to be
stable, and I do not think anybody would expect it be stored as
relative.  So I thought having the printf() would be a good way
for debugging the absolute expansion, but after that I do not
think it is needed (but again, I may well be missing some issues
you've thought about, so please tell me otherwise).
