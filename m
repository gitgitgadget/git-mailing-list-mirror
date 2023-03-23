Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67C6C76196
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 15:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjCWPWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCWPWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 11:22:03 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE762ED65
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 08:22:01 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 115D8CA126B;
        Thu, 23 Mar 2023 11:22:01 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:948:2c:9be7:96af] (unknown [IPv6:2600:1700:840:e768:948:2c:9be7:96af])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D9C44CC8313;
        Thu, 23 Mar 2023 11:22:00 -0400 (EDT)
Message-ID: <aaad07e3-11c9-9bb1-89ec-f9418cb2ef77@jeffhostetler.com>
Date:   Thu, 23 Mar 2023 11:22:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] split-index; stop abusing the `base_oid` to strip the
 "link" extension
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
 <f1897b880729b649ab24da14cbc3432d44b7c731.1679500859.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <f1897b880729b649ab24da14cbc3432d44b7c731.1679500859.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/23 12:00 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When a split-index is in effect, the `$GIT_DIR/index` file needs to
> contain a "link" extension that contains all the information about the
> split-index, including the information about the shared index.
> 
> However, in some cases Git needs to suppress writing that "link"
> extension (i.e. to fall back to writing a full index) even if the
> in-memory index structure _has_ a `split_index` configured. This is the
> case e.g. when "too many not shared" index entries exist.
> 
> In such instances, the current code sets the `base_oid` field of said
> `split_index` structure to all-zero to indicate that `do_write_index()`
> should skip writing the "link" extension.
> 
> This can lead to problems later on, when the in-memory index is still
> used to perform other operations and eventually wants to write a
> split-index, detects the presence of the `split_index` and reuses that,
> too (under the assumption that it has been initialized correctly and
> still has a non-null `base_oid`).
> 
> Let's stop zeroing out the `base_oid` to indicate that the "link"
> extension should not be written.
> 
> One might be tempted to simply call `discard_split_index()` instead,
> under the assumption that Git decided to write a non-split index and
> therefore the the `split_index` structure might no longer be wanted.
> However, that is not possible because that would release index entries
> in `split_index->base` that are likely to still be in use. Therefore we
> cannot do that.
> 
> The next best thing we _can_ do is to introduce a flag, specifically
> indicating when the "link" extension should be skipped. So that's what
> we do here.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   read-cache.c                 | 37 ++++++++++++++++++++++--------------
>   t/t7527-builtin-fsmonitor.sh |  2 +-
>   2 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index b09128b1884..8fcb2d54c05 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2868,6 +2868,12 @@ static int record_ieot(void)
>   	return !git_config_get_index_threads(&val) && val != 1;
>   }
>   
> +enum strip_extensions {
> +	WRITE_ALL_EXTENSIONS = 0,
> +	STRIP_ALL_EXTENSIONS = 1,
> +	STRIP_LINK_EXTENSION_ONLY = 2
> +};

