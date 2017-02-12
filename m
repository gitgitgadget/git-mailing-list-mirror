Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD8F1FC44
	for <e@80x24.org>; Sun, 12 Feb 2017 09:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbdBLJtA (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 04:49:00 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:52735 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdBLJs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 04:48:59 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 824BBC6D2;
        Sun, 12 Feb 2017 10:48:56 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (mailhost.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 7C53A100553;
        Sun, 12 Feb 2017 10:48:56 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 7648B125EA0;
        Sun, 12 Feb 2017 10:48:56 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 2/2 v3] sha1_name: teach get_sha1_1 "-" shorthand for "@{-1}"
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-3-git-send-email-kannan.siddharth12@gmail.com>
Date:   Sun, 12 Feb 2017 10:48:56 +0100
In-Reply-To: <1486752926-12020-3-git-send-email-kannan.siddharth12@gmail.com>
        (Siddharth Kannan's message of "Fri, 10 Feb 2017 18:55:26 +0000")
Message-ID: <vpqbmu768on.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

>  sha1_name.c              |  5 ++++
>  t/t4214-log-shorthand.sh | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100755 t/t4214-log-shorthand.sh
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 73a915f..d774e46 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -947,6 +947,11 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
>  	if (!ret)
>  		return 0;
>  
> +	if (!strcmp(name, "-")) {
> +		name = "@{-1}";
> +		len = 5;
> +	}

One drawback of this approach is that further error messages will be
given from the "@{-1}" string that the user never typed.

After you do that, the existing "turn - into @{-1}" pieces of code
become useless and you should remove it (probably in a further patch).

There are at least:

$ git grep -n -A1 'strcmp.*"-"' | grep -B 1 '@\{1\}'
builtin/checkout.c:975: if (!strcmp(arg, "-"))
builtin/checkout.c-976-         arg = "@{-1}";
--
builtin/merge.c:1231:   } else if (argc == 1 && !strcmp(argv[0], "-")) {
builtin/merge.c-1232-           argv[0] = "@{-1}";
--
builtin/revert.c:158:           if (!strcmp(argv[1], "-"))
builtin/revert.c-159-                   argv[1] = "@{-1}";
--
builtin/worktree.c:344: if (!strcmp(branch, "-"))
builtin/worktree.c-345-         branch = "@{-1}";

In the final version, obviously the same "refactoring" (specific
command -> git-wide) should be done for documentation (it should be in
this patch to avoid letting not-up-to-date documentation even for a
single commit).

> diff --git a/t/t4214-log-shorthand.sh b/t/t4214-log-shorthand.sh
> new file mode 100755
> index 0000000..dec966c
> --- /dev/null
> +++ b/t/t4214-log-shorthand.sh
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +
> +test_description='log can show previous branch using shorthand - for @{-1}'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	echo hello >world &&
> +	git add world &&
> +	git commit -m initial &&
> +	echo "hello second time" >>world &&
> +	git add world &&
> +	git commit -m second &&
> +	echo "hello other file" >>planet &&
> +	git add planet &&
> +	git commit -m third &&
> +	echo "hello yet another file" >>city &&
> +	git add city &&
> +	git commit -m fourth
> +'

You may use test_commit to save a few lines of code.

> +test_expect_success '"log -" should work' '
> +	git checkout -b testing-1 master^ &&
> +	git checkout -b testing-2 master~2 &&
> +	git checkout master &&
> +
> +	git log testing-2 >expect &&
> +	git log - >actual &&
> +	test_cmp expect actual
> +'

I'd have split this into a "setup branches" and a '"log -" should work'
test (to actually see where "setup branches" happen in the output, and
to allow running the setup step separately if needed). Not terribly
important.

> +test_expect_success 'symmetric revision range should work when one end is left empty' '
> +	git checkout testing-2 &&
> +	git checkout master &&
> +	git log ...@{-1} > expect.first_empty &&
> +	git log @{-1}... > expect.last_empty &&
> +	git log ...- > actual.first_empty &&
> +	git log -... > actual.last_empty &&

Nitpick: we stick the > and the filename (as you did in most places
already).

It may be worth adding tests for more cases like

* Check what happens with suffixes, i.e. -^, -@{yesterday} and -~.

* -..- -> to make sure you handle the presence of two - properly.

* multiple separate arguments to make sure you handle them all, e.g.
  "git log - -", "git log HEAD -", "git log - HEAD".

The last two may be overkill, but the first one is probably important.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
