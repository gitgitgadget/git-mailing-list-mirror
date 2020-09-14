Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E37CC2BBD1
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1457215A4
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zo5abI2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgINUeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:34:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56493 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgINURd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:17:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53803102FF6;
        Mon, 14 Sep 2020 16:17:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=L6QMFZMGz2jU34Aj5+eyFKYujZk=; b=Zo5abI2JNN3ztBv9Vb1F
        MP00Oxsvl21JC3S71UDQacDx1wO7e3H6Ee/0sRsPb1YqbrPoh7I8ThOyKrHdZWhA
        AQJKfA9p4dse9gWMiXDg1Pw+a64rZme7HLy8z3jt+GH5JNffRUnQBtSzVwqsGXZ8
        Tphg265trkDRaQR6F/XF6QA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=LJasQOJ8r6EkL41hVaFrY3h/be1D47QTiEvPf/NdLlZKMB
        jJrPeDOLsSCq4pXlN+oc1P71hZrVroWmgQfr/eHL5wzhuHBiI96K2eYLbpmixOI1
        rbnO16Q7Bta4q2gp5HAdzsar4uuyW2Asdm/bqK41JKyK49kRdlY2b8oa7d+38=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C8A1102FF5;
        Mon, 14 Sep 2020 16:17:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88724102FF1;
        Mon, 14 Sep 2020 16:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/7] remote: add reflog check for "force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
        <20200913145413.18351-2-shrinidhi.kaushik@gmail.com>
Date:   Mon, 14 Sep 2020 13:17:26 -0700
Message-ID: <xmqqd02ojep5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FC93A16-F6C7-11EA-89BD-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Add a check to verify if the remote-tracking ref of the local branch is
> reachable from one of its "reflog" entries; `set_ref_status_for_push`
> updated to add a reject reason and disallow the forced push if the
> check fails.

I have to wonder (not objecting to, just wondering about) if it is a
good assumption that the current branch must be where we should have
seen the tip of the other side we are about to lose.  I ask because
when I do a large rewrite I often am on a detached HEAD most of the
time, and after everything looks sensible in the rewritten result,
I "checkout -B" the local branch.

We could reduce the rate of false positive ("no you've not looked at
what you are about to discard, so we won't let you force") by
checking reflogs of all the local branches and HEAD, but that may be
too much.  I wonder if checking reflog entries only for HEAD (and
not any of the current local branches) would be a good compromise.
