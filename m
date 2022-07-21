Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D8AC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiGUVhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiGUVhM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:37:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9F19362F
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:37:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 337FE1AB723;
        Thu, 21 Jul 2022 17:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7A+dpj9PhXqb
        p5Jq7ivtmH+NGBPT7pPyuqje27NiFd8=; b=pLRypDLUrW2eZT/qnzcYRFrw5JAu
        aF9L6kUIq5aAI0P/RmXHtl5rghTsmoL1HpOnugSZY0stgc7AnigJ8dlDbLk8mWjN
        mhTL7JL5CBZXrIpXU87+KZcTMFnU9vEHsfq1QdPl2QVuRDkas2ugVbKpw0ERvtbp
        XAMXB6eEu4QtsZI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BE531AB722;
        Thu, 21 Jul 2022 17:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8E621AB720;
        Thu, 21 Jul 2022 17:37:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 06/26] submodule--helper: fix most "struct pathspec"
 memory leaks
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
        <patch-v3-06.26-7672ef1305f-20220721T191249Z-avarab@gmail.com>
Date:   Thu, 21 Jul 2022 14:37:06 -0700
In-Reply-To: <patch-v3-06.26-7672ef1305f-20220721T191249Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Jul
 2022 21:13:02
        +0200")
Message-ID: <xmqqr12edu65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 45485C68-093D-11ED-8CE4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Call clear_pathspec() at the end of various functions that work with
> and allocate a "struct pathspec".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/submodule--helper.c | 84 +++++++++++++++++++++++++------------
>  1 file changed, 58 insertions(+), 26 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 73ac1fcbb9c..a60dc6af178 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -269,7 +269,7 @@ static char *get_up_path(const char *path)
>  static int module_list(int argc, const char **argv, const char *prefix=
)
>  {
>  	int i;
> -	struct pathspec pathspec;
> +	struct pathspec pathspec =3D { 0 };
>  	struct module_list list =3D MODULE_LIST_INIT;
> =20
>  	struct option module_list_options[] =3D {
> @@ -278,6 +278,7 @@ static int module_list(int argc, const char **argv,=
 const char *prefix)
>  			   N_("alternative anchor for relative paths")),
>  		OPT_END()
>  	};
> +	int ret =3D 1;

Move this way above, perhaps next to where "int i;" is declared, or
replace the blank before where module_list_options[] is declared
with this line.

The same comment applies to changes to module_foreach() and
status_submodule_cb() in this patch.  The change to
absorb_git_dirs() gets it right.

Thanks.
