Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4670BC636D7
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 08:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjBMIgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 03:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBMIgW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 03:36:22 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772FBCC1F
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 00:36:21 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k23-20020a63ff17000000b004fbb61bfcfeso568143pgi.21
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 00:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8bEavaSgWf5DFT6LFhIE+8Yqzsuq+7vmFnjzBs70b4=;
        b=dVNiX0yKLRWAYyGyQBJqc7w/nJuRVBqkaNYqh9vI/lbg1ZMzCyXOy/aag9fDRmLcxY
         rNEH21jMsWqgFq2kl7f+bAwHnZ+98DsDc9kHn1rqLQE3/ZvLLn9H8eMtzexLI+Q4wMZg
         5ATnRQCIRzgN35FaWxDka7II7hQb7UtzNtY8ud3ss7bqMvyxZa5E2/B6y78mA3ojRzEK
         50WgvgsExEksbFIU4u8ZKyFGtKXhClMBKP6phoayFH7DBhmzmUcetUJSZukg0hA1o7el
         6sex38KisIAMwnRJYnJ35yf4rJnx1WLX9JUPlU3CsQzxjqVDAx7p7b1McZRRluaoLoc3
         i3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8bEavaSgWf5DFT6LFhIE+8Yqzsuq+7vmFnjzBs70b4=;
        b=AHr8G/4La2sUOU/erQ1V9xiLwEIhjKA7htt3S8yt8pbFbiQtWZh2GXWGQ5TJlES/fI
         ghjBd0JQt6zC3906pAEz3ftou2sjOeDvg167tvjG9et1hF76EgpmwaSG5ztwafJVONhE
         7W0GXE6+fjgjeGOhHn9R4Ul1YFaOJS4F7+NjbGeINLtjnT3O2nV4PjHE6WJ7fWv/Edul
         Mw/qUyycC7q4LxEpvldB/QU0XH5D6JbDk03Sg87+sYq93/1GTbHBKVrighPRHrxkWDqx
         HbcveC/LbCyhqIcXQezU97KYae3YVJUzAtSNpxCv9+IMJo/1L/L2/9KQ8oWSqdQ4neBR
         ENpw==
X-Gm-Message-State: AO0yUKVGw5lbtSqFRw8ndHDDcN0Z+9Pa2fyt/EVSrp6IIXknBo5QSeMD
        nCuGZ8fzCBCxOxXeQ3EKAYO12K9VoAhSuQ==
X-Google-Smtp-Source: AK7set+aPZTShnBpYZ1ur+EmHXd4UkTgkjparXHN+1kKnUllDoG8ko6Qnj52GtEWjjhB8zLJFBUR/3G4sn4xEQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a62:53c6:0:b0:58d:a84a:190b with SMTP id
 h189-20020a6253c6000000b0058da84a190bmr4801693pfb.48.1676277380929; Mon, 13
 Feb 2023 00:36:20 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:36:18 +0800
In-Reply-To: <20230209000212.1892457-7-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com> <20230209000212.1892457-7-calvinwan@google.com>
Message-ID: <kl6lh6vqarnh.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v8 6/6] diff-lib: parallelize run_diff_files for submodules
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> @@ -244,6 +266,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			newmode = ce->ce_mode;
>  		} else {
>  			struct stat st;
> +			unsigned ignore_untracked = 0;
> +			int defer_submodule_status = 1;
>  
>  			changed = check_removed(istate, ce, &st);
>  			if (changed) {

Previously [1] it wasn't entirely clear whether we intended to always
parallelize submodule diffing, but now it seems that we always try to
parallelize. In essence, this means that we don't have a serial
implementation any more, but maybe that's okay.

[1] https://lore.kernel.org/git/kl6lilgtveoe.fsf@chooglen-macbookpro.roam.corp.google.com/

> @@ -265,14 +289,53 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			}
>  
>  			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
> -							    ce_option, &dirty_submodule);
> +							    ce_option, &dirty_submodule,
> +							    &defer_submodule_status,
> +							    &ignore_untracked);

Here we get the 'changed' bit of the submodule. Because we always defer,
we never call is_submodule_modified() inside
match_stat_with_submodule() and as such, we never set "dirty_submodule"
here. If so, could we remove the variable altogether?

