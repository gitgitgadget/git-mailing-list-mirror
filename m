Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A95D20954
	for <e@80x24.org>; Thu, 23 Nov 2017 02:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbdKWCQp (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 21:16:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50093 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751860AbdKWCQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 21:16:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CE54A0191;
        Wed, 22 Nov 2017 21:16:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WwOagFHMYZZHOY9sUElNFiUKibA=; b=x6VDIx
        mcmhZnsbgVd1DU4X9SM5agLXwR1flxBEb/+J1fFhc9SlxmDeJ2S20DAk+g8RNPDj
        xLD7e18HxDrteKxwnF4DoNW1sjxBhKQlG9NGLtcUXsw7Gmu5xBHjG3pAFNtmFycz
        Nxqi/KY36K2QcDpHquzb4sdKujSZvQkL0hPLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SaCOLbfiYPs0c2PH016CMtOEcmT8DjX0
        ekg/k/AHLhJccpjr6JTNrwjZd2ugSe0Ix+9HaQbvl4PigdIZFd6zGDhu59VAcZg9
        kg63aU1+LjaEWQ8tP/Mq33NEMh55McwXeajNy6KVCd8PLo816sBiT8dEL39xyRC9
        kvbA8bWkSJY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64EE0A0190;
        Wed, 22 Nov 2017 21:16:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC275A018F;
        Wed, 22 Nov 2017 21:16:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] xdiff/xpatience: support anchoring line(s)
References: <20171121221717.155301-1-jonathantanmy@google.com>
        <20171122234152.72901-1-jonathantanmy@google.com>
        <xmqqa7zdsqb6.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 23 Nov 2017 11:16:42 +0900
In-Reply-To: <xmqqa7zdsqb6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 23 Nov 2017 11:05:01 +0900")
Message-ID: <xmqq3755sprp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 598839E6-CFF4-11E7-A19F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> One thing that might help is to warn if --anchor is used without
>> --patience, but I couldn't find a good place to put that warning. Let me
>> know if you know of a good place.
>
> How about dropping --anchor option and do it as "--patience=<pattern>"?

Well, that may not be an optimal suggestion, as it is always a pain
to have to deal with an option with optional argument.

I understand that the case you would really want to warn against is

    git diff --histogram --anchor=foo

and not

    git diff --anchor=foo

as it is sensible to turn --patience on implicitly.  Perhaps a good
starting point might be to rename the option to include "patience"
somewhere in its name ("--patience-anchor=<pattern>"?) to make it
more obvious that it is about helping the patience algorithm.  And
then make "--patience-anchor=<pattern>" without any other algorithm
selection option to behave as if "--patience" was also given.

What do we do when

    git diff --histogram --patience

is given?  Do we warn?  If we don't, perhaps it may not be too bad
if 

    git diff --histogram --patience-anchor=foo
    git diff --patience-anchor=foo --histogram

did not get any warning.  Instead we just implicitly turn any
occurence of --patience-anchor=foo into --patience followed by the
same option, and assume that the user wanted the usual "last one
wins" semantics.  It would turn patience on for the former, and
ignore the anchor for the latter and use historgram.

