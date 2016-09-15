Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFA722070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754485AbcIOUds (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:33:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62962 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751520AbcIOUdq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:33:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A6653D151;
        Thu, 15 Sep 2016 16:33:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1SMqnc/64tXaarDLLHtGCnoInOU=; b=Q1BtdW
        2YYMuK2pL+2700WZYTdA0rNpma42Fwgq9svyyLU0BCNSCFHdN+yhRtBg3+aPk+Ld
        XQ3pxk/TZlPpo+dTvfNTVIh67C/nkEm74mtwdw0N8npWlVtWh5mRkNsKKu7Z3Bql
        QFH4+ojl8VXUPZVIY174vPGjVtL3rn9fXR2To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vsbWgXPgMkssruhUO8aB4IIKsEDkbiX5
        zAeSnsHFlHcXXYlp+UNjzBrFFOU6NrBcVLf0IlcUZmBFY2zudY3UAtMwjvicVNLm
        9iyzC3I0E1nXujSsaCb1Wzj8FB2Yj3jvPLWjf25FIWb70JXIZUDyZUcIzfagmbVs
        7AJvIcrlsHM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BB4E3D150;
        Thu, 15 Sep 2016 16:33:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BE1F3D14F;
        Thu, 15 Sep 2016 16:33:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, tboegi@web.de, jacob.keller@gmail.com
Subject: Re: [PATCH v7 04/10] pkt-line: add packet_flush_gently()
References: <20160908182132.50788-1-larsxschneider@gmail.com>
        <20160908182132.50788-5-larsxschneider@gmail.com>
        <xmqqinu0y9v1.fsf@gitster.mtv.corp.google.com>
        <B138B703-08A6-45C4-9D54-80F87C75356B@gmail.com>
        <xmqq37l3v2rk.fsf@gitster.mtv.corp.google.com>
        <385016D3-8298-4273-81E7-876CB25B2789@gmail.com>
        <20160915194443.x7zvkkryvworqcxt@sigill.intra.peff.net>
        <744FA3D5-888A-4032-90C4-6BFC7D5D4010@gmail.com>
Date:   Thu, 15 Sep 2016 13:33:42 -0700
In-Reply-To: <744FA3D5-888A-4032-90C4-6BFC7D5D4010@gmail.com> (Lars
        Schneider's message of "Thu, 15 Sep 2016 22:19:19 +0200")
Message-ID: <xmqqlgysnbrt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B26DABCA-7B83-11E6-B081-92D512518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> So the "right" pattern is either:
>> 
>>  1. Return -1 and the caller is responsible for telling the user.
>> 

... which is valid only if there aren't different kinds of errors
that all return -1; with "return error(...)" with different
messages, the users can tell what kind of error they got (while the
caller may just do the same abort-procedure no matter what kind of
error it got), but if all of them are replaced with "return -1", the
caller cannot produce different error messages to tell the users.

>>  2. Return -1 and stuff the error into an error strbuf, so it can be
>>     passed up the call chain easily (and callers do not have to come up
>>     with their own wording).

... and this would become one of the viable options (the other is to
define your own error code so that the caller can tell what error it
got).

>> But if all current callers would just call error() themselves anyway,
>> then it's OK to punt on this and let somebody else handle it later if
>> they add a new caller who wants different behavior (and that is what
>> Junio was saying above, I think).

Yes.  Just keeping it noisy until somebody wants a quiet-and-gentle
version is probably the best course to take.
