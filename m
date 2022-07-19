Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3531C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbiGSVbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiGSVbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:31:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5172630F78
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:31:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DC9D19D33C;
        Tue, 19 Jul 2022 17:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g6UWgXXJ+Hrb
        YLanOQU40kqhvuKDGCvubnlClM/Yo/s=; b=QxkFNfJTefIwv3QcYEhvXBMOiQAW
        c0Udc7Y29Q7wugP3s1zLYyZkLWc3LQ1WUH5uyNMyiFMbumux9/rVfO0Gz3UH6e7e
        H2DAzqF956vLu53oTJ0Tzo+UpzLmRquOHun6zB0dsdNOxLKz8jW1y38maCP83Eot
        jI19u0/bjiAVp5c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2544D19D33B;
        Tue, 19 Jul 2022 17:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD67E19D333;
        Tue, 19 Jul 2022 17:31:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v2 02/24] submodule--helper: fix a leak in
 "clone_submodule"
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
        <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <patch-v2-02.24-130a396b837-20220719T204458Z-avarab@gmail.com>
Date:   Tue, 19 Jul 2022 14:31:31 -0700
In-Reply-To: <patch-v2-02.24-130a396b837-20220719T204458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 19 Jul
 2022 22:46:53
        +0200")
Message-ID: <xmqqpmi094cs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28B73374-07AA-11ED-8154-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 73717be957c..4155d2450e0 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1644,6 +1644,7 @@ static int clone_submodule(struct module_clone_da=
ta *clone_data)
>  	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>  	struct strbuf sb =3D STRBUF_INIT;
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	char *to_free =3D NULL;
> =20
>  	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
>  	sm_gitdir =3D absolute_pathdup(sb.buf);
> @@ -1651,9 +1652,9 @@ static int clone_submodule(struct module_clone_da=
ta *clone_data)
> =20
>  	if (!is_absolute_path(clone_data->path)) {
>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
> -		clone_data->path =3D strbuf_detach(&sb, NULL);
> +		clone_data->path =3D to_free =3D strbuf_detach(&sb, NULL);
>  	} else {
> -		clone_data->path =3D xstrdup(clone_data->path);
> +		clone_data->path =3D clone_data->path;
>  	}

WTH?  Shouldn't the entire else-clause just go?

> =20
>  	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
> @@ -1737,6 +1738,7 @@ static int clone_submodule(struct module_clone_da=
ta *clone_data)
>  	strbuf_release(&sb);
>  	free(sm_gitdir);
>  	free(p);
> +	free(to_free);
>  	return 0;
>  }

The caller passes clone_data to us, we may have stuffed an allocated
piece of memory in there when we had to make it absolute, and we
free it but let the clone_data structure smuggle the now-stale
pointer out of the function, so that the caller may be able to abuse
it?

That leaves a bad taste in my mouth.  Doesn't it in yours?

If the caller is *NOT* allowed to rely on the value in
clone_data->path after we return, perhaps

+	free(to_free);
+	clone_data->path =3D NULL;

But stepping back a bit, would it make more sense to introduce a
local variable "path" and leave clone_data->path alone, after we
decide to either compute an absolute path out of it, or we decide
to use the path as is, i.e.

	if (!is_absolute_path(...)) {
		...
		to_free =3D path =3D strbuf_detach(&sb, NULL);
	} ... {
		path =3D clone_data->path;
		to_free =3D NULL;
	}

and after that, never use clone_data->path but work solely on the
local "path"?  A quick scan tells me that no line in the rest of the
function passes the whole clone_data to other helpers, so it may just
be a matter of s/clone_data->path/path/g perhaps?
