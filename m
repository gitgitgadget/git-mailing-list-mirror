Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3811207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbcI3SFJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 14:05:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:50541 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932430AbcI3SFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 14:05:08 -0400
Received: (qmail 25099 invoked by uid 109); 30 Sep 2016 18:05:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 18:05:07 +0000
Received: (qmail 12687 invoked by uid 111); 30 Sep 2016 18:05:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 14:05:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 14:05:04 -0400
Date:   Fri, 30 Sep 2016 14:05:04 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
Message-ID: <20160930180504.p6ueuxj6g7qzcbwq@sigill.intra.peff.net>
References: <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
 <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
 <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
 <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
 <20160930080658.lyi7aovvazjmy346@sigill.intra.peff.net>
 <CA+55aFxW1S6FNUh8YjSXkfC8=F5dka1rY-As6PWfG2rqmrsXXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxW1S6FNUh8YjSXkfC8=F5dka1rY-As6PWfG2rqmrsXXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 10:54:16AM -0700, Linus Torvalds wrote:

> On Fri, Sep 30, 2016 at 1:06 AM, Jeff King <peff@peff.net> wrote:
> >
> > I agree that this deals with the performance concerns by caching the
> > default_abbrev_len and starting there. I still think it's unnecessarily
> > invasive to touch get_short_sha1() at all, which is otherwise only a
> > reading function.
> 
> So the reason that d oesn't work is that the "disambiguate_state" data
> where we keep the number of objects is only visible within
> get_short_sha1().
> 
> So outside that function, you don't have any sane way to figure out
> how many objects. So then you have to do the extra counting function..

Right. I think you should do the extra counting function. It's a few
more lines, but the design is way less tangled.

> > So IMHO, the best combination is the init_default_abbrev() you posted in
> > [1], but initialized at the top of find_unique_abbrev(). And cached
> > there, obviously, in a similar way.
> 
> That's certainly possible, but I'm really not happy with how the
> counting function looks.  And nobody actually stood up to say "yeah,
> that gets alternate loose objects right" or "if you have tons of those
> alternate loose objects you have other issues anyway". I think
> somebody would have to "own" that counting function, the advantage of
> just putting it into disambiguate_state is that we just get the
> counting for free..

I don't think you _need_ get the alternate loose objects right. In fact,
I don't think you need to care about loose objects at all. For the
scales we're talking about, they're a rounding error. I would have done
it like this:

diff --git a/sha1_file.c b/sha1_file.c
index 65deaf9..1845502 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1382,6 +1382,32 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
+static int approximate_object_count_valid;
+
+/*
+ * Give a fast, rough count of the number of objects in the repository. This
+ * ignores loose objects completely. If you have a lot of them, then either
+ * you should repack because your performance will be awful, or they are
+ * all unreachable objects about to be pruned, in which case they're not really
+ * interesting as a measure of repo size in the first place.
+ */
+unsigned long approximate_object_count(void)
+{
+	static unsigned long count;
+	if (!approximate_object_count_valid) {
+		struct packed_git *p;
+
+		prepare_packed_git();
+		count = 0;
+		for (p = packed_git; p; p = p->next) {
+			if (open_pack_index(p))
+				continue;
+			count += p->num_objects;
+		}
+	}
+	return count;
+}
+
 static void *get_next_packed_git(const void *p)
 {
 	return ((const struct packed_git *)p)->next;
@@ -1456,6 +1482,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
+	approximate_object_count_valid = 0;
 	prepare_packed_git_run_once = 0;
 	prepare_packed_git();
 }
