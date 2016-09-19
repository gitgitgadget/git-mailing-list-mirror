Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25DE62070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932679AbcISSSk (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:18:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55251 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932593AbcISSSj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:18:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 918EA3FAED;
        Mon, 19 Sep 2016 14:18:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ERjxBkNOxZ0rmMsoPVH6Tnboee8=; b=RkMTWN
        N2jXqAs/qk79X5yyZg+XSDOuO3Y/d4G/CiacsheoI2Za80LW7zsSXSjplexnmykm
        9hlVWEENpP+hhIhTzbnEpQs6be5SrF8Z6+ZFLqNhAEH2RTHtWR/TTGTiDNo+l5mV
        12+DnQgQSQh5qcQJ9qIeFbKlwiTe+QGunN11c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ml4Gn6coKSOntgRoAtuh2i++4o81M6QZ
        pRornho2ET984u3JvKAahsVSmnw/MaWV/1mwEkFFxVchWSwxhArOYxEoYXBMQtLC
        ZVJqzRlNd9ynUBbunbzOkVcfwhGkCeJdtpuZyImc0OJV0PXBRH98sGV7jfjYPaIq
        7zzUqucmp/4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89EDA3FAEC;
        Mon, 19 Sep 2016 14:18:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FC0D3FAEB;
        Mon, 19 Sep 2016 14:18:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
        <1474073981-96620-1-git-send-email-bmwill@google.com>
Date:   Mon, 19 Sep 2016 11:18:35 -0700
In-Reply-To: <1474073981-96620-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 16 Sep 2016 17:59:41 -0700")
Message-ID: <xmqqwpi7eosk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BA1AD7A-7E95-11E6-9074-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>  static void show_ce_entry(const char *tag, const struct cache_entry *ce)
>  {
> +	struct strbuf name = STRBUF_INIT;
>  	int len = max_prefix_len;
> +	if (submodule_prefix)
> +		strbuf_addstr(&name, submodule_prefix);
> +	strbuf_addstr(&name, ce->name);

Continuing with the previous review, which concentrated on what
happens in the superproject; let's see what happens in the recursive
invocation in a submodule.

So a recursively spawned "ls-files --submodule-prefix=sub/" finds
a path in the index PATH and forms "sub/PATH" in "name".  From here
on, where we used to match pathspec against ce->name, we would be
matching it against name->buf.

> +	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
> +	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
>  		show_gitlink(ce);

This is primarily what happens in the superproject to decide if the
submodule is worth showing.  When we are in a submodule, we can
descend into subsubmodule (if our ls-files run in the superproject
passed --recurse-submodule down) from here.

> +	} else if (match_pathspec(&pathspec, name.buf, name.len,
> +				  len, ps_matched,
> +				  S_ISDIR(ce->ce_mode) ||
> +				  S_ISGITLINK(ce->ce_mode))) {

This is interesting bit to see what happens in the recursive
invocation.  It uses the usual match_pathspec(), as we want to be
precise and correct, iow, we do not want to use DO_MATCH_SUBMODULE,
aka "it might be worth descending into submodule".

> +		if (tag && *tag && show_valid_bit &&
> +		    (ce->ce_flags & CE_VALID)) {
> +...
> +		}
> +		write_eolinfo(ce, ce->name);
> +		write_name(ce->name);

The prefixing is taken care of by write_name(), so it is correct to
use ce->name here.

> ...  
> +	strbuf_release(&name);
>  }

OK, everything I saw so far for the recursive invocation here makes
sense.

Thanks.
