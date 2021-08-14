Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0F6C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 18:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7703E60F51
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 18:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbhHNSGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 14:06:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58914 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbhHNSGP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 14:06:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E87314DA1D;
        Sat, 14 Aug 2021 14:05:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ph2xaOhu3t55zpgtMCj1kN1tKkDMcP2VNS67Z
        a9QGM=; b=suvyUsj1CBnFm8D6+vbQcXdKAep9tONm+OCijSnGXePpgwIWFslhcL
        cqGgniQpF1vEUMLmBrLGpsjvn77pJ1zPqJtfM+SsNDDvs9Y7ZP4xyquL/jrxxjWU
        RvRsMFPYbBEmwSN4w14U788w6UtKcWdfNw7sK37kUlSG5rev4i9NM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 666BE14DA1C;
        Sat, 14 Aug 2021 14:05:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F39314DA19;
        Sat, 14 Aug 2021 14:05:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Mahi Kolla <mkolla2@illinois.edu>
Subject: Re: [PATCH v6] clone: set submodule.recurse=true if
 submodule.stickyRecursiveClone enabled
References: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
        <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com>
Date:   Sat, 14 Aug 2021 11:05:41 -0700
In-Reply-To: <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com> (Mahi
        Kolla via GitGitGadget's message of "Sat, 14 Aug 2021 01:09:56 +0000")
Message-ID: <xmqqy293ucju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E07ADB6-FD2A-11EB-A346-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 66fe66679c8..a08d9012243 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -986,6 +986,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	struct remote *remote;
>  	int err = 0, complete_refs_before_fetch = 1;
>  	int submodule_progress;
> +	int sticky_recursive_clone;

This variable does not have to be in such a wider scope, I think.


>  	struct transport_ls_refs_options transport_ls_refs_options =
>  		TRANSPORT_LS_REFS_OPTIONS_INIT;
> @@ -1130,6 +1131,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  					   strbuf_detach(&sb, NULL));
>  		}

Just in this scope, where "struct string_list_item *item" and
"struct strbuf sb" are declared, is where an extra int variable,
which receives the configuration value, needs to exist.

Also, for a variable that is used only to receive value from
git_config_get_bool(), immediately to be used and then never used
again, we do not need such a long and descriptive name.

> +		if (!git_config_get_bool("submodule.stickyRecursiveClone", &sticky_recursive_clone)
> +		    && sticky_recursive_clone) {
> +		    string_list_append(&option_config, "submodule.recurse=true");
> +		}

We do not need {} around a single statement block.

Taken together, perhaps like the attached.

I'll queue the patch posted as-is for now.

Thanks.

diff --git c/builtin/clone.c w/builtin/clone.c
index 66fe66679c..c4e02d2f78 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -1114,6 +1114,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_recurse_submodules.nr > 0) {
 		struct string_list_item *item;
 		struct strbuf sb = STRBUF_INIT;
+		int val;
 
 		/* remove duplicates */
 		string_list_sort(&option_recurse_submodules);
@@ -1130,6 +1131,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					   strbuf_detach(&sb, NULL));
 		}
 
+		if (!git_config_get_bool("submodule.stickyRecursiveClone", &val) &&
+		    val)
+		    string_list_append(&option_config, "submodule.recurse=true");
+
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
 			die(_("clone --recursive is not compatible with "
