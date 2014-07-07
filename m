From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] cache-tree: subdirectory tests
Date: Mon, 07 Jul 2014 12:15:07 -0700
Message-ID: <xmqqegxxc75w.fsf@gitster.dls.corp.google.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
	<1404619619-4774-3-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 21:15:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4ENu-0003Cb-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 21:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbaGGTPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 15:15:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51905 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbaGGTPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 15:15:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 81DF92601C;
	Mon,  7 Jul 2014 15:15:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nbT6Nhb83NjtWk1pUlT4mS6D4OY=; b=VT6h4W
	qBLjXZCLfx2sPYYtlsO/D8Xi6rt1D1dk26riBYzdlsJWp5jOQk3BE5F238ee9ebh
	HvOuVkIriFjtCFFQKT13MhRSuDxTqt+hH/YLllCCoVld9S6U931FbQvSA9y3jakf
	KhBq/uxhIIBfitpt3nh4MWIn8PF1UoZv00GgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N9Ii/F68ueLLsVnPDGqOUGLs09BI7YY0
	cU49Gq5t5Msm8XzXwJIcfNMrrnGHzyUM8n/owN4GKwhojNgTvI4V2nngYAAAjoeo
	OOLMVvvGy8VngnxvCbdxyGtR9WLyNAWUhe2o14HDICKyzsNFkEdtwz2fgFTxOaGo
	qioPmfn0zXw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEA002601B;
	Mon,  7 Jul 2014 15:15:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 55CD726010;
	Mon,  7 Jul 2014 15:14:59 -0400 (EDT)
In-Reply-To: <1404619619-4774-3-git-send-email-dturner@twitter.com> (David
	Turner's message of "Sat, 5 Jul 2014 21:06:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FD187B78-060A-11E4-A1A3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252982>

David Turner <dturner@twopensource.com> writes:

> Add tests to confirm that invalidation of subdirectories nether over-
> nor under-invalidates.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  t/t0090-cache-tree.sh | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 98fb1ab..8437c5f 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -21,10 +21,13 @@ test_shallow_cache_tree () {
>  	cmp_cache_tree expect
>  }
>  
> +# Test that the cache-tree for a given directory is invalid.
> +# If no directory is given, check that the root is invalid
>  test_invalid_cache_tree () {
> -	echo "invalid                                   (0 subtrees)" >expect &&
> -	printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
> -	cmp_cache_tree expect
> +	test-dump-cache-tree >actual &&
> +	sed -e "s/$_x40/SHA/" -e "s/[0-9]* subtrees//g" <actual >filtered &&
> +	expect=$(printf "invalid                                  $1 ()\n") &&

It would be saner to do 'printf "string %s more string" "$1"' than
embedding caller-supplied "$1" inside the format specifier.

> +	fgrep "$expect" filtered

We'd actually want to see fewer uses of 'fgrep' in the tests for two
reasons.

Is having an entry that is invalidated the only thing we care about
in this test?  Shouldn't the caller expect "These subtrees and
nothing else must be invalidated", in which case the helper should
check not just the expected "invalid dir1/" appears in the output
but no other unexpected "invalid somethingelse/" appears (and this
"no other unexpected output" makes use of grep family in tests like
this less desirable).

In other words, wouldn't it be better to do the helper along the
lines of:

	test_invalidated_cache_tree () {
        	if test $# != 0
		then
	        	printf "invalid %s ()\n" "" "$@"
                fi >expect &&
		test-dump-cache-tree |
                sed -n -e '/^invalid /p' >actual &&
                test_cmp expect actual
	}

and use

	test_invalidated_cache_tree dir1

when we expect only dir1 and dir2 (but not dir2 or anything else) is
invalidated?

Thanks.
