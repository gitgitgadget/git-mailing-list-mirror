Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2B31F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKSIFo (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 03:05:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:50828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725815AbfKSIFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 03:05:44 -0500
Received: (qmail 11204 invoked by uid 109); 19 Nov 2019 08:05:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Nov 2019 08:05:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21640 invoked by uid 111); 19 Nov 2019 08:09:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Nov 2019 03:09:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Nov 2019 03:05:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git rev-parse --show-toplevel inside `.git` returns 0 and prints
 nothing
Message-ID: <20191119080543.GA14313@sigill.intra.peff.net>
References: <CA+dzEBmrMavFJeyPSQr2wA9kFZwz_Kfr6PFBLRfLJ-EuCVXJnA@mail.gmail.com>
 <xmqqk17wziex.fsf@gitster-ct.c.googlers.com>
 <20191119033311.GA18613@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191119033311.GA18613@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 10:33:11PM -0500, Jeff King wrote:

> And the only real change here is that "--show-toplevel" prints an error
> and exits non-zero when we won't have a working tree. Something like:
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 3857fd1b8a..81161f2dfb 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -805,6 +805,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				const char *work_tree = get_git_work_tree();
>  				if (work_tree)
>  					puts(work_tree);
> +				else
> +					die("this operation must be run in a work tree");
>  				continue;
>  			}
>  			if (!strcmp(arg, "--show-superproject-working-tree")) {
> 
> 
> I think the reason this hasn't come up until now is callers are expected
> to use require_work_tree() or "rev-parse --is-inside-work-tree" first.
> 
> It would probably make sense for the rev-parse documentation to also
> clarify what "the top-level directory" is.

Here it is wrapped up with a commit message, a test, and a documentation
fix. I have to admit I'm having second thoughts, though. It _is_
slightly confusing, and this is what I would do if we were designing
from scratch. But the current behavior, while weird, does let the caller
distinguish all cases. So another option would just be to document the
outcome more clearly. I'm on the fence.

-- >8 --
Subject: [PATCH] rev-parse: make --show-toplevel without a worktree an error

Ever since it was introduced in 7cceca5ccc (Add 'git rev-parse
--show-toplevel' option., 2010-01-12), the --show-toplevel option has
treated a missing working tree as a quiet success: it neither prints a
toplevel path, but nor does it report any kind of error.

While a caller could distinguish this case by looking for an empty
response, the behavior is rather confusing. We're better off complaining
that there is no working tree, as other internal commands would do in
similar cases (e.g., "git status" or any builtin with NEED_WORK_TREE set
would just die()). So let's do the same here.

While we're at it, let's clarify the documentation and add some tests,
both for the new behavior and for the more mundane case (which was not
covered).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-rev-parse.txt |  3 ++-
 builtin/rev-parse.c             |  2 ++
 t/t1500-rev-parse.sh            | 10 ++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 9985477efe..19b12b6d43 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -262,7 +262,8 @@ print a message to stderr and exit with nonzero status.
 	directory.
 
 --show-toplevel::
-	Show the absolute path of the top-level directory.
+	Show the absolute path of the top-level directory of the working
+	tree. If there is no working tree, report an error.
 
 --show-superproject-working-tree::
 	Show the absolute path of the root of the superproject's
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 85ce2095bf..7a00da8203 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -803,6 +803,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				const char *work_tree = get_git_work_tree();
 				if (work_tree)
 					puts(work_tree);
+				else
+					die("this operation must be run in a work tree");
 				continue;
 			}
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 0177fd815c..603019b541 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -146,6 +146,16 @@ test_expect_success 'rev-parse --show-object-format in repo' '
 	grep "unknown mode for --show-object-format: squeamish-ossifrage" err
 '
 
+test_expect_success '--show-toplevel from subdir of working tree' '
+	pwd >expect &&
+	git -C sub/dir rev-parse --show-toplevel >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--show-toplevel from inside .git' '
+	test_must_fail git -C .git rev-parse --show-toplevel
+'
+
 test_expect_success 'showing the superproject correctly' '
 	git rev-parse --show-superproject-working-tree >out &&
 	test_must_be_empty out &&
-- 
2.24.0.512.g217e13b85d

