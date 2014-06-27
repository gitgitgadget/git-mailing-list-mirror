From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash create: Add --include-untracked and --all option to stash create
Date: Fri, 27 Jun 2014 10:37:24 -0700
Message-ID: <xmqqionm2qzv.fsf@gitster.dls.corp.google.com>
References: <1403856479-37421-1-git-send-email-shigeta@kanamei.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: shigeta@kanamei.co.jp
X-From: git-owner@vger.kernel.org Fri Jun 27 19:37:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0a5i-0000vk-EY
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 19:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbaF0Rhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 13:37:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61869 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaF0Rhe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 13:37:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DEBD022338;
	Fri, 27 Jun 2014 13:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+cZSYUbxgByqmeA1bJiUFSo4Uws=; b=x8sGgT
	O5L0sexuyDOh6dsrzo+r0h7qS4na2mxQif9Pf5HTxYprY0OBiBU37mq08AK29DBy
	wuHNdKSkKRSo3esh3AqwJfB7k40r3dH8AoDJtN0FULW/iUHDNbkYsR+D4GGD1RYQ
	fKUAWXn9VQl3zXDXPp/J8Y2ICMzTZLxGwnxoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZNCiGgaCthWhC2jbmcSBdUhH1WTPhSsH
	j0KE/+bRb93Uqt7S1SncstDz9rirfLX4Wi+NVcv9Eaq/FJp1PASYa8Zz10YG8AZ0
	iF6kz5W240+MsBwO4mlKSSKHSBeXbrED11wp4tFv2/8mwXtmsFOwb5FRBVRKgK1k
	dkAVPWL2J3M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D322A22337;
	Fri, 27 Jun 2014 13:37:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 943752232E;
	Fri, 27 Jun 2014 13:37:17 -0400 (EDT)
In-Reply-To: <1403856479-37421-1-git-send-email-shigeta@kanamei.co.jp>
	(shigeta@kanamei.co.jp's message of "Fri, 27 Jun 2014 17:07:59 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AF176FF6-FE21-11E3-9592-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252563>

shigeta@kanamei.co.jp writes:

> From: Kazumasa Shigeta <shigeta@kanamei.co.jp>
>
> The --include-untracked option acts like the normal "git stash save --include-untracked --all" but it does not change anything in working directory.
> It is inconvenient stash create does not have --include-untracked option however stash save has --include-untracked option.

Please wrap long lines.

> It fails when using message that start with dash. It is not compatible with now.

I cannot quite parse this.  What do you exactly mean by "It is not
compatible with now"?  Do you mean "with this patch, we break
backward compatibility" and if so in what way?

> diff --git a/git-stash.sh b/git-stash.sh
> index 4798bcf..d636651 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -57,8 +57,35 @@ clear_stash () {
>  }
>  
>  create_stash () {
> -	stash_msg="$1"
> -	untracked="$2"
> +    stash_msg=
> +    untracked=

Broken indentation here?  We indent with tabs, not runs of spaces.

> +	while test $# != 0
> +	do
> +		case "$1" in
> +		-u|--include-untracked)
> +			untracked=untracked
> +			;;
> +		-a|--all)
> +			untracked=all
> +			;;
> +		--)
> +			shift
> +			break
> +			;;
> +		-*)
> +			option="$1"
> +			eval_gettextln "error: unknown option for 'stash create': \$option
> +       To provide a message, use git stash create -- '\$option'"
> +			exit 1
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +	stash_msg="$*"
>  
>  	git update-index -q --refresh
>  	if no_changes
> @@ -260,8 +287,25 @@ save_stash () {
>  	fi
>  	test -f "$GIT_DIR/logs/$ref_stash" ||
>  		clear_stash || die "$(gettext "Cannot initialize stash")"
> +    untracked_opt=
> +    case "$untracked" in
> +		untracked)
> +			untracked_opt="--include-untracked"
> +			break
> +			;;
> +		all)
> +			untracked_opt="--all"
> +			break
> +			;;
> +    esac
> +
> +	if test -z "$untracked_opt"
> +	then
> +		create_stash  -- "$stash_msg"
> +	else
> +		create_stash "$untracked_opt" -- "$stash_msg"
> +	fi
> -	create_stash "$stash_msg" $untracked

Wouldn't it suffice to do:

	create_stash ${untracked_opt:+"$untracked_opt"} -- "$stash_msg"

without if/then/else/fi?

> diff --git a/t/t3907-stash-create-include-untracked.sh b/t/t3907-stash-create-include-untracked.sh
> new file mode 100755
> index 0000000..c28ed0f
> --- /dev/null
> +++ b/t/t3907-stash-create-include-untracked.sh
> @@ -0,0 +1,286 @@
> +#!/bin/sh
> +#
> +# File:   t3907-stash-create-include-untracked.sh
> +# Author: shigeta
> +#
> +# Created on 2014/05/01, 13:13:15

Please discard the above lines.  We can see what file it is in, and
"git log" knows who wrote it when.  You are only risking them to
become obsolete and/or irrelevant over time without adding any real
value.

Don't we have existing test script for "stash"?  If we do, shouldn't
this patch be appending test pieces for new mode of operation it
introduces to that existing script instead?

> +test_description='Test git stash create --include-untracked and --all'
> +
> +. ./test-lib.sh
> +
> +cat > .gitignore <<EOF
> +.gitignore
> +ignored
> +ignored.d/
> +EOF

No SP between redirect operator and the filename.  Quote EOF if your
here-document does not need any variable interpolation to reduce
mental burden from readers.  I.e.

	cat >.gitignore <<\EOF
        foo
        bar
        EOF

Also in newer test scripts we try to have as little commands to be
executed outside test_expect_success set-up block as possible.  The
general structure of a new test script (if we do need to add one for
this patch, which I doubt) should be along the lines of...

	test_description='...'
        . ./test-lib.sh

	test_expect_success setup '
		the first test piece typically does all the set up &&
		cat >.gitignore <<-\EOF &&
                .gitignore
                ...
                EOF
		other initialisation necessary
	'

        test_expect_success 'explain what this second test checks' '
		piece specific setup &&
		cat >expect <<-\EOF &&
                expected output comes here
                EOF
                do the command >actual &&
                test_cmp expect actual
	'

        test_expect_success 'explain what this third test checks' '
        ...

        test_done
