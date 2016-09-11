Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489FB1FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 21:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbcIKVow (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 17:44:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62180 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750912AbcIKVov (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 17:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB9A13B44E;
        Sun, 11 Sep 2016 17:44:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U+aqy+prD1PaKzk45CGLEFpT50w=; b=R73o/I
        34ql52LL1gbCsXWwptBXJKelld6BIl4/EGjx3WNfoYw78SaA0Umnat9rjvAxRkJV
        jsZQG8xNzgYCR3Jywi06Uezexhuz6KxtP2Ggj9jhHY4YHIhD14f6f+g1ez/g66IH
        nh5QFrnHV1uUN8SbJmuB56IEMatf5OXyilRYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a4egfp2sFeKOabLasEZdLSAE/ox/K7Ki
        UDgNoT1LG2cq2Q5PI6kPDSEx2vsua1c2o82CtRIqVYnx7WJvawCWXzRZjlFTlaEB
        2JLVBwHLtSMJGzh6o55aZ+3cDSlOjkn6CEikul3x+DLXjs7Pe4AV2LFRBLEeuJlD
        lN12OUYboAc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E31463B44D;
        Sun, 11 Sep 2016 17:44:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 591153B44C;
        Sun, 11 Sep 2016 17:44:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] cat-file: introduce the --filters option
References: <cover.1472041389.git.johannes.schindelin@gmx.de>
        <cover.1473415827.git.johannes.schindelin@gmx.de>
        <084088ba86c0af3636d960276c0bfdf7f5d2cfde.1473415827.git.johannes.schindelin@gmx.de>
        <xmqqfup9ds9p.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609091800020.129229@virtualbox>
        <xmqqbmzxdpjp.fsf@gitster.mtv.corp.google.com>
        <xmqqvay5c7t3.fsf@gitster.mtv.corp.google.com>
        <xmqqr38tc7d1.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609100957040.129229@virtualbox>
Date:   Sun, 11 Sep 2016 14:44:47 -0700
In-Reply-To: <alpine.DEB.2.20.1609100957040.129229@virtualbox> (Johannes
        Schindelin's message of "Sat, 10 Sep 2016 09:57:33 +0200 (CEST)")
Message-ID: <xmqqzine6rhs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6CA8E78-7868-11E6-AE6A-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In other words, instead of trying to be consistent by erroring out
>> in non-regular blob case, I think the attached change on top would
>> make more sense, by consistently passing the object contents as-is
>> for all "not filtered" cases, whether it is run from the batch mode
>> or from the command line.
>>  ...
>> +	if ((type == OBJ_BLOB) && S_ISREG(mode)) {
>>  		struct strbuf strbuf = STRBUF_INIT;
>>  		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
>>  			free(*buf);
>
> Yes, that makes most sense to me, too.

Alright; will squash it in then before merging it down to 'next'.


