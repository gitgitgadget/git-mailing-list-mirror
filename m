From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/31] rebase: refactor reading of state
Date: Tue, 28 Dec 2010 15:08:25 -0800
Message-ID: <7v1v51v6l2.fsf@alter.siamese.dyndns.org>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1293528648-21873-3-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 00:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXier-0007oP-LK
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 00:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844Ab0L1XIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 18:08:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0L1XIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 18:08:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB1D23DF4;
	Tue, 28 Dec 2010 18:09:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3S0w4AdiboKlWYGXwqW9SV20MWI=; b=YuuUtaXxnM3q1632WKvyge8
	1fPz2tOESn9CFzyRlJ39poWgfAEAo9YNW2V3DTvdwYKWainUSwxwcN+icx/WKDjh
	0sY0IOLUa7EIe9QRVApw/ZUy1eRPLP0WpPqwIafI03sAXHfR19r7DF9QTMRb6ap8
	/bDT7VgfReEKmwbLM21s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=o4Cz/heftfwnUB40TldjP8Lnp1moRFSiScmyWA4k4R/bqqseK
	fm+Lf8MLPO0Lob1iXn2h7ISbU+TAsjI7Ka2z8ultnBf9UGPnG/L0NvOOVYpi0JHS
	HU9BkFkbbfgE+nb6aA1SNdzvfOooeElLv6+cYBKUpP4ZvFDYB5i6ch9D78=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B2D13DEE;
	Tue, 28 Dec 2010 18:09:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 122183DE5; Tue, 28 Dec 2010
 18:08:59 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 78B0BC9E-12D7-11E0-802B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164294>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> +read_state () {
> +	if test -d "$merge_dir"
> +	then
> +		state_dir="$merge_dir"
> +		prev_head=$(cat "$merge_dir"/prev_head) &&
> +		end=$(cat "$merge_dir"/end) &&
> +		msgnum=$(cat "$merge_dir"/msgnum)
> +	else
> +		state_dir="$apply_dir"
> +	fi &&
> +	head_name=$(cat "$state_dir"/head-name) &&
> +	onto=$(cat "$state_dir"/onto) &&
> +	orig_head=$(cat "$state_dir"/orig-head) &&
> +	GIT_QUIET=$(cat "$state_dir"/quiet)
> +}
> +
>  continue_merge () {
>  	test -n "$prev_head" || die "prev_head must be defined"
>  	test -d "$merge_dir" || die "$merge_dir directory does not exist"
> @@ -138,10 +154,6 @@ call_merge () {
>  }
>  
>  move_to_original_branch () {
> -	test -z "$head_name" &&
> -		head_name="$(cat "$merge_dir"/head-name)" &&
> -		onto="$(cat "$merge_dir"/onto)" &&
> -		orig_head="$(cat "$merge_dir"/orig-head)"

It used to be safe to call this without head_name and friends set, because
the function took care of reading these itself.  Nobody calls this without
head_name set anymore?

I am not complaining nor suggesting to add an unnecessary "read_state"
here only to slow things down---I am making sure that you removed this
because you know it is unnecessary.

> @@ -220,13 +232,9 @@ do
>  			echo "mark them as resolved using git add"
>  			exit 1
>  		}
> +		read_state
>  		if test -d "$merge_dir"
>  		then
> -			prev_head=$(cat "$merge_dir/prev_head")
> -			end=$(cat "$merge_dir/end")
> -			msgnum=$(cat "$merge_dir/msgnum")
> -			onto=$(cat "$merge_dir/onto")
> -			GIT_QUIET=$(cat "$merge_dir/quiet")

Even though this patch may make the code shorter, it starts to read
head_name and orig_head that we previously did not open and change the
values of variables with what are read from them.  Does this change affect
the behaviour in any way (either in performance or in correctness)?

> @@ -236,10 +244,6 @@ do
>  			finish_rb_merge
>  			exit
>  		fi
> -		head_name=$(cat "$apply_dir"/head-name) &&
> -		onto=$(cat "$apply_dir"/onto) &&
> -		orig_head=$(cat "$apply_dir"/orig-head) &&
> -		GIT_QUIET=$(cat "$apply_dir"/quiet)
>  		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
>  		move_to_original_branch

Earlier move-to-original-branch was Ok to be called without head_name, and
the old code here read from the file anyway, so it didn't matter, but now
it seems that the first check and assignment you removed from the function
may matter because this caller does not even read from head_name.  Are you
sure about this change?

> @@ -279,18 +275,15 @@ do
>  			die "No rebase in progress?"
>  
>  		git rerere clear
> -
> -		test -d "$merge_dir" || merge_dir="$apply_dir"

My heartbeat skipped when I first saw this.  Thanks to the previous
commit, it was exposed that somebody reused $dotest that was only to be
used when using merge machinery because the things left to be done in this
codepath are common between the merge and apply, which is kind of sloppy,
but that sloppiness is now gone ;-).

Are there places that read from individual files for states left after
this patch, or read_state is the only interface to get to the states?  If
the latter that would be a great news, and also would suggest that we may
want to have a corresponding write_state function (and we may even want to
make the state into a single file to reduce I/O---but that is a separate
issue that can be done at the very end of the series if it turns out to be
beneficial).

Of course it is fine if introduction of read_state is an attempt to catch
most common cases, but it would reduce chances of mistake if the coverage
were 100% (as opposed to 99.9%) hence this question.
