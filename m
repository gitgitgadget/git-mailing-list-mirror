From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4 v6] cache-tree: Write updated cache-tree after commit
Date: Fri, 11 Jul 2014 08:52:49 -0700
Message-ID: <xmqq38e76gfi.fsf@gitster.dls.corp.google.com>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
	<1405038686-1138-4-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:53:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5d8C-0001vy-HI
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 17:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbaGKPxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 11:53:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57064 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbaGKPw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 11:52:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F04925831;
	Fri, 11 Jul 2014 11:52:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iHgPWBebrcRGq3rHLNJ7ytfI8ig=; b=b9rlXC
	AnrHKNgSslcSQmDWgNl7XyMkQly6Y6xLdvh5m3nQu5oLfKtG1d4JozjqBk1oiPu9
	kOYb4SBCNpPSjwy8kck3yaPueDotUYCk1zOiECo6CVEbczLG/JQKG1mQMh+ZAwVF
	iuWhCnxjTnH0SMUOSl8uodC4huXYUoR8uC1M0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LiuJrzXqfvEHcGzTMKdWueznTmvtDvUQ
	EfVB9Lea1o6jAHwY9rDE5vUJvObqxXTJREOZSRZHq6cu46PBQXZ3cTKK4N8aAsvy
	ZP/biw7lwDIXB8KtwbQgQv8lNEzIafqYRy22VEtYd2Lv86KLzlbiWDfnfRQscH5p
	SbY7T0cZmGM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 423E62582F;
	Fri, 11 Jul 2014 11:52:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6958D25809;
	Fri, 11 Jul 2014 11:52:36 -0400 (EDT)
In-Reply-To: <1405038686-1138-4-git-send-email-dturner@twitter.com> (David
	Turner's message of "Thu, 10 Jul 2014 17:31:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6100DDA0-0913-11E4-A57C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253284>

David Turner <dturner@twopensource.com> writes:

> @@ -16,8 +16,34 @@ cmp_cache_tree () {
>  # We don't bother with actually checking the SHA1:
>  # test-dump-cache-tree already verifies that all existing data is
>  # correct.

Is this statement now stale and needs to be removed?

> -test_shallow_cache_tree () {
> -	printf "SHA  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >expect &&
> +generate_expected_cache_tree_rec () {
> +	dir="$1${1:+/}" &&
> +	parent="$2" &&
> +	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
> +	# We want to count only foo because it's the only direct child
> +	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
> +	subtree_count=$(echo "$subtrees"|awk '$1 {++c} END {print c}') &&
> +	entries=$(git ls-files|wc -l) &&
> +	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
> +	for subtree in $subtrees
> +	do
> +	    cd "$subtree"
> +	    generate_expected_cache_tree_rec "$dir$subtree" "$dir" || return 1
> +	    cd ..
> +	done &&
> +	dir=$parent
> +}
> +
> +generate_expected_cache_tree () {
> +    cwd=$(pwd)
> +    generate_expected_cache_tree_rec
> +    ret="$?"
> +    cd "$cwd"
> +    return $ret
> +}

As we always have had trouble between $PWD and $(pwd) on other
platforms, I'd prefer something simpler, like:

	expected_cache_tree () {
		(
                	# subshell to let it wander around freely
	        	generate_expected_cache_tree_rec
		)
	}

Other than these two, the new tests were good from a cursory look.
The change to builtin/commit.c looked good, too.

Thanks.
