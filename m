Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E837A20441
	for <e@80x24.org>; Sun,  1 Jan 2017 01:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754878AbdAABLW (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 20:11:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61969 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754832AbdAABLV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 20:11:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FF735C464;
        Sat, 31 Dec 2016 20:11:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3VqySFcm+XAzf6IVcWs8SZlCfGc=; b=wM9hLc
        4SC4c/iqxEtZjAQtlwCu3FW6unJR2pNNAG4ZMcV7tLaHJ0TJuAdISrmBV4UKnEYC
        kraTqaJ7Y6p712UDR8tZhdC4c5w3XRr1r1foAvYmHhrpEmwyx7SdEqT9Ask0FaON
        b5EdjTyb9mKBj+DOrWj/R3BKL2StcZRtr7uTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=otv+ejCGr7u8iPByLS9nMyCW3TTLdSz3
        V1QmBAsW3WBQB9cOt09BWk3SKO8uEh8qeSxPhitEgLShnGBK5TQCNsYJVvNR4HC0
        eJ9xY++UZn5td2S7H650pdeTc8BxtufTrkJpX0Rdz81+YCuJVQMuLvA9EHcJMULL
        /X/VJprnmTg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4846A5C462;
        Sat, 31 Dec 2016 20:11:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7C795C461;
        Sat, 31 Dec 2016 20:11:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net
Subject: Re: [PATCH] pathspec: give better message for submodule related pathspec error
References: <20161229192908.32633-1-sbeller@google.com>
Date:   Sat, 31 Dec 2016 17:11:18 -0800
In-Reply-To: <20161229192908.32633-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 29 Dec 2016 11:29:08 -0800")
Message-ID: <xmqqh95j60uh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33E3FCC4-CFBF-11E6-B640-E17F7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Every once in a while someone complains to the mailing list to have
> run into this weird assertion[1].
>
> The usual response from the mailing list is link to old discussions[2],
> and acknowledging the problem stating it is known.
>
> For now just improve the user visible error message.

Thans. judging from the date: header I take this is meant as v3 that
supersedes v2 done on Wednesday.

It is not clear in the above that what this thing is.  Given that we
are de-asserting it, is the early part of the new code diagnosing an
end-user error (i.e. you gave me a pathspec but that extends into a
submodule which is a no-no)?  The "was a submodule issue" comment
added is "this is an end-user mistake, there is nothing to fix in
the code"?

I take that the new "BUG" thing tells the Git developers that no
sane codepath should throw an pathspec_item that satisfies the
condition of the if() statement for non-submodules?

> diff --git a/pathspec.c b/pathspec.c
> index 22ca74a126..b446d79615 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -313,8 +313,23 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>  	}
>  
>  	/* sanity checks, pathspec matchers assume these are sane */
> -	assert(item->nowildcard_len <= item->len &&
> -	       item->prefix         <= item->len);
> +	if (item->nowildcard_len > item->len ||
> +	    item->prefix         > item->len) {
> +		/* Historically this always was a submodule issue */
> +		for (i = 0; i < active_nr; i++) {
> +			struct cache_entry *ce = active_cache[i];
> +			int ce_len = ce_namelen(ce);
> +			int len = ce_len < item->len ? ce_len : item->len;
> +			if (!S_ISGITLINK(ce->ce_mode))
> +				continue;

Computation of ce_len and len are better done after this check, no?

> +			if (!memcmp(ce->name, item->match, len))
> +				die (_("Pathspec '%s' is in submodule '%.*s'"),
> +					item->original, ce_len, ce->name);
> +		}
> +		/* The error is a new unknown bug */
> +		die ("BUG: item->nowildcard_len > item->len || item->prefix > item->len)");
> +	}
> +
>  	return magic;
>  }
>  
> diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
> new file mode 100755
> index 0000000000..e62dbb7327
> --- /dev/null
> +++ b/t/t6134-pathspec-in-submodule.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description='test case exclude pathspec'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup a submodule' '
> +	test_commit 1 &&
> +	git submodule add ./ sub &&

Is this adding our own project as its submodule?  

It MIGHT be a handy hack when writing a test, but let's stop doing
that insanity.  No sane project does that in real life, doesn't it?

Create a subdirectory, make it a repository, have a commit there and
bind that as our own submodule.  That would be a more normal way to
start your own superproject and its submodule pair if they originate
together at the same place.

Better yet create a separate repository, have a commit there, and
then pull it in with "git submodule add && git submodule init" into
our repository.  That would be the normal way to borrow somebody
else's project as a part of your own superproject.

> +	git commit -a -m "add submodule" &&
> +	git submodule deinit --all
> +'
> +
> +cat <<EOF >expect
> +fatal: Pathspec 'sub/a' is in submodule 'sub'
> +EOF
> +
> +test_expect_success 'error message for path inside submodule' '
> +	echo a >sub/a &&
> +	test_must_fail git add sub/a 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +cat <<EOF >expect
> +fatal: Pathspec '.' is in submodule 'sub'
> +EOF
> +
> +test_expect_success 'error message for path inside submodule from within submodule' '
> +	test_must_fail git -C sub add . 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
