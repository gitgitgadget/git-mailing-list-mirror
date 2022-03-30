Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54952C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349229AbiC3RUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347990AbiC3RUq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:20:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D770AE5F
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:18:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DD07117A03;
        Wed, 30 Mar 2022 13:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qK8HL8/f2NL5+r3OhjkH/WpZMg3ibXb0f/OUi2
        MU8hE=; b=tWey1jEiqcJroHpcxpnl02x85jZ/1fo9cPqj9Ghe6Wzp9E9mFv2Yru
        iHWNn+UEWqZY/ueJH6LG88lI37sGzNI/zEKEScLL+7l78IphDesYVCJ2qC9tjp92
        WC2xDzW81TzxVokuaRaq4X4LL138z+vj7McVDaXAb7zGFUYcRcf78=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 035BF117A02;
        Wed, 30 Mar 2022 13:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A9EB1179FF;
        Wed, 30 Mar 2022 13:18:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 03/14] object-file: pass filename to fsync_or_die
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <2d1bc4568ac744f11c886a5f964dbe563c04ce8b.1648616734.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 10:18:57 -0700
In-Reply-To: <2d1bc4568ac744f11c886a5f964dbe563c04ce8b.1648616734.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 30 Mar 2022 05:05:21
        +0000")
Message-ID: <xmqqfsmz9x4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C2C9BFC-B04D-11EC-8748-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> If we die while trying to fsync a loose object file, pass the actual
> filename we're trying to sync. This is likely to be more helpful for a
> user trying to diagnose the cause of the failure than the former
> 'loose object file' string. It also sidesteps any concerns about
> translating the die message differently for loose objects versus
> something else that has a real path.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  object-file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Looks good and obviously can be done totally outside the series.
Perhaps while the rest of the topic is still cooking, extract this
(we may find others) and have them graduate sooner?

> diff --git a/object-file.c b/object-file.c
> index b254bc50d70..5ffbf3d4fd4 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1888,16 +1888,16 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
>  }
>  
>  /* Finalize a file on disk, and close it. */
> -static void close_loose_object(int fd)
> +static void close_loose_object(int fd, const char *filename)
>  {
>  	if (the_repository->objects->odb->will_destroy)
>  		goto out;
>  
>  	if (fsync_object_files > 0)
> -		fsync_or_die(fd, "loose object file");
> +		fsync_or_die(fd, filename);
>  	else
>  		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
> -				       "loose object file");
> +				       filename);
>  
>  out:
>  	if (close(fd) != 0)
> @@ -2011,7 +2011,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));
>  
> -	close_loose_object(fd);
> +	close_loose_object(fd, tmp_file.buf);
>  
>  	if (mtime) {
>  		struct utimbuf utb;
