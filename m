Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFE5C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355920AbiCYO6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbiCYO6k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:58:40 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279352E42
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:57:06 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id e4so8411609oif.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sdiptOg0e1TNnbVYA0tfmxcNodYmEw74orXdH0b5dvo=;
        b=FufMLwbkrtupL9m4A14LXja55XCLHJuX0bjUwF2Iu55B7i/miLQVbSQ2dt+xd7rQWQ
         wm2GZMTZanQkjpEQiYGn7zOo5xo103LHuGvE5AjsRaF8K7U6pPv4WKpNp+0O9SYtl9W4
         b709yqXUbfiGdYJYmGmEqLg9tNnVddcMcLk+GvvQ9guti2DTzmaWAcTaPnM6+/lLBAZ0
         Q+TrrvwJtq6/PqtzZEkQJXec2bjHZ1bRoi2m4fAc7F923E6OjYU6RV1Wm8mwwbexYo48
         XeoEZQNs2nqNQrM7clz4rC2kGOqPckRESZSNhW2UBLXyYML5SnaOXWPJFu3UoSUwXWHH
         lyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sdiptOg0e1TNnbVYA0tfmxcNodYmEw74orXdH0b5dvo=;
        b=ZQm+r2AADLRqZg7F/lFAH484bN/CGZCTJQN6jg9254Fq2821OTafiQOZM6FG3ifyA2
         ij9TvG7zt65tnbLj6rXgqncTCwGIQeRQVtc9ssMcdk984fIoSUDbrNbC/iHh5jmZXHhl
         zwQouSkhHvK+ksIhn1CF0bOpFYunX2lD84k88D17QScJSZ902c8GgCxcGStWzlUV/Dd0
         99JG7CWymM6Q/BMgWwgGDYnY20kssqd8n65izGXn8vRW89Z6fQcmtynyuT+pgLJnyTk3
         KIpuXl3lpLsOeIyxqkUq8rgT0abq0tPYczHTiaCKLKrHUTxLpXax2O2alz0bLMroaNK3
         K01w==
X-Gm-Message-State: AOAM530QuC4klrEcoPITKBoMyhS5Hh+rQ8S4HU3FZ5oXJeHdNw0P2fcg
        MU5YBKKcc3/H5i4jHwZwtfcyZm96NcpA
X-Google-Smtp-Source: ABdhPJzDKytvwYjxDt4bXU7oaxg9fv++mnzM95tEu7CRLrYdgy7A6OWP5i8ZwpLY64guxZhIKYVVhg==
X-Received: by 2002:a05:6808:64b:b0:2ef:73b4:a14 with SMTP id z11-20020a056808064b00b002ef73b40a14mr5578872oih.120.1648220225498;
        Fri, 25 Mar 2022 07:57:05 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q6-20020a9d6646000000b005cd9d37df92sm2684075otm.5.2022.03.25.07.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 07:57:05 -0700 (PDT)
