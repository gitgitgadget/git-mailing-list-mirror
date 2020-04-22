Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E345C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE602098B
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zimu+Wr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDVRs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:48:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63911 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVRs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 13:48:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8F00C0587;
        Wed, 22 Apr 2020 13:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cCaIEo6ckwGrVkJJHDal/KOvqgE=; b=Zimu+W
        r9eP7fAcdOmDAdtvIpuQqNKTAUFXj8a5bZ09akFekhbsq3rJnOdwgnD0fzSj4Gg1
        59s/PBcy6VtoF1sYLW/t0ubXNQTLtwCTLlmpnqeCTwwfXqwvwb/iLtFh/9Z9Kl1r
        D0e3XXRV2bwVybTK0LoZagSQQZtkfUgY0rIlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BUr5cHC0UIVvzBiZuI55UQfR7PCManHR
        gxC/owxebFloFVrl/bp4spvKI003L8EcCxIucytgzeT87YPdm8vHc/QhvB3t1j0N
        u9+SN5dnponqL1d14SOBxml5vTBHaEuWFIIDKs1jNXV1oCEOrF6mUddGXysIVTYU
        WywvejIi2Lw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0932C0586;
        Wed, 22 Apr 2020 13:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 10BA6C0581;
        Wed, 22 Apr 2020 13:48:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for GNU/Hurd
References: <20200422153347.40018-1-jrtc27@jrtc27.com>
        <20200422164150.GA140314@google.com>
Date:   Wed, 22 Apr 2020 10:48:20 -0700
In-Reply-To: <20200422164150.GA140314@google.com> (Jonathan Nieder's message
        of "Wed, 22 Apr 2020 09:41:50 -0700")
Message-ID: <xmqq368vjtsr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 755DBEFA-84C1-11EA-B6F5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I wonder why we set up this knob this way.  A lot of operating systems
> support fopen(..., "r") of a directory --- wouldn't it make sense for
> FREAD_READS_DIRECTORIES to be the default and for users on stricter
> platforms to be able to set FREAD_DOES_NOT_READ_DIRECTORIES if they
> want to speed Git up by taking advantage of their saner fread?

It would have been helped to hear that when we accepted cba22528
(Add compat/fopen.c which returns NULL on attempt to open directory,
2008-02-08).  Perhaps back then it was more common not to allow
fopen() on a directory?  I dunno.

Because we do not very often hear "oops, this system also needs the
READS_DIRECTORIES knob set" these days, I consider it a fair game to
toggle the polarity of it, once the Hurd patch that started this
thread lands, as the vicinity of the code would become quiescent
again.
