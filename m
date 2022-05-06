Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41EBC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 10:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390955AbiEFK0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390951AbiEFK0n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 06:26:43 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A7563384
        for <git@vger.kernel.org>; Fri,  6 May 2022 03:23:00 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nmv6w-0005dO-68;
        Fri, 06 May 2022 11:22:59 +0100
Message-ID: <f3f883cb-9141-6871-0f3d-3d3293a17f5f@iee.email>
Date:   Fri, 6 May 2022 11:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
Content-Language: en-GB
To:     Jason Hatton <jhatton@globalfinishing.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <CY4PR16MB16552D74E064638BEC11ECB1AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CY4PR16MB16552D74E064638BEC11ECB1AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05/2022 01:26, Jason Hatton wrote:
> Git cache stores file sizes using uint32_t. This causes any file
> that is a multiple of 2^32 to have a cached file size of zero.
> Zero is a special value used by racily clean. This causes git to
> rehash every file that is a multiple of 2^32 every time git status
> or git commit is run.
>
> This patch mitigates the problem by making all files that are a
> multiple of 2^32 appear to have a size of 1<<31 instead of zero.
>
> The value of 1<<31 is chosen to keep it as far away from zero
> as possible to help prevent things getting mixed up with unpatched
> versions of git.
>
> An example would be to have a 2^32 sized file in the index of
> patched git. Patched git would save the file as 2^31 in the cache.
> An unpatched git would very much see the file has changed in size
> and force it to rehash the file, which is safe. The file would
> have to grow or shrink by exactly 2^31 and retain all of its
> ctime, mtime, and other attributes for old git to not notice
> the change.
>
> This patch does not change the behavior of any file that is not
> an exact multiple of 2^32.
>
> Signed-off-by: Jason D. Hatton <jhatton@globalfinishing.com>
> ---
>  cache.h      |  1 +
>  read-cache.c | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 4b666b2848..74e983227b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -898,6 +898,7 @@ int ie_modified(struct index_state *, const struct cache_entry *, struct stat *,
>  #define HASH_SILENT 8
>  int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
>  int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
> +unsigned int munge_st_size(off_t st_size);
>  
>  /*
>   * Record to sd the data from st that we use to check whether a file
> diff --git a/read-cache.c b/read-cache.c
> index ea6150ea28..b0a1b505db 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -163,6 +163,18 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
>  		add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
>  }
>  
> +/*
> + * Munge st_size into an unsigned int.

This "Munge" above isn't telling the reader 'why'/'what' is going on.
The comment should in some way highlight that a zero size result is
special, and that we have the roll over issue when the stored in 32 bits
- the double duty of racy vs changed in the stat data heuristic.
Synonyms of 'munge' ?


> + */
> +unsigned int munge_st_size(off_t st_size) {
> +	unsigned int sd_size = st_size;
> +
> +	if(!sd_size && st_size)
> +		return 0x80000000;
> +	else
> +		return sd_size;
> +}
> +
>  void fill_stat_data(struct stat_data *sd, struct stat *st)
>  {
>  	sd->sd_ctime.sec = (unsigned int)st->st_ctime;
> @@ -173,7 +185,7 @@ void fill_stat_data(struct stat_data *sd, struct stat *st)
>  	sd->sd_ino = st->st_ino;
>  	sd->sd_uid = st->st_uid;
>  	sd->sd_gid = st->st_gid;
> -	sd->sd_size = st->st_size;
> +	sd->sd_size = munge_st_size(st->st_size);
>  }
>  
>  int match_stat_data(const struct stat_data *sd, struct stat *st)
> @@ -212,7 +224,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
>  			changed |= INODE_CHANGED;
>  #endif
>  
> -	if (sd->sd_size != (unsigned int) st->st_size)
> +	if (sd->sd_size != munge_st_size(st->st_size))
>  		changed |= DATA_CHANGED;
>  
>  	return changed;

