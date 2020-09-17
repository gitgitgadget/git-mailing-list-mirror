Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F0CC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04417206CA
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MpGRTYMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgIQAwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:52:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56692 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQAws (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 20:52:48 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:52:46 EDT
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A297380A59;
        Wed, 16 Sep 2020 20:43:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b9DLl8swyjBoIJmtsE2lS+p8T2c=; b=MpGRTY
        MJAGc+vf6sNo6RC12hMd41EnjOvJo1avTMLM7O1gFd2b/sed5z6Bso+0tDJglaeI
        mGk6/zuIzOhd0IBs4Ab7hC9lnhRdgJJSBtqP9yw/xUJ1qcuddiIV+Ph88y7tWllG
        wda8WprmjPsAjU4AAvVowQhauz3zr6liPRZjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CczypPyXQm+ndm2B41VDKOXhrfciqjur
        Gny/8ZR+exGqEVoaWjA1QFujlrVUFU26hMvxu95TfdZIp4C5JZKtrjjG+AbM2Shd
        uSuWEJG2KIvUy839godaTCevDEfzADsZSsF6HC26zL6Z8i2PDPoLMaCJ20utjnIa
        f8qbRFNbRjw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99ADF80A58;
        Wed, 16 Sep 2020 20:43:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25E7480A57;
        Wed, 16 Sep 2020 20:43:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] format-patch: cancel useAutoBase if base is invalid
References: <20200916234916.422553-1-jacob.e.keller@intel.com>
        <xmqqr1r1tfil.fsf@gitster.c.googlers.com>
Date:   Wed, 16 Sep 2020 17:43:35 -0700
In-Reply-To: <xmqqr1r1tfil.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 16 Sep 2020 17:26:26 -0700")
Message-ID: <xmqqmu1pteq0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D20AA736-F87E-11EA-9C6E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If we are doing the usual "prime with configuration variables and
> then override from the commnad line option" thing, then you cannot
> tell these two cases apart, but I happen to think that it is better
> to fail (and not to ignore silently) consistently whether the
> "compute an appropriate base automatically" came from config or
> command line, so...

If we really need to tell these two apart, we'd invent a new
variable (we only need a single bit) to record "did we get this base
setting from the command line?" along with what we are already
doing.  You would need to use a option callback instead of a simple
OPT_STRING() to parse the "base" option, but I think it should be
straightforward.




