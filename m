Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA00C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 04:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952FF22CAF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 04:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YvXdfjG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgHGEDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:03:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53091 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgHGEDp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 00:03:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28E32F12CA;
        Fri,  7 Aug 2020 00:03:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3k7VGhDUqPdS33ZCblLVousj8LM=; b=YvXdfj
        G2xqcSr2Q6QVjwiNJGXYJ28NZmA000k3uWh2Fx25HXTP9oOp/ghTISONxcRoANXC
        GSXVIo9s7tb+XQiNlctYc99ZFB7ip8P+3it7QBKyQfnR8TaG9ylI2ArYlbrASFXg
        Nx1phMZlgp2x6A1BcwvE4TECL3oIhkip+DxFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Il9niJXNW4Z+bh1CPfYdDae1GjocYME5
        D2g4ciXsKrKaCL+BCncyjSevGroczaUV9oLQY77jK53VTCkw7RgnKb5paL45mxBf
        9oD4SRMuci7b2S2qEhwc/XhZ+ucIHEvq0rm3NyYHiJgyKQLniTxZ+DBwqClnzQge
        ndwrZP+FekY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2207FF12C9;
        Fri,  7 Aug 2020 00:03:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68D4CF12C8;
        Fri,  7 Aug 2020 00:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: "#define precompose_argv(c,v) /* empty */" is evil
References: <xmqqy2mribft.fsf@gitster.c.googlers.com>
        <20200807000126.GC8085@camp.crustytoothpaste.net>
        <xmqqpn83i9sk.fsf@gitster.c.googlers.com>
        <20200807013230.GD8085@camp.crustytoothpaste.net>
Date:   Thu, 06 Aug 2020 21:03:37 -0700
In-Reply-To: <20200807013230.GD8085@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 7 Aug 2020 01:32:30 +0000")
Message-ID: <xmqqlfirhzl2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F99D3322-D862-11EA-9F71-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>  #ifdef NO_SETITIMER
>> -#define setitimer(which,value,ovalue)
>> +static inline int setitimer(int which, const struct itimerval *value, struct itimerval *newvalue) {
>
> The rest of the patch looks fine, but do we know that these structs will
> exist if NO_SETITIMER is defined?  If not, we may need to use a void *
> here, which would provide us worse type checking, but would work on
> platforms that lack the interval timers at all, such as NonStop.

I thought about that and also making s/FILE/void/ for flockfile()
and funlockfile() for the same reason.  Indeed my first draft used
"void *".

But because these no-op macros are designed to be used in the main
codepath WITHOUT surrounding #ifdef...#endif for readability, the
platforms that use NO_SETITIMER has to declare the variable that the
calling site of setitimer() passes as its parameters, so they must
have something called "struct itimerval".  That is why I ended up
using the real type here

For example, builtin/log.c defines

    static struct itimerval early_output_timer;

and makes an unconditional call OUTSIDE any #ifdef...#endif to
setitimer(), like so:

	early_output_timer.it_value.tv_sec = 0;
	early_output_timer.it_value.tv_usec = 500000;
	setitimer(ITIMER_REAL, &early_output_timer, NULL);

I would expect that this is the use pattern any users of these
fallback definitions in git-compat-util.h should follow; those who
do not have "struct itimerval" natively indeed are using a fallback
definition from <git-compat-util.h>.

> That does kind of defeat the purpose of this patch, but I still think
> it's a win, since we end up with some type checking, even if it's not
> perfect, and almost every platform provides setitimer, so any errors
> will be caught quickly.

Yes, even if we loosen the type to "void *", it does catch certain
errors.  One thing I wrote in the log message is that moving to
"static inline" allows us to catch not just type mismatches but also
missing variables (i.e. the original code used a variable that has
been renamed, and the instances of the variable used as parameters
to these no-op macros were left unmodified).  That's not a type
mismatch but missing identifier.  The motivating example was quite
similar; it was a field renamed but left unadjusted.

Thanks.


