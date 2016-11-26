Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8681FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 17:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbcKZRJh (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 12:09:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:47442 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbcKZRJg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 12:09:36 -0500
Received: (qmail 5793 invoked by uid 109); 26 Nov 2016 17:09:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 26 Nov 2016 17:09:35 +0000
Received: (qmail 23959 invoked by uid 111); 26 Nov 2016 17:10:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 26 Nov 2016 12:10:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Nov 2016 12:09:33 -0500
Date:   Sat, 26 Nov 2016 12:09:33 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Galbraith <umgwanakikbuti@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-daemon regression: 650c449250d7 common-main: call
 git_extract_argv0_path()
Message-ID: <20161126170933.6tge6j5etuchqy33@sigill.intra.peff.net>
References: <1480169028.3830.24.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480169028.3830.24.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 26, 2016 at 03:03:48PM +0100, Mike Galbraith wrote:

> git-daemon went broke on me post v2.9.3 due to binaries being installed
> in /usr/lib/git, which is not in PATH.  Reverting 650c449250d7 fixes it
> up, as does ln -s /usr/lib/git/git-daemon /usr/bin/git-daemon 'course,
> but thought I should report it, since it used to work without that.

Generally /usr/lib/git _should_ be in your PATH, as it is added by the
git wrapper when you run "git daemon".

The only behavior difference caused by 650c449250d7 is that we replace
argv[0] with the output of git_extract_argv0_path(argv[0]), which will
give the basename, not a full path. So presumably you are running:

  /usr/lib/git/git-daemon

directly. I'm not sure that's even supposed to work these days, and it
was not just a happy accident that it did.

On the other hand, I am sympathetic that something used to work and now
doesn't. It probably wouldn't be that hard to work around it.

The reason for the behavior change is that one of the cmd_main()
functions was relying on the basename side-effect of the
extract_argv0_path function, so 650c449250d7 just feeds the munged
argv[0] to all of the programs. The cleanest fix would probably be
something like:

diff --git a/common-main.c b/common-main.c
index 44a29e8b1..c654f9555 100644
--- a/common-main.c
+++ b/common-main.c
@@ -33,7 +33,7 @@ int main(int argc, const char **argv)
 
 	git_setup_gettext();
 
-	argv[0] = git_extract_argv0_path(argv[0]);
+	git_extract_argv0_path(argv[0]);
 
 	restore_sigpipe_to_default();
 
diff --git a/git.c b/git.c
index bd66a2e0a..05986680c 100644
--- a/git.c
+++ b/git.c
@@ -730,6 +730,11 @@ int cmd_main(int argc, const char **argv)
 	cmd = argv[0];
 	if (!cmd)
 		cmd = "git-help";
+	else {
+		const char *base = find_last_dir_sep(cmd);
+		if (base)
+			cmd = base + 1;
+	}
 
 	trace_command_performance(argv);
 	trace_stdin();

-Peff
