Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C743B1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 20:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbcHAUhV (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 16:37:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:52810 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752278AbcHAUhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 16:37:16 -0400
Received: (qmail 13699 invoked by uid 102); 1 Aug 2016 19:37:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 15:37:03 -0400
Received: (qmail 17039 invoked by uid 107); 1 Aug 2016 19:37:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 15:37:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 15:37:00 -0400
Date:	Mon, 1 Aug 2016 15:37:00 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Paul Tan <pyokagan@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
Message-ID: <20160801193659.hag2yax2rniczkbo@sigill.intra.peff.net>
References: <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net>
 <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net>
 <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
 <20160729180517.GA14953@sigill.intra.peff.net>
 <CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
 <20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net>
 <xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com>
 <20160801180047.sgzqgh7pvp2qzwug@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160801180047.sgzqgh7pvp2qzwug@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 02:00:47PM -0400, Jeff King wrote:

> So at this point I think I'd lean towards programs which have multiple
> logical commit operations explicitly saying "I am starting a new
> operation". It may be that we end up attaching more to that in the long
> run than just timestamp resets, too (i.e., what other cached data might
> there be that used to happen in separate sub-processes?).

Here's that patch.

I still just put in a bare "reset_ident_date()" in git-am. This _could_
be wrapped in: begin_logical_commit() or something, but it would just be
a wrapper around resetting the ident_date. So I'm inclined not to worry
about such semantic obfuscation until we actually have a second thing to
reset. :)

I also didn't go looking for other spots which might want similar
treatment. Junio mentioned that the sequencer code still uses an
external commit process, so cherry-pick/revert are OK. git-fast-import
creates a stream of commits, but already deals with this issue in a
separate way. And I couldn't think of other programs that want to make a
string of commits.

-- >8 --
Subject: [PATCH] am: reset cached ident date for each patch

When we compute the date to go in author/committer lines of
commits, or tagger lines of tags, we get the current date
once and then cache it for the rest of the program.  This is
a good thing in some cases, like "git commit", because it
means we do not racily assign different times to the
author/committer fields of a single commit object.

But as more programs start to make many commits in a single
process (e.g., the recently builtin "git am"), it means that
you'll get long strings of commits with identical committer
timestamps (whereas before, we invoked "git commit" many
times and got true timestamps).

This patch addresses it by letting callers reset the cached
time, which means they'll get a fresh time on their next
call to git_committer_info() or git_author_info(). The first
caller to do so is "git am", which resets the time for each
patch it applies.

It would be nice if we could just do this automatically
before filling in the ident fields of commit and tag
objects. Unfortunately, it's hard to know where a particular
logical operation begins and ends.

For instance, if commit_tree_extended() were to call
reset_ident_date() before getting the committer/author
ident, that doesn't quite work; sometimes the author info is
passed in to us as a parameter, and it may or may not have
come from a previous call to ident_default_date(). So in
those cases, we lose the property that the committer and the
author timestamp always match.

You could similarly put a date-reset at the end of
commit_tree_extended(). That actually works in the current
code base, but it's fragile. It makes the assumption that
after commit_tree_extended() finishes, the caller has no
other operations that would logically want to fall into the
same timestamp.

So instead we provide the tool to easily do the reset, and
let the high-level callers use it to annotate their own
logical operations.

There's no automated test, because it would be inherently
racy (it depends on whether the program takes multiple
seconds to run). But you can see the effect with something
like:

  # make a fake 100-patch series
  top=$(git rev-parse HEAD)
  bottom=$(git rev-list --first-parent -100 HEAD | tail -n 1)
  git log --format=email --reverse --first-parent \
          --binary -m -p $bottom..$top >patch

  # now apply it; this presumably takes multiple seconds
  git checkout --detach $bottom
  git am <patch

  # now count the number of distinct committer times;
  # prior to this patch, there would only be one, but
  # now we'd typically see several.
  git log --format=%ct $bottom.. | sort -u

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Helped-by: Paul Tan <pyokagan@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 2 ++
 cache.h      | 1 +
 ident.c      | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index b77bf11..8aa9b5b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1840,6 +1840,8 @@ static void am_run(struct am_state *state, int resume)
 		const char *mail = am_path(state, msgnum(state));
 		int apply_status;
 
+		reset_ident_date();
+
 		if (!file_exists(mail))
 			goto next;
 
diff --git a/cache.h b/cache.h
index b5f76a4..31e65f9 100644
--- a/cache.h
+++ b/cache.h
@@ -1269,6 +1269,7 @@ extern const char *ident_default_email(void);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 extern int git_ident_config(const char *, const char *, void *);
+extern void reset_ident_date(void);
 
 struct ident_split {
 	const char *name_begin;
diff --git a/ident.c b/ident.c
index 139c528..e20a772 100644
--- a/ident.c
+++ b/ident.c
@@ -184,6 +184,11 @@ static const char *ident_default_date(void)
 	return git_default_date.buf;
 }
 
+void reset_ident_date(void)
+{
+	strbuf_reset(&git_default_date);
+}
+
 static int crud(unsigned char c)
 {
 	return  c <= 32  ||
-- 
2.9.2.670.gf6ce898

