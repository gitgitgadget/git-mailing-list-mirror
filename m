Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4CD1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 00:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeHZEWc (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 00:22:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:56084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726317AbeHZEWc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 00:22:32 -0400
Received: (qmail 15928 invoked by uid 109); 26 Aug 2018 00:41:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 26 Aug 2018 00:41:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6121 invoked by uid 111); 26 Aug 2018 00:41:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 20:41:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 20:41:50 -0400
Date:   Sat, 25 Aug 2018 20:41:50 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Oschwald <oschwald@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: $GIT_DIR is no longer set when pre-commit hooks are called
Message-ID: <20180826004150.GA31168@sigill.intra.peff.net>
References: <CAFKzd1qaMU=K6uc62xL0DUyZOWxY79Qakaog2dzBjiNrmq0ydg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFKzd1qaMU=K6uc62xL0DUyZOWxY79Qakaog2dzBjiNrmq0ydg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 04:16:00PM -0700, Gregory Oschwald wrote:

> As of the release of 2.18.0, $GIT_DIR is no longer set before calling
> pre-commit hooks. This change was introduced in "set_work_tree: use
> chdir_notify" (8500e0de) and is still present in master.
> 
> I reviewed the discussion when this change was initially submitted,
> and I don't think this behavior change was intentional.

It was sort-of intentional and sort-of not.

We never set intentionally GIT_DIR for hooks in the first place, but it
would sometimes end up set as a side effect of other operations. So some
hooks might see it and some might not. In the case of the pre-commit
hook, I think it was probably set consistently, since git-commit
requires a working tree, and setup_work_tree() used to set it as an
accidental side effect of its absolute/relative adjustments.

The "right" way to find the directory has always been "git rev-parse
--git-dir" (which will use GIT_DIR if set, and otherwise do the normal
discovery process).

However, I am sympathetic to the breakage of existing hooks. AFAICT that
while unintentional, we've probably been consistently setting $GIT_DIR
in hooks for commands with work-trees since 2008, as a side effect of
044bbbcb63 (Make git_dir a path relative to work_tree in
setup_work_tree(), 2008-06-19). Although I am slightly confused by this
earlier thread where the OP complained that the variable is set only
sometimes:

  https://public-inbox.org/git/CAEDDsWdXQ1+UukvbfRoTPzY3Y9sOaxQ7nh+qL_Mcuy3=XKKh7w@mail.gmail.com/

(and there the preferred behavior is actually _not_ to have it set,
because it's a gotcha when chdir-ing to another repo).

If we want to keep supporting this case, then I think we should be doing
it consistently, by setting $GIT_DIR in the child environment as we run
the hook. Something like the patch below, but ideally we'd apply it
consistently to all hooks (of course, that would break any hooks that
chdir to a new repo without resetting GIT_DIR, but such hooks are
already iffy, as they may already sometimes see GIT_DIR set in the
environment).

diff --git a/builtin/commit.c b/builtin/commit.c
index 3bfeabc463..3670024a25 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1440,6 +1440,7 @@ int run_commit_hook(int editor_is_used, const char *index_file, const char *name
 	int ret;
 
 	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	argv_array_pushf(&hook_env, "GIT_DIR=%s", get_git_dir());
 
 	/*
 	 * Let the hook know that no editor will be launched.

-Peff
