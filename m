Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9E2C54FCB
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADA12082E
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="otciXoo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDTXbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:31:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54382 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTXbX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 19:31:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89AE15A9E4;
        Mon, 20 Apr 2020 19:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eArIiKtm2VJFYjmz+z7BRul92iQ=; b=otciXo
        o5Tqh1OfYKjbY/C1pMtbH/QfPIgU9l/Y0LjDvaE2fSEY5mWSl9HD/wuRoYxc9DW0
        4cZVfNt/snhNkK9JxG1RnoGvazCJlzMrgIOSdmxT8a7YjpTmDMLO1y4Ge/XlDexC
        V/h6+SPrJpRimsnMs9ZFMhjA5Bm5ibnFZ4I0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kqxa2Uzwoe/zEFFp/lvGk7Y/32nXZhS4
        ELDGXkEsxx7A6RX4fpJjMh6bJQwNBhICiLZD/4fuB1DxOGTWtm8GYCHxA785HA5X
        80wxd/fEA5qf2KH5ccyDRWxk08QedJPrOpUyClFY7lJoZkpRFJl1I62P6WTXw9gl
        gY59KKs/cYU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 800755A9E3;
        Mon, 20 Apr 2020 19:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E89A5A9E2;
        Mon, 20 Apr 2020 19:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: Re: [PATCH 1/3] tempfile.c: introduce 'create_tempfile_mode'
References: <cover.1587422630.git.me@ttaylorr.com>
        <aa86e8df403eef31295e6036f280995fa74cc3b4.1587422630.git.me@ttaylorr.com>
Date:   Mon, 20 Apr 2020 16:31:18 -0700
In-Reply-To: <aa86e8df403eef31295e6036f280995fa74cc3b4.1587422630.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 20 Apr 2020 16:51:03 -0600")
Message-ID: <xmqq1rohrayh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0961F706-835F-11EA-9836-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Arguably, all temporary files should have permission 0444, since they
> are likely to be renamed into place and then not written to again.

If the repository is not shared, it is more than likely that these
files ought to have permission narrower than that.  As you'd be
concluding any file that you created and written to in $GIT_DIR/
with adjust_shared_perm(), I do not think it is a good idea to allow
callers to pass an arbitrary mode and let them expect the mode would
stick.  Shoudln't we instead be passing "int read_only" and depending
on the boolean value, choosing between 0444 and 0666 in the function?

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  tempfile.c | 6 +++---
>  tempfile.h | 7 ++++++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/tempfile.c b/tempfile.c
> index d43ad8c191..94aa18f3f7 100644
> --- a/tempfile.c
> +++ b/tempfile.c
> @@ -130,17 +130,17 @@ static void deactivate_tempfile(struct tempfile *tempfile)
>  }
>  
>  /* Make sure errno contains a meaningful value on error */
> -struct tempfile *create_tempfile(const char *path)
> +struct tempfile *create_tempfile_mode(const char *path, int mode)
>  {
>  	struct tempfile *tempfile = new_tempfile();
>  
>  	strbuf_add_absolute_path(&tempfile->filename, path);
>  	tempfile->fd = open(tempfile->filename.buf,
> -			    O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, 0666);
> +			    O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, mode);
>  	if (O_CLOEXEC && tempfile->fd < 0 && errno == EINVAL)
>  		/* Try again w/o O_CLOEXEC: the kernel might not support it */
>  		tempfile->fd = open(tempfile->filename.buf,
> -				    O_RDWR | O_CREAT | O_EXCL, 0666);
> +				    O_RDWR | O_CREAT | O_EXCL, mode);
>  	if (tempfile->fd < 0) {
>  		deactivate_tempfile(tempfile);
>  		return NULL;
> diff --git a/tempfile.h b/tempfile.h
> index cddda0a33c..b5760d4581 100644
> --- a/tempfile.h
> +++ b/tempfile.h
> @@ -89,7 +89,12 @@ struct tempfile {
>   * a tempfile (whose "fd" member can be used for writing to it), or
>   * NULL on error. It is an error if a file already exists at that path.
>   */
> -struct tempfile *create_tempfile(const char *path);
> +struct tempfile *create_tempfile_mode(const char *path, int mode);
> +
> +static inline struct tempfile *create_tempfile(const char *path)
> +{
> +	return create_tempfile_mode(path, 0666);
> +}
>  
>  /*
>   * Register an existing file as a tempfile, meaning that it will be
