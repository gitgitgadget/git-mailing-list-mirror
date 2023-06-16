Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E39CEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 04:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjFPEYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 00:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFPEYL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 00:24:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE942D50
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 21:24:09 -0700 (PDT)
Received: (qmail 8588 invoked by uid 109); 16 Jun 2023 04:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jun 2023 04:24:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29214 invoked by uid 111); 16 Jun 2023 04:24:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jun 2023 00:24:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jun 2023 00:24:07 -0400
From:   Jeff King <peff@peff.net>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        "eric.frederich@siemens.com" <eric.frederich@siemens.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Possible bug regarding trailers
Message-ID: <20230616042407.GA54009@coredump.intra.peff.net>
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
 <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 09:03:42PM +0200, Kristoffer Haugsbakk wrote:

> This check used to be simpler: before it only checked for a line that
> started with `---`, no matter what came after on that line. But that was
> changed to match on `---` followed by `isspace(v*)` in c188668e38
> (interpret-trailers: tighten check for "---" patch boundary,
> 2018-08-22). Reading the commit message it seems that the change was
> conservative. Maybe it would have been more strict (like demanding only
> lines like either `---\n` or `---\n `) if there weren’t concerns about
> how the behavior had been documented to match loosely up until that
> point.

It's possible that we should be more strict about the separator, but I
think the real bug is that we are respecting a separator at all in this
example.

That "---" handling is meant for format-patch/am-style processing, where
the commit is embedded in an email. And there it is an unfortunate but
accepted limitation that you can't put "---" separators in your commit
message, or the parsing will get confused.

But when we run "git commit --trailer", we know that we have a complete
commit message, not an email. And so we should not look for "---" at
all. But we do, and the commit object we write is broken (the trailer is
in the wrong spot):

  $ git commit -m "A bad commit
  
  --- let's mess stuff up ---
  
  Have fun
  " --trailer "old-scm-change-id:THIS TRAILER GETS LOST"

  $ git cat-file commit HEAD^
  tree 1dd017bdd070190005e5e162d87afebcd61e0fa8
  author example <a@b.com> 1686888121 -0400
  committer example <a@b.com> 1686888121 -0400
  
  A bad commit
  
  old-scm-change-id: THIS TRAILER GETS LOST
  
  --- let's mess stuff up ---
  
  Have fun

On the display side, I think "--format=%(trailers)" is doing the right
thing here; it is not respecting the "---", because it knows we have a
complete commit message from the object, not something we're trying to
pull out of the email format (so it finds nothing, because the trailer
is not at the end). Likewise, "cat-file | interpret-trailers" is doing
the right thing; by default it respects the divider. These examples
probably ought to be doing:

  git cat-file commit HEAD^ |
  git interpret-trailers --parse --no-divider

to tell interpret-trailers that we are feeding it a pure commit message,
not an email.

So I think the only bug is that "commit --trailer" should not respect
the divider. And the fix presumably:

diff --git a/builtin/commit.c b/builtin/commit.c
index e67c4be221..9f4448f6b9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1043,7 +1043,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct child_process run_trailer = CHILD_PROCESS_INIT;
 
 		strvec_pushl(&run_trailer.args, "interpret-trailers",
-			     "--in-place", git_path_commit_editmsg(), NULL);
+			     "--in-place", "--no-divider",
+			     git_path_commit_editmsg(), NULL);
 		strvec_pushv(&run_trailer.args, trailer_args.v);
 		run_trailer.git_cmd = 1;
 		if (run_command(&run_trailer))

I cannot think of a reason we wouldn't want to do that (though obviously
it would need a test to become a patch). But it's possible I'm missing
some use case (e.g., would anybody feed format-patch-ish output to "git
commit --trailer ... -F" and expect it to handle the "---" divider? That
seems odd to me).

I'm adding Christian to the cc, since he wrote most of the original
interpret-trailers code and may have thoughts.

-Peff
