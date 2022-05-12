Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF2EC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 18:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357516AbiELSPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357502AbiELSPO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 14:15:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D226FA64
        for <git@vger.kernel.org>; Thu, 12 May 2022 11:15:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 714F919A63F;
        Thu, 12 May 2022 14:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wy2oSqza6u19
        1gWjM+0oPFG5TqCXkLuQTZlHJBjNqY4=; b=WgK7S3lAX+YMe+SbADTLpdmDKU0r
        qScq2dp0ffp3eMPrVM9UNHiHfAr2196bWfOfcUjUWfRBFi2C41I+Ct5Fat6INlV8
        G6lqQPEBkJKP+N36EmeQMF9q/MnupiO2Rc6uYbyftFtivvTHWm2zt8pNFvFx8v/Q
        ENpFvZuhQDLJ3qU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A1D019A63E;
        Thu, 12 May 2022 14:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1221219A63A;
        Thu, 12 May 2022 14:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     rsbecker@nexbridge.com,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Taylor Blau' <me@ttaylorr.com>,
        'Derrick Stolee' <stolee@gmail.com>,
        'Elijah Newren' <newren@gmail.com>,
        'Johannes Schindelin' <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/7] archive: optionally add "virtual" files
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
        <xmqqtu9x6ovh.fsf@gitster.g>
        <03d701d864ba$46d15c10$d4741430$@nexbridge.com>
        <xmqq8rr955zf.fsf@gitster.g>
        <3cf6e4f8-9151-6d68-21ca-b94d6a7557e6@web.de>
        <xmqqzgjnkgy0.fsf@gitster.g>
        <47ed5a2f-f4aa-1ec1-27c9-9b0b70eb8bca@web.de>
Date:   Thu, 12 May 2022 11:15:05 -0700
In-Reply-To: <47ed5a2f-f4aa-1ec1-27c9-9b0b70eb8bca@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 12 May 2022 18:16:50 +0200")
Message-ID: <xmqqfslefwie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 73D6DDFC-D21F-11EC-88A6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Good point.  write_tar_entry() actually normalizes the permission bits
> and applies tar.umask (0002 by default):
>
> 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
> 		*header.typeflag =3D TYPEFLAG_DIR;
> 		mode =3D (mode | 0777) & ~tar_umask;
> 	} else if (S_ISLNK(mode)) {
> 		*header.typeflag =3D TYPEFLAG_LNK;
> 		mode |=3D 0777;
> 	} else if (S_ISREG(mode)) {
> 		*header.typeflag =3D TYPEFLAG_REG;
> 		mode =3D (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;

Yeah, this side seems to care only about u+x bit, so
"add-executable" as a separate option would fly we..

> But write_zip_entry() only normalizes (drops) the permission bits of
> non-executable files:
>
>                 attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
>                         (mode & 0111) ? ((mode) << 16) : 0;
>                 if (S_ISLNK(mode) || (mode & 0111))
>                         creator_version =3D 0x0317;
>
> attr2 corresponds to the field "external file attributes" mentioned in
> the ZIP format specification, APPNOTE.TXT.  It's interpreted based on
> the "version made by" (creator_version here); that 0x03 part above
> means "UNIX".  The default is MS-DOS (FAT filesystem), with effectivly
> no support for file permissions.
>
> So we currently leak permission bits of executable files into ZIP
> archives, but not tar files. :-|  Normalizing those to 0755 would be
> more consistent.

Yup.

>> For tracked paths, we probably are normalizing the blobs
>> between 0644 and 0755 way before the values are passed as "mode"
>> parameter to the write_entry() functions, but for these extra files,
>> there is no such massaging.
>
> Right, mode values from read_tree() pass through canon_mode(), so only
> untracked files (those appended with --add-file) are affected by the
> leakage mentioned above.

Thanks for sanity-checking.

