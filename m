Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8035A1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbcLHSB6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:01:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52708 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752557AbcLHSB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:01:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DD3D53565;
        Thu,  8 Dec 2016 13:01:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IYTtNrB97agIDTaFpDAsrXRu/p0=; b=OV/Tbk
        LZoY4QSOiMNLcQm2xY+Ruq3hYdj/rRmpeeLbAo3idDGlCCCU/z1A6M0Qlcvnlz22
        3Qwq5wtXTl2uFgHq2YuJQtCYYoVsz8E6xeJUx58/Bm/H3VVhQW9uplMGof6jlut3
        e44NDYHK+ivN6RqN3jChYr4tVUhqb3PddfZAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JwFHCpbppKl9rsDfO4TOHzHuKurFVJGg
        XwQK1B3e3aAj9kRGSqibYdEzy0NbJUD5E+WOqloK2tgX3r4J/khHoCSpYEViSDSs
        AKcyuCBSbMWCeKClYBeExBflgpiqIKebCAiX+7vUqVcLmG/9JlZF6EbMQC/3++3C
        D0cFJDRrSHQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5673B53564;
        Thu,  8 Dec 2016 13:01:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9D0853561;
        Thu,  8 Dec 2016 13:01:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Tan <pyokagan@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] wt-status: implement opportunisitc index update correctly
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com>
        <20161207194105.25780-1-gitster@pobox.com>
        <20161207194105.25780-2-gitster@pobox.com>
        <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
        <CACRoPnRpZr=E6SW81Vg-2TiOr=RJo1YouAt5iZoE0CNBx-qesg@mail.gmail.com>
Date:   Thu, 08 Dec 2016 10:01:54 -0800
In-Reply-To: <CACRoPnRpZr=E6SW81Vg-2TiOr=RJo1YouAt5iZoE0CNBx-qesg@mail.gmail.com>
        (Paul Tan's message of "Thu, 8 Dec 2016 18:18:39 +0800")
Message-ID: <xmqqmvg6ti3x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67E4F6EC-BD70-11E6-BEF4-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Tan <pyokagan@gmail.com> writes:

> Hmm, to add on, looking at the three other call sites of this
> function, two of them (builtin/commit.c and builtin/describe.c)
> basically do:
>
>     if (0 <= fd)
>         update_index_if_able(...)
>
> with that 0 <= fd conditional. With this patch it becomes three out of
> four.

The other one is diff.c::refresh_index_quietly() that you are not
counting, I think, but if you look at it again, it also is not
called after hold_locked_index() fails to acquire the lock, so with
this fix everybody refrains from calling it when it does not hold
the lock.

> Perhaps the repeated use of this conditional is a sign that the
> 0 <= fd check could be built into update_index_if_able()?

That condition is "do we have the lock?  Otherwise we are not even
allowed to update it", so in that sense it may make sense.

> I think there is precedent for building in these kind of checks --
> rollback_lock_file() also does not fail if the lock file was not
> successfully opened.
>
> That said, the number of call sites is quite low so it's probably not
> worth doing this.

Yeah, I can go either way.  At least with the change things are
consistent.
