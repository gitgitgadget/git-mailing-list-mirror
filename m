Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20338C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A443E2080A
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q2FrVayI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgIJVAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:00:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51899 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbgIJOqu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 10:46:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6DAC74A35;
        Thu, 10 Sep 2020 10:46:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=K8rsTQxuC0pCJ0XD6asUWuuKgTg=; b=Q2FrVayIno9eCfc4jKWI
        X94HlmOMg9i4CreJYiYxtDMNfYgXQn3HJ3bG7JVEfe32U6xHPvXDpto0hf0afRbz
        myjh9S34zlh+F4CDCiZBEQzBr3FOFE/wqSPXe1A2F/xXpRWWZu/qMRZblBWWtcDk
        CMbmNJxSDr8jpHu7ftUK+QA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=A9Rs4f9yNrRovVx8HxiKvjsEp26Pu88PgSw19VALFlDBR7
        ykaGCebMim3NqjFqnr+gs3B0xwD/wr7HWcTS8AJwxqhXv3OI3Urk7TnW/MbhkHf/
        xsX01QM6ENYfiBO9ba9id1fry7xmO41FigYEZKtrum7pfczZA+ldrHe+kpDP8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBF8274A34;
        Thu, 10 Sep 2020 10:46:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 597A774A33;
        Thu, 10 Sep 2020 10:46:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
        <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
Date:   Thu, 10 Sep 2020 07:46:43 -0700
Message-ID: <xmqqsgbpr8oc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7212D48E-F374-11EA-BEB5-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In contrast, when you want to make sure that you _actually_ incorporated
>> the revision that is currently the remote tip, e.g. via `git pull
>> --rebase` with a possible additional rebase on top that makes this _not_ a
>> fast-forward, you totally have to force the push, otherwise it won't work.
>
> Maybe `--force-if-incorporated`? Originally, I had in mind to call it
> `--safe-force`, but that might be too vague.

Yup.  "safe force" indeed feels like a misnomer.  The assumption of
safety relies heavily on the workflow.

I might even say --force-if-merged even if the way the to-be-lost
changes have become part of what you are pushing out is not
technically a merge, but there may be shorter and sweeter way to
express it than 'merge' and 'incorporate'.
