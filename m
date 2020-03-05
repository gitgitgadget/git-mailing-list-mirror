Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3AC3F2D2
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 18:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648AB2072D
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 18:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iH7aawKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgCESoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:44:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64613 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgCESoM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 13:44:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55A4952D7D;
        Thu,  5 Mar 2020 13:44:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yIZEPK8+NDXK
        m/kmTejFcfZxSwY=; b=iH7aawKr26gFqs0Xo/9R7UOhW5GjiX7lOIexbR1Lcg4h
        97xk9vouZHbzpgaUVOmHwsL6ITejxkdlhlruZBue8e0/SedbDhOSslY+L2v9SBTI
        4h92sU+U2BmPgmPmxfZxSXMPaoLEgil0nlgMrc9mw6EIICZ7bte4g/VsHGPOfCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EktDpo
        BuNZYOhnOIs4R5OvaUm2Pr51DQt9WFvtzLvcG7RX7hhS0pL9/xIMHi+QfscSHIjs
        A9mGIjyYuyTu330JqdzkZsf/X2YULlfTzUZzROIWXmQt/4GdHH/iDuvnW2I4EP7X
        D9q203L6+3NBhqpcFif6ATCc/A+liYky7MKLs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B11152D7C;
        Thu,  5 Mar 2020 13:44:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C6F252D7B;
        Thu,  5 Mar 2020 13:44:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 0/2] gpg-interface: prefer check_signature() for GPG verification
References: <20191127174821.5830-1-hji@dyntopia.com>
        <20200304114804.19108-1-hji@dyntopia.com>
Date:   Thu, 05 Mar 2020 10:44:05 -0800
In-Reply-To: <20200304114804.19108-1-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Wed, 4 Mar 2020 11:48:02 +0000")
Message-ID: <xmqqftem4p6y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B04BD6E-5F11-11EA-B4BC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> This patch refactors the use of verify_signed_buffer() for GPG
> verification to use check_signature() instead.
>
> Previously, both check_signature() and verify_signed_buffer() were used
> to verify signatures in various parts of Git.  However,
> verify_signed_buffer() does not parse the GPG status message.  Instead,
> it relies entirely on the exit code from GPG coupled with the existence
> of a GOODSIG string in the output buffer.  Unfortunately, the mere
> prescience of GOODSIG does not necessarily imply a valid signature, as
> shown by Micha=C5=82 G=C3=B3rny [1].
>
> verify_signed_buffer() should be reserved for internal use by
> check_signature() since check_signature() parses and verifies the statu=
s
> message.  This is accomplished in this patch.
>
> Changes since v0:
> * Added regression tests for log-tree and fmt-merge-msg.
> * Fixed a bug in log-tree.c that caused "No signature" to be shown
>   erroneously.
> * Fixed a similar bug in fmt-merge-msg.c.
> * Always invoke signature_check_clear() after check_signature().  The
>   check function may touch the signature_check structure on failure.

Thanks.  Will queue.  Let's cook it slower and aim for the next
cycle.

> [1] https://dev.gentoo.org/~mgorny/articles/attack-on-git-signature-ver=
ification.html
>
> Hans Jerry Illikainen (2):
>   t: increase test coverage of signature verification output
>   gpg-interface: prefer check_signature() for GPG verification
>
>  builtin/fmt-merge-msg.c  |  11 ++--
>  gpg-interface.c          |  97 +++++++++++++++++------------------
>  gpg-interface.h          |   9 ----
>  log-tree.c               |  34 ++++++-------
>  t/t4202-log.sh           | 106 +++++++++++++++++++++++++++++++++++++++
>  t/t6200-fmt-merge-msg.sh |  23 +++++++++
>  6 files changed, 202 insertions(+), 78 deletions(-)
