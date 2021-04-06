Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD3C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 21:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFB2613C2
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 21:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhDFVhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:37:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:42954 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233243AbhDFVhI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 17:37:08 -0400
Received: (qmail 9330 invoked by uid 109); 6 Apr 2021 21:36:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 21:36:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32644 invoked by uid 111); 6 Apr 2021 21:36:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 17:36:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 17:36:58 -0400
From:   Jeff King <peff@peff.net>
To:     Nikita Bobko <nikitabobko@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [Bug report] diff.noprefix config is ignored for interactive
 `add`
Message-ID: <YGzUerPL7V8jDxHo@coredump.intra.peff.net>
References: <CAMJzOtyzu8y5mWdKXe3MPe8ZoJs8O=me8Xuu0t77YVdAMc7Tgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMJzOtyzu8y5mWdKXe3MPe8ZoJs8O=me8Xuu0t77YVdAMc7Tgg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 06, 2021 at 12:15:28PM +0200, Nikita Bobko wrote:

> Steps to reproduce:
> 1. Run `git -c diff.noprefix=true add -p`
> 
> Expected behavior:
> `a/` and `b/` prefixes are not shown during interactive `add`
> like this:
> [...]
> Actual behavior:
> `a/` and `b/` prefixes are shown instead. Like this:

That's not too surprising. The add-interactive script is built around
the diff-tree plumbing command, which does not respect a lot of
"cosmetic" config, especially if it would make the diff hard to parse.
So the add-interactive command would have to manually plumb through the
config option, like we do for some other options.

In this case, I think you'd want to enable the option only for the
version of the diff we show to the user (since the machine-readable one
has to actually be parsed by git-apply). This is what we do for
supporting color diffs, for example.

I imagine something like this:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index bc3a1e8eff..1a249e15cb 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -43,6 +43,12 @@
 		$repo->get_color('color.diff.new', 'green'),
 	) : ();
 
+# options to feed to diff to produce human-readable version
+my @human_diff_opts = (
+	$diff_use_color ? '--color' : (),
+	$repo->config_bool('diff.noprefix') ? qw(--no-prefix) : (),
+);
+
 my $normal_color = $repo->get_color("", "reset");
 
 my $diff_algorithm = $repo->config('diff.algorithm');
@@ -714,8 +720,8 @@ sub parse_diff {
 	}
 	my @diff = run_cmd_pipe("git", @diff_cmd, qw(--no-color --), $path);
 	my @colored = ();
-	if ($diff_use_color) {
-		my @display_cmd = ("git", @diff_cmd, qw(--color --), $path);
+	if (@human_diff_opts) {
+		my @display_cmd = ("git", @diff_cmd, @human_diff_opts, '--', $path);
 		if (defined $diff_filter) {
 			# quotemeta is overkill, but sufficient for shell-quoting
 			my $diff = join(' ', map { quotemeta } @display_cmd);

would work, but I didn't really test it. There's another hitch, which is
that this subsystem has all been re-written in C. So we'd really want to
implement it in the new code (possibly in both places, though maybe it
is time to consider cutting over from the perl script to the C one by
deafult?).

But hopefully this illustrates the general idea, and gives somebody
interested in the feature enough to work up their own patch.

-Peff
