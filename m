Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC6C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 23:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiDOXgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiDOXgg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 19:36:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CC87CB3A
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:34:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7DCF10D8C3;
        Fri, 15 Apr 2022 19:34:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k5aDNu8zLRuo
        Y7vRjCq94sBib11h8QYCpQNrh86BVaM=; b=rIosRQgswjUbOwZCCmegnbW/3pBD
        IyipzWlr8KNC9D1sCoO4cPyHQ8e9/IY+6e0VAKgrCLjDRs85veHcveKjoiC/JvIy
        y61nwYdkS/Ge8CXF4n8n9BRgbCHTHpqOngfcVmzwiEBhd343OpOnWJyoGjcxy+Zh
        6gtHRaToghZHMao=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0B2D10D8C2;
        Fri, 15 Apr 2022 19:34:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFDB010D8C0;
        Fri, 15 Apr 2022 19:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@talktalk.net, avarab@gmail.com
Subject: Re: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12
 warning in http.c
References: <20220415123922.30926-1-carenas@gmail.com>
        <20220415231342.35980-1-carenas@gmail.com>
        <20220415231342.35980-3-carenas@gmail.com>
Date:   Fri, 15 Apr 2022 16:34:03 -0700
In-Reply-To: <20220415231342.35980-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 15 Apr 2022 16:13:42 -0700")
Message-ID: <xmqqh76taplg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89C490B6-BD14-11EC-9E0F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> This provides a "no code change needed" option to the "fix" currently
> queued as part of ab/http-gcc-12-workaround and therefore should be
> reverted once that gets merged.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  config.mak.dev | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index 335efd46203..c3104f400b2 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -68,6 +68,7 @@ endif
>  # https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
>  ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
>  DEVELOPER_CFLAGS +=3D -Wno-error=3Dstringop-overread
> +DEVELOPER_CFLAGS +=3D -Wno-error=3Ddangling-pointer
>  endif
> =20
>  GIT_TEST_PERL_FATAL_WARNINGS =3D YesPlease

Hmph, this might be an acceptable workaround to squelch the compiler
that complains "you stored an onstack pointer in a structure and
then you are leaving the scope".  We should do something more like
the attached patch, with or without the gcc warning, I think.  We
may have smuggled the pointer to finished in slot->finished pointer
that survives the current stackframe out of the function in the
original code, so that is what we rectify by clearing the member
when it has the value we stored.


 http.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git c/http.c w/http.c
index 229da4d148..85437b1980 100644
--- c/http.c
+++ w/http.c
@@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *sl=
ot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+
+	if (slot->finished =3D=3D &finished)
+		slot->finished =3D NULL;
 }
=20
 static void release_active_slot(struct active_request_slot *slot)
