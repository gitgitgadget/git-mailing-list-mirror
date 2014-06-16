From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase--merge: fix --skip with two conflicts in a row
Date: Mon, 16 Jun 2014 13:31:59 -0700
Message-ID: <xmqqoaxsppds.fsf@gitster.dls.corp.google.com>
References: <20140615223913.GI368384@vauxhall.crustytoothpaste.net>
	<ea5a46c7605a181b6726093e04bc882b013fd504.1402876855.git.sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phillip Susi <psusi@ubuntu.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:32:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdZc-0008MQ-H0
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841AbaFPUcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:32:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53054 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193AbaFPUcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:32:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BC3220750;
	Mon, 16 Jun 2014 16:32:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xiETJgcWK4vp+DAa19d8AnPOcmQ=; b=IIpdxn
	HwSin0lxu32Az2yacuGqd3uDTnEYw9oRlLipmRd1cKNWdmx0SF5iJeByqCe+AV/o
	UJ64g6RSihP6FOvcGwyI6Xtwc/C82Zl1kgte2A0g51Rv4mFS8hvytHfsqFGiK9K4
	l5oTCYjc6r4romZyUqxrhSOVZv0sY1m2Wh0zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cCB4QPP1BJjgW7/JTi9ZWjHtbIe9N3MN
	xZ5yHcY9ZCkdKWb2m8jKtSHU7zsq4bz4FZmqoEbIHt9199rvJ6aXgrLiB93fpnhg
	S5gy9gZG0rus1dNCSEEGYLQ/j0bkh3tt0sSCIirND8DycQyHkFvPaTomtibptWg+
	XMxvVzhnOG4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 421FA2074F;
	Mon, 16 Jun 2014 16:32:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 663FE20743;
	Mon, 16 Jun 2014 16:31:59 -0400 (EDT)
In-Reply-To: <ea5a46c7605a181b6726093e04bc882b013fd504.1402876855.git.sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Mon, 16 Jun 2014 00:01:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4431C496-F595-11E3-A579-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251821>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If git rebase --merge encountered a conflict, --skip would not work if the
> next commit also conflicted.  The msgnum file would never be updated with
> the new patch number, so no patch would actually be skipped, resulting in an
> inescapable loop.
>
> Update the msgnum file's value as the first thing in call_merge.  This also
> avoids an "Already applied" message when skipping a commit.  There is no
> visible change for the other contexts in which call_merge is invoked, as the
> msgnum file's value remains unchanged in those situations.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Sounds good to me.  Thanks.

>  git-rebase--merge.sh    |  5 +++--
>  t/t3402-rebase-merge.sh | 15 +++++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index 6d77b3c..d3fb67d 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -53,11 +53,12 @@ continue_merge () {
>  }
>  
>  call_merge () {
> -	cmt="$(cat "$state_dir/cmt.$1")"
> +	msgnum="$1"
> +	echo "$msgnum" >"$state_dir/msgnum"
> +	cmt="$(cat "$state_dir/cmt.$msgnum")"
>  	echo "$cmt" > "$state_dir/current"
>  	hd=$(git rev-parse --verify HEAD)
>  	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
> -	msgnum=$(cat "$state_dir/msgnum")
>  	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
>  	eval GITHEAD_$hd='$onto_name'
>  	export GITHEAD_$cmt GITHEAD_$hd
> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
> index be8c1d5..5a27ec9 100755
> --- a/t/t3402-rebase-merge.sh
> +++ b/t/t3402-rebase-merge.sh
> @@ -33,6 +33,7 @@ test_expect_success setup '
>  	tr "[a-z]" "[A-Z]" <original >newfile &&
>  	git add newfile &&
>  	git commit -a -m"side edits further." &&
> +	git branch second-side &&
>  
>  	tr "[a-m]" "[A-M]" <original >newfile &&
>  	rm -f original &&
> @@ -41,6 +42,7 @@ test_expect_success setup '
>  	git branch test-rebase side &&
>  	git branch test-rebase-pick side &&
>  	git branch test-reference-pick side &&
> +	git branch test-conflicts side &&
>  	git checkout -b test-merge side
>  '
>  
> @@ -138,4 +140,17 @@ test_expect_success 'rebase -s funny -Xopt' '
>  	test -f funny.was.run
>  '
>  
> +test_expect_success 'rebase --skip works with two conflicts in a row' '
> +	git checkout second-side  &&
> +	tr "[A-Z]" "[a-z]" <newfile >tmp &&
> +	mv tmp newfile &&
> +	git commit -a -m"edit conflicting with side" &&
> +	tr "[d-f]" "[D-F]" <newfile >tmp &&
> +	mv tmp newfile &&
> +	git commit -a -m"another edit conflicting with side" &&
> +	test_must_fail git rebase --merge test-conflicts &&
> +	test_must_fail git rebase --skip &&
> +	git rebase --skip
> +'
> +
>  test_done
