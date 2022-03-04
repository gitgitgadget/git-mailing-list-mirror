Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F801C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 23:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiCDXo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiCDXoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:44:25 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C1124F1D
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:43:37 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE7A517A612;
        Fri,  4 Mar 2022 18:43:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/sWRFMsFdwxgvnscswS2p7KwHU/D8Vrdy+kvEC
        KCMeE=; b=hwJawyT8VoQh17Q/AZrZ4oRPWqdtOnltGbS4dc4RiCebDXmFcRe+i6
        5N0SpUts6kCmBDyO54JJJJQvm9ybsDCulv3WJmHyp2xIutnsSDuGqvkCnwuBj3B6
        OpjYTKtYZVGVLV0qOdVQ42Of6TfLwBbW1sFGPAdjhRLkvZjrFhJ2s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D66BE17A611;
        Fri,  4 Mar 2022 18:43:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E7EA17A60B;
        Fri,  4 Mar 2022 18:43:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:43:33 -0800
In-Reply-To: <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 23 Feb 2022
        17:55:11 +0000")
Message-ID: <xmqqzgm5wafu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7CF845C-9C14-11EC-904F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> In order to have a valid pack-file after unbundling a bundle that has
> the 'filter' capability, we need to generate a .promisor file. The
> bundle does not promise _where_ the objects can be found, but we can
> expect that these bundles will be unbundled in repositories with
> appropriate promisor remotes that can find those missing objects.

That sounds like a lot of wishful thinking, but I do not think of a
better way to phrase the idea.  Taking a bundle out of a repository
and unbundling it elsewhere is "git fetch" that could be done to
send objects from the former to the latter repository, so I am OK
with the assumption that the original repository will stay available
for such users who took its contents over sneaker-net instead of
over the wire.

> Use the 'git index-pack --promisor=<message>' option to create this
> .promisor file. Add "from-bundle" as the message to help anyone diagnose
> issues with these promisor packs.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle.c               | 4 ++++
>  t/t6020-bundle-misc.sh | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/bundle.c b/bundle.c
> index e284ef63062..3d97de40ef0 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -631,6 +631,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
>  	struct child_process ip = CHILD_PROCESS_INIT;
>  	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
>  
> +	/* If there is a filter, then we need to create the promisor pack. */
> +	if (header->filter)
> +		strvec_push(&ip.args, "--promisor=from-bundle");
> +
>  	if (extra_index_pack_args) {
>  		strvec_pushv(&ip.args, extra_index_pack_args->v);
>  		strvec_clear(extra_index_pack_args);
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index 39cfefafb65..344af34db1e 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -513,7 +513,13 @@ do
>  		The bundle uses this filter: $filter
>  		The bundle records a complete history.
>  		EOF
> -		test_cmp expect actual
> +		test_cmp expect actual &&
> +
> +		# This creates the first pack-file in the
> +		# .git/objects/pack directory. Look for a .promisor.
> +		git bundle unbundle partial.bdl &&
> +		ls .git/objects/pack/pack-*.promisor >promisor &&
> +		test_line_count = 1 promisor

OK.  Do we also want to inspect the contents of the resulting
repository to make sure that the bundle had the right contents?

One idea to do so would probably be

 - prepare a test repository (you already have it)
 - prepare a partial.bdl (you already do this)

 - clone the test repository into a new repository, with the same
   filter
 - create an empty repository, unbundle the partial.bdl

 - take "for-each-ref" and list of objects available in these two
   "partial copies" from the test repository, and compare

