From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 00:26:09 -0800
Message-ID: <7v64mebxsu.fsf@assigned-by-dhcp.cox.net>
References: <20060314211022.GA12498@localhost.localdomain>
	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	<20060314224027.GB14733@localhost.localdomain>
	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
	<7vek13ieap.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
	<7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
	<20060316075324.GA19650@pfit.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 09:26:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJnoE-0004Nt-Vp
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 09:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbWCPI0M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 03:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbWCPI0M
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 03:26:12 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:22257 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1752250AbWCPI0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 03:26:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060316082430.RLDD20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Mar 2006 03:24:30 -0500
To: Qingning Huo <qhuo@mayhq.org>
In-Reply-To: <20060316075324.GA19650@pfit.vm.bytemark.co.uk> (Qingning Huo's
	message of "Thu, 16 Mar 2006 07:53:24 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17630>

Qingning Huo <qhuo@mayhq.org> writes:

> So we recognize the full path approach is desired,

I said "if you can work problems your environment has _without_
doing the full path thing, then it would be ideal".

I never said full path is desired -- I despise full path, in
fact.  It makes certain things very inconvenient.

> ...but because of
> technique reasons (building and testing), it is not applied.

There were not even a patch.  I suspect people involved in the
discussion realized that approach was unworkably cumbersome.

In our Makefile, we have sed script mechanism to replace tokens
so we _could_ change our sources to do something like this:

        diff --git a/git-commit.sh b/git-commit.sh
        index 330a434..10835c6 100755
        --- a/git-commit.sh
        +++ b/git-commit.sh
	...
        @@ -115,7 +115,7 @@ run_status () {
                    echo '#
         # Initial commit
         #'
        -	    git-ls-files |
        +	    @@GIT_PATH@@git-ls-files |
                    sed -e '
                            s/\\/\\\\/g
                            s/ /\\ /g
        @@ -126,7 +126,7 @@ run_status () {
                    committable="$?"
                fi

        -	git-diff-files --name-status |
        +	@@GIT_PATH@@git-diff-files --name-status |
                sed -e '
                        s/\\/\\\\/g
                        s/ /\\ /g
	...

and sed it out with 's/@@GIT_PATH@@/$(gitexecdir_SQ)/g'.

However, you have to realize that I often want to try things out
*without* running "make", let alone installing.  The current way
things are set up lets me say:

	$ GIT_EXEC_PATH=$my_git_source \
          sh -x $my_git_source/git-commit.sh

to see where things break.  Changing things the way I quoted
above would make things _extremely_ inconvenient for me.

And it is ugly.  "Making things ugly and inconvenient for what
purpose?" is the question I have to ask myself at this point.

And if the answer is "to support unusual configuration which,
quite frankly, I think is broken", then...

We could probably define a shell function that looks like:

        git_exec () {
                cmd="$1"
                shift
                case "${GIT_EXEC_PATH+set}" in
                set) ;;
                *) GIT_EXEC_PATH='@@GIT_EXEC_PATH@@' ;;
                esac
                "$GIT_EXEC_PATH/git-$cmd" "$@"
        }

in git-sh-setup [*1*], and then rewrite the above to something
like this instead:

        diff --git a/git-commit.sh b/git-commit.sh
        index 330a434..8a73420 100755
        --- a/git-commit.sh
        +++ b/git-commit.sh
        ...
        @@ -115,7 +115,7 @@ run_status () {
                    echo '#
         # Initial commit
         #'
        -	    git-ls-files |
        +	    git_exec ls-files |
                    sed -e '
                            s/\\/\\\\/g
                            s/ /\\ /g
        @@ -126,7 +126,7 @@ run_status () {
                    committable="$?"
                fi

        -	git-diff-files  --name-status |
        +	git_exec diff-files  --name-status |
                sed -e '
                        s/\\/\\\\/g
                        s/ /\\ /g
        ...

But that does not cover Perl nor Python scripts, and does not
address the ugliness either.


[Footnote]

*1* BTW, I just noticed that git-sh-setup needs to be on user's
PATH, so we probably have to inline and duplicate the git_exec()
shell function definition at the beginning of each script after
all, when we make the initial ". git-sh-setup" inclusion to
honor GIT_EXEC_PATH without munging the user's PATH.

Which is not a big deal by itself, since we preprocess
*.{sh,perl,py} files anyway, but still it leaves a _big_
ugliness factor.