Earlier (in a response to Junio's response on this commit) I said
that I didn't think we needed to make a bit set here, but I want
to re-think that or at least walk thru the change and talk out loud.

I'll explain in-line below.

> +
>   /*
>    * On success, `tempfile` is closed. If it is the temporary file
>    * of a `struct lock_file`, we will therefore effectively perform
> @@ -2876,7 +2882,7 @@ static int record_ieot(void)
>    * rely on it.
>    */
>   static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
> -			  int strip_extensions, unsigned flags)
> +			  enum strip_extensions strip_extensions, unsigned flags)
>   {
>   	uint64_t start = getnanotime();
>   	struct hashfile *f;
> @@ -3045,7 +3051,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   			return -1;
>   	}
>   
> -	if (!strip_extensions && istate->split_index &&
> +	if (strip_extensions == WRITE_ALL_EXTENSIONS && istate->split_index &&
>   	    !is_null_oid(&istate->split_index->base_oid)) {

(I hate all of this double negative logic...)

Here we only want the extension if we have WRITE_ALL, so that is
NOT STRIP_ALL and NOT STRIP_LINK_ONLY, so that is OK.

>   		struct strbuf sb = STRBUF_INIT;
>   
> @@ -3060,7 +3066,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   		if (err)
>   			return -1;
>   	}
> -	if (!strip_extensions && !drop_cache_tree && istate->cache_tree) {
> +	if (strip_extensions != STRIP_ALL_EXTENSIONS && !drop_cache_tree && istate->cache_tree) {

Here we only want the extension when NOT STRIP_ALL, so this is
either WRITE_ALL or STRIP_LINK_ONLY, so this is OK.  The rest are
the same, so I'll omit them.

[...]

All of this looks correct, but I stumbled over things on my first
or second reading.  I wonder if it would it simplify things to define
this as:

enum strip_extensions {
	WRITE_ALL_EXTENSIONS   = 0,
	STRIP_LINK_EXTENSION   = (1<0),
	STRIP_OTHER_EXTENSIONS = (1<1),
	STRIP_ALL_EXTENSIONS   = (STRIP_LINK_EXTENSION
				 | STRIP_OTHER_EXTENSIONS),
};

Then the link test becomes:
	if ( ! (strip_extensions & STRIP_LINK_EXTENSION) &&
	    istate->split_index &&
	    ...) {

and the others become:

	if ( ! (strip_extensions & STRIP_OTHER_EXTENSIONS) &&
	    ...) {

If we need to add the ability later to strip an individual,
we can easily add a bit to the enum and update the _ALL_ mask
and the corresponding `if` test.

In a later commit (probably in another series), we can invert
these double negatives to improve readability.

> +/*
> + * Write the Git index into a `.lock` file
> + *
> + * If `strip_link_extension` is non-zero, avoid writing any "link" extension
> + * (used by the split-index feature).
> + */
>   static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
> -				 unsigned flags)
> +				 unsigned flags, int strip_link_extension)
>   {
>   	int ret;
>   	int was_full = istate->sparse_index == INDEX_EXPANDED;
> @@ -3185,7 +3197,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>   	 */
>   	trace2_region_enter_printf("index", "do_write_index", the_repository,
>   				   "%s", get_lock_file_path(lock));
> -	ret = do_write_index(istate, lock->tempfile, 0, flags);
> +	ret = do_write_index(istate, lock->tempfile, strip_link_extension ? STRIP_LINK_EXTENSION_ONLY : 0, flags);
>   	trace2_region_leave_printf("index", "do_write_index", the_repository,
>   				   "%s", get_lock_file_path(lock));
>   
> @@ -3214,7 +3226,7 @@ static int write_split_index(struct index_state *istate,
>   {
>   	int ret;
>   	prepare_to_write_split_index(istate);
> -	ret = do_write_locked_index(istate, lock, flags);
> +	ret = do_write_locked_index(istate, lock, flags, 0);

could we use the enum values here instead of 0 ?

>   	finish_writing_split_index(istate);
>   	return ret;
>   }
> @@ -3366,9 +3378,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>   	if ((!si && !test_split_index_env) ||
>   	    alternate_index_output ||
>   	    (istate->cache_changed & ~EXTMASK)) {
> -		if (si)
> -			oidclr(&si->base_oid);
> -		ret = do_write_locked_index(istate, lock, flags);
> +		ret = do_write_locked_index(istate, lock, flags, 1);

and here

>   		goto out;
>   	}
>   
> @@ -3394,8 +3404,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>   		/* Same initial permissions as the main .git/index file */
>   		temp = mks_tempfile_sm(git_path("sharedindex_XXXXXX"), 0, 0666);
>   		if (!temp) {
> -			oidclr(&si->base_oid);
> -			ret = do_write_locked_index(istate, lock, flags);
> +			ret = do_write_locked_index(istate, lock, flags, 1);

and here

>   			goto out;
>   		}
>   		ret = write_shared_index(istate, &temp, flags);
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index cbafdd69602..9fab9a2ab38 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -1003,7 +1003,7 @@ test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
>   	egrep "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
>   '
>   
> -test_expect_failure 'split-index and FSMonitor work well together' '
> +test_expect_success 'split-index and FSMonitor work well together' '
>   	git init split-index &&
>   	test_when_finished "git -C \"$PWD/split-index\" \
>   		fsmonitor--daemon stop" &&

Thanks
Jeff
