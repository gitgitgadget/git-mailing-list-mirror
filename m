Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745AA1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbcG2SFW (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:05:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:51201 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752269AbcG2SFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:05:21 -0400
Received: (qmail 5543 invoked by uid 102); 29 Jul 2016 18:05:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:05:21 -0400
Received: (qmail 3770 invoked by uid 107); 29 Jul 2016 18:05:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:05:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 14:05:18 -0400
Date:	Fri, 29 Jul 2016 14:05:18 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] reset cached ident date before creating objects
Message-ID: <20160729180517.GA14953@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net>
 <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net>
 <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 10:15:26AM -0700, Junio C Hamano wrote:

> > One obvious impact would be reflog entries, since we would reset the
> > time between the object creation and the ref write (so your reflog entry
> > would sometimes be a second or more after the commit time it writes).
> > I'm not sure how much anybody _cares_ about that; they're much less
> > intimate than author/committer times.
> 
> As long as it is understood that a commit object is created and then
> a ref is updated to point at it in this order, I do not think there
> is any confusion on the party who reads the reflog, I would think.

Actually, I think we can trivially keep this the same.

Linus suggested resetting the timestamp after making the commit, to
clear the way for the next commit. But if we reset any cached value
_before_ making the commit, this has a few advantages:

  - the cached timestamp remains the same afterwards for anything which
    wants to look at it (like reflog updates, but also potentially
    anything that wants to report the ident it just used).

  - this gives a more accurate timestamp if the distance between caching
    and the actual commit creation is more than a second (and this does
    happen; we call git_committer_info() in many places besides creating
    an actual commit).

So here's a patch. I gave tags the same treatment, though I don't know
if there are any cases that create a series of tags. I grepped through
all the calls to git_committer_info(), and I didn't see any others that
would want to reset the date.

It does feel a little backwards to cache by default, and then try to
catch all the places that want to reset. Another way of thinking about
it would be to almost _never_ cache, but let a few callsites like (the
commit object creation) explicitly ask for a stable timestamp between
the author and committer. That would be a lot more invasive, though. And
it just gives us the opposite problem: finding all sites which care
about stability and annotating them.

(In fact, even this patch may regress some cases that want stability,
though I could not think of any. The test suite does not complain, but
that's not surprising; it has to avoid looking at this kind of thing
entirely, or it would be racy).

-- >8 --
Subject: reset cached ident date before creating objects

When we compute the date to put in author/committer lines of
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
call to git_committer_info() or git_author_info().  We do so
automatically before filling in the ident fields of commit
and tag objects. That retains the property that committers
and authors in a single object will match, but means that
separate objects we create should always get their own
fresh timestamps.

There's no automated test, because it would be inherently
racy (it depends on whether the program takes multiple
seconds to run). But you can see the effect with something
like:

  # make a fake 100-patch series; use --first-parent
  # so that we pretend merges are just more patches
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
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c | 1 +
 cache.h       | 1 +
 commit.c      | 1 +
 ident.c       | 5 +++++
 4 files changed, 8 insertions(+)

diff --git a/builtin/tag.c b/builtin/tag.c
index 50e4ae5..3025e7f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -225,6 +225,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (type <= OBJ_NONE)
 	    die(_("bad object type."));
 
+	reset_ident_date();
 	header_len = snprintf(header_buf, sizeof(header_buf),
 			  "object %s\n"
 			  "type %s\n"
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
diff --git a/commit.c b/commit.c
index 71a360d..7ddbffe 100644
--- a/commit.c
+++ b/commit.c
@@ -1548,6 +1548,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	}
 
 	/* Person/date information */
+	reset_ident_date();
 	if (!author)
 		author = git_author_info(IDENT_STRICT);
 	strbuf_addf(&buffer, "author %s\n", author);
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
2.9.2.666.g67a7da4

