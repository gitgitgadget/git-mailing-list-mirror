Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C519C1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 22:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755690AbcKVW7P (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 17:59:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55657 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755401AbcKVW7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 17:59:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BC8B52091;
        Tue, 22 Nov 2016 17:59:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KxGytOfIY/hkObQIWv3XRD5snU4=; b=NFtPcO
        b5YuHxlX875PkXNyfLZPuJDmm6iUk9FxHwrsdC6JzUE9LC96zq2wZChKEM9h/pvS
        zczToUMrIbgfeeFtFMLiA5TRQyp7tCxrwh09ii/AOegNgIbVdl1Y54I6Bk7xO3Eb
        EfVfYr8Qs6SiRU8ub2qS8OpPq0lz53tD9cyYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DLmAID0Hvc/EDH6wcUKyy2GSYrQBOaUm
        JLWY4UIQtQVnqo361MoTsB3PJBwIeDmq+7HIJ2HN6jfTvOqLBFDuGhw0iVpfFz9n
        uYqW2UkKYxRwAuS42IK1zgVGjBEAtJcuZkGpXQDrYuUkqPkkbyAgPVRJdnJV8RKk
        50lyq/lQR/c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61D5852090;
        Tue, 22 Nov 2016 17:59:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC4605208E;
        Tue, 22 Nov 2016 17:59:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 5/6] grep: enable recurse-submodules to work on <tree> objects
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
        <1479840397-68264-1-git-send-email-bmwill@google.com>
        <1479840397-68264-6-git-send-email-bmwill@google.com>
Date:   Tue, 22 Nov 2016 14:59:11 -0800
In-Reply-To: <1479840397-68264-6-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Tue, 22 Nov 2016 10:46:36 -0800")
Message-ID: <xmqqshqjnmtc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48EEF780-B107-11E6-80CD-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> diff --git a/tree-walk.c b/tree-walk.c
> index 828f435..ff77605 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -1004,6 +1004,19 @@ static enum interesting do_match(const struct name_entry *entry,
>  				 */
>  				if (ps->recursive && S_ISDIR(entry->mode))
>  					return entry_interesting;
> +
> +				/*
> +				 * When matching against submodules with
> +				 * wildcard characters, ensure that the entry
> +				 * at least matches up to the first wild
> +				 * character.  More accurate matching can then
> +				 * be performed in the submodule itself.
> +				 */
> +				if (ps->recursive && S_ISGITLINK(entry->mode) &&
> +				    !ps_strncmp(item, match + baselen,
> +						entry->path,
> +						item->nowildcard_len - baselen))
> +					return entry_interesting;
>  			}

This one (and the other hunk) feels more correct than the previous
round.  One thing to keep in mind however is that ps->recursive is
about "do we show a tree as a tree aka 040000, or do we descend into
it to show its contents?", not about "do we recurse into submodules?",
AFAICT.

So this change may have an impact on "git ls-tree -r" with pathspec;
I offhand do not know if that impact is undesirable or not.  A test
or two may be in order to illustrate what happens?  With a submodule
at "sub/module", running "git ls-tree -r HEAD -- sub/module/*" or
something like that, perhaps?
