Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A6BC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiB1QAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiB1QAp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:00:45 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B170922
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:00:06 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A2F0E3F482E;
        Mon, 28 Feb 2022 11:00:05 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 486113F482D;
        Mon, 28 Feb 2022 11:00:05 -0500 (EST)
Subject: Re: [PATCH 07/11] bundle: safely handle --objects option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <1476a9495c53a165e6971afe75205889524fe7ca.1645638911.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <83bfbce4-3c79-031a-5961-429145910409@jeffhostetler.com>
Date:   Mon, 28 Feb 2022 11:00:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1476a9495c53a165e6971afe75205889524fe7ca.1645638911.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/23/22 12:55 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Since 'git bundle' uses setup_revisions() to specify the object walk,
> some options do not make sense to include during the pack-objects child
> process. Further, these options are used for a call to
> traverse_commit_list() which would then require a callback which is
> currently NULL.
> 
> By populating the callback we prevent a segfault in the case of adding
> the --objects flag. This is really a redundant statement because the

Nit: I stumbled over "...because the bundles are constructing..."
Is there a better wording here??

> bundles are constructing a pack-file containing all objects in the
> discovered commit range.
> 
> Adding --objects to a 'git bundle' command might cause a slower command,
> but at least it will not have a hard failure when the user supplies this
> option. We can also disable walking trees and blobs in advance of this
> walk.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   bundle.c               | 10 +++++++++-
>   t/t6020-bundle-misc.sh | 12 ++++++++++++
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/bundle.c b/bundle.c
> index a0bb687b0f4..dc56db9a50a 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -451,6 +451,12 @@ struct bundle_prerequisites_info {
>   	int fd;
>   };
>   
> +
> +static void ignore_object(struct object *obj, const char *v, void *data)
> +{
> +	/* Do nothing. */
> +}
> +
>   static void write_bundle_prerequisites(struct commit *commit, void *data)
>   {
>   	struct bundle_prerequisites_info *bpi = data;
> @@ -544,7 +550,9 @@ int create_bundle(struct repository *r, const char *path,
>   		die("revision walk setup failed");
>   	bpi.fd = bundle_fd;
>   	bpi.pending = &revs_copy.pending;
> -	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
> +
> +	revs.blob_objects = revs.tree_objects = 0;
> +	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
>   	object_array_remove_duplicates(&revs_copy.pending);
>   
>   	/* write bundle refs */
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index b13e8a52a93..6522401617d 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -475,4 +475,16 @@ test_expect_success 'clone from bundle' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'unfiltered bundle with --objects' '
> +	git bundle create all-objects.bdl \
> +		--all --objects &&
> +	git bundle create all.bdl \
> +		--all &&
> +
> +	# Compare the headers of these files.
> +	head -11 all.bdl >expect &&
> +	head -11 all-objects.bdl >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> 
