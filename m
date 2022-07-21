Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B09C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiGUVpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUVpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:45:21 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7646B167FC
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:45:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A42411AE855;
        Thu, 21 Jul 2022 17:45:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sh/MbKbUru23
        cyu5KqF4ONVzeeVnZ2HBJhRSNueOJi0=; b=S08aEuRfFpbBdCVMrFFt8axFzh7r
        f0t7pCRE+QHdN1TFgRrjOP2d85L/1ufdE1E+rbMFwgIBq0Vc/v+AW94lU+zG34ES
        u2+MV0hXSc7w3NSp/YOU4hqtBBEYvxi9CvOl17hrDcQ9HGVZLeKOep3VSi1OG43y
        Fw1NiciVgC3UZ/Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D3051AE854;
        Thu, 21 Jul 2022 17:45:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 480901AE853;
        Thu, 21 Jul 2022 17:45:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 17/26] submodule--helper: fix obscure leak in
 module_add()
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
        <patch-v3-17.26-7811bdbf149-20220721T191249Z-avarab@gmail.com>
Date:   Thu, 21 Jul 2022 14:45:15 -0700
In-Reply-To: <patch-v3-17.26-7811bdbf149-20220721T191249Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Jul
 2022 21:13:13
        +0200")
Message-ID: <xmqqlesmdtsk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 686F1D5C-093E-11ED-9A01-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix an obscure leak in module_add()< if the "git add" command we were

"<" -> "," perhaps?  I dunno.

> piping to failed we'd fail to strbuf_release(&sb). This fixes a leak
> introduced in a6226fd772b (submodule--helper: convert the bulk of
> cmd_add() to C, 2021-08-10).
>
> In fixing it move to a "goto cleanup" pattern, and since we need to
> introduce a "ret" variable to do that let's also get rid of the
> intermediate "exit_code" variable. The initialization to "-1" in
> a6226fd772b has always been redundant, we'd only use the "exit_code"
> value after assigning the return value of pipe_command() to it.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/submodule--helper.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

The patch looks good, especially with removal of "exit_code" it is
very clear what is going on and how errors are handled.

Nicely done.
