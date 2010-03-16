From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Teach --no-ff option to 'rebase -i'.
Date: Tue, 16 Mar 2010 15:19:29 -0400
Message-ID: <4B9FD9C1.9060200@xiplink.com>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 20:27:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrcQE-00031F-03
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 20:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab0CPT1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 15:27:17 -0400
Received: from smtp192.dfw.emailsrvr.com ([67.192.241.192]:48271 "EHLO
	smtp192.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab0CPT1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 15:27:16 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2010 15:27:16 EDT
Received: from relay19.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay19.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id A8223274842D;
	Tue, 16 Mar 2010 15:18:05 -0400 (EDT)
Received: by relay19.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 6D31F2748C44;
	Tue, 16 Mar 2010 15:18:05 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142348>

Apologies -- this patch fails several rebase unit tests.

Back to the drawing board...

		M.


Marc Branchaud wrote:
> This option tells rebase--interactive to cherry-pick all the commits in the
> rebased branch, instead of fast-forwarding over any unchanged commits.
> 
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
> 
> This offers an alterntive way to deal with reverted merges (the
> revert-a-faulty-merge.txt howto recommends reverting the initial reversion
> before re-merging a modified topic branch).
> 
> With this change, you can instead use the --no-ff option to recreate the
> branch with entirely new commits (they're new because at the very least the
> committer time is different).  This obviates the need to revert the
> reversion, as you can re-merge the new topic branch directly.
> 
> (Honestly, I wouldn't say that this approach is vastly superior to
> reverting the reversion.  I just find it a little less messy and a little
> more intuitive.  It's also a bit easier to explain to people to "use --no-ff
> after reverting a merge" instead of making sure they get the double-
> reversion right.)
> 
> 		M.
> 
>  Documentation/git-rebase.txt |   13 ++++++++++++-
>  git-rebase--interactive.sh   |   10 ++++++++--
>  t/t3417-rebase-no-ff.sh      |   36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 3 deletions(-)
>  create mode 100755 t/t3417-rebase-no-ff.sh
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 823f2a4..01f1476 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -316,7 +316,18 @@ which makes little sense.
>  	commit to be modified, and change the action of the moved
>  	commit from `pick` to `squash` (or `fixup`).
>  +
> -This option is only valid when '--interactive' option is used.
> +This option is only valid when the '--interactive' option is used.
> +
> +--no-ff::
> +	Cherry-pick all rebased commits instead of fast-forwarding over
> +	the unchanged ones.  This ensures that the entire history of the
> +	rebased branch is composed of new commits.  You may find this
> +	helpful after reverting a topic branch merge, as this option
> +	recreates the topic branch with fresh commits so it can be remerged
> +	successfully without needing to "reverting the reversion" (as described
> +	in the link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To]).
> ++
> +This option is only valid when the '--interactive' option is used.
>  
>  include::merge-strategies.txt[]
>  
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 3e4fd14..aecac3e 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -20,6 +20,7 @@ v,verbose          display a diffstat of what changed upstream
>  onto=              rebase onto given branch instead of upstream
>  p,preserve-merges  try to recreate merges instead of ignoring them
>  s,strategy=        use the given merge strategy
> +no-ff              never fast-forward any commits, even if they're unchanged
>  m,merge            always used (no-op)
>  i,interactive      always used (no-op)
>   Actions:
> @@ -103,6 +104,7 @@ VERBOSE=
>  OK_TO_SKIP_PRE_REBASE=
>  REBASE_ROOT=
>  AUTOSQUASH=
> +NO_SKIP=
>  
>  GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
>  mark the corrected paths with 'git add <paths>', and
> @@ -222,7 +224,7 @@ do_with_author () {
>  }
>  
>  pick_one () {
> -	no_ff=
> +	no_ff=$NO_SKIP
>  	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
>  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
>  	test -d "$REWRITTEN" &&
> @@ -742,6 +744,10 @@ first and then run 'git rebase --continue' again."
>  	-i)
>  		# yeah, we know
>  		;;
> +	--no-ff)
> +		# Set -n parameter to pass to pick_one function
> +		NO_SKIP=t
> +		;;
>  	--root)
>  		REBASE_ROOT=t
>  		;;
> @@ -927,7 +933,7 @@ EOF
>  		has_action "$TODO" ||
>  			die_abort "Nothing to do"
>  
> -		test -d "$REWRITTEN" || skip_unnecessary_picks
> +		test -d "$REWRITTEN" || ( test -z "$NO_SKIP" && skip_unnecessary_picks )
>  
>  		git update-ref ORIG_HEAD $HEAD
>  		output git checkout $ONTO && do_rest
> diff --git a/t/t3417-rebase-no-ff.sh b/t/t3417-rebase-no-ff.sh
> new file mode 100755
> index 0000000..29455da
> --- /dev/null
> +++ b/t/t3417-rebase-no-ff.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Marc Branchaud
> +#
> +
> +test_description='git rebase -i --no-ff tests'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +set_fake_editor
> +
> +test_expect_success setup '
> +	echo hello > hello &&
> +	git add hello &&
> +	git commit -m "hello" &&
> +
> +	echo world >> hello &&
> +	git commit -a -m "hello world" &&
> +
> +	echo goodbye >> hello &&
> +	git commit -a -m "goodbye" &&
> +
> +	git tag old_head
> +	'
> +# Pause to ensure that the cherry-picked commits have a different
> +# timestamp.
> +sleep 1
> +
> +test_expect_success rebase '
> +	git rebase -i --no-ff HEAD~2 &&
> +	test ! $(git rev-parse HEAD) = $(git rev-parse old_head)
> +	'
> +
> +test_done
