Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8260BC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 16:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiGTQnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGTQnl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 12:43:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CBB61D88
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 09:43:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDD8312ED47;
        Wed, 20 Jul 2022 12:43:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uzhav7hb0AqQ
        J2RppoD+kiz0WZexeo+Fo6mf2pk0JIg=; b=V0+9yTOEA2Yt3X+SufWp9oKW48fc
        ME37ZLDWLBWAJbriUf0PZwEHUR3ZcNVGbmwW50IIT5u0z5RjiTIBxIxij37h5trw
        culsoiSGjsYUiMi8xbhUw31utqqgD0khr89KpFV0qmmu+5N47CjTv3lJ2E5RZDFl
        oWknYoXYbz81Je0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B66CC12ED46;
        Wed, 20 Jul 2022 12:43:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30A5412ED45;
        Wed, 20 Jul 2022 12:43:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v2 05/24] submodule--helper: "struct pathspec" memory
 leak in module_update()
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
        <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <patch-v2-05.24-a4672aa9c94-20220719T204458Z-avarab@gmail.com>
Date:   Wed, 20 Jul 2022 09:43:37 -0700
In-Reply-To: <patch-v2-05.24-a4672aa9c94-20220719T204458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 19 Jul
 2022 22:46:56
        +0200")
Message-ID: <xmqqwnc73fba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B500B2E-084B-11ED-937E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The module_update() function calls module_list_compute() twice, which
> in turn will reset the "struct pathspec" passed to it. Let's instead
> track two of them, and clear them both.

Looks correct.  I wish there were an easy way to limit the scope of
this new pathspec2 to the block guarded by "if (opt.init)", but with
the "jump to error-exit" idiom, there unfortunately isn't.

Thanks.


>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/submodule--helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 28c5fdb8954..7466e781e97 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2602,6 +2602,7 @@ static int update_submodules(struct update_data *=
update_data)
>  static int module_update(int argc, const char **argv, const char *pref=
ix)
>  {
>  	struct pathspec pathspec =3D { 0 };
> +	struct pathspec pathspec2 =3D { 0 };
>  	struct update_data opt =3D UPDATE_DATA_INIT;
>  	struct list_objects_filter_options filter_options =3D { 0 };
>  	int ret;
> @@ -2692,7 +2693,7 @@ static int module_update(int argc, const char **a=
rgv, const char *prefix)
>  		struct init_cb info =3D INIT_CB_INIT;
> =20
>  		if (module_list_compute(argc, argv, opt.prefix,
> -					&pathspec, &list) < 0) {
> +					&pathspec2, &list) < 0) {
>  			ret =3D 1;
>  			goto cleanup;
>  		}
> @@ -2715,6 +2716,7 @@ static int module_update(int argc, const char **a=
rgv, const char *prefix)
>  cleanup:
>  	list_objects_filter_release(&filter_options);
>  	clear_pathspec(&pathspec);
> +	clear_pathspec(&pathspec2);
>  	return ret;
>  }
