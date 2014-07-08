From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 06/19] rebase -i: Stop on root commits with empty log messages
Date: Tue, 08 Jul 2014 15:26:39 -0700
Message-ID: <xmqq8uo38p28.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<00ca9dc0d1750301aa22c2bb78976b141233cef3.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 00:27:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4dql-0006Ye-Gd
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 00:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbaGHW0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 18:26:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53813 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbaGHW0q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 18:26:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2236327DFF;
	Tue,  8 Jul 2014 18:26:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JEiUg+XSZiklD4O9auP+h0q4/h0=; b=GMpmj/
	GOA2D09fc8DofNkLcAhwAFt5IQcgXS90ynqzhCtulVRFsPDXwYAHLsj0nvKTMj/g
	8520kkVP35NuwNZVh6nrc0aD4BMrLKYWaaSi2TIzWr2yjIv7UQfsXyrsJVezOw4b
	gULAc/Mpbku6jbgwibyIpI++qUpeDCdcuJLOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=am0FzkFFapiNgGOF6CCahh/7uFGDu/cR
	slkh8TRbolQk9IUKSDMgUq9ZlUCInopVlYtZh6iut86YYfdnS9W6A6LhWX10gQqY
	KR8kUiNs6nZCxbex+LYV7LEsNVMkAGVxEWkR3QxMgkfC8KHSDTFMHW00m06xfeTD
	UM2JF2qoeXw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 170C027DFE;
	Tue,  8 Jul 2014 18:26:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E878327DFC;
	Tue,  8 Jul 2014 18:26:25 -0400 (EDT)
In-Reply-To: <00ca9dc0d1750301aa22c2bb78976b141233cef3.1404323078.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 2 Jul 2014 19:47:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E60EA274-06EE-11E4-A045-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253054>

Fabian Ruch <bafain@gmail.com> writes:

> The command line used to recreate root commits specifies the
> erroneous option `--allow-empty-message`. If the root commit has an
> empty log message, the replay of this commit should fail and the
> rebase should be interrupted like for any other commit that is on the
> to-do list and has an empty commit message. Remove the option.
>
> The option might have been introduced by copy-and-paste of the first
> part of the command line which initializes the authorship of the
> sentinel commit. Indeed, the sentinel commit has an empty log message
> and this should not trigger a failure, which is why the option
> `--allow-empty-message` is correctly specified here.

The first "commit --amend" uses -C "$1" to give the amended result
not just the authorship but also the log message taken from "$1".
If we are allowing a commit without any message to be used as "$1",
I think --allow-empty-message needs to be there.  If "$1" requires
the option here, why doesn't the second one, that records the
updated tree with the metainformation taken from the same commit
"$1" can successfully commit without the option?

Puzzled...

> Add test.
>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh |  2 +-
>  t/t3412-rebase-root.sh     | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 4c875d5..0af96f2 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -510,7 +510,7 @@ do_pick () {
>  		git commit --allow-empty --allow-empty-message --amend \
>  			   --no-post-rewrite -n -q -C $1 &&
>  			pick_one -n $1 &&
> -			git commit --allow-empty --allow-empty-message \
> +			git commit --allow-empty \
>  				   --amend --no-post-rewrite -n -q -C $1 \
>  				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>  			die_with_patch $1 "Could not apply $1... $2"
> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
> index 0b52105..9867705 100755
> --- a/t/t3412-rebase-root.sh
> +++ b/t/t3412-rebase-root.sh
> @@ -278,4 +278,43 @@ test_expect_success 'rebase -i -p --root with conflict (second part)' '
>  	test_cmp expect-conflict-p out
>  '
>  
> +test_expect_success 'stop rebase --root on empty root log message' '
> +	# create a root commit with a non-empty tree so that rebase does
> +	# not fail because of an empty commit, and an empty log message
> +	echo root-commit >file &&
> +	git add file &&
> +	tree=$(git write-tree) &&
> +	root=$(git commit-tree $tree </dev/null) &&
> +	git checkout -b no-message-root-commit $root &&
> +	# do not ff because otherwise neither the patch nor the message
> +	# are looked at and checked for emptiness
> +	test_when_finished git rebase --abort &&
> +	test_must_fail env EDITOR=true git rebase -i --force-rebase --root &&
> +	echo root-commit >file.expected &&
> +	test_cmp file.expected file
> +'
> +
> +test_expect_success 'stop rebase --root on empty child log message' '
> +	# create a root commit with a non-empty tree and provide a log
> +	# message so that rebase does not fail until the root commit is
> +	# successfully replayed
> +	echo root-commit >file &&
> +	git add file &&
> +	tree=$(git write-tree) &&
> +	root=$(git commit-tree $tree -m root-commit) &&
> +	git checkout -b no-message-child-commit $root &&
> +	# create a child commit with a non-empty patch so that rebase
> +	# does not fail because of an empty commit, but an empty log
> +	# message
> +	echo child-commit >file &&
> +	git add file &&
> +	git commit --allow-empty-message --no-edit &&
> +	# do not ff because otherwise neither the patch nor the message
> +	# are looked at and checked for emptiness
> +	test_when_finished git rebase --abort &&
> +	test_must_fail env EDITOR=true git rebase -i --force-rebase --root &&
> +	echo child-commit >file.expected &&
> +	test_cmp file.expected file
> +'
> +
>  test_done
