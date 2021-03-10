Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA85DC433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D7664F60
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhCJXCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 18:02:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60228 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhCJXCD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 18:02:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 377971241D3;
        Wed, 10 Mar 2021 18:02:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zjLezC+mVFqx+mD2TT96endblf4=; b=WonfOL
        3FTMNsqL3KRoy1t7oW/gnwL/eyGjePWYD/ydRtrvTqSyvfm9iEAFriJrHSsjsTE/
        D2nweiKiSdk+YN+P9Y28TMfR9fnuFHsN2lsebGkm2rzcWEN6QWrmQ1oTd6SbXpTm
        WHD0V39BSahK7MU29PCF11dNHNd+FvVrFPiRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kyOGamG6e55tLwVd0XnQtfvPAvjY5jCM
        gqA5isc6l4rQjyZHUirwGspbPSe2MqfRda2S3/pLjfM6WmVx530NwZUoZvpWUYXH
        7Wb1n6oFIYFXsTJ9dtpOX+1kqHPOwJfoXlXi2PoeCIbxwPfi7N1CxQ5TlJADjES6
        Iltbb9FC+2o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3067B1241D2;
        Wed, 10 Mar 2021 18:02:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 720AE1241CF;
        Wed, 10 Mar 2021 18:02:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ephrim Khong <dr.khong@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] merge-recursive: create new files with O_EXCL
References: <f6cd9386-8a58-ee52-4c7b-60d9bd14a51d@gmail.com>
Date:   Wed, 10 Mar 2021 15:01:58 -0800
In-Reply-To: <f6cd9386-8a58-ee52-4c7b-60d9bd14a51d@gmail.com> (Ephrim Khong's
        message of "Wed, 10 Mar 2021 08:57:43 +0100")
Message-ID: <xmqqblbqipeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F045436-81F4-11EB-B9AD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ephrim Khong <dr.khong@gmail.com> writes:

> When re-writing the content of a file during a merge, the file
> is first unlinked and then re-created. Since it is a new file
> at the time of the open call, O_EXCL should be passed to clarify
> that the file is expected to be new.
>
> Signed-off-by: Ephrim Khong <dr.khong@gmail.com>
> ---
> This is actually a fix for an issue we ran into on an nfs4
> mount. Files created with O_TRUNC instead of O_EXCL sometimes
> had their permissions wrong. However, it appears to be a safe
> thing to change this, especially since other parts of the
> git codebase also prefer the O_EXCL flag.

Interesting.  

It seems that this part of the code has always used O_TRUNC since
its inception at 6d297f81 (Status update on merge-recursive in C,
2006-07-08) when two thieves smuggled it into our codebase.  Back
then, this was the only use of O_TRUNC|O_WRONLY|O_CREAT combination
in the production codebase (as you observed, O_CREAT|O_EXCL|O_WRONLY
was what all the other codepaths use).  But the use of O_TRUNC has
spread over time to other parts of the codebase, perhaps cargo
culted.  If you look at hits from

    $ git grep -e O_TRUNC -e O_EXCL

you see the combination of CREAT/WRONLY/TRUNC used all over the
place [*], especially in newer parts of the code.

So it becomes very curious why this one location needs to be so
special and you are not patching other uses of O_TRUNC.

I do not think we mind fixing the use of O_TRUNC with "remove and
then create with O_EXCL", but we'd probably want to

 * understand why only this place matters, or perhaps other uses of
   O_TRUNC needs the same fix to work "correctly" with your NFS
   mounts, in which case we'd need all of them addressed in the same
   series of patches, and

 * understand why your NFS mount is broken and give a better
   explanation as to why we need to have a workaround in our code.

before doing so.

Thanks.


[Footnote]

* It is understandable that CREAT/WRONLY/TRUNC are used in
  combination, as that is documented as a synonym for creat().




>  merge-recursive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index f736a0f632..f72a376c5b 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -974,7 +974,7 @@ static int update_file_flags(struct merge_options *opt,
>  			int fd;
>  			int mode = (contents->mode & 0100 ? 0777 : 0666);
>
> -			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
> +			fd = open(path, O_WRONLY | O_EXCL | O_CREAT, mode);
>  			if (fd < 0) {
>  				ret = err(opt, _("failed to open '%s': %s"),
>  					  path, strerror(errno));
