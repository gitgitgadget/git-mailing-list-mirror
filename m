Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AED1C2BB1D
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D87320674
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 18:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fGWcsZsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCMSS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:18:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52936 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgCMSS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 14:18:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D47F44E20;
        Fri, 13 Mar 2020 14:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Fo/s3u097Dyt1MliVanauerFlI=; b=fGWcsZ
        sJnggqaX4k96tBsP3EJ2mzs4Gsw3GeJVFfdbh3R7ndcsj6L+kPE/MHLXZ5mbTN5Y
        e/GTHH0bJ8KiQDGqK/wkNfS0Pd0PccrP1/1oAAUpiXOjerihJmC6pytROsN/kbS6
        noE69RnEjpcvqTLFqgpq1uyA+YkHfTxTsSWso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B14irXloVc0Cxw3eP5EV/leAEkYGcwxw
        Svg6DucRTgdFtpSwmLzGnlqR5B4TWWJTXnLz4EvUS2Og6rh5ofjDXqHwK7ZeI7dp
        uGdxP+us+cDz6BocgTJsaFFAzpHyGl1JFiZhjmrbF+F+HNKdMTQGJ8WgOz8CFv0B
        7em9n+4u7gE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53EDE44E1F;
        Fri, 13 Mar 2020 14:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D686044E1D;
        Fri, 13 Mar 2020 14:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, erlend-a@innova.no,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] Make rev-parse -q and --is-* quiet
References: <CAHk66ftWBYF3d_L0-__BP5mKNxBioj57y44yhyqGrtK3TZTjSg@mail.gmail.com>
        <20200313174755.GA549554@coredump.intra.peff.net>
Date:   Fri, 13 Mar 2020 11:18:26 -0700
In-Reply-To: <20200313174755.GA549554@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 13 Mar 2020 13:47:55 -0400")
Message-ID: <xmqqa74kce4t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0898053E-6557-11EA-B187-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure if returning a single is_set makes sense, though. It
> effectively becomes an OR, and you wouldn't know which flag triggered
> it. It would make more sense to me for the invocation above to simply be
> an error, reminding the caller that they need to handle it more
> carefully.
>
> We _could_ encode each value into the exit code (e.g., set bit 1 if the
> first condition was true, and so on). But checking that becomes as much
> hassle as reading stdout, so there's little value.

None of the above excites me.  I do not think it makes much sense to
combine -q with --is-* for the reasons you stated already (i.e. the
caller cannot tell between "failure" and "false") in the first
place, but if we must do this:

 - reserve 0 (true) and 1 (false) for successful exit and use 2 (or
   above) for other failures;

 - when --quiet is in use, make --is-* mutually exclusive and die
   when more than one of them is given.  I think any of the --is-*,
   when used with --quiet, should also be an error if there are revs
   on the command line (e.g. "git rev-parse --is-inside-git-dir
   HEAD" is OK, but not with "--quiet").

is the minimum that makes me feel that we have semi-reasonable
behaviour that can be explained to end users.
