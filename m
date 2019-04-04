Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E6820248
	for <e@80x24.org>; Thu,  4 Apr 2019 15:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfDDPni (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 11:43:38 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34257
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727333AbfDDPni (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Apr 2019 11:43:38 -0400
X-IronPort-AV: E=Sophos;i="5.60,308,1549926000"; 
   d="scan'208";a="301835232"
Received: from nautfst12.univ-lyon1.fr (HELO moylip) ([134.214.142.79])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2019 17:43:34 +0200
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "BERBEZIER NATHAN p1601409" <nathan.berbezier@etu.univ-lyon1.fr>,
        CHABANNE PABLO p1602176 <pablo.chabanne@etu.univ-lyon1.fr>
Subject: Re: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
References: <d21d42228425408298da9e99b5877ac9@BPMBX2013-01.univ-lyon1.fr>
Date:   Thu, 04 Apr 2019 17:43:34 +0200
In-Reply-To: <d21d42228425408298da9e99b5877ac9@BPMBX2013-01.univ-lyon1.fr>
        (BOMPARD CORENTIN's message of "Thu, 4 Apr 2019 12:22:26 +0000")
Message-ID: <86sguxvkrd.fsf@univ-lyon1.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr> writes:

> Adding the --set-upstream option to git pull/fetch

We usually write commit messages with imperative tone, hence "add", not
"adding".

> +		/*
> +		 * We want to set the current branch config following the 
> +		 * ref_map entry which fetches on FETCH_HEAD

fetches _to_? And period at end of sentence.

> +		 * In case of "git pull <remote> --set-upstream" we
> +		 * 	don't want to set all branches' config.
> +		 * If there is no local ref which points on FETCH_HEAD

Indentation is weird. If you're just writting sentences, just wrap the
text 1 column away from the "*", and to make paragraphs, add blank lines
(containing just "*") between paragraphs.

> +		 * 	we don't set the config for the current branch
> +		 * 	and warn the user.
> +		 * If there is a fetch of more than one branch for example: 
> +		 * 	"git pull <remote> <branch> <branch> --set-upstream"
> +		 *	setting the current branch's config makes no sense.
> +		 * Where we are in case of "git pull <remote> <branch>:<branch>" we
> +		 * 	don't want to set the config for the local branch
> +		 * 	can be improved in the future to set local branch's config.
> +		 */

I'm biaised because we talked about this in real-life, but I find the
explanation unclear. I'd write stg like

/*
 * We're setting the upstream configuration for the current branch. The
 * relevant upstream is the fetched branch that is meant to be merged with
 * the current one, i.e. the one fetched to FETCH_HEAD.
 * 
 * When there are several such branches, consider the request ambiguous and
 * err on the safe side by doing nothing and just emit a warning.
 */

I think the discussion about the various use-case that may lead to
different cases (0, 1 or >1 branches fetched to FETCH_HEAD) is not
needed here, but can be relevant comments in the tests.

> +		for (rm = ref_map; rm; rm = rm->next) {
> +			fprintf(stderr, "\n -%s", rm->name);
> +			if (rm->peer_ref) {
> +				fprintf(stderr, " -> %s", rm->peer_ref->name);
> +			} else {
> +				if (target) {
> +					fprintf(stderr, " -> FETCH_HEAD\n");
> +					warning(_("Multiple FETCH_HEAD"));

Is this a debug statement or a real warning? In the later case, it
should be made clearer to the user.

> +					target = NULL;
> +					break;
> +				} else {
> +					target = rm;

This is the branch you're fetching from, right? If so, "target" is a
misleading name. Perhaps source_ref?

> +					fprintf(stderr, " -> FETCH_HEAD");
> +				}
> +			}
> +		}
> +		fprintf(stderr, "\n\n");
> +		if (target) {
> +			if (!strcmp(ref_map->name, "HEAD") ||
> +					starts_with(ref_map->name, "refs/heads/")) {

Weird indentation. Perhaps you have a tab-width != 8?

More importantly, shouldn't ref_map->name be target->name here?

> +				install_branch_config(0, branch->name,
> +							 transport->remote->name,
> +							 target->name);
> +			} else if (starts_with(ref_map->name, "refs/remotes/")) {
> +				warning(_("Not setting upstream for a remote remote-tracking branch"));
> +			} else if (starts_with(ref_map->name, "refs/tags/")) {
> +				warning(_("Tag upstream not set"));
> +			} else {
> +				warning(_("Unknown branch type"));
> +			}
> +		} else {
> +			warning(_("Fetching more than one branch. Current branch's upstream not set"));

The warning seems misleading to me: this else branch is executed in many
cases (described in the comment above), not only when there's more than
one branch, right?

> --- /dev/null
> +++ b/t/t5553-set-upstream.sh
> @@ -0,0 +1,141 @@
> +#!/bin/sh
> +
> +test_description='"git fetch/pull --set-upstream" basic tests.
> +
> +'
> +. ./test-lib.sh
> +
> +
> +
> +check_config() {
> +	(echo $2; echo $3) >expect.$1
> +	(git config branch.$1.remote
> +	 git config branch.$1.merge) >actual.$1
> +	test_cmp expect.$1 actual.$1
> +}
> +
> +check_config_empty() {
> +	git config branch.$1.remote >remote.$1
> +	test_must_be_empty remote.$1
> +	git config branch.$1.merge >merge.$1
> +	test_must_be_empty merge.$1
> +}

Broken &&-chain (in both functions, but most importantly in the second,
where the first test_must_be_empty is useless without &&.

> +test_expect_success 'fetch --set-upstream does not set branch other' '

Misleading test name: "set branch" -> "set upstream"? And here it's not
just about "other" but about all branches.

'fetch --set-upstream does not set upstream w/o branch'

?

> +	git checkout master &&
> +	git fetch --set-upstream upstream &&
> +	check_config_empty master &&
> +	check_config_empty other
> +'

> +#test_expect_success 'fetch --set-upstream does not set branch other' '
> +#	git checkout master &&
> +#	git fetch --set-upstream upstream &&
> +#	check_config master upstream refs/heads/master &&
> +#	check_config_empty other
> +#'

Avoid leaving leftovers like this, even in WIP patches, they distract
the reader.

> +test_expect_success 'fetch --set-upstream upstream master sets branch master but not other' '
> +	git fetch --set-upstream upstream master &&
> +	check_config master upstream refs/heads/master &&
> +	check_config_empty other
> +'
> +
> +

Style: you sometimes leave 2 blank lines, sometimes 1 between tests. Try
to be consistent.

> +test_expect_success 'pull --set-upstream upstream other sets branch other' '

Test title and content say the opposite of each other.

> +	git pull --set-upstream upstream other &&
> +	check_config master upstream refs/heads/other &&
> +	check_config_empty other
> +'

> +test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails with the bad url' '
> +	test_must_fail git pull --set-upstream http://nosuchdomain.example.com
> +'

You should check that it doesn't touch the config. That it fails is not
a surprise regardless of the correctness of your code, but the thing to
check is that it does not touch the config before failing.

> +test_expect_success 'pull --set-upstream upstream with more than one branch does nothing' '

Here also, test title and content say different things. Probably you
need to reset the config and use check_config_empty.

> +	git pull --set-upstream upstream master three &&
> +	check_config master upstream HEAD &&
> +	check_config_empty three
> +'

-- 
Matthieu Moy
https://matthieu-moy.fr/
