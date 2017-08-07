Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F2C2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbdHGVNK (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:13:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59950 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751971AbdHGVNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:13:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9695EA0203;
        Mon,  7 Aug 2017 17:13:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eQgNw4KJpYKPN3SCyYWIvVhovYk=; b=kax1mK
        5DMZLZPgOSbH256FgdgZgXTaut+VoUhn0chzb4BTKaCXBIvpVTKqZo34QEKFLsKs
        kvwpYF7peNydsHXOvmEG2hD7fgy0GsMdKDvsuWucUdMzUe3Mv3Mt0kq6HYz52IIO
        EFYNF1HBePTvq7Hhxqgja5mlDISKka4FXu07Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xI8EcV5qWRrz1b1K7xGsk0dMtIDvi/Yb
        DogV4K5oiDckzQEOmXJje1+kusGcMmVXzKTkSVE3La76OsUDqcoGtmH4X71DRBL/
        8GzehqNwOVThNQH96L0hxA8voS8dhOBwbDOFoPrZafgiu7gDOFGeB1DKYIXW7pre
        vMjKSrYoljE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80F4EA0201;
        Mon,  7 Aug 2017 17:13:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F57CA01FD;
        Mon,  7 Aug 2017 17:13:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/6] clean up parsing of maybe_bool
References: <cover.1502128418.git.martin.agren@gmail.com>
        <CAGZ79kaEA7DRm4inO=XPCVvA3mJioV_yckAVEUbCo5DEwoxbUQ@mail.gmail.com>
Date:   Mon, 07 Aug 2017 14:12:58 -0700
In-Reply-To: <CAGZ79kaEA7DRm4inO=XPCVvA3mJioV_yckAVEUbCo5DEwoxbUQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 7 Aug 2017 11:44:06 -0700")
Message-ID: <xmqq1sonozdx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 316E4362-7BB5-11E7-9232-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The series looks fine to me overall, though patch 5 is overly gentle IMHO.
> We could have removed it right there as Junio is very good at resolving
> conflicts or producing dirty merges for such a situation.
> But delaying it until no other series' are in flight is fine with me, too.

If you remove the old one, it would cause compilation error due to
removal of the declaration of the old one when other series that are
in flight adds new callsites to it.  Which makes life a bit easier
for the integrators when it is trivial to convert these callsites to
use the new one.  If the way the old one and the new one are called
are vastly different, of course, leaving the compatibility layer
that no longer is used after the series will make it easier to live
with other topics in flight, on the other hand.

I am fine with either in this case, but I probably would have opted
for removal at the end of this series if I were doing this series,
because

-	git_config_maybe_bool(K,V)
+	git_parse_maybe_bool(V)

that may have to happen during evil merges would have been trivial.

Thanks.
