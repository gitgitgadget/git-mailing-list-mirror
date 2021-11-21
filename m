Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72338C433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 18:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbhKUSlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 13:41:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:35882 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238384AbhKUSlE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 13:41:04 -0500
Received: (qmail 17648 invoked by uid 109); 21 Nov 2021 18:37:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Nov 2021 18:37:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5341 invoked by uid 111); 21 Nov 2021 18:37:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Nov 2021 13:37:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Nov 2021 13:37:58 -0500
From:   Jeff King <peff@peff.net>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
References: <20211120194048.12125-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211120194048.12125-1-ematsumiya@suse.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 20, 2021 at 04:40:48PM -0300, Enzo Matsumiya wrote:

> When prepare_cmd() fails for, e.g., pager process setup,
> child_process_clear() frees the memory in pager_process.args, but .argv
> still points to the previously location.

Makes sense to introduce the root of the problem (.argv pointing to the
wrong place). minor grammo: s/previously/previous/

> When setup_pager() is called a second time, from cmd_log_init_finish()
> in this case, its strvec operations (i.e. using pager_process.argv) will
> lead to a use-after-free.

And then this shows how the root problem triggers. There's one minor
inaccuracy here. It's not the strvec operations which fail. It's that
start_command() will prefer an already-set pager_process.argv to looking
at pager_process.args at all.

> This patch makes sure that further uses of the child_process cleared by
> child_process_clear() gets a properly initialized struct.
> 
> Reproducer:
> $ git config pager.show INVALID_PAGER
> $ git show $VALID_COMMIT
> error: cannot run INVALID_PAGER: No such file or directory
> [1]    3619 segmentation fault (core dumped)  git show $VALID_COMMIT

Yep, this all makes sense.

I think it may be squashing in a test, like this:

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435..013e5e35ca 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -786,4 +786,9 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 	test_path_is_file pager-used
 '
 
+test_expect_success TTY 'handle multiple failed attempts to run pager' '
+	test_config pager.log does-not-exist &&
+	test_terminal git log
+'
+
 test_done

That shows that the fix works, and will help catch any regressions. Note
that checking for a successful exit code contradicts an earlier test in
t7006. That's because that earlier test is wrong. There's some
discussion in this thread:

  https://lore.kernel.org/git/xmqq1r4b8ezp.fsf@gitster.g/

I think we can ignore that for now and just add our new test.

> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> Reviewed-by: Jeff King <peff@peff.net>

We'd usually leave of "Reviewed-by" until the reviewer has had a chance
to see _this_ version of the patch. I.e., usually it would not be added
by the submitter, but by the maintainer (unless you are resending
verbatim a patch that already got review).

> diff --git a/run-command.c b/run-command.c
> index f329391154ae..a7bf81025afb 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -19,6 +19,7 @@ void child_process_clear(struct child_process *child)
>  {
>  	strvec_clear(&child->args);
>  	strvec_clear(&child->env_array);
> +	child_process_init(child);
>  }

And naturally I agree that the patch itself looks good. :)

I like this is a minimal fix, but note there is one extra curiosity.
When you run the test above (or your reproduction recipe), you should
see that it complains to stderr twice about being unable to run the
pager. That is perhaps a sign that setup_pager() should make sure it is
never run twice (because either it succeeds, in which case we don't want
to run a second pager, or it failed, in which case trying again is
pointless).

If we fixed changed that, then that would also fix the bug you found,
regardless of this child_process_clear() change.

-Peff
