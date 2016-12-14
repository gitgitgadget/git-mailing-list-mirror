Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4ED1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 15:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756324AbcLNPVE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 10:21:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:56425 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755315AbcLNPVD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 10:21:03 -0500
Received: (qmail 1983 invoked by uid 109); 14 Dec 2016 15:20:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 15:20:41 +0000
Received: (qmail 25541 invoked by uid 111); 14 Dec 2016 15:21:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 10:21:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 10:20:39 -0500
Date:   Wed, 14 Dec 2016 10:20:39 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     git@vger.kernel.org, mah@jump-ing.de, jacob.keller@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCHv3 1/3] merge: Add '--continue' option as a synonym for
 'git commit'
Message-ID: <20161214152039.swtll7xrmcdwz7bc@sigill.intra.peff.net>
References: <20161213084859.13426-1-judge.packham@gmail.com>
 <20161214083757.26412-1-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214083757.26412-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 09:37:55PM +1300, Chris Packham wrote:

> +	if (continue_current_merge) {
> +		int nargc = 1;
> +		const char *nargv[] = {"commit", NULL};
> +
> +		if (orig_argc != 2)
> +			usage_msg_opt("--continue expects no arguments",
> +			      builtin_merge_usage, builtin_merge_options);

This message should probably be inside a _() for translation.

I noticed when running it that the output looks funny:

  $ git merge --continue foo
  --continue expects no arguments

  usage: [...]

I was going to suggest adding something like "fatal:" here, but I
actually think it should be the responsibility of usage_msg_opt().
Looking at its other callers, they would all benefit. I posted a
patch:

  http://public-inbox.org/git/20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net/

I also wondered what it would look like to support "--quiet" on top of
this.  I don't care that much about it in particular, but I just want to
make sure we're not painting ourselves into a corner.

Here's what I came up with;

diff --git a/builtin/merge.c b/builtin/merge.c
index 668aaffb8..b13523ce9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1160,10 +1160,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		show_progress = 0;
 
 	if (abort_current_merge) {
-		int nargc = 2;
-		const char *nargv[] = {"reset", "--merge", NULL};
+		int acceptable_arguments = 2; /* argv[0] plus --abort */
+		struct argv_array nargv = ARGV_ARRAY_INIT;
 
-		if (orig_argc != 2)
+		argv_array_pushl(&nargv, "reset", "--merge", NULL);
+		if (verbosity < 0) {
+			acceptable_arguments++;
+			argv_array_push(&nargv, "--quiet");
+		}
+
+		if (orig_argc != acceptable_arguments)
 			usage_msg_opt("--abort expects no arguments",
 			      builtin_merge_usage, builtin_merge_options);
 
@@ -1171,15 +1177,22 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
 
 		/* Invoke 'git reset --merge' */
-		ret = cmd_reset(nargc, nargv, prefix);
+		ret = cmd_reset(nargv.argc, nargv.argv, prefix);
+		argv_array_clear(&nargv);
 		goto done;
 	}
 
 	if (continue_current_merge) {
-		int nargc = 1;
-		const char *nargv[] = {"commit", NULL};
+		int acceptable_arguments = 2; /* argv[0] plus --abort */
+		struct argv_array nargv = ARGV_ARRAY_INIT;
+
+		argv_array_push(&nargv, "commit");
+		if (verbosity < 0) {
+			acceptable_arguments++;
+			argv_array_push(&nargv, "--quiet");
+		}
 
-		if (orig_argc != 2)
+		if (orig_argc != acceptable_arguments)
 			usage_msg_opt("--continue expects no arguments",
 			      builtin_merge_usage, builtin_merge_options);
 
@@ -1187,7 +1200,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die(_("There is no merge in progress (MERGE_HEAD missing)."));
 
 		/* Invoke 'git commit' */
-		ret = cmd_commit(nargc, nargv, prefix);
+		ret = cmd_commit(nargv.argc, nargv.argv, prefix);
+		argv_array_clear(&nargv);
 		goto done;
 	}
 

So not too bad (and you could probably refactor it to avoid some of the
duplication). Though it does get some obscure cases wrong, like:

  git merge --continue --verbose --quiet

I dunno. Maybe I am leading you down a rabbit hole, and we should just
live with silently ignoring useless options. I looked at what
cherry-pick does for this case, and its verify_opt_compatible is
somewhat scary from a maintenance standpoint. It's a whitelist, not a
blacklist, so it's easy to forget options (and it looks like "git
cherry-pick --abort -Sfoo" is missed, for example).

-Peff
