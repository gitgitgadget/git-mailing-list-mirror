Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9BFC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D232464E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VOiZvZ1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgBRRoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:44:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54887 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRRox (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 12:44:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5F31BC726;
        Tue, 18 Feb 2020 12:44:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tlzbztf4XgH7I1YN/0rAi1ke7/g=; b=VOiZvZ
        1aNsubrooKQFuztW2rFw4B/R+NUL6Kovk5BbCjxpYSmBV4C+D0pl1jnEmEQPKgUt
        GvNEAHQjLHogRnZYc7Z6g2/lBxNcKexWEOEx7q4Z5eIJ6gf+J5vdizCbdI0kFCci
        HDpKUSJm8ORtA+k9XOebzWHQHYS3WaP6sm6Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lLp9rB61QtxkYnSmuRs1KvPxqOwC6vRP
        YK0mzVEcll1btJWa/+hRGe4Rjw32DuO5x/aSROxDePiwkoCe+a6Fpnr6pXP2fdvt
        +inzP3g6q11pRZrjzvYECYzuNoOAqYU7mxn7k1Y416TxyajHgoQ8jlcpU1u75i66
        8luHN4NAwW8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE70CBC725;
        Tue, 18 Feb 2020 12:44:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E9404BC724;
        Tue, 18 Feb 2020 12:44:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 2/2] send-pack: downgrade push options error to warning
References: <20200217144432.43920-1-sir@cmpwn.com>
        <20200217144432.43920-2-sir@cmpwn.com>
        <20200218054009.GD1641086@coredump.intra.peff.net>
Date:   Tue, 18 Feb 2020 09:44:46 -0800
In-Reply-To: <20200218054009.GD1641086@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 18 Feb 2020 00:40:09 -0500")
Message-ID: <xmqqmu9fkcxd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BE6EED8-5276-11EA-9A68-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This makes me a little nervous, because we don't know what those push
> options were supposed to do.

Thanks for stopping this early.  As you said, this die() is very
much deliberate way for us to make sure that we do not damage an
receiving end that is not prepared.
          
> So perhaps it would make sense to do one or both of:
>
>  - allow remote.*.pushOptions for specific remotes
>
>  - add a push.pushOptionIfAble key which behaves similarly to
>    push.pushOption, but is quietly ignored if options aren't supported.
>    Then you could put options there that you know are safe to be
>    ignored.

Sensible suggestions.
