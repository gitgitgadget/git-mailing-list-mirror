Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44960203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 16:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160AbcG0Qbm (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 12:31:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757118AbcG0Qbl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 12:31:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3F6A2FD6C;
	Wed, 27 Jul 2016 12:31:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u7hD8SyqOkywM2j8N4Px5aEQnx4=; b=tEql5W
	cwH98C8vhdelvz9iAA9YW135FskTdAxgKvPCKFi7W2N5HxMf97zfXWN5leIrWk4i
	IseZ5Ui95ihRmXlT4+LzN4q0h+qyF6971QWr+wJLV/QV99eTcJNH5SyIRqDsiK1U
	j1ODqZ14/ot+jdfPU3cGvUnwYF6HBm4ZI+ktw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JHwZm83EwES0G0j9kH4e/CVp5MDNJPH9
	RSgELM2NE2lCiuQCkqEKa/bxvyLdDWB19gw3Hyo94dh+w7/rH96Lm4GTN+KyoRuk
	lH6H4JDZyM2s28N4ELkrUW0Lru+QxikQ1u/j+1YuTFtzmqc8ZTSZ+5pYj7Tan21m
	UmRGf2o6Cu0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABF182FD6B;
	Wed, 27 Jul 2016 12:31:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30A022FD6A;
	Wed, 27 Jul 2016 12:31:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com, peff@peff.net
Subject: Re: [PATCH v2 3/5] pkt-line: extract and use `set_packet_header` function
References: <20160722154900.19477-1-larsxschneider@gmail.com>
	<20160727000605.49982-1-larsxschneider@gmail.com>
	<20160727000605.49982-4-larsxschneider@gmail.com>
	<xmqqinvsx77w.fsf@gitster.mtv.corp.google.com>
	<A6E129CE-26F9-456A-B9C7-A502245DD19E@gmail.com>
Date:	Wed, 27 Jul 2016 09:31:36 -0700
In-Reply-To: <A6E129CE-26F9-456A-B9C7-A502245DD19E@gmail.com> (Lars
	Schneider's message of "Wed, 27 Jul 2016 11:13:26 +0200")
Message-ID: <xmqq60rrxct3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9803A7A0-5417-11E6-AE0D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 27 Jul 2016, at 02:20, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> larsxschneider@gmail.com writes:
>> 
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> `set_packet_header` converts an integer to a 4 byte hex string. Make
>>> this function publicly available so that other parts of Git can easily
>>> generate a pkt-line.
>> 
>> I think that having to do this is a strong sign that the design of
>> this series is going in a wrong direction.
>
> Thanks for the feedback. Do you think using "pkt-line" is a move into
> the wrong direction in general or do you think only my usage of 
> "pkt-line" is not ideal?

I only meant this:

    If you try to produce packet-line data without using helper
    functions in pkt-line.[ch] that are designed to do so
    (presumably because the current set of helpers lack some
    capability you want to use), I am not enthused.

And I did not see a utility of a public set-packet-header helper
unless you are hand-rolling a function that produces packet-line
data outside pkt-line.[ch], hence the comment we are discussing here
was made before actually seeing how this new helper is used.

As to the use of packet-line as the data format, I do not have a
strong opinion either way.
