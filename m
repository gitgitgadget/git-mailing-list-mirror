Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60BEC6369E
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8AD221FD
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgLCA7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 19:59:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55906 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgLCA7f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 19:59:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52770F0324;
        Wed,  2 Dec 2020 19:58:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XeQzeQ9VdT48mL1UQ4hhn9hCQdc=; b=Mq+wKq
        OiVi5W6hwNJxwr+e0pitemkVGYFhElZ7grg37nZN2dV/4pt5W43cKEwlkFwLd+Pz
        8iMm/jQo0ymcMxjECyi20R2aB52TqZAYQ4ATmXmMVVJA2oGLahrV2mzCDPjfn8YQ
        RiWTb46rbJ5kpc1/14UMpxZ+2MkKo0un1NbYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qcjqcApeE56RS+SWCuhgZtYKPjoVVsR7
        dzZayschRTQhSfWXsAixASGbVFURJ5SjT/AeeXBGipi/HQxt3zg3RYCbAqnFV0+h
        EkjQ8krZr/MrxwchE6+HPKXjqFNFrXRBmbbcwXj/zFbbKBXl6Rz7C/+lB5EfQX6u
        j1jZsEwhatM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B696F0323;
        Wed,  2 Dec 2020 19:58:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 814B9F031D;
        Wed,  2 Dec 2020 19:58:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 05/27] revision: move diff merges functions to its
 own diff-merges.c
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-6-sorganov@gmail.com>
Date:   Wed, 02 Dec 2020 16:58:48 -0800
In-Reply-To: <20201108213838.4880-6-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 9 Nov 2020 00:38:16 +0300")
Message-ID: <xmqqa6uvk8mv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4DBF3A2-3502-11EB-B5E6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> diff --git a/diff-merges.h b/diff-merges.h
> new file mode 100644
> index 000000000000..e0cca3d935d3
> --- /dev/null
> +++ b/diff-merges.h
> @@ -0,0 +1,12 @@
> +#ifndef DIFF_MERGES_H
> +#define DIFF_MERGES_H

Describe what "diff-merges" module is about in a comment here.

This matters because in 07/27 the log message complains that the
first-parent traversal option is checked in the module but it is out
of place.  Without defining what the "module" is about, the readers
would have a hard time agreeing with the justification.

My guess is that this is about deciding how a merge commit is shown
in 'log -p' and 'show' output, comparing the commit with its
parent(s) in patch output.  With that explained, it may make sense
for 07/27 to complain that --first-parent that is primarily a
traversal option does also affect how a merge is shown (I do not
necessarily agree with the complaint, though)

> +
> +struct rev_info;
> +
> +void init_diff_merge_revs(struct rev_info *revs);
> +int parse_diff_merge_opts(struct rev_info *revs, const char **argv);
> +void setup_diff_merges_revs(struct rev_info *revs);
> +void rev_diff_merges_default_to_dense_combined(struct rev_info *revs);
> +void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
> +
> +#endif
> diff --git a/revision.c b/revision.c
> index ce90c2991657..4bc14a08a624 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -5,6 +5,7 @@
>  #include "tree.h"
>  #include "commit.h"
>  #include "diff.h"
> +#include "diff-merges.h"
>  #include "refs.h"
>  #include "revision.h"
>  #include "repository.h"
> @@ -1805,8 +1806,6 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
>  	return 1;
>  }
>  
> -static void init_diff_merge_revs(struct rev_info *revs);
> -
>  void repo_init_revisions(struct repository *r,
>  			 struct rev_info *revs,
>  			 const char *prefix)
> @@ -2155,75 +2154,6 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
>  	add_grep(revs, pattern, GREP_PATTERN_BODY);
>  }
>  
> -static void init_diff_merge_revs(struct rev_info *revs) {
> -	revs->ignore_merges = -1;
> -}
> -
> -static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
> -	int argcount;
> -	const char *optarg;
> -	const char *arg = argv[0];
> -
> -	if (!strcmp(arg, "-m")) {
> -		/*
> -		 * To "diff-index", "-m" means "match missing", and to the "log"
> -		 * family of commands, it means "show full diff for merges". Set
> -		 * both fields appropriately.
> -		 */
> -		revs->ignore_merges = 0;
> -		revs->match_missing = 1;
> -	} else if (!strcmp(arg, "-c")) {
> -		revs->diff = 1;
> -		revs->dense_combined_merges = 0;
> -		revs->combine_merges = 1;
> -	} else if (!strcmp(arg, "--cc")) {
> -		revs->diff = 1;
> -		revs->dense_combined_merges = 1;
> -		revs->combine_merges = 1;
> -	} else if (!strcmp(arg, "--no-diff-merges")) {
> -		revs->ignore_merges = 1;
> -	} else if (!strcmp(arg, "--combined-all-paths")) {
> -		revs->diff = 1;
> -		revs->combined_all_paths = 1;
> -	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
> -		if (!strcmp(optarg, "off")) {
> -			revs->ignore_merges = 1;
> -		} else {
> -			die(_("unknown value for --diff-merges: %s"), optarg);
> -		}
> -	} else
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static void setup_diff_merges_revs(struct rev_info *revs)
> -{
> -	if (revs->combine_merges && revs->ignore_merges < 0)
> -		revs->ignore_merges = 0;
> -	if (revs->ignore_merges < 0)
> -		revs->ignore_merges = 1;
> -	if (revs->combined_all_paths && !revs->combine_merges)
> -		die("--combined-all-paths makes no sense without -c or --cc");
> -}
> -
> -void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs) {
> -	if (revs->first_parent_only && revs->ignore_merges < 0)
> -		revs->ignore_merges = 0;
> -}
> -
> -void rev_diff_merges_default_to_dense_combined(struct rev_info *revs) {
> -	if (revs->ignore_merges < 0) {
> -		/* There was no "-m" variant on the command line */
> -		revs->ignore_merges = 0;
> -		if (!revs->first_parent_only && !revs->combine_merges) {
> -			/* No "--first-parent", "-c", or "--cc" */
> -			revs->combine_merges = 1;
> -			revs->dense_combined_merges = 1;
> -		}
> -	}
> -}
> -
>  static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
>  			       int *unkc, const char **unkv,
>  			       const struct setup_revision_opt* opt)
> diff --git a/revision.h b/revision.h
> index 3dd0229f4edc..f6bf860d19e5 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -456,7 +456,4 @@ int rewrite_parents(struct rev_info *revs,
>   */
>  struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
>  
> -void rev_diff_merges_default_to_dense_combined(struct rev_info *revs);
> -void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
> -
>  #endif