Message-ID: <d71fa968-be75-f4ad-ea6c-644f9d2b52d9@github.com>
Date:   Fri, 25 Mar 2022 10:57:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] pack-objects: lazily set up "struct rev_info", don't leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2022 10:25 AM, Ævar Arnfjörð Bjarmason wrote:
> In the preceding [1] (pack-objects: move revs out of
> get_object_list(), 2022-03-22) the "repo_init_revisions()" was moved
> to cmd_pack_objects() so that it unconditionally took place for all
> invocations of "git pack-objects".
> 
> We'd thus start leaking memory, which is easily reproduced in
> e.g. git.git by feeding e83c5163316 (Initial revision of "git", the
> information manager from hell, 2005-04-07) to "git pack-objects";
> 
>     $ echo e83c5163316f89bfbde7d9ab23ca2e25604af290 | ./git pack-objects initial
>     [...]
> 	==19130==ERROR: LeakSanitizer: detected memory leaks
> 
> 	Direct leak of 7120 byte(s) in 1 object(s) allocated from:
> 	    #0 0x455308 in __interceptor_malloc (/home/avar/g/git/git+0x455308)
> 	    #1 0x75b399 in do_xmalloc /home/avar/g/git/wrapper.c:41:8
> 	    #2 0x75b356 in xmalloc /home/avar/g/git/wrapper.c:62:9
> 	    #3 0x5d7609 in prep_parse_options /home/avar/g/git/diff.c:5647:2
> 	    #4 0x5d415a in repo_diff_setup /home/avar/g/git/diff.c:4621:2
> 	    #5 0x6dffbb in repo_init_revisions /home/avar/g/git/revision.c:1853:2
> 	    #6 0x4f599d in cmd_pack_objects /home/avar/g/git/builtin/pack-objects.c:3980:2
> 	    #7 0x4592ca in run_builtin /home/avar/g/git/git.c:465:11
> 	    #8 0x457d81 in handle_builtin /home/avar/g/git/git.c:718:3
> 	    #9 0x458ca5 in run_argv /home/avar/g/git/git.c:785:4
> 	    #10 0x457b40 in cmd_main /home/avar/g/git/git.c:916:19
> 	    #11 0x562259 in main /home/avar/g/git/common-main.c:56:11
> 	    #12 0x7fce792ac7ec in __libc_start_main csu/../csu/libc-start.c:332:16
> 	    #13 0x4300f9 in _start (/home/avar/g/git/git+0x4300f9)
> 
> 	SUMMARY: LeakSanitizer: 7120 byte(s) leaked in 1 allocation(s).
> 	Aborted
> 
> Narrowly fixing that commit would have been easy, just add call
> repo_init_revisions() right before get_object_list(), which is
> effectively what was done before that commit.
> 
> But an unstated constraint when setting it up early is that it was
> needed for the subsequent [2] (pack-objects: parse --filter directly
> into revs.filter, 2022-03-22), i.e. we might have a --filter
> command-line option, and need to either have the "struct rev_info"
> setup when we encounter that option, or later.
> 
> Let's just change the control flow so that we'll instead set up the
> "struct rev_info" only when we need it. Doing so leads to a bit more
> verbosity, but it's a lot clearer what we're doing and why.

This makes sense.

> We could furthermore combine the two get_object_list() invocations
> here by having repo_init_revisions() invoked on &pfd.revs, but I think
> clearly separating the two makes the flow clearer. Likewise
> redundantly but explicitly (i.e. redundant v.s. a "{ 0 }") "0" to
> "have_revs" early in cmd_pack_objects().

I disagree, especially when you later want to make sure we free
the data from revs using your release_revisions().

> This does add the future constraint to opt_parse_list_objects_filter()
> that we'll need to adjust this wrapper code if it looks at any other
> value of the "struct option" than the "value" member.

So we are coupling ourselves to the implementation of this method.

> But that regression should be relatively easy to spot. I'm
> intentionally not initializing the "struct wrap" with e.g. "{ 0 }" so
> that various memory sanity checkers would spot that, we just
> initialize the "value" in po_filter_cb(). By doing this e.g. we'll die
> on e.g. this test if we were to use another member of "opt" in
> opt_parse_list_objects_filter()>

So you are using uninitialized memory as a way to discover any
necessary changes to that coupling. I'm not sure this is super-safe
because we don't necessarily run memory checkers during CI builds.

I'd rather have a consistently initialized chunk of data that would
behave predictably (and hopefully we'd discover it is behaving
incorrectly with that predictable behavior).