>  			newmode = ce_mode_from_stat(ce, st.st_mode);
> +			if (defer_submodule_status) {
> +				struct submodule_status_util tmp = {
> +					.changed = changed,
> +					.dirty_submodule = 0,
> +					.ignore_untracked = ignore_untracked,
> +					.newmode = newmode,
> +					.ce = ce,
> +					.path = ce->name,
> +				};
> +				struct string_list_item *item;
> +
> +				item = string_list_append(&submodules, ce->name);
> +				item->util = xmalloc(sizeof(tmp));
> +				memcpy(item->util, &tmp, sizeof(tmp));
> +				continue;
> +			}
>  		}
>  
>  		if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
>  				       changed, istate, ce))

I'm surprised to see that we still call "diff_change_helper()" even
though we've 'deferred' the submodule diff, especially since "changed"
is set and "dirty_submodule" is unset. Even if this is safe, I think we
shouldn't do this because...

> +	if (submodules.nr) {
> +		unsigned long parallel_jobs;
> +		struct string_list_item *item;
> +
> +		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
> +			parallel_jobs = 1;
> +		else if (!parallel_jobs)
> +			parallel_jobs = online_cpus();
> +
> +		if (get_submodules_status(&submodules, parallel_jobs))
> +			die(_("submodule status failed"));
> +		for_each_string_list_item(item, &submodules) {
> +			struct submodule_status_util *util = item->util;
> +
> +			if (diff_change_helper(&revs->diffopt, util->newmode,
> +				       util->dirty_submodule, util->changed,
> +				       istate, util->ce))

Here we call "diff_change_helper()" again on the deferred submodule, but
now with the "dirty_submodule" value we expected. At best this is
wasteful, but at worst this is possibly wrong.

For good measure, I applied this patch to see if we needed either
"dirty_submodule" or the second "diff_change_helper()" call; our
test suite still passes after I remove both of them.

  diff --git a/diff-lib.c b/diff-lib.c
  index 2dde575ec6..21adcc7fd6 100644
  --- a/diff-lib.c
  +++ b/diff-lib.c
  @@ -156,6 +156,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
      struct cache_entry *ce = istate->cache[i];
      int changed;
      unsigned dirty_submodule = 0;
  +		int defer_submodule_status = 1;

      if (diff_can_quit_early(&revs->diffopt))
        break;
  @@ -267,7 +268,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
      } else {
        struct stat st;
        unsigned ignore_untracked = 0;
  -			int defer_submodule_status = 1;

        changed = check_removed(istate, ce, &st);
        if (changed) {
  @@ -311,9 +311,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
        }
      }

  -		if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
  -				       changed, istate, ce))
  -			continue;
  +		if (!defer_submodule_status)
  +			diff_change_helper(&revs->diffopt, newmode, 0,
  +					   changed, istate, ce);
    }
    if (submodules.nr) {
      unsigned long parallel_jobs;


> +static void parse_status_porcelain_strbuf(struct strbuf *buf,
> +				   unsigned *dirty_submodule,
> +				   int ignore_untracked)
> +{
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +
> +	string_list_split(&list, buf->buf, '\n', -1);
> +
> +	for_each_string_list_item(item, &list) {
> +		if (parse_status_porcelain(item->string,
> +					   strlen(item->string),
> +					   dirty_submodule,
> +					   ignore_untracked))
> +			break;
> +	}
> +	string_list_clear(&list, 0);
> +}

Given that this function only has one caller, is quite simple, and isn't
actually a strbuf version of "parse_status_porcelain()" (it's actually a
multiline version that also happens to accept a strbuf), I think this
might be better inlined.

> +test_expect_success 'status in superproject with submodules (parallel)' '
> +	git -C super status --porcelain >output &&
> +	git -C super -c submodule.diffJobs=8 status --porcelain >output_parallel &&
> +	diff output output_parallel
> +'
> +
>  test_done

When I first suggested this test, I thought that we would sometimes
defer submodule status and sometimes not, so this would be a good way to
check between both modes. Now this is less useful, since this is only
checking that parallelism > 1 doesn't affect the output, but it's still
a useful reasonableness check IMO. Thanks.
