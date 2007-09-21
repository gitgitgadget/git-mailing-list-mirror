From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Fri, 21 Sep 2007 14:35:21 -0600
Message-ID: <1190406921.6541.16.camel@beauty>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYpCD-0001ks-KM
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 22:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbXIUUdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 16:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100AbXIUUdr
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 16:33:47 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:4924 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbXIUUdq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 16:33:46 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Fri, 21 Sep 2007 14:33:32 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [134.253.112.193] (sacv8030gl.sandia.gov
 [134.253.112.193]) by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id
 l8LKXUYT003834 for <git@vger.kernel.org>; Fri, 21 Sep 2007 14:33:31
 -0600
In-Reply-To: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.21.131353
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0, __STOCK_PHRASE_7 0'
X-TMWD-Spam-Summary: TS=20070921203333; SEV=2.2.2; DFV=B2007092115;
 IFV=2.0.4,4.0-9; AIF=B2007092115; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230372E34364634324139432E303031353A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092115_5.02.0125_4.0-9
X-WSS-ID: 6AEAF5163HO3113833-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58876>

Junk.  Sorry about the address.  My mailer went retarded.

-JE

On Fri, 2007-09-21 at 14:27 -0600, root wrote:
> Signed-off-by: Josh England <jjengla@sandia.gov>
> ---
>  Documentation/hooks.txt       |   10 +++++++
>  git-checkout.sh               |    5 +++
>  t/t5403-post-checkout-hook.sh |   61 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 0 deletions(-)
>  create mode 100755 t/t5403-post-checkout-hook.sh
> 
> diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
> index c39edc5..e78f91a 100644
> --- a/Documentation/hooks.txt
> +++ b/Documentation/hooks.txt
> @@ -87,6 +87,16 @@ parameter, and is invoked after a commit is made.
>  This hook is meant primarily for notification, and cannot affect
>  the outcome of `git-commit`.
>  
> +post-checkout
> +-----------
> +
> +This hook is invoked when a `git-checkout` is run on a local repository.
> +The hook is given two parameters: the ref of the previous HEAD, and the ref of 
> +the new HEAD.  This hook cannot affect the outcome of `git-checkout`.
> +
> +This hook can be used to perform repository validity checks, auto-display
> +differences from the previous HEAD, or set working dir metadata properties.
> +
>  [[pre-receive]]
>  pre-receive
>  -----------
> diff --git a/git-checkout.sh b/git-checkout.sh
> index 17f4392..0cff36c 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
> @@ -284,3 +284,8 @@ if [ "$?" -eq 0 ]; then
>  else
>  	exit 1
>  fi
> +
> +# Run a post-checkout hook
> +if test -x "$GIT_DIR"/hooks/post-checkout; then
> +        "$GIT_DIR"/hooks/post-checkout $old $new
> +fi
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> new file mode 100755
> index 0000000..aa0216a
> --- /dev/null
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2006 Josh England
> +#
> +
> +test_description='Test the post-checkout hook.'
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	echo Data for commit0. >a &&
> +	git update-index --add a &&
> +	tree0=$(git write-tree) &&
> +	commit0=$(echo setup | git commit-tree $tree0) &&
> +        git update-ref refs/heads/master $commit0 &&
> +	git-clone ./. clone1 &&
> +	git-clone ./. clone2 &&
> +        GIT_DIR=clone2/.git git branch -a new2 &&
> +       	echo Data for commit1. >clone2/b &&
> +	GIT_DIR=clone2/.git git add clone2/b &&
> +	GIT_DIR=clone2/.git git commit -m new2
> +'
> +
> +for clone in 1 2; do 
> +    cat >clone${clone}/.git/hooks/post-checkout <<'EOF'
> +#!/bin/sh
> +echo $@ > $GIT_DIR/post-checkout.args
> +EOF
> +    chmod u+x clone${clone}/.git/hooks/post-checkout
> +done
> +
> +test_expect_success 'post-checkout runs as expected ' '
> +        GIT_DIR=clone1/.git git checkout master &&
> + 	test -e clone1/.git/post-checkout.args
> +'
> +
> +test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
> +         old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
> +         new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&         
> +         test $old = $new
> +'
> +
> +test_expect_success 'post-checkout runs as expected ' '
> +        GIT_DIR=clone1/.git git checkout master &&
> + 	test -e clone1/.git/post-checkout.args
> +'
> +
> +test_expect_success 'post-checkout args are correct with git checkout -b ' '
> +        GIT_DIR=clone1/.git git checkout -b new1 &&
> +        old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
> +        new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&         
> +        test $old = $new
> +'
> +
> +test_expect_success 'post-checkout receives the right arguments with HEAD changed ' '
> +        GIT_DIR=clone2/.git git checkout new2 &&
> +        old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
> +        new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&         
> +        test $old != $new
> +'
> +
> +test_done
