Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE0BC77B7E
	for <git@archiver.kernel.org>; Sat, 27 May 2023 17:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjE0RjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 13:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0RjF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 13:39:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60417D3
        for <git@vger.kernel.org>; Sat, 27 May 2023 10:39:04 -0700 (PDT)
Received: (qmail 2401 invoked by uid 109); 27 May 2023 17:39:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 May 2023 17:39:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32551 invoked by uid 111); 27 May 2023 17:39:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 May 2023 13:39:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 27 May 2023 13:39:03 -0400
From:   Jeff King <peff@peff.net>
To:     Jim Pryor <dubiousjim@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git 2.40.1 tree-diff crashes with (glob) magic on pathspecs
Message-ID: <20230527173903.GB1460206@coredump.intra.peff.net>
References: <c2b73d05-1214-4e30-bab6-14e0b8d69773@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2b73d05-1214-4e30-bab6-14e0b8d69773@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2023 at 03:53:31PM +0200, Jim Pryor wrote:

> $ git --no-pager log --oneline -- ':(glob)**/test2'
> 
> What did you expect to happen? (Expected behavior)
> 
> 13a1b11 (HEAD -> master) third commit
> 2bacc0c second commit
> c6eb1c1 first commit
> 
> What happened instead? (Actual behavior)
> 
> 13a1b11 (HEAD -> master) third commit
> BUG: tree-diff.c:596: unsupported magic 8
> error: git died of signal 6

Thanks for your report. I had trouble reproducing at first, but there is
one extra twist. By default, the command you gave produces:

  $ git --no-pager log --oneline -- ':(glob)**/test2'
  48eab09 (HEAD -> main) third commit
  89a47e5 second commit

which makes sense; we did not ask about "test", which is the path the
original commit touched. So I guessed you might have log.follow set, and
indeed:

  $ git --no-pager log --oneline --follow -- ':(glob)**/test2'
  48eab09 (HEAD -> main) third commit
  BUG: tree-diff.c:596: unsupported magic 8
  Aborted

I _think_ in this case that ":(glob)" is not actually doing much. It is
already the default that we will glob pathspecs; it is only needed to
override "git --literal" (which changes the default to not glob).

But this also seems to be wading into a spot that is not actually
supported by --follow. The code near where the BUG() is triggered looks
like this:

static void try_to_follow_renames([...])
{
[...]
        /*
         * follow-rename code is very specific, we need exactly one
         * path. Magic that matches more than one path is not
         * supported.
         */
        GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
#if 0
        /*
         * We should reject wildcards as well. Unfortunately we
         * haven't got a reliable way to detect that 'foo\*bar' in
         * fact has no wildcards. nowildcard_len is merely a hint for
         * optimization. Let it slip for now until wildmatch is taught
         * about dry-run mode and returns wildcard info.
         */
        if (opt->pathspec.has_wildcard)
                BUG("wildcards are not supported");
#endif

So follow-mode does not actually work with wildcards, but we err on the
side of not rejecting them outright. In that sense, the simplest "fix"
here would be to allow :(glob) to match the '#if 0' section, like:

diff --git a/tree-diff.c b/tree-diff.c
index 69031d7cba..d287079253 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -593,7 +593,8 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	 * path. Magic that matches more than one path is not
 	 * supported.
 	 */
-	GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
+	GUARD_PATHSPEC(&opt->pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL | PATHSPEC_GLOB);
 #if 0
 	/*
 	 * We should reject wildcards as well. Unfortunately we

That would avoid the BUG() and make things work consistently. But it
still would not produce the output you expect, because --follow simply
does not work with wildcard pathspecs. And fixing that would presumably
be a much bigger change (I didn't dig into it).

Complicating this slightly is the fact that you didn't explicitly ask
for --follow, but just had log.follow set. I think we automatically
disable log.follow when there is more than one pathspec, and in theory
we ought to do the same for actual wildcards. But maybe it would be
enough for follow-mode to kick in, but to end up mostly ignored (which
is what the patch above would do).

(I say "mostly" because I suspect you could construct a history where
the glob matched a literal filename, too, and the follow code gets
confused. But outside of intentionally-constructed pathological cases,
that seems unlikely).

-Peff
