Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1912027B
	for <e@80x24.org>; Wed,  1 Mar 2017 23:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbdCAXHC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:07:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64262 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752994AbdCAXHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:07:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B38F1775D8;
        Wed,  1 Mar 2017 18:05:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s5E3trCDDJgPlRJBK1wWRBQ/y6A=; b=LjDIoN
        XEPO9TIlhaZk7sJPBzmD4ywSIq2srDuUFDtoQ2IemewzTX2EmAAchSw/DzOKzQm2
        3mKoF1PV2HtU9kz7Svr2rze/Az70qA2zShuBe8IOckMiTmUWNhWMyQgGBZtsya1S
        lrr/JkhXxueBM9QVcuS1gkcqXB6EqBHuxPmMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NlvFmRmKTZ+Gch1LYBktex808On6HtMT
        TLHWtEAFuLeD2PWh1NrY+CnT9IiryyjAybahg08VUIwEFbDsa8cVVVLC49vtxISL
        qrwgrjGYukUT19OskZMmRUv64c/WCq1kMTpZSHytTDMbpNOT3sszwp42IIKNTerw
        4ka0fu8dMSc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC26A775D7;
        Wed,  1 Mar 2017 18:05:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D7DF775D6;
        Wed,  1 Mar 2017 18:05:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 5/6 v5] merge.c: delegate handling of "-" shorthand to revision.c:get_sha1
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
        <1488007487-12965-6-git-send-email-kannan.siddharth12@gmail.com>
        <xmqqpoi0eho8.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 01 Mar 2017 15:05:52 -0800
In-Reply-To: <xmqqpoi0eho8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 01 Mar 2017 14:49:43 -0800")
Message-ID: <xmqqinnsegxb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F0C7DD0-FED3-11E6-9947-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
>
>> The callchain for handling each argument contains the function
>> revision.c:get_sha1 where the shorthand for "-" ~ "@{-1}" has already been
>> implemented in a previous patch; the complete callchain leading to that
>> function is:
>>
>> 1. merge.c:collect_parents
>> 2. commit.c:get_merge_parent : this function calls revision.c:get_sha1
>>
>> This patch also adds a test for checking that the shorthand works properly
>
> This breaks "git merge".
>
>> +test_expect_success 'merge - should work' '
>> +        git checkout testing-2 &&
>> +        git merge - &&
>> +        git rev-parse HEAD HEAD^^ | sort >actual &&
>> +        git rev-parse master testing-1 | sort >expect &&
>> +        test_cmp expect actual
>
> This test is not sufficient to catch a regression I seem to be
> seeing.
>
> 	$ git checkout side
> 	$ git checkout pu
> 	$ git merge -
>
> used to say "Merge branch 'side' into pu".  With this series merged,
> I seem to be getting "Merge commit '-' into pu".

You stopped at get_sha1_1() in your 3817cebabc ("sha1_name.c: teach
get_sha1_1 "-" shorthand for "@{-1}"", 2017-02-25), instead of going
down to get_sha1_basic() and teaching it that "-" means the same
thing as "@{-1}", which would in turn require you to teach
dwim_ref() that "-" is the same thing as "@{-1}".  As dwim_ref()
does not know about "-" and does not expand it to the refname like
it expands "@{-1}", it would break and that is why 3817cebabc punts
at a bit higher in the callchain.

The breakage by this patch to "git merge" happens for the same
reason.  cmd_merge() calls collect_parents() which annotates the
commits that are merged with their textual name, which used to be
"@{-1}" without this patch but now "-" is passed as-is.  This
annotation will be given to merge_name(), and the first thing it
does is dwim_ref().  The function knows what to do with "@{-1}",
but it does not know what to do with "-", and that is why you end up
producing "Merge commit '-' into ...".

Dropping this patch from the series would make things consistent
with what was done in 3817cebabc and I think that is a sensible
place to stop.  After the dust settles, We _can_ later dig further
by teaching dwim_ref() and friends what "-" means, and when it is
done, this patch would become useful.

Thanks.





