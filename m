Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C456DC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1C1206DB
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 15:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A/6hZ6Wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgC2Pot (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 11:44:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54968 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2Pot (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 11:44:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CD7C49B72;
        Sun, 29 Mar 2020 11:44:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4L0AIMCFJ5GxULPOI13Tp8N3uA8=; b=A/6hZ6
        Wh+nWykGhSbX6Tl8YCI3IIJx4LgTa4q6o+2Eg52lNeWtIEwIUJGdwm5d+omFV699
        uKinCpJoFiDGgktFQx3IAchEG784uIkrDf44RR6qfEZF39QB3dJqa47cZK4HZ2Ql
        jJ/nDGDoKU4chYXHfOriamxEtIDpn7k4uMwGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WR8nzSdJvImyaBaxWvrcudyJDmXdjg4X
        UIdE2cJatcomtZMRIg5G/shIq7uZylF9IJeozW01zHiJroZv8dq4SnY0DBycFAUz
        ROUwdVXVGO6cppGzT2ZS4sQbSCfNFJ3/fNYclHY27Sv+nLYhhhnlKw65uUm2XRdE
        4QuTii3Dm38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6503E49B71;
        Sun, 29 Mar 2020 11:44:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE2C149B70;
        Sun, 29 Mar 2020 11:44:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib-functions: make packetize() more efficient
References: <20200327080210.GA604725@coredump.intra.peff.net>
        <20200327080300.GA605934@coredump.intra.peff.net>
        <xmqq1rpdhaid.fsf@gitster.c.googlers.com>
        <20200328112010.GC639140@coredump.intra.peff.net>
        <xmqqh7y8c94g.fsf@gitster.c.googlers.com>
        <xmqq8sjjdfo9.fsf@gitster.c.googlers.com>
        <20200329145343.GB15400@coredump.intra.peff.net>
Date:   Sun, 29 Mar 2020 08:44:46 -0700
In-Reply-To: <20200329145343.GB15400@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 29 Mar 2020 10:53:43 -0400")
Message-ID: <xmqqzhbzb1xt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37ACAE90-71D4-11EA-A3B6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Mar 28, 2020 at 08:05:10PM -0700, Junio C Hamano wrote:
>
>> -- >8 --
>> Subject: CodingGuidelines: allow ${#posix} == strlen($posix)
>
> I'm in favor of this patch, but...
>
>> The construct has been in POSIX for the past 10+ years, and we have
>> used in t9xxx (subversion) series of the tests, so we know it is at
>> least portable across systems that subversion Perl bindings have
>> been ported to.
>
> It is even stronger than that. t9010 is run for everybody (with the
> exception of the last test, which needs svnadmin).

Ah, you're right.  Lemme make it stronger.

    The construct has been in POSIX for the past 10+ years, and we have
    used in t9xxx (subversion) series of the tests, so we know it is at
    portable across systems that people have run those tests, which is
    almost everything we'd care about.

Thanks.
