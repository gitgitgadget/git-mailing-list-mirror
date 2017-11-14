Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD9A201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 05:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdKNFOI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 00:14:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53161 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750714AbdKNFOI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 00:14:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A09A8ADA62;
        Tue, 14 Nov 2017 00:14:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jvZzgGyZRSMITvjFeAJHsfg+kZA=; b=hCkjlt
        O632Y58XkqFz8K6yeCwMk747umAJVIWxkvJEgnCZG2CAQNLLkPjMZUzbihc+9y92
        DJPrSDYQYAXTQriUMSFpG37Wm41KAys2rWzWDNyAj0yI5GmLcF0vHhDRjeyFaWZX
        tlChO8s+a1xLxe6xxTtvz6tAIJWqkJvXCdvXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pILdulLp2uFjDZykharaluHLiW0AQual
        vNe59AYYl5Fiqh0owHJqS4Kphss/6k4/64je4n6/jQswYAojPFo7/b4NqldiJUVJ
        Y7KO1b0K52pPWZ5XBjscU+QGtcKtV2OtrJ5RklgnOwWZaCwK/dI4TVnhhKrFPmF/
        sTK6WOxD2+g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98E9DADA61;
        Tue, 14 Nov 2017 00:14:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A5E4ADA5E;
        Tue, 14 Nov 2017 00:14:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 16/30] merge-recursive: Introduce new functions to handle rename logic
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-17-newren@gmail.com>
        <xmqqd14l5ugx.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 14 Nov 2017 14:14:05 +0900
In-Reply-To: <xmqqd14l5ugx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 14 Nov 2017 13:56:30 +0900")
Message-ID: <xmqqy3n94f36.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3A8A624-C8FA-11E7-8135-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> +struct rename_info {
>> +	struct string_list *head_renames;
>> +	struct string_list *merge_renames;
>> +};
>
> This type is added in order to allow the caller and the helper to
> communicate the findings in a single logical structure, instead of
> having to pass them as separate parameters, etc.  If we anticipate
> that the information that needs to be passed will grow richer in
> later steps (or a follow-up series), such encapsulation makes a lot

Hmph, I actually am quite confused with the existing code.

The caller (originally in merge_trees(), now in handle_renames())
calls get_renames() twice and have the list of renamed paths in
these two string lists.  get_renames() mostly works with the
elements in the "entries" list and adds the "struct rename" to the
string list that is to be returned.  And the caller uses these two
string lists get_renames() returns when calling process_renames(),
but once process_renames() is done with them, these two string lists
are never looked at by anybody.

So do we really need to pass this structure around in the first
place?  I am wondering if we can do the cleanup_rename() on both of
these lists after handle_renames() calls process_renames() before
returning, which will eliminate the need for this structure and a
separate cleanup_renames() helper that clears the structure and the
two string lists in it.

