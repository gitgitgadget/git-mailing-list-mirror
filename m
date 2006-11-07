X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Mon, 06 Nov 2006 16:13:44 -0800
Message-ID: <7vd580azbb.fsf@assigned-by-dhcp.cox.net>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 00:13:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611070026.16425.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 7 Nov 2006 00:26:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31035>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhEb8-0002mA-Pj for gcvg-git@gmane.org; Tue, 07 Nov
 2006 01:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753857AbWKGANq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 19:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbWKGANq
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 19:13:46 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52458 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1753456AbWKGANp
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 19:13:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107001344.ZDFI18816.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 19:13:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id jcDp1V00b1kojtg0000000; Mon, 06 Nov 2006
 19:13:50 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> Example to hack on git's next branch:
>
>  git-clone --use-separate-remote http://www.kernel.org/pub/scm/git/git.git
>  cd git
>  git-checkout origin/next
>  <hack on next>
>  git pull (to merge patches from remote 'next')
>
> The checkout creates local branch 'next' to checkout read-only
> remote branch 'remotes/origin/next'. Additionally, it sets up
> 'remotes/origin/next' from remote repository 'origin' as
> default merge source for the new development branch.

I am disturbed by an inconsistency here.

> +	if git-show-ref --verify --quiet -- "refs/heads/$newbranch"
> +	then
> +		echo "Proposed new branch '$newbranch' to checkout...
> +		echo "To checkout, specify a new branch name with -b"
> +		exit 1
> +	fi

This logic is guarding against already having a local branch
that is called 'next', and that is why the "Proposed new branch"
message needs to be there.  One explanation of why 'next' exists
in the local branch namespace in the first place is probably
there are other remote branches than origin that have 'next' and
the user previously checked it out.  Or perhaps the user has
already done this "checkout origin/next" once already.

I wonder if it is more consistent and easy to use to just make
this:

	git checkout origin/next

a synonym to:

	git checkout -b origin/next remotes/origin/next

when remotes/origin/next exists and heads/origin/next does not.

Then "git checkout origin/next" would always mean "I want to
switch to the branch I use to hack on the branch 'next' Junio
has".  Do it once and you will get exactly my tip, hack on it,
switch out of it and then do it again and you won't lose your
previous work but just switch to that branch.

That is, something like this...

---

diff --git a/git-checkout.sh b/git-checkout.sh
index 119bca1..f6486c6 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -4,6 +4,16 @@ USAGE='[-f] [-b <new_branch>] [-m] [<bra
 SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 
+# Automatic forking of local branch based on remote
+if test $# = 1 &&
+   git show-ref --verify --quiet -- "refs/remotes/$1" &&
+   ! git show-ref --verify --quiet -- "refs/heads/$1"
+then
+	set x -b "$1" "remotes/$1"
+	echo >&2 "* Forking local branch $1 off of remotes/$1..."
+	shift
+fi
+
 old_name=HEAD
 old=$(git-rev-parse --verify $old_name 2>/dev/null)
 new=
