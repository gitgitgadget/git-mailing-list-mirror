Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF47520380
	for <e@80x24.org>; Mon, 22 Apr 2019 10:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfDVKis (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 06:38:48 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13679
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbfDVKis (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Apr 2019 06:38:48 -0400
X-IronPort-AV: E=Sophos;i="5.60,381,1549926000"; 
   d="scan'208";a="303599272"
Received: from 209.56.68.91.rev.sfr.net (HELO moylip) ([91.68.56.209])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2019 12:38:32 +0200
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "BERBEZIER NATHAN p1601409" <nathan.berbezier@etu.univ-lyon1.fr>,
        CHABANNE PABLO p1602176 <pablo.chabanne@etu.univ-lyon1.fr>
Subject: Re: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
In-Reply-To: <f601baa2c2a04ddea4ba32ab25d0dd21@BPMBX2013-01.univ-lyon1.fr>
        (BOMPARD CORENTIN's message of "Fri, 19 Apr 2019 18:42:03 +0000")
References: <20190419160046.5283-1-corentin.bompard@etu.univ-lyon1.fr>
        <f601baa2c2a04ddea4ba32ab25d0dd21@BPMBX2013-01.univ-lyon1.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
Date:   Mon, 22 Apr 2019 12:38:31 +0200
Message-ID: <86zhoil3yw.fsf@univ-lyon1.fr>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr> writes:

> Add the --set-upstream option to git pull/fetch

Add _a_?

> which lets the user set the upstream configuration
> (branch.<current-branch-name>.merge and
> branch.<current-branch-name>.remote) for the current branch.
>
> For example a typical use-case like

I don't understand this sentence. Perhaps

A typical use-case is:

>     git clone http://example.com/my-public-fork
>
>     git remote add main http://example.com/project-main-repo
>
>     git pull --set-upstream main master

I'd keep the newline before and after the block of commands, but not
between commands.

> +--set-upstream::
> +	If the new URL remote is correct, pull and add upstream (tracking) 

"URL remote" seems translated literally from french. You probably meant
"remote URL". I'd write "If the remote is fetched successfully, ...".

> +	reference, used by argument-less linkgit:git-push[1] and other commands.

What's your conclusion on the discussion following your previous
submission here? Mine is that git-push is not the best command to
mention here. The setting impacts pull, fetch, push, merge and rebase
(I may have missed others), and to me the main motivation is to impact
pull, so if only one command should be cited, it should be pull.

> +		 * When there are several such branches, consider the request ambiguous and
> +		 * err on the safe side by doing nothing and just emit a waring.

s/waring/warning/

> +			if (!rm->peer_ref) {
> +				if (source_ref) {
> +					warning(_("multiple branch detected, incompatible with set-upstream"));
> +					source_ref = NULL;
> +					goto skip;

"source_ref = NULL" is dead code due to the "goto skip" right below. I'd
remove it.

> +		if (source_ref) {
> +			if (!strcmp(source_ref->name, "HEAD") || 
> +				starts_with(source_ref->name, "refs/heads/")) {
> +				install_branch_config(0, branch->name,
> +							 transport->remote->name,
> +							 source_ref->name);
> +			} else if (starts_with(source_ref->name, "refs/remotes/")) {
> +				warning(_("not setting upstream for a remote remote-tracking branch"));
> +			} else if (starts_with(source_ref->name, "refs/tags/")) {
> +				warning(_("tag upstream not set"));

The second warning seems a bit cryptic to me. Why not take the same as
the first, with s/remote-tracking branch/tag/?

> +			warning(_("no source branch found. \n" 

Already noted in previous round: useless trailing whitespace.

> --- /dev/null
> +++ b/t/t5553-set-upstream.sh
> @@ -0,0 +1,137 @@
> +#!/bin/sh
> +
> +test_description='"git fetch/pull --set-upstream" basic tests.
> +
> +'

Don't make $test_description a multi-line string, just close the ' on
the first line.

> +check_config_empty () {

Perhaps name the function check_config_missing instead of ..._empty.

> +test_expect_success 'setup bare parent fetch' '
> +	ensure_fresh_upstream &&
> +	git remote add upstream parent &&
> +	git remote add up parent

I don't think you ever use this "up". Either add a comment explaining
why it's needed, or remove it.

> +test_expect_success 'fetch --set-upstream upstream master sets branch master but not other' '
> +	git fetch --set-upstream upstream master &&
> +	check_config master upstream refs/heads/master &&
> +	check_config_empty other
> +'
> +
> +test_expect_success 'fetch --set-upstream upstream other sets branch other' '
> +	git fetch --set-upstream upstream other &&
> +	check_config master upstream refs/heads/other &&
> +	check_config_empty other
> +'

The first test sets the config for master, and the config is not reset
between tests, so the second may read the config set by "git fetch"
right above, or just a leftover config of the previous test.

You need a "clear_config" in between. Best is to put it at the beginning
of tests so that it's clear that the test does not depend on what has
been executed previously. There are several places where you really need
it. It probably makes sense to use it at the start of every tests for
consistency and future-proof-ness.

> +test_expect_success 'fetch --set-upstream http://nosuchdomain.example.com fails with the bad url' '
> +	test_must_fail git fetch --set-upstream http://nosuchdomain.example.com &&
> +	check_config master upstream refs/heads/other &&
> +	check_config_empty other &&
> +	check_config_empty other2
> +'

It would probably make sense to check what happens when running

  git fetch --set-upstream <some-valid-url>

i.e. use a URL instead of a named remote.

-- 
Matthieu Moy
https://matthieu-moy.fr/
