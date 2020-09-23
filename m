Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30FEC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 19:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3990C2145D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 19:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nhtMnLTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWTXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 15:23:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65426 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWTXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 15:23:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42D8DDF391;
        Wed, 23 Sep 2020 15:23:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qzGZj11L7W1k1JgbO74etXL6Za0=; b=nhtMnL
        TfWvm/9lO5CNZsgcRFdhy2tdnbb56tL2CyTIHiRtC+80FtGxmbecKMz9jlfW6Nus
        mQxARKtSzq6dLcrlsUhtfpfqmBVEemc0cKMApONIUaw7YkUNBSPz7g8uZylpgiVw
        desasvQ+KQwb9rrsU5ZzRXKh/Qb6JzTaicIrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mvqhk89kPwZOpfGhk/KrQn8wT1qOPMNI
        zOqI371DQKYKUaEibZ170LS9I+LQYcVcK/L+ia/hXPi+SPLAtT4X+SevDhvWT7/+
        l2JEQvTfmjudM9xjrhui/3ijkS6/54Yp2h01bfZTMJDufHOM54hTn5Myn2cBWG1Q
        IdfMC/pREvM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B5CFDF390;
        Wed, 23 Sep 2020 15:23:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8B473DF38F;
        Wed, 23 Sep 2020 15:23:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-1-tguyot@gmail.com>
        <20200918113256.8699-2-tguyot@gmail.com>
        <20200918172747.GD183026@coredump.intra.peff.net>
        <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com>
        <xmqq363fm02a.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009231709340.5061@tvgsbejvaqbjf.bet>
Date:   Wed, 23 Sep 2020 12:23:46 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009231709340.5061@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 23 Sep 2020 21:16:20 +0200
        (CEST)")
Message-ID: <xmqqk0wki9fh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E3DC6D2-FDD2-11EA-A338-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I believe that that is exactly the reason why we want this:
>
> -	same_contents = oideq(&one->oid, &two->oid);
> +	same_contents = one->oid_valid && two->oid_valid ?
> 		oideq(&one->oid, &two->oid) : !strcmp(one->data, two->data);

Not quite.  The other side should either be

	one->size == two->size && !memcmp(...)

or just left to false, as the downstream code must be prepared for
same_contents being false even when one and two turns out to be
not-byte-for-byte-same but equivalent anyway.
