Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1BE1F97E
	for <e@80x24.org>; Tue, 30 Jul 2019 20:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfG3UEx (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 16:04:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53983 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3UEx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:04:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EAE6A16601D;
        Tue, 30 Jul 2019 16:04:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SnYafPvYKhBl2BIaAO1jiOXo7s4=; b=EA1Dnu
        goP88lTZNm1cUbtxcgA7ggdBFxotXBhXy0WyimFZQ+j7fDvMxUQDXXoTHi82vzVG
        TMt+OQwsSyt2vkq59/txpp2uslfMm/PaqtiWtTT5tRqigRBrLNomr67GQ/tzNtws
        JxE8kSqYh/NbPCKG00j1i/zWlAWsAywg87psc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X9si1Mw8PRKngEy46IqYPPsSAf2ydq2Y
        cwjujehArsWPwbzYtxoJjI6iKbwhuaDfjnZTMQ2fMVlBI2MiLhfKPnSHkt+ulXpB
        5S13M8QG3UbXyHuyzGb/8CDCI9hjTsHkTxUd4EPXAbwv2is8+ovp3+pW+QnNwV01
        xZUTe45+E/4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E131716601C;
        Tue, 30 Jul 2019 16:04:50 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E31416601B;
        Tue, 30 Jul 2019 16:04:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, jackdanielz@eyomi.org,
        Antonio Ospite <ao2@ao2.it>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [GSoC][PATCH] grep: fix worktree case in submodules
References: <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
        <ba3d8a953a2cc5b4ff03fefa434ffd7bd6a78f15.1564505605.git.matheus.bernardino@usp.br>
Date:   Tue, 30 Jul 2019 13:04:49 -0700
In-Reply-To: <ba3d8a953a2cc5b4ff03fefa434ffd7bd6a78f15.1564505605.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Tue, 30 Jul 2019 13:53:27 -0300")
Message-ID: <xmqqtvb3s2zi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49A688F2-B305-11E9-B14F-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> @@ -475,7 +475,7 @@ static int grep_submodule(struct grep_opt *opt,
>  		strbuf_release(&base);
>  		free(data);
>  	} else {
> -		hit = grep_cache(&subopt, pathspec, 1);
> +		hit = grep_cache(&subopt, pathspec, cached);
>  	}

Interesting.  It appears to me that this has always searched in
submodule index and never working tree.  I am not sure if there was
any specific reason to avoid looking into the working tree files.

Passing the 'cached' bit down from grep_cache() does look like a
sensible way to go.

> @@ -523,7 +523,8 @@ static int grep_cache(struct grep_opt *opt,
>  			}
>  		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
>  			   submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
> -			hit |= grep_submodule(opt, pathspec, NULL, ce->name, ce->name);
> +			hit |= grep_submodule(opt, pathspec, NULL, ce->name,
> +					      ce->name, cached);
>  		} else {
>  			continue;
>  		}
> @@ -598,7 +599,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>  			free(data);
>  		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
>  			hit |= grep_submodule(opt, pathspec, &entry.oid,
> -					      base->buf, base->buf + tn_len);
> +					      base->buf, base->buf + tn_len,
> +					      1); /* ignored */

The trailing comment is misleading.  In the context of reviewing
this patch, we can probably tell it applies only to that "1", but
if you read only the postimage, the "ignored" comment looks as if
the call itself is somehow ignored by somebody unspecified.  It is
not clear at all that it is only about the final parameter.

If you must...

		hit |= grep_submodule(opt, pathspec, &entry.oid,
				      base->buf, base->buf + tn_len,
				      1 /* ignored */);

... is a reasonable way to write it.

> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> index a11366b4ce..946f91fa57 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -408,4 +408,25 @@ test_expect_success 'grep --recurse-submodules with submodules without .gitmodul
>  	test_cmp expect actual
>  '
>  
> +reset_and_clean () {
> +	git reset --hard &&
> +	git clean -fd &&
> +	git submodule foreach --recursive 'git reset --hard' &&
> +	git submodule foreach --recursive 'git clean -fd'

Do we need two separate foreach, instread of a single one that does
both reset and clean (i.e. "git reset --hard && git clean -f -d")?

