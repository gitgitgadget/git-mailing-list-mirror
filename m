Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FA7C2BA2B
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 05:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2482078A
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 05:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jU0VTslm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDSFfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:35:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57982 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSFfv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 01:35:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B11A2C9845;
        Sun, 19 Apr 2020 01:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lKVrZoQPZcgbHJr0SvX03Zb+T7o=; b=jU0VTs
        lmK3sP/m+Hj+RzhJKOja1lcWTP6gmZCJyRLVRLEGwYo5lrE2m6bD0Ho1QJMjPUd2
        R8TNij8I22B2WcZBDuGL2W2vC2ldmGhTqr9k0DZTLSnMbst1gOzUQF5qCq662S4D
        CugkLNnNxTKtibzx55bS5jwD6nxxvNzc/BKJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RzcU61wzQhd200f/XYPcToHoWu9DHMkT
        gPLrLt7DD9w8UU81xN6PtFos/25mZOjspfwP0komnJcWOTviVCEZLCCUdbc50MA9
        rjJ+00TYtjxWsyFN4YoUcb31OnP9jk0xR/CfEgQHSxCNhZbWsgTjBnPH+dbw9fsr
        vkS284bgvws=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAADAC9844;
        Sun, 19 Apr 2020 01:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 04197C9843;
        Sun, 19 Apr 2020 01:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Clarke <dclarke@blastwave.org>
Cc:     git@vger.kernel.org
Subject: Re: minor patch required to compile git 2.26.1 on Oracle Solaris 10 with Oracle Studio
References: <6bf94982-71c4-78e9-0f4d-7fa4e485c417@blastwave.org>
Date:   Sat, 18 Apr 2020 22:35:45 -0700
In-Reply-To: <6bf94982-71c4-78e9-0f4d-7fa4e485c417@blastwave.org> (Dennis
        Clarke's message of "Sun, 19 Apr 2020 04:52:20 +0000")
Message-ID: <xmqqzhb8rqa6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EDF8EF8-81FF-11EA-9B0E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Clarke <dclarke@blastwave.org> writes:

> Very minor patch required :

But both size_t and unsigned int are wrong types, no?  Shouldn't we
be using socklen_t (and we seem to have autoconf support to figure
out an appropriate socklen_t fallback typedef)?

> --- ./compat/inet_ntop.c.orig   Tue Apr 14 01:51:03 2020
> +++ ./compat/inet_ntop.c        Sun Apr 19 04:16:39 2020
> @@ -168,7 +168,7 @@
>   *     Paul Vixie, 1996.
>   */
>  const char *
> -inet_ntop(int af, const void *src, char *dst, size_t size)
> +inet_ntop(int af, const void *src, char *dst, unsigned int size)
>  {
>         switch (af) {
>         case AF_INET:
> --- ./git-compat-util.h.orig    Tue Apr 14 01:51:03 2020
> +++ ./git-compat-util.h Sun Apr 19 03:56:17 2020
> @@ -795,7 +795,7 @@
>  #endif
>
>  #ifdef NO_INET_NTOP
> -const char *inet_ntop(int af, const void *src, char *dst, size_t size);
> +const char *inet_ntop(int af, const void *src, char *dst, unsigned
> int size);
>  #endif
>
>  #ifdef NO_PTHREADS
> #
> # exit
>
> That allows compile to proceed beatly with :
>
> alpha$
> alpha$ cc -V
> cc: Studio 12.6 Sun C 5.15 SunOS_sparc 2017/05/30
