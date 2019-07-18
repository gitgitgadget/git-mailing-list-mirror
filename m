Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD32B1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 18:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391461AbfGRSbf (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 14:31:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62580 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391446AbfGRSbe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 14:31:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D379817250C;
        Thu, 18 Jul 2019 14:31:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QTne71MBSwy4cSDttg3vHdTExuQ=; b=L/jx8t
        SPPg7ZKaOSiXppHE8P7BM1GAd4R6Jx7J5fiu/dJBzcrrSj5LPvRrp3VZP2Fg+uag
        gz58RCCAoy13I8i/pKTfejSO+J4sGhGw1knnfXOAgnW+Km/uzZPnSCSfEfHOYpEz
        +OYqeo4enFr3j15fv4homT+A0sroDyOLx/Jzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vxS96rSRDsqVTtPjsciSlFjoyDg7w462
        Ui9V02PcF3d549Ada7x5F5wypa4egWFmizJrX3yZdSfz3ebRbK6q87poiZSsUzE1
        S88D82RCN1/LvJ8YFVYHnsBXOYk+NlFYtTWz0esEjtuiPo4nMiUa+LLnNqplnPzp
        r4AtEI5it44=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB0A517250B;
        Thu, 18 Jul 2019 14:31:24 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2ED3017250A;
        Thu, 18 Jul 2019 14:31:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/9] t3404: demonstrate that --edit-todo does not check for dropped commits
References: <20190717143918.7406-1-alban.gruin@gmail.com>
        <20190717143918.7406-2-alban.gruin@gmail.com>
Date:   Thu, 18 Jul 2019 11:31:22 -0700
In-Reply-To: <20190717143918.7406-2-alban.gruin@gmail.com> (Alban Gruin's
        message of "Wed, 17 Jul 2019 16:39:10 +0200")
Message-ID: <xmqqwogfxkhx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F2E7544-A98A-11E9-9B72-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> When set to "warn" or "error", `rebase.missingCommitCheck' would make
> rebase -i warn if the user removed commits from the todo list to prevent
> mistakes.  Unfortunately, rebase --edit-todo and rebase --continue don't
> take it into account.
>
> This adds three tests to t3404 to demonstrate this.  The first one is
> not broken, as when `rebase.missingCommitsCheck' is not set, nothing in
> particular must be done towards dropped commits.  The two others are
> broken, demonstrating the problem.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 82 +++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 461dd539ff..f5c0a8d2bb 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1345,6 +1345,88 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
> +	test_config rebase.missingCommitsCheck ignore &&
> +	rebase_setup_and_clean missing-commit &&
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES="1 2 bad 3 4" \
> +		git rebase -i --root >/dev/null 2>stderr &&

Do you need to capture into stderr?  Nobody seems to use it.

> +	FAKE_LINES="1 2 4" git rebase --edit-todo &&
> +	git rebase --continue 2>actual &&
> +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
> +	test_i18ngrep \
> +		"Successfully rebased and updated refs/heads/missing-commit" \
> +		actual
> +'
> +
> +cat >expect <<EOF
> +error: invalid line 5: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master)
> +Warning: some commits may have been dropped accidentally.
> +Dropped commits (newer to older):
> + - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
> +To avoid this message, use "drop" to explicitly remove a commit.
> +
> +Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
> +The possible behaviours are: ignore, warn, error.
> +
> +EOF
> +
> +tail -n 8 <expect >expect.2

Having this outside the test_expect_success block that uses the file
is bad.  You may have mimicked other tests in the same script, but
that is not a good excuse to make things worse.  Just make sure
these new stuff follow the best-current-practice pattern without
touching the existing bad examples (and later fix them up after the
dust settles, but don't let it distract you from the theme these
patches are addressing).

> +
> +test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
> +	test_config rebase.missingCommitsCheck warn &&
> +	rebase_setup_and_clean missing-commit &&
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES="1 2 3 4 bad 5" \
> +		git rebase -i --root >/dev/null 2>stderr &&

Ditto.

> +	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
> +	test_i18ncmp expect actual &&

So, after "--edit-todo", you are supposed to get an error and a warning,
but ...

> +	git rebase --continue 2>actual.2 &&
> +	head -n 8 <actual.2 >actual &&
> +	test_i18ncmp expect.2 actual &&

... after "--continue", you do not get any error, as you removed
'bad' from the input, but you still get a warning, followed by a
report of the fact that a commit has been dropped.  OK.

> +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
> +	test_i18ngrep \
> +		"Successfully rebased and updated refs/heads/missing-commit" \
> +		actual.2
> +'
> +
> +cat >expect <<EOF
> +error: invalid line 3: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
> +Warning: some commits may have been dropped accidentally.
> +Dropped commits (newer to older):
> + - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
> + - $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
> +To avoid this message, use "drop" to explicitly remove a commit.
> +
> +Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
> +The possible behaviours are: ignore, warn, error.
> +
> +EOF
> +
> +tail -n 9 <expect >expect.2
> +
> +test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
> +	test_config rebase.missingCommitsCheck error &&
> +	rebase_setup_and_clean missing-commit &&
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES="1 2 bad 3 4" \
> +		git rebase -i --root >/dev/null 2>stderr &&
> +	test_must_fail env FAKE_LINES="1 2 4" \
> +		git rebase --edit-todo 2>actual &&
> +	test_i18ncmp expect actual &&
> +	test_must_fail git rebase --continue 2>actual &&

OK, and this one fails as the configuration is set to 'error'.

> +	test_i18ncmp expect.2 actual &&
> +	cp .git/rebase-merge/git-rebase-todo.backup \
> +		.git/rebase-merge/git-rebase-todo &&

Why?  Who uses this copy?

> +	FAKE_LINES="1 2 drop 3 4 drop 5" \
> +		git rebase --edit-todo &&
> +	git rebase --continue 2>actual &&
> +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
> +	test_i18ngrep \
> +		"Successfully rebased and updated refs/heads/missing-commit" \
> +		actual
> +'
> +
>  test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and exec' '
>  	rebase_setup_and_clean abbrevcmd &&
>  	test_commit "first" file1.txt "first line" first &&
