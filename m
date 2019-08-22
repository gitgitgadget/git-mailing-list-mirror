Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EFAB1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 21:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404606AbfHVVBZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 17:01:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52443 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733015AbfHVVBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD81C71168;
        Thu, 22 Aug 2019 17:01:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0BVCF0IIvgPJUWl9g7mElzZ5nPg=; b=bTXY6V
        kgYWT0Zhjvqk2CZ7eRs9SWD5up/pyTyXJ/yLmulnyM1Q8AWme97U1KvGBxhinxpJ
        lZjUrStNtYY03t3tDtoqg7NXxxMBpIBkYLRm+ony4XjG5szioA5PJEFAntltQJ6i
        2aPrXxaHkoe4mevu2kRK+9EAZE8QMTWR/dKmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xtQ5YMFD3Wz/bnAd2y/A+gO7raonXhoj
        8Pn2ypToBOhFnAo66Idf2i6gMAjS/pm9vodn9ajdN9t3grIhYLtVrACW/I5+7MN3
        fzDe8WMsxkK34IYl5HBUFGq39h/kZw0rqcfsMtQdn4idJfaG9cdggwOGYe+kxc/f
        NQ2JYSuB6Wc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94A0E71166;
        Thu, 22 Aug 2019 17:01:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BA03471165;
        Thu, 22 Aug 2019 17:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] git-submodule: fix expansion of depth for cmd_update
References: <20190822203114.18805-1-jacob.e.keller@intel.com>
Date:   Thu, 22 Aug 2019 14:01:16 -0700
In-Reply-To: <20190822203114.18805-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 22 Aug 2019 13:31:14 -0700")
Message-ID: <xmqqh868oqxv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCD1E4A4-C51F-11E9-93AA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The depth variable already contains "--depth=", so expanding it with an
> additional --depth when invoking the update-clone git submodule--helper
> is incorrect.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>
> I'm *reasonably* sure this is correct, but I am not sure how to test it.
> It's possible that it expands to "--depth --depth=N" and somehow this gets
> handled properly?

I agree with your eyeballing of all the assignments to the variable,
and other references to $depth take either one of these two forms:

	git submodule--helper ... ${depth:+"$depth"} ...
	git submodule--helper ... $depth ...

As long as "git submodule ... --depth <depth> ..." gets called with
<depth> that does not have $IFS, either would work fine, but the
former is correct even when <depth> has problematic characters in it
and your patch uses that form, too).

However.

The command line parser for update_clone() stuffs --depth as a
string to suc.depth, and then the machinery ends up calling 
prepare_to_clone_next_submodule() with such an instance of suc
(struct submodule_update_clone).  Then that function just pushes the
suc->depth to an argv array used to spawn a "submodule--helper clone".

So passing "--depth --depth=23" would be "correct", sadly, in that
codepath (I am not saying other codepaths would not call the same
prepare_to_clone_next_submodule() with "--depth 23", as I didn't
check, and if there is such a codepath, it would break).  

We may need to clean the mess up X-<.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index c7f58c5756f7..4e7fc8bf3652 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -547,7 +547,7 @@ cmd_update()
>  		${update:+--update "$update"} \
>  		${reference:+"$reference"} \
>  		${dissociate:+"--dissociate"} \
> -		${depth:+--depth "$depth"} \
> +		${depth:+"$depth"} \
>  		$recommend_shallow \
>  		$jobs \
>  		-- \
