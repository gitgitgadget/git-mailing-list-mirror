Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AE691FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbdBMUij (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:38:39 -0500
Received: from avasout02.plus.net ([212.159.14.17]:56983 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbdBMUii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:38:38 -0500
Received: from [10.0.2.15] ([146.90.175.113])
        by avasout02 with smtp
        id kLeb1u0042TAAPE01LecQ4; Mon, 13 Feb 2017 20:38:36 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=F9YnTupN c=1 sm=1 tr=0
 a=xPbQrKg7pJ/t022iV9eLWw==:117 a=xPbQrKg7pJ/t022iV9eLWw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=49SH-MnNuw-JaQbAKbwA:9
 a=n2AuYUPkMhNymyIs:21 a=iGIQnsrOff3RhdK7:21 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 02/11] files-backend: convert git_path() to
 strbuf_git_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170213152011.12050-3-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <e8a83077-1d4d-1274-956c-83388957bc63@ramsayjones.plus.com>
Date:   Mon, 13 Feb 2017 20:38:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170213152011.12050-3-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/02/17 15:20, Nguyễn Thái Ngọc Duy wrote:
> git_path() and friends are going to be killed in files-backend.c in near
> future. And because there's a risk with overwriting buffer in
> git_path(), let's convert them all to strbuf_git_path(). We'll have
> easier time killing/converting strbuf_git_path() then because we won't
> have to worry about memory management again.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 114 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 90 insertions(+), 24 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 75565c3aa..6582c9b2d 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2169,6 +2169,8 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
>  	static int timeout_configured = 0;
>  	static int timeout_value = 1000;
>  	struct packed_ref_cache *packed_ref_cache;
> +	struct strbuf sb = STRBUF_INIT;
> +	int ret;
>  
>  	files_assert_main_repository(refs, "lock_packed_refs");
>  
> @@ -2177,10 +2179,13 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
>  		timeout_configured = 1;
>  	}
>  
> -	if (hold_lock_file_for_update_timeout(
> -			    &packlock, git_path("packed-refs"),
> -			    flags, timeout_value) < 0)
> +	strbuf_git_path(&sb, "packed-refs");
> +	ret = hold_lock_file_for_update_timeout(&packlock, sb.buf,
> +						flags, timeout_value);
> +	strbuf_release(&sb);
> +	if (ret < 0)
>  		return -1;
> +
>  	/*
>  	 * Get the current packed-refs while holding the lock.  If the
>  	 * packed-refs file has been modified since we last read it,
> @@ -2335,6 +2340,9 @@ static void try_remove_empty_parents(char *name)
>  	for (q = p; *q; q++)
>  		;
>  	while (1) {
> +		struct strbuf sb = STRBUF_INIT;
> +		int ret;
> +
>  		while (q > p && *q != '/')
>  			q--;
>  		while (q > p && *(q-1) == '/')
> @@ -2342,7 +2350,10 @@ static void try_remove_empty_parents(char *name)
>  		if (q == p)
>  			break;
>  		*q = '\0';
> -		if (rmdir(git_path("%s", name)))
> +		strbuf_git_path(&sb, "%s", name);
> +		ret = rmdir(sb.buf);
> +		strbuf_release(&sb);
> +		if (ret)
>  			break;
>  	}
>  }
> @@ -2431,7 +2442,11 @@ static int repack_without_refs(struct files_ref_store *refs,
>  		return 0; /* no refname exists in packed refs */
>  
>  	if (lock_packed_refs(refs, 0)) {
> -		unable_to_lock_message(git_path("packed-refs"), errno, err);
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		strbuf_git_path(&sb, "packed-refs");
> +		unable_to_lock_message(sb.buf, errno, err);
> +		strbuf_release(&sb);
>  		return -1;
>  	}
>  	packed = get_packed_refs(refs);
> @@ -2529,11 +2544,12 @@ static int rename_tmp_log(const char *newrefname)
>  {
>  	int attempts_remaining = 4;
>  	struct strbuf path = STRBUF_INIT;
> +	struct strbuf tmp_renamed_log = STRBUF_INIT;
>  	int ret = -1;
>  
> - retry:
> -	strbuf_reset(&path);
>  	strbuf_git_path(&path, "logs/%s", newrefname);
> +	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
> + retry:
>  	switch (safe_create_leading_directories_const(path.buf)) {
>  	case SCLD_OK:
>  		break; /* success */
> @@ -2546,7 +2562,7 @@ static int rename_tmp_log(const char *newrefname)
>  		goto out;
>  	}
>  
> -	if (rename(git_path(TMP_RENAMED_LOG), path.buf)) {
> +	if (rename(tmp_renamed_log.buf, path.buf)) {
>  		if ((errno==EISDIR || errno==ENOTDIR) && --attempts_remaining > 0) {
>  			/*
>  			 * rename(a, b) when b is an existing
> @@ -2574,6 +2590,7 @@ static int rename_tmp_log(const char *newrefname)
>  	ret = 0;
>  out:
>  	strbuf_release(&path);
> +	strbuf_release(&tmp_renamed_log);
>  	return ret;
>  }
>  
> @@ -2614,9 +2631,15 @@ static int files_rename_ref(struct ref_store *ref_store,
>  	int flag = 0, logmoved = 0;
>  	struct ref_lock *lock;
>  	struct stat loginfo;
> -	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
> +	struct strbuf sb_oldref = STRBUF_INIT;
> +	struct strbuf sb_newref = STRBUF_INIT;
> +	struct strbuf tmp_renamed_log = STRBUF_INIT;
> +	int log, ret;
>  	struct strbuf err = STRBUF_INIT;
>  
> +	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
> +	log = !lstat(sb_oldref.buf, &loginfo);
> +	strbuf_release(&sb_oldref);
>  	if (log && S_ISLNK(loginfo.st_mode))
>  		return error("reflog for %s is a symlink", oldrefname);
>  
> @@ -2630,7 +2653,12 @@ static int files_rename_ref(struct ref_store *ref_store,
>  	if (!rename_ref_available(oldrefname, newrefname))
>  		return 1;
>  
> -	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
> +	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
> +	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
> +	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);

It probably won't make too much difference, but the two code
sequences above are not similar in terms of side-effects when
'log' is false. In that case, the two calls to git_path() and
the call to rename() are not made in the original code. In the
new sequence, the two calls to strbuf_git_path() are always made
(but rename() is not).

> +	strbuf_release(&sb_oldref);
> +	strbuf_release(&tmp_renamed_log);
> +	if (ret)
>  		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
>  			oldrefname, strerror(errno));
>  
> @@ -2709,13 +2737,19 @@ static int files_rename_ref(struct ref_store *ref_store,
>  	log_all_ref_updates = flag;
>  
>   rollbacklog:
> -	if (logmoved && rename(git_path("logs/%s", newrefname), git_path("logs/%s", oldrefname)))
> +	strbuf_git_path(&sb_newref, "logs/%s", newrefname);
> +	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
> +	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))

ditto

>  		error("unable to restore logfile %s from %s: %s",
>  			oldrefname, newrefname, strerror(errno));
> +	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
>  	if (!logmoved && log &&
> -	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
> +	    rename(tmp_renamed_log.buf, sb_oldref.buf))

similar

>  		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
>  			oldrefname, strerror(errno));
> +	strbuf_release(&sb_newref);
> +	strbuf_release(&sb_oldref);
> +	strbuf_release(&tmp_renamed_log);
>  
>  	return 1;
>  }

ATB,
Ramsay Jones

