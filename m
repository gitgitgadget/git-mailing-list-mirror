Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F51F1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 02:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBHCsD (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 21:48:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:36958 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726801AbfBHCsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 21:48:03 -0500
Received: (qmail 18515 invoked by uid 109); 8 Feb 2019 02:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 02:48:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21194 invoked by uid 111); 8 Feb 2019 02:48:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Feb 2019 21:48:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2019 21:48:01 -0500
Date:   Thu, 7 Feb 2019 21:48:01 -0500
From:   Jeff King <peff@peff.net>
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     git@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Subject: Re: `git status -u no` suppresses modified files too.
Message-ID: <20190208024800.GA11392@sigill.intra.peff.net>
References: <87y36rcanq.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y36rcanq.fsf@rustcorp.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 12:18:57PM +1030, Rusty Russell wrote:

> This broke my "is this clean?" sanity check and very much violates
> the man page description.

Wow, this one had me scratching my head for a minute. What you're
describing here:

>         $ git status -u no
>         On branch guilt/repro

...seems horribly broken, and the behavior goes back to the beginnings
of "-u". So I wondered how we would not have noticed for so long.

But what is going on is quite subtle. The "-u" option takes an optional
argument, and so must be used in its "stuck" form. I.e.,

  git status -uno

does do what you expect. We cannot allow the separated form here,
because that would conflict with another actual option, like:

  git status -u --porcelain

So why does it behave as it does? We accept "no" as its own pathspec
argument, and thus we limit the status to that path. And that's why
there's "nothing to commit"; there's nothing in that pathspec.

This is a pretty horrible UI trap. Most of the time with pathspecs we
require them to be on the right-hand side of a "--" unless the paths
actually exist in the filesystem. But then, in most of those cases we're
making sure they're not ambiguous between revisions and paths. So maybe
it's overkill here. I dunno. But the patch below certainly makes what's
going on in your case less subtle:

  $ git status -u no
  fatal: no: no such path in the working tree.
  Use 'git <command> -- <path>...' to specify paths that do not exist locally.

You do still have to figure out why it wasn't stuck to "-u", though.

---
diff --git a/builtin/commit.c b/builtin/commit.c
index 2986553d5f..7177d7d82f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1300,6 +1300,16 @@ static int git_status_config(const char *k, const char *v, void *cb)
 	return git_diff_ui_config(k, v, NULL);
 }
 
+static void verify_pathspec(const char *prefix, const char **argv)
+{
+	while (*argv) {
+		const char *arg = *argv++;
+		if (!strcmp(arg, "--"))
+			return;
+		verify_filename(prefix, arg, 0);
+	}
+}
+
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	static int no_renames = -1;
@@ -1351,7 +1361,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	status_init_config(&s, git_status_config);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
-			     builtin_status_usage, 0);
+			     builtin_status_usage, PARSE_OPT_KEEP_DASHDASH);
 	finalize_colopts(&s.colopts, -1);
 	finalize_deferred_config(&s);
 
@@ -1362,6 +1372,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	    s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
 		die(_("Unsupported combination of ignored and untracked-files arguments"));
 
+	verify_pathspec(prefix, argv);
 	parse_pathspec(&s.pathspec, 0,
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
