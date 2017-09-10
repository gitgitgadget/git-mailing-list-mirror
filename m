Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1801FAD6
	for <e@80x24.org>; Sun, 10 Sep 2017 07:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdIJHaG (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 03:30:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:33650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751077AbdIJHaF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 03:30:05 -0400
Received: (qmail 20421 invoked by uid 109); 10 Sep 2017 07:30:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Sep 2017 07:30:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18083 invoked by uid 111); 10 Sep 2017 07:30:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Sep 2017 03:30:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Sep 2017 03:30:03 -0400
Date:   Sun, 10 Sep 2017 03:30:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/34] clone: release strbuf after use in remove_junk()
Message-ID: <20170910073002.hg6tqgm2z7owqr2u@sigill.intra.peff.net>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175005.20756-7-l.s.r@web.de>
 <xmqq1snj61wr.fsf@gitster.mtv.corp.google.com>
 <0884b528-d455-09c6-0eaf-d2af50077a98@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0884b528-d455-09c6-0eaf-d2af50077a98@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 08:27:40AM +0200, René Scharfe wrote:

> >>   	if (junk_work_tree) {
> >>   		strbuf_addstr(&sb, junk_work_tree);
> >>   		remove_dir_recursively(&sb, 0);
> >> -		strbuf_reset(&sb);
> >>   	}
> >> +	strbuf_release(&sb);
> >>   }
> > 
> > The code definitely needs a _release() at the end, but I feel
> > lukewarm about the "if we are about to _release(), do not bother to
> > _reset()" micro-optimization.  Keeping the existing two users that
> > use sb as a (shared and reused) temporary similar would help those
> > who add the third one or reuse the pattern in their code elsewhere.
> 
> That's not intended as an optimization, but as a promotion -- the reset
> is moved to the outer block and upgraded to a release.  The result is
> consistent with builtin/worktree.c::remove_junk().

Hmm. This is a cleanup function called only from signal and atexit
handlers. I don't think we actually do need to clean up, and this might
be a good candidate for UNLEAK().

And in fact, being called from a signal handler means we should
generally avoid touching malloc or free (which could be holding locks).
That would mean preferring a leak to strbuf_release(). Of course that is
the tip of the iceberg. We call strbuf_addstr() here, and
remove_dir_recursively() will grow our buffer.

So I actually wonder if junk_git_dir and junk_work_tree should be
pre-sized strbufs themselves. And that makes the leak "go away" in the
eyes of leak-checkers because we hold onto the static strbufs until
program exit.

I.e., something like this:

diff --git a/builtin/clone.c b/builtin/clone.c
index 8d11b570a1..a350f7801e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -471,8 +471,19 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 		fprintf(stderr, _("done.\n"));
 }
 
-static const char *junk_work_tree;
-static const char *junk_git_dir;
+static void register_junk(struct strbuf *junk, const char *str)
+{
+	/*
+	 * we don't want to have to allocate for recursive removal during a
+	 * signal handler, so pre-size our strbufs to something that is
+	 * unlikely to overflow.
+	 */
+	strbuf_grow(junk, 4096);
+	strbuf_addstr(junk, str);
+}
+
+static struct strbuf junk_work_tree = STRBUF_INIT;
+static struct strbuf junk_git_dir = STRBUF_INIT;
 static enum {
 	JUNK_LEAVE_NONE,
 	JUNK_LEAVE_REPO,
@@ -486,8 +497,6 @@ N_("Clone succeeded, but checkout failed.\n"
 
 static void remove_junk(void)
 {
-	struct strbuf sb = STRBUF_INIT;
-
 	switch (junk_mode) {
 	case JUNK_LEAVE_REPO:
 		warning("%s", _(junk_leave_repo_msg));
@@ -499,16 +508,10 @@ static void remove_junk(void)
 		break;
 	}
 
-	if (junk_git_dir) {
-		strbuf_addstr(&sb, junk_git_dir);
-		remove_dir_recursively(&sb, 0);
-		strbuf_reset(&sb);
-	}
-	if (junk_work_tree) {
-		strbuf_addstr(&sb, junk_work_tree);
-		remove_dir_recursively(&sb, 0);
-		strbuf_reset(&sb);
-	}
+	if (junk_git_dir.len)
+		remove_dir_recursively(&junk_git_dir, 0);
+	if (junk_work_tree.len)
+		remove_dir_recursively(&junk_work_tree, 0);
 }
 
 static void remove_junk_on_signal(int signo)
@@ -970,11 +973,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (!dest_exists && mkdir(work_tree, 0777))
 			die_errno(_("could not create work tree dir '%s'"),
 				  work_tree);
-		junk_work_tree = work_tree;
+		register_junk(&junk_work_tree, work_tree);
 		set_git_work_tree(work_tree);
 	}
 
-	junk_git_dir = real_git_dir ? real_git_dir : git_dir;
+	register_junk(&junk_git_dir, real_git_dir ? real_git_dir : git_dir);
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die(_("could not create leading directories of '%s'"), git_dir);
 

Technically this would probably also benefit from all of the variables
being marked volatile, but we'd have to cast the volatility away to use
any strbuf functions. :(

If we really wanted to make this robust for signals (and I'm not sure
that it is worth the effort), I suspect the best route would be to teach
the tempfile.c code (which tries very hard to be careful about signals
and volatility) to handle directories.

-Peff
