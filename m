Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD7DE94131
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjJFWAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjJFWAX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:00:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A2BE
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:00:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F76A27EA6;
        Fri,  6 Oct 2023 18:00:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=1GzNxSBEMtXs1Ykg5Y9Jv8RbbbMu2f8Q3f8Vbl
        u7i1M=; b=wSQHN0Cvkes+zhq3zqGDov9fqjmPH5ex1/+few2G6yV0sTxp3LeRZq
        YoQKs9CbggUkaR8m1eAevuiJ0qRqX/lPRbYefIdIr+6rkvYA92rP1eeKxJcSzfcP
        RJ0Eeqe49hdfiOl9ATzFylfQnU3SwQSEuDf1FWWAtAEKy7bPAgVbs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38E6527EA5;
        Fri,  6 Oct 2023 18:00:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE22F27EA2;
        Fri,  6 Oct 2023 18:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/4] dir.[ch]: expose 'get_dtype'
In-Reply-To: <24014010ea350a2ea8676b6560ca1d60838c56ef.1696615769.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Fri, 06 Oct 2023 18:09:27
        +0000")
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
        <24014010ea350a2ea8676b6560ca1d60838c56ef.1696615769.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Oct 2023 15:00:17 -0700
Message-ID: <xmqq1qe78l8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCE69E44-6493-11EE-9A02-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Move 'get_dtype()' from 'diagnose.c' to 'dir.c' and add its declaration to
> 'dir.h' so that it is accessible to callers in other files. The function and
> its documentation are moved verbatim except for a small addition to the
> description clarifying what the 'path' arg represents.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  diagnose.c | 36 ------------------------------------
>  dir.c      | 28 ++++++++++++++++++++++++++++
>  dir.h      | 11 +++++++++++
>  3 files changed, 39 insertions(+), 36 deletions(-)

OK.  diagnose.c should still have access to the function as it
includes <dir.h>, and to anybody that includes <dir.h> and sees the
declaration of get_dtype(), DT_FOO should be visible because <dir.h>
includes <statinfo.h> that has fallback definition of DT_FOO.

Looking simple and straight-forward.


> diff --git a/diagnose.c b/diagnose.c
> index 8430064000b..fc4d344bd63 100644
> --- a/diagnose.c
> +++ b/diagnose.c
> @@ -71,42 +71,6 @@ static int dir_file_stats(struct object_directory *object_dir, void *data)
>  	return 0;
>  }
>  
> -/*
> - * Get the d_type of a dirent. If the d_type is unknown, derive it from
> - * stat.st_mode.
> - *
> - * Note that 'path' is assumed to have a trailing slash. It is also modified
> - * in-place during the execution of the function, but is then reverted to its
> - * original value before returning.
> - */
> -static unsigned char get_dtype(struct dirent *e, struct strbuf *path)
> -{
> -	struct stat st;
> -	unsigned char dtype = DTYPE(e);
> -	size_t base_path_len;
> -
> -	if (dtype != DT_UNKNOWN)
> -		return dtype;
> -
> -	/* d_type unknown in dirent, try to fall back on lstat results */
> -	base_path_len = path->len;
> -	strbuf_addstr(path, e->d_name);
> -	if (lstat(path->buf, &st))
> -		goto cleanup;
> -
> -	/* determine d_type from st_mode */
> -	if (S_ISREG(st.st_mode))
> -		dtype = DT_REG;
> -	else if (S_ISDIR(st.st_mode))
> -		dtype = DT_DIR;
> -	else if (S_ISLNK(st.st_mode))
> -		dtype = DT_LNK;
> -
> -cleanup:
> -	strbuf_setlen(path, base_path_len);
> -	return dtype;
> -}
> -
>  static int count_files(struct strbuf *path)
>  {
>  	DIR *dir = opendir(path->buf);
> diff --git a/dir.c b/dir.c
> index 8486e4d56ff..5e01af3a25e 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2235,6 +2235,34 @@ static int get_index_dtype(struct index_state *istate,
>  	return DT_UNKNOWN;
>  }
>  
> +unsigned char get_dtype(struct dirent *e, struct strbuf *path)
> +{
> +	struct stat st;
> +	unsigned char dtype = DTYPE(e);
> +	size_t base_path_len;
> +
> +	if (dtype != DT_UNKNOWN)
> +		return dtype;
> +
> +	/* d_type unknown in dirent, try to fall back on lstat results */
> +	base_path_len = path->len;
> +	strbuf_addstr(path, e->d_name);
> +	if (lstat(path->buf, &st))
> +		goto cleanup;
> +
> +	/* determine d_type from st_mode */
> +	if (S_ISREG(st.st_mode))
> +		dtype = DT_REG;
> +	else if (S_ISDIR(st.st_mode))
> +		dtype = DT_DIR;
> +	else if (S_ISLNK(st.st_mode))
> +		dtype = DT_LNK;
> +
> +cleanup:
> +	strbuf_setlen(path, base_path_len);
> +	return dtype;
> +}
> +
>  static int resolve_dtype(int dtype, struct index_state *istate,
>  			 const char *path, int len)
>  {
> diff --git a/dir.h b/dir.h
> index ad06682fd54..28c630ce806 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -363,6 +363,17 @@ struct dir_struct {
>  
>  struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp);
>  
> +/*
> + * Get the d_type of a dirent. If the d_type is unknown, derive it from
> + * stat.st_mode using the path to the dirent's containing directory (path) and
> + * the name of the dirent itself.
> + *
> + * Note that 'path' is assumed to have a trailing slash. It is also modified
> + * in-place during the execution of the function, but is then reverted to its
> + * original value before returning.
> + */
> +unsigned char get_dtype(struct dirent *e, struct strbuf *path);
> +
>  /*Count the number of slashes for string s*/
>  int count_slashes(const char *s);
