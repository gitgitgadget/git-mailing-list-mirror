Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFE9C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 04:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBKExA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 23:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKEw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 23:52:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4D55EBCD
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 20:52:57 -0800 (PST)
Received: (qmail 23264 invoked by uid 109); 11 Feb 2023 04:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 04:52:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31780 invoked by uid 111); 11 Feb 2023 04:52:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 23:52:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 23:52:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Blevins <wblevins001@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 2/2] doc/ls-remote: clarify pattern format
Message-ID: <Y+cfKFz2rXLLVkjs@coredump.intra.peff.net>
References: <Y+cAdZTs5y0yiTkM@coredump.intra.peff.net>
 <Y+cBFF0OPSq8DGnA@coredump.intra.peff.net>
 <xmqq5yc8gbec.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yc8gbec.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 06:54:03PM -0800, Junio C Hamano wrote:

> >  'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
> >  	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
> > -	      [--symref] [<repository> [<refs>...]]
> > +	      [--symref] [<repository> [<patterns>...]]
> 
> Micronit.
> 
> builtin/ls-remote.c::ls_remote_usage[] needs a matching update.

Good catch. It is more than a micronit, as it causes t0450 to fail (I
did not even think to run the tests, since it was just a doc change).

> > -<refs>...::
> > +<patterns>...::
> >  	When unspecified, all references, after filtering done
> > -	with --heads and --tags, are shown.  When <refs>... are
> > -	specified, only references matching the given patterns
> > -	are displayed.
> > +	with --heads and --tags, are shown.  When <patterns>... are
> > +	specified, only references matching one or more of the given
> > +	patterns are displayed. Each pattern is interpreted as a glob
> > +	(see `glob` in linkgit:gitglossary[7]) which is matched against
> > +	the "tail" of a ref, starting from a slash separator (so `bar`
> > +	matches `refs/heads/bar` but not `refs/heads/foobar`).
> 
> Good.  Is it too obvious that the pattern `refs/heads/bar` matches
> the ref `refs/heads/bar`, even though it becomes fuzzy what
> "starting from a slash separator" means in such a scenario?

Ah, thank you for bringing that up. I actually meant to call attention
to that case, as when I tried "git ls-remote . refs/heads/master", it
did not match anything, which seemed to me like a bug. But in fact it is
because I don't have a master branch in my repo (I only keep my feature
branches, plus an integration branch, and always refer to yours as
origin/master), and my experiment was buggy. :)

I do think it's worth mentioning (and thankfully there is no bug to
fix).

Here's a re-roll with both changes.

-- >8 --
Subject: [PATCH] doc/ls-remote: clarify pattern format

We document that you can specify "refs" to ls-remote, but we don't
explain any further than that they are "matched" as patterns. Since this
can be interpreted in a lot of ways, let's clarify that they are
tail-matched globs.

Likewise, let's use the word "patterns" to refer to them consistently,
rather than "refs" (both here and in the quick "-h" help), and mention
more explicitly that only one pattern needs to be matched (though there
is also an example already that shows this in action).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-ls-remote.txt | 15 ++++++++++-----
 builtin/ls-remote.c             |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index f17567945f..ff3da547dd 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
 	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
-	      [--symref] [<repository> [<refs>...]]
+	      [--symref] [<repository> [<patterns>...]]
 
 DESCRIPTION
 -----------
@@ -85,11 +85,16 @@ OPTIONS
 	either a URL or the name of a remote (see the GIT URLS and
 	REMOTES sections of linkgit:git-fetch[1]).
 
-<refs>...::
+<patterns>...::
 	When unspecified, all references, after filtering done
-	with --heads and --tags, are shown.  When <refs>... are
-	specified, only references matching the given patterns
-	are displayed.
+	with --heads and --tags, are shown.  When <patterns>... are
+	specified, only references matching one or more of the given
+	patterns are displayed. Each pattern is interpreted as a glob
+	(see `glob` in linkgit:gitglossary[7]) which is matched against
+	the "tail" of a ref, starting either from the start of the ref
+	(so a full name like `refs/heads/foo` matches) or from a slash
+	separator (so `bar` matches `refs/heads/bar` but not
+	`refs/heads/foobar`).
 
 EXAMPLES
 --------
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 5d5ac03871..6516177348 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -8,7 +8,7 @@
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
 	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]\n"
-	   "              [--symref] [<repository> [<refs>...]]"),
+	   "              [--symref] [<repository> [<patterns>...]]"),
 	NULL
 };
 
-- 
2.39.1.795.g4b3688ded9

