Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620D02013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbdBOVk4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:40:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:56005 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751686AbdBOVkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:40:55 -0500
Received: (qmail 23814 invoked by uid 109); 15 Feb 2017 21:40:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 21:40:54 +0000
Received: (qmail 17739 invoked by uid 111); 15 Feb 2017 21:40:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 16:40:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 16:40:52 -0500
Date:   Wed, 15 Feb 2017 16:40:52 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] show-branch: fix crash with long ref name
Message-ID: <20170215214052.5py4pxkcz4g2bmtk@sigill.intra.peff.net>
References: <20170214154816.12625-1-chriscool@tuxfamily.org>
 <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
 <xmqqlgt88t0r.fsf@gitster.mtv.corp.google.com>
 <20170214195513.7zae6x22advkrms6@sigill.intra.peff.net>
 <CAP8UFD0EfUgfmTB4dj-A+rw79F7SWKxYvatNfR+Nj-8ukWYAQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0EfUgfmTB4dj-A+rw79F7SWKxYvatNfR+Nj-8ukWYAQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 10:29:46PM +0100, Christian Couder wrote:

> > I notice Christian's patch added a few tests. I don't know if we'd want
> > to squash them in (I didn't mean to override his patch at all; I was
> > about to send mine out when I noticed his, and I wondered if we wanted
> > to combine the two efforts).
> 
> I think it would be nice to have at least one test. Feel free to
> squash mine if you want.

I started to add some tests, but I had second thoughts. It _is_ nice
to show off the fix, but as far as regressions go, this specific case is
unlikely to come up again. What would be more valuable, I think, is a
test script which set up a very long refname (not just 150 bytes or
whatever) and ran it through a series of git commands.

But then you run into all sorts of portability annoyances with pathname
restrictions (you can hack around creation by writing the refname
directly into packed-refs, but most manipulations will want to take the
.lock in the filesystem). So I dunno. It seems like being thorough is a
lot of hassle for not much gain. Being not-thorough is easy, but is
mostly a token that is unlikely to find any real bugs.

So I punted, at least for now.

I see the patches are marked for 'next' in the latest What's Cooking.
If it is not too late in today's integration cycle, here is a re-roll of
patch 3 that squashes in Pranit's suggestion (if it is too late, then
Pranit, you may want to re-send it as a squash on top).

-- >8 --
Subject: [PATCH] show-branch: use skip_prefix to drop magic numbers

We make several starts_with() calls, only to advance
pointers. This is exactly what skip_prefix() is for, which
lets us avoid manually-counted magic numbers.

Helped-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/show-branch.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 404c4d09a..19756595d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -275,8 +275,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
 		pretty_str = pretty.buf;
 	}
-	if (starts_with(pretty_str, "[PATCH] "))
-		pretty_str += 8;
+	skip_prefix(pretty_str, "[PATCH] ", &pretty_str);
 
 	if (!no_name) {
 		if (name && name->head_name) {
@@ -470,17 +469,14 @@ static void snarf_refs(int head, int remotes)
 	}
 }
 
-static int rev_is_head(char *head, char *name,
+static int rev_is_head(const char *head, const char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
 	if (!head || (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
-	if (starts_with(head, "refs/heads/"))
-		head += 11;
-	if (starts_with(name, "refs/heads/"))
-		name += 11;
-	else if (starts_with(name, "heads/"))
-		name += 6;
+	skip_prefix(head, "refs/heads/", &head);
+	if (!skip_prefix(name, "refs/heads/", &name))
+		skip_prefix(name, "heads/", &name);
 	return !strcmp(head, name);
 }
 
@@ -799,8 +795,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				has_head++;
 		}
 		if (!has_head) {
-			int offset = starts_with(head, "refs/heads/") ? 11 : 0;
-			append_one_rev(head + offset);
+			const char *name = head;
+			skip_prefix(name, "refs/heads/", &name);
+			append_one_rev(name);
 		}
 	}
 
-- 
2.12.0.rc1.541.g3e32dea89

