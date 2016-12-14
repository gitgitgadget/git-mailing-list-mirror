Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEFD203C1
	for <e@80x24.org>; Wed, 14 Dec 2016 07:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbcLNG75 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 01:59:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56962 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752544AbcLNG74 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 01:59:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8F3E4E0BC;
        Wed, 14 Dec 2016 01:59:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WGrj0E8f8OMlKItV5obCnToxY6w=; b=kVqgyG
        /3ifnvan/rvnmFMjBQmr4uuXLaPBNtWFnM+EVetPl51sbE2iFoJJ1w/E9d8N7tQ/
        TBJWanLWweezojtu+nqd5Je903/KqXgS4BRFeR/2Sx7Bd4eMkMsjzwbPYCv2c3xL
        e/c3si78Ppt2iPy2j/H42H1DVDfEVTyJakCQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LjADESq92Q9ByjNI2EdkI+JBZ3MHHnMI
        YB5fF92ByDYNXtuHPKq7gtBW4BA1G0ZS2Jv2TSpwregaDEQKDRxfKBfXBtg8A+Mq
        ZroBgv31TXDGoYmryzH9vxdYa4Qsu8OX10PRpg3KqNgOOieI56sHGr9joYW29EL5
        eAbZWaG3zw0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2EAD4E0BA;
        Wed, 14 Dec 2016 01:59:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B5D04E0B9;
        Wed, 14 Dec 2016 01:59:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 05/34] sequencer (rebase -i): learn about the 'verbose' mode
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <1d1f8d8b0696769bb85dd8a2269dc281aa91eede.1481642927.git.johannes.schindelin@gmx.de>
        <xmqq37hr1orb.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 13 Dec 2016 22:59:20 -0800
In-Reply-To: <xmqq37hr1orb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 13 Dec 2016 13:51:36 -0800")
Message-ID: <xmqq8trjyp13.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D759B9AA-C1CA-11E6-96A5-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> ...
>> +		if (opts->verbose) {
>> +			const char *argv[] = {
>> +				"diff-tree", "--stat", NULL, NULL
>> +			};
>> + ...
>> +			run_command_v_opt(argv, RUN_GIT_CMD);
>> +			strbuf_reset(&buf);
>> +		}
>> +		strbuf_release(&buf);
>>  	}
>
> It's a bit curious that the previous step avoided running a separate
> process and instead did "diff-tree -p" all in C, but this one does not.
>
> I think it is because this one is outside the loop?

Nah, this guess of mine "The patch file generation done in 03/34
avoids spawn because it is in a loop" is off the mark.  It is done
before "edit" gives control back to the end user and it is not like
we write one patch file per iteration of the loop we want to get
maximum speed out of.

