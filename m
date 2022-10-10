Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A451CC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJJSLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJJSLM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:11:12 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8985F5F
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:11:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0E39142D7D;
        Mon, 10 Oct 2022 14:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bl3aYvmTmnQkz0wzKORE8eV+4kgaXwf6rTRxD6
        wB7bk=; b=usZ0NiZuK8GwjQH3RNoEWXE91/2D1oyA54M7Rfh6/cs7ASgwi+ltix
        s+3XmjKgd9bzs5R0ZjDEfE1/0WWPs6OPdwdo8f8DAsCFINGuYs6ayJcYhheLToG3
        nBxZzdOo9E81TEnqDSBFEHMp+KOWPClFFAfiUbD/qi2dlZlci2Abk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7797142D7C;
        Mon, 10 Oct 2022 14:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F181142D7B;
        Mon, 10 Oct 2022 14:11:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, orygaw@protonmail.com, rsbecker@nexbridge.com
Subject: Re: [PATCH 2/2] grep.c: tolerate NULL grep_expr in free_pattern_expr()
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
        <cover.1665423686.git.me@ttaylorr.com>
        <7e094882c2a71894416089f894557a9eae07e8f8.1665423686.git.me@ttaylorr.com>
        <xmqqy1tn36pc.fsf@gitster.g>
Date:   Mon, 10 Oct 2022 11:11:05 -0700
In-Reply-To: <xmqqy1tn36pc.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        10 Oct 2022 10:54:23 -0700")
Message-ID: <xmqqsfjv35xi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA283BF4-48C6-11ED-AD11-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  static void free_pattern_expr(struct grep_expr *x)
>>  {
>> +	if (!x)
>> +		return;
>> +
>>  	switch (x->node) {
>>  	case GREP_NODE_TRUE:
>>  	case GREP_NODE_ATOM:
>
> This hunk makes sense, but
>
>> @@ -790,8 +793,6 @@ void free_grep_patterns(struct grep_opt *opt)
>>  		free(p);
>>  	}
>>  
>> -	if (!opt->extended)
>> -		return;
>>  	free_pattern_expr(opt->pattern_expression);
>>  }
>
> I do not know about this one.  We used to avoid freeing, even when
> the .pattern_expression member is set, as long as the .extended bit
> is not set.  Now we unconditionally try to free it even when the bit
> says it does not want to.  Why?

Ah, grep.c::compile_grep_patterns() has the answer.  We only
populate the .pattern_expression member when we are doing a complex
query and leave it empty otherwise.  The .pattern_list member is
used instead as a list of OR'ed patterns in grep.c::match_line()
when .extended is not set.

The !opt->extended guard assumes that opt->pattern_expression exists
only when extended is set, which is correct, but forgets that even
when extended is set, pattern_expression is not necessarily non-NULL.

So I think the right thing to do may be to allow free_pattern_expr()
to take and ignore NULL silently?  Ah, that is already what you are
doing in the first hunk.  Is this second hunk even necessary?

I wonder how calls to grep.c::match_line() with opt->extended true
and opt->pattern_expression NULL, though.  It should die() at the
beginning of match_expr_eval(), which probably is OK, but somehow
feels unsatisfactory.