> While we're at it add parentheses around the arguments to the OPT_*
> macros in in list-objects-filter-options.h, as we need to change those
> lines anyway. It doesn't matter in this case, but is good general
> practice.
> 
> 1. https://lore.kernel.org/git/619b757d98465dbc4995bdc11a5282fbfcbd3daa.1647970119.git.gitgitgadget@gmail.com
> 2. https://lore.kernel.org/git/97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> This is on top of ds/partial-bundle-more: I thought the fix for this
> new leak was involved enough to propose it as a commit-on-top rather
> than a fixup for a re-roll, especially since aside from the newly
> leaked memory I don't think ds/partial-bundle-more is breaking
> anything by doing that.
> 
> Except that is, interacting badly with my release_revisions() series
> in "seen", which currently causes the "linux-leaks" job to fail there:
> https://lore.kernel.org/git/cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com/
> 
> This is proper fix for the issue the interaction with my topic
> revealed (not caused, we just started testing for this leak there),
> i.e. it obsoletes the suggestion of adding an UNLEAK() there.
> 
>  builtin/pack-objects.c        | 30 +++++++++++++++++++++++++-----
>  list-objects-filter-options.h |  8 +++++---
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index d39f668ad56..735080a4a95 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3857,6 +3857,23 @@ static int option_parse_unpack_unreachable(const struct option *opt,
>  	return 0;
>  }
>  
> +struct po_filter_data {
> +	unsigned have_revs:1;
> +	struct rev_info revs;
> +};
> +
> +static int po_filter_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	struct po_filter_data *data = opt->value;
> +	struct option wrap; /* don't initialize! */
> +
> +	repo_init_revisions(the_repository, &data->revs, NULL);
> +	wrap.value = &data->revs.filter;
> +	data->have_revs = 1;
> +
> +	return opt_parse_list_objects_filter(&wrap, arg, unset);
> +}

The coupling here is unfortunate, but unavoidable. The future-proof
way to do it would be to modify opt->value and pass the rest of its
members as-is, but it's marked const so that's not an option.

One way to help make this coupling more obvious would be to move
this method into list-filter-options.c so we can have their
implementations adjacent and even refer to them.

Here is a potential version that looks like that:

--- >8 ---

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index f02d8df142..55c7131814 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -281,6 +281,10 @@ void parse_list_objects_filter(
 		die("%s", errbuf.buf);
 }
 
+/*
+ * If you change this to use any member in 'opt' other than 'value',
+ * then be sure to update opt_parse_list_objects_filter_in_revs().
+ */
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
@@ -293,6 +297,18 @@ int opt_parse_list_objects_filter(const struct option *opt,
 	return 0;
 }
 
+int opt_parse_list_objects_filter_in_revs(const struct option *opt,
+					  const char *arg, int unset)
+{
+	struct rev_info_maybe_empty *ri = opt->value;
+	struct option wrap = { .value = &ri->revs.filter };
+
+	repo_init_revisions(the_repository, &ri->revs, NULL);
+	ri->has_revs = 1;
+
+	return opt_parse_list_objects_filter(&wrap, arg, unset);
+}
+
 const char *list_objects_filter_spec(struct list_objects_filter_options *filter)
 {
 	if (!filter->filter_spec.nr)
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 90e4bc9625..cf8b710a76 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -106,6 +106,8 @@ void parse_list_objects_filter(
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
+int opt_parse_list_objects_filter_in_revs(const struct option *opt,
+					  const char *arg, int unset);
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
 	OPT_CALLBACK(0, "filter", fo, N_("args"), \
diff --git a/revision.h b/revision.h
index 5bc59c7bfe..95aa3ee891 100644
--- a/revision.h
+++ b/revision.h
@@ -329,6 +329,11 @@ struct rev_info {
 	struct tmp_objdir *remerge_objdir;
 };
 
+struct rev_info_maybe_empty {
+	int has_revs;
+	struct rev_info revs;
+};
+
 int ref_excluded(struct string_list *, const char *path);
 void clear_ref_exclusion(struct string_list **);
 void add_ref_exclusion(struct string_list **, const char *exclude);

--- >8 ---


> +	} else if (pfd.have_revs) {
> +		get_object_list(&pfd.revs, rp.nr, rp.v);
>  	} else {
> +		struct rev_info revs;
> +
> +		repo_init_revisions(the_repository, &revs, NULL);
>  		get_object_list(&revs, rp.nr, rp.v);
>  	}

Here, I think it would be better to have

	else {
		if (!pfd.have_revs) {
			repo_init_revisions(the_repository, &pfd.revs, NULL);
			pfd.have_revs = 1;
		}
		get_object_list(&pfd.revs, rp.nr, rp.v);
	}

and then later you can add

	if (pfd.have_revs)
		release_revisions(&pfd.revs);

to clear the memory in exactly one place.

Thanks,
-Stolee
