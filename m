Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FB9C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 06:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiHCGbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiHCGbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 02:31:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADA714037
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 23:31:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CC5E148716;
        Wed,  3 Aug 2022 02:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A4ipBSaDRgSBhPpusWqxrOBgPHWTJVPyYi/Z6W
        1TM28=; b=vHCGRuUnQ3Wypew/UED2Cg3lIL7hAk3kyDcdqMMtv5IgUqLQqe5ED1
        CIMd5Dhh2A10NwfOfj7RHpp6fxensiQAnz6gPYYtvATMJyfnCvj+Pvcql4ZPU8l7
        GznAMDfHn2PxNJTToOTMR5gfWK1nqcdKfHjK4guL14Qj/3nW0iMdw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45352148715;
        Wed,  3 Aug 2022 02:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 812DE148714;
        Wed,  3 Aug 2022 02:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 05/10] log-tree: use ref_namespaces instead of
 if/else-if
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <53b15a0b7932f892505d07a509909b62c473037e.1659122979.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 23:31:44 -0700
In-Reply-To: <53b15a0b7932f892505d07a509909b62c473037e.1659122979.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 29 Jul 2022
        19:29:34 +0000")
Message-ID: <xmqqv8r9dei7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2A3E29E-12F5-11ED-B611-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The add_ref_decoration() method uses an if/else-if chain to determine if
> a ref matches a known ref namespace that has a special decoration
> category. That decoration type is later used to assign a color when
> writing to stdout.
>
> The newly-added ref_namespaces array contains all namespaces, along
> with information about their decoration type. Check this array instead
> of this if/else-if chain. This reduces our dependency on string literals
> being embedded in the decoration logic.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  log-tree.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index bb80f1a94d2..6075bdd334e 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -137,6 +137,7 @@ static int ref_filter_match(const char *refname,
>  static int add_ref_decoration(const char *refname, const struct object_id *oid,
>  			      int flags, void *cb_data)
>  {
> +	int i;
>  	struct object *obj;
>  	enum object_type objtype;
>  	enum decoration_type deco_type = DECORATION_NONE;
> @@ -167,16 +168,21 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>  		return 0;
>  	obj = lookup_object_by_type(the_repository, oid, objtype);
>  
> -	if (starts_with(refname, "refs/heads/"))
> -		deco_type = DECORATION_REF_LOCAL;
> -	else if (starts_with(refname, "refs/remotes/"))
> -		deco_type = DECORATION_REF_REMOTE;
> -	else if (starts_with(refname, "refs/tags/"))
> -		deco_type = DECORATION_REF_TAG;
> -	else if (!strcmp(refname, "refs/stash"))
> -		deco_type = DECORATION_REF_STASH;
> -	else if (!strcmp(refname, "HEAD"))
> -		deco_type = DECORATION_REF_HEAD;
> +	for (i = 0; i < NAMESPACE__COUNT; i++) {
> +		struct ref_namespace_info *info = &ref_namespaces[i];
> +
> +		if (!info->decoration)
> +			continue;
> +		if (info->exact) {
> +			if (!strcmp(refname, info->ref)) {
> +				deco_type = info->decoration;
> +				break;
> +			}
> +		} else if (starts_with(refname, info->ref)) {
> +			deco_type = info->decoration;
> +			break;
> +		}
> +	}

Very nice.  The double-dash in the NAMESPACE__COUNT constant somehow
looks strange.  As we scan through ref_namespace[] array densely,

	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++)
		...

without having to use the constant would probably be more in line
with the way how the rest of the codebase works.
