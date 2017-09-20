Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8632047F
	for <e@80x24.org>; Wed, 20 Sep 2017 04:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751011AbdITEUd (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 00:20:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52640 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750785AbdITEUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 00:20:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 404889595A;
        Wed, 20 Sep 2017 00:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K0ecbsTsozgMp4z4X/tVRAt2Ea4=; b=lEYhJ6
        fjsf+AKLNYluO0Kf0V4Lruwg4nGwK1VnhAIkPLVaHAmezXdT0zrfQultWcwmfeIe
        E1uqpMzfNIfOj4zOEahTvFx+Rixk/d8yrmdYuNjkZohc3MtNTxNIn5ChL+qQMS3f
        Wkey2F7hnLP9ke72ju5ofHMChtHkiJJye9Ue8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lziO7XX10obOfiqapiRNqAQVVVqdAm9Q
        hmHAyB1WBmp0AaXK1sGLfoIWiWb9etlJLYvh5qDRq7aqGrF5HLRtzt/YTrlniBkV
        qMW+jzyd7/qBotyZ3XFz1FI9BwYQLBTy7iec59rkIVqidN6h5OaqFTkoXj1z6Xf5
        xYhhrFb02N0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3971395959;
        Wed, 20 Sep 2017 00:20:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4B0795958;
        Wed, 20 Sep 2017 00:20:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] branch: cleanup branch name validation
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
        <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
        <20170919071525.9404-4-kaarticsivaraam91196@gmail.com>
Date:   Wed, 20 Sep 2017 13:20:30 +0900
In-Reply-To: <20170919071525.9404-4-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 19 Sep 2017 12:45:23 +0530")
Message-ID: <xmqqzi9qngq9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A649D0C-9DBB-11E7-9DF4-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> -int validate_new_branchname(const char *name, struct strbuf *ref,
> -			    int force, int attr_only)
> +int validate_branch_update(const char *name, struct strbuf *ref,
> +			   int could_exist, int clobber_head)

"update" to me means something already exists and the caller is
asking this function if it is OK to update it, but is that what this
function is used for?  I do not find the original name too bad, but
if I were renaming it, I'd call it ok_to_create_branch(), with the
understanding that forcing a recreation of an existing branch falls
into the wider definition of "create".

Also I'd avoid "could", which can be taken as an optimization hint
(i.e. "you usually do not have to worry about this thing to already
exist, but I am telling you that for this one call that is not the
case and you need to be a bit more careful by spending extra cycles
to see if it is and deal with the situation accordingly if it indeed
is"), and use "ok" as part of the name for the parameter (or flip
the meaning of it and say "create_only" or something).
