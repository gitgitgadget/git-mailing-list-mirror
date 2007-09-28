From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Fri, 28 Sep 2007 18:03:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709281751390.28395@racer.site>
References: <11909961212172-git-send-email-tom@u2i.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 19:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbJH8-0004wX-FO
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 19:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbXI1RFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 13:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbXI1RFB
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 13:05:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:36751 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752451AbXI1RFA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 13:05:00 -0400
Received: (qmail invoked by alias); 28 Sep 2007 17:04:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 28 Sep 2007 19:04:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2Vl9p4ay2SnZm6k0YvZ3qaw/eH63aL86tVNNz2Z
	sAFgdHLqgLZUAg
X-X-Sender: gene099@racer.site
In-Reply-To: <11909961212172-git-send-email-tom@u2i.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59409>

Hi,

On Fri, 28 Sep 2007, Tom Clarke wrote:

> diff --git a/git-merge-rebase.sh b/git-merge-rebase.sh
> new file mode 100755
> index 0000000..fc07331
> --- /dev/null
> +++ b/git-merge-rebase.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2005 Linus Torvalds

Really?

> +# Copyright (c) 2007 Tom Clarke
> +#
> +# Resolve two trees with rebase
> +
> +# The first parameters up to -- are merge bases; the rest are heads.
> +bases= head= remotes= sep_seen=
> +for arg
> +do
> +	case ",$sep_seen,$head,$arg," in
> +	*,--,)
> +		sep_seen=yes
> +		;;
> +	,yes,,*)
> +		head=$arg
> +		;;
> +	,yes,*)
> +		remotes="$remotes$arg "
> +		;;
> +	*)
> +		bases="$bases$arg "
> +		;;
> +	esac
> +done
> +
> +# Give up if we are given two or more remotes -- not handling octopus.
> +case "$remotes" in
> +?*' '?*)
> +	exit 2 ;;
> +esac

You can check that much earlier, no?  IOW something like

	while test $# != 0
	do
		case "$1" in --) break ;; esac
		shift
	done

	test $# = 3 || die "merge stragey rebase needs exactly one ref"

	git rebase "$3"

(It's not like you need the variables...) Hmm?

> +git rebase $remotes || exit 2
> diff --git a/git-merge.sh b/git-merge.sh
> index 6c513dc..ea3cc16 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -81,11 +82,18 @@ finish () {
>  			echo "No merge message -- not updating HEAD"
>  			;;
>  		*)
> -			git update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
> +			case " $wt_strategy " in
> +			*" $no_update_ref "*)
> +				;;
> +			*)
> +				git update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
> +				;;
> +			esac

You may want to warn earlier, if a message was supplied with -s rebase, or 
even error out.

> diff --git a/t/t3031-merge-rebase.sh b/t/t3031-merge-rebase.sh
> new file mode 100755
> index 0000000..8e3641d
> --- /dev/null
> +++ b/t/t3031-merge-rebase.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description='merge-rebase backend test'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'merging using rebase does not create merge commit' '
> +	echo hello >a &&
> +	git add a &&
> +	test_tick && git commit -m initial &&
> +
> +	git checkout -b branch &&
> +	echo hello >b &&
> +	git add b &&
> +	test_tick && git commit -m onbranch &&
> +
> +	git checkout master &&
> +	echo update >a &&
> +	git add a &&
> +	test_tick && git commit -m update &&

I like to have something like this in a "test_expect_success setup" part, 
and then have the meat of the test in its own test case.

But hey, you're the author, it's for you to decide.

Thanks,
Dscho
