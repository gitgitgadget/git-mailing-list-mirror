Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E9AC433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D199C2067B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dZRuGp8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgFGRF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 13:05:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50036 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgFGRF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 13:05:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 748E6DE879;
        Sun,  7 Jun 2020 13:05:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rB/lY3ptm1hWoTYwcmdHviD3BW0=; b=dZRuGp
        8jrdSbbhOYZfQQHOJW4kcHWN+rpTze6NVAne5yZsop9AqfBOKtFUejhnTAJmGDem
        IRjmEhhV5Y0DgsxjsSPlXQAfVIDoSJAI40C3RzrZ+BEkI5P6zcRKyOyxX4NWtj+Q
        /kUoVvpYU5OoSwtxX+fQ9l+qCOF9agOYYHB4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rLWixWdfAolUk2fmB1SAun6B9VIsMURe
        Sngf5JG99sgDqS+sd6bU8n/Fxt8PNfbU2Gzp6ftvoJwL+1k+1EgUJkE8/3vHodSe
        BvDawiZrxTgXhKc8LY1lcwASoBE4B3Z+I/vTRcfKmFqUlBd9PL9xxLpCam8stYPe
        ToOvYPGXx5U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C15FDE878;
        Sun,  7 Jun 2020 13:05:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2FEDDE877;
        Sun,  7 Jun 2020 13:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Evans <kevans@freebsd.org>
Cc:     git@vger.kernel.org
Subject: Re: fread reading directories
References: <CACNAnaG19QD1PbVS93nFm3XY70CZCrRosmVq-_3j+puAKSPj9Q@mail.gmail.com>
Date:   Sun, 07 Jun 2020 10:05:20 -0700
In-Reply-To: <CACNAnaG19QD1PbVS93nFm3XY70CZCrRosmVq-_3j+puAKSPj9Q@mail.gmail.com>
        (Kyle Evans's message of "Sat, 6 Jun 2020 17:36:58 -0500")
Message-ID: <xmqqd06an6wf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 125E396C-A8E1-11EA-8372-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Evans <kevans@freebsd.org> writes:

> I was looking at FREAD_READS_DIRECTORIES to measure some performance
> differences, then stumbled upon [0] that dropped fread() from the
> autoconf test that causes git to use its git_fopen shim [1] even on
> Linux.

I thought we saw this mentioned recently?  I do not recall if
any concrete improvement came out of it.

The Makefile defines the macro as such:

# Define FREAD_READS_DIRECTORIES if you are on a system which succeeds
# when attempting to read from an fopen'ed directory (or even to fopen
# it at all).

So, the macro is expected to be set if a platform gives back FILE *
on a directory, whether it allows fread() on it or not.

If it is a good idea is entirely different story, though.
