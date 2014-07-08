From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] cache-tree: Write updated cache-tree after commit
Date: Tue, 08 Jul 2014 10:55:08 -0700
Message-ID: <xmqqoawzag77.fsf@gitster.dls.corp.google.com>
References: <1404779625-16972-1-git-send-email-dturner@twitter.com>
	<1404779625-16972-4-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 19:55:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Zbv-0005Ai-12
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 19:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbaGHRzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 13:55:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51740 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754895AbaGHRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 13:55:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37A9F2641A;
	Tue,  8 Jul 2014 13:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zzMKKKpWTLVLtA7jCvBz3/jOQFo=; b=JX0nhd
	t1eF4J/MHO5dpKIwtpkFnBKhRIJotHCKA1NBAksEhdguDIhvkoN3+vwFTlWI8nk8
	/rqgKRlBGsn+pgRGnHx6XL39WOHijhvDQh3hH+TZ94Ru/3GQwgAeDEnGQUTAMsUy
	v+fRgh6rL1rFV7RT66BVsk1kBLmNJOi7t+hY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yIXqn2zVTXK5jmNi7QRvhd9dZ6uol8oO
	aeqv2+6wUiR1oBgGoC5VbfpwNZWT5sfIbGXfj6A0FR08GrnEUtk1z/PiZ4wbqNl5
	VxgMB2ubC8IePMxeXGqMuL72Xs/9IlZRmYlLz+N/EG2p1vRBCT1uRyFxpOXM1RC+
	p4Wq/3y/PRs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C14726419;
	Tue,  8 Jul 2014 13:55:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF61826403;
	Tue,  8 Jul 2014 13:54:57 -0400 (EDT)
In-Reply-To: <1404779625-16972-4-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 7 Jul 2014 17:33:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9835294-06C8-11E4-A00E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253036>

David Turner <dturner@twopensource.com> writes:

> @@ -16,8 +16,26 @@ cmp_cache_tree () {
>  # We don't bother with actually checking the SHA1:
>  # test-dump-cache-tree already verifies that all existing data is
>  # correct.
> -test_shallow_cache_tree () {
> -	printf "SHA  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >expect &&
> +generate_expected_cache_tree () {
> +	dir="$1${1:+/}" &&
> +	parent="$2" &&
> +	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
> +	# We want to count only foo because it's the only direct child
> +	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
> +	subtree_count=$(echo "$subtrees"|awk '$1 {++c} END {print c}') &&
> +	entries=$(git ls-files|wc -l) &&
> +	printf "SHA $dir (%d entries, %d subtrees)\n" $entries $subtree_count &&
> +	for subtree in $subtrees
> +	do
> +	    cd "$subtree"
> +	    generate_expected_cache_tree "$dir$subtree" $dir || return 1
> +	    cd ..

If the || return 1 ever triggers, would the main test process end up
in an unexpected place?  A test piece executes test_cache_tree whose
control eventually reaches here and returns failure; the next test
piece will start at a wrong directory, no?

> +	done &&
> +	dir=$parent
> +}
> +
> +test_cache_tree () {
> +	generate_expected_cache_tree >expect &&
>  	cmp_cache_tree expect
>  }
>  
> @@ -33,14 +51,14 @@ test_no_cache_tree () {
>  	cmp_cache_tree expect
>  }
>  
> -test_expect_failure 'initial commit has cache-tree' '
> +test_expect_success 'initial commit has cache-tree' '
>  	test_commit foo &&
> -	test_shallow_cache_tree
> +	test_cache_tree
>  '
>  
>  test_expect_success 'read-tree HEAD establishes cache-tree' '
>  	git read-tree HEAD &&
> -	test_shallow_cache_tree
> +	test_cache_tree
>  '
