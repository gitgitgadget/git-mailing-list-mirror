Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10FBC43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 23:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B2A206D5
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 23:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gc4bU1B9";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="uY63F/RZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLHXAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 18:00:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64369 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfLHXAC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 18:00:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE004953F5;
        Sun,  8 Dec 2019 18:00:00 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=SKYRIHdl4i9cBrJAbObtkkcUm+4=; b=Gc4bU1
        B90fn1WbIUUHaJdKuEdB/SDKZLP3X9Epy7cDOdUHuH7doXmCov4ZqH3KlaDEoS94
        Dt/7bQN+bUT9lsNCshWON9cdP6VWnxg4oDcRFmfTHREjgEiDUQ4UEXiUV6e1V/p7
        dcI0O0/ejyf3eKhP7s6/Fobj6EgOFPJ0RN7xI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5F66953F4;
        Sun,  8 Dec 2019 18:00:00 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=S+SS4IrzAp/ijVYx8NQCKB3N56fxtN2vMZnLPeeYT6Q=; b=uY63F/RZh+IwJUcnbGo+f6RvWQkkSdlX69qF6ibx/WwQc/XmTrtJ4Z+DzeyjMzwgzj4SN1fKPHtLm/QLpUobnC4iO9Ry+xxcBWWqn6cuUHFxmO7AjaGQHfAz9Ax57k62PJOPLHmp1MHdUqpwRUq4dV8nd7UCtqr8BQL24jyvnvY=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02571953EA;
        Sun,  8 Dec 2019 17:59:58 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG?] ls-files -o now traverses nested repo when given multiple pathspecs
In-Reply-To: <CABPp-BGpfATCdiat0A6OHx3aG22BzOcC37HG8wBMRrrbLG_Mfw@mail.gmail.com>
References: <874kyf6en3.fsf@kyleam.com> <871rtfv0wn.fsf@kyleam.com> <CABPp-BEvr+wB_yqOAG9oOaONtckYzn-zghyAtx2fWJweg55ovA@mail.gmail.com> <CABPp-BGpfATCdiat0A6OHx3aG22BzOcC37HG8wBMRrrbLG_Mfw@mail.gmail.com>
Date:   Sun, 08 Dec 2019 17:59:56 -0500
Message-ID: <87v9qqtocz.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74D5BAFA-1A0E-11EA-ADC3-8D86F504CC47-24757444!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> If you want to take an early look, I've got some patches up at
> https://github.com/git/git/pull/676.  I plan to write a proper cover
> letter and submit to the list on Monday.

I can confirm that your patches resolve the cases reported here.  Thank
you for working on this!
