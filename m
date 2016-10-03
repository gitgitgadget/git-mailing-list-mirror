Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2823207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 23:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbcJCXrd (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 19:47:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:51639 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbcJCXrb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 19:47:31 -0400
Received: (qmail 30598 invoked by uid 109); 3 Oct 2016 23:47:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 23:47:31 +0000
Received: (qmail 31889 invoked by uid 111); 3 Oct 2016 23:47:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 19:47:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 19:47:28 -0400
Date:   Mon, 3 Oct 2016 19:47:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] abbrev: auto size the default abbreviation
Message-ID: <20161003234728.s5sadekukxoppcmw@sigill.intra.peff.net>
References: <20161001001937.10884-1-gitster@pobox.com>
 <20161001001937.10884-4-gitster@pobox.com>
 <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net>
 <CA+55aFydV+9c3-5C03XUj7v_wGJF5NyJNaP6742zLVgZs410FA@mail.gmail.com>
 <20161003224028.ksvwaplxe7a3vtwv@sigill.intra.peff.net>
 <xmqqoa313v0j.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa313v0j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 03:52:44PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Oct 03, 2016 at 03:34:03PM -0700, Linus Torvalds wrote:
> >
> >> On Mon, Oct 3, 2016 at 3:27 PM, Jeff King <peff@peff.net> wrote:
> >> >
> >> > +       if (len < 0) {
> >> > +               unsigned long count = approximate_object_count();
> >> > +               len = (msb(count) + 1) / 2;
> >> > +               if (len < 0)
> >> > +                       len = FALLBACK_DEFAULT_ABBREV;
> >> > +       }
> >> 
> >> that second "if (len < 0)" should probably be testing against
> >> FALLBACK_DEFAULT_ABBREV, not zero. Or at the very least
> >> MINIMUM_ABBREV. Because a two-character abbreviation won't even be
> >> recognized, even if the git project is very small indeed.
> >
> > Oops, yes, clearly it should be FALLBACK_DEFAULT_ABBREV. What is there
> > would not even pass the tests (it _does_ work on linux.git, of course,
> > because it is much too large for that code to be triggered).
> 
> OK, as Linus's "count at the point of use" is already in 'next',
> could you make it incremental with a log message?

Sure. I wasn't sure if you actually liked my direction or not, so I was
mostly just showing off what the completed one would look like.

Here it is as an incremental on top of lt/abbrev-auto. I also tweaked
the math a bit to round-up more aggressively, and commented it more (I
could also just make the math look exactly like Linus's, counting up
until hitting an expected collision. I dunno if that is more clear).

-- >8 --
Subject: [PATCH] find_unique_abbrev: move logic out of get_short_sha1()

The get_short_sha1() is only about reading short sha1s; we
do call it in a loop to check "is this long enough" for each
object, but otherwise it should not need to know about
things like our default_abbrev setting.

So instead of asking it to set default_automatic_abbrev as a
side-effect, let's just have find_unique_abbrev() pick the
right place to start its loop.  This requires a separate
approximate_object_count() function, but that naturally
belongs with the rest of sha1_file.c.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     |  7 ++++++-
 sha1_file.c | 27 +++++++++++++++++++++++++++
 sha1_name.c | 60 +++++++++++++++++++++++++++++++++++-------------------------
 3 files changed, 68 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index 0e2a059..f22ace5 100644
--- a/cache.h
+++ b/cache.h
@@ -1204,7 +1204,6 @@ struct object_context {
 #define GET_SHA1_TREEISH          020
 #define GET_SHA1_BLOB             040
 #define GET_SHA1_FOLLOW_SYMLINKS 0100
-#define GET_SHA1_AUTOMATIC	 0200
 #define GET_SHA1_ONLY_TO_DIE    04000
 
 #define GET_SHA1_DISAMBIGUATORS \
@@ -1456,6 +1455,12 @@ extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
 
+/*
+ * Give a rough count of objects in the repository. This sacrifices accuracy
+ * for speed.
+ */
+unsigned long approximate_object_count(void);
+
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
diff --git a/sha1_file.c b/sha1_file.c
index b9c1fa3..4882440 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1381,6 +1381,32 @@ static void prepare_packed_git_one(char *objdir, int local)
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
@@ -1455,6 +1481,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
+	approximate_object_count_valid = 0;
 	prepare_packed_git_run_once = 0;
 	prepare_packed_git();
 }
diff --git a/sha1_name.c b/sha1_name.c
index beb7ab5..76e6885 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -15,7 +15,6 @@ typedef int (*disambiguate_hint_fn)(const unsigned char *, void *);
 
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
-	unsigned int nrobjects;
 	char hex_pfx[GIT_SHA1_HEXSZ + 1];
 	unsigned char bin_pfx[GIT_SHA1_RAWSZ];
 
@@ -119,14 +118,6 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 
 			if (strlen(de->d_name) != 38)
 				continue;
-
-			/*
-			 * We only look at the one subdirectory, and we assume
-			 * each subdirectory is roughly similar, so each
-			 * object we find probably has 255 other objects in
-			 * the other fan-out directories.
-			 */
-			ds->nrobjects += 256;
 			if (memcmp(de->d_name, ds->hex_pfx + 2, ds->len - 2))
 				continue;
 			memcpy(hex + 2, de->d_name, 38);
@@ -160,7 +151,6 @@ static void unique_in_pack(struct packed_git *p,
 
 	open_pack_index(p);
 	num = p->num_objects;
-	ds->nrobjects += num;
 	last = num;
 	while (first < last) {
 		uint32_t mid = (first + last) / 2;
@@ -390,9 +380,6 @@ static int show_ambiguous_object(const unsigned char *sha1, void *data)
 	return 0;
 }
 
-/* start from our historical default before the automatic abbreviation */
-static int default_automatic_abbrev = FALLBACK_DEFAULT_ABBREV;
-
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
 {
@@ -439,14 +426,6 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);
 	}
 
-	if (len < 16 && !status && (flags & GET_SHA1_AUTOMATIC)) {
-		unsigned int expect_collision = 1 << (len * 2);
-		if (ds.nrobjects > expect_collision) {
-			default_automatic_abbrev = len+1;
-			return SHORT_NAME_AMBIGUOUS;
-		}
-	}
-
 	return status;
 }
 
@@ -476,22 +455,53 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 	return ret;
 }
 
+/*
+ * Return the slot of the most-significant bit set in "val". There are various
+ * ways to do this quickly with fls() or __builtin_clzl(), but speed is
+ * probably not a big deal here.
+ */
+unsigned msb(unsigned long val)
+{
+	unsigned r = 0;
+	while (val >>= 1)
+		r++;
+	return r;
+}
+
 int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 {
 	int status, exists;
-	int flags = GET_SHA1_QUIETLY;
 
 	if (len < 0) {
-		flags |= GET_SHA1_AUTOMATIC;
-		len = default_automatic_abbrev;
+		unsigned long count = approximate_object_count();
+		/*
+		 * Add one because the MSB only tells us the highest bit set,
+		 * not including the value of all the _other_ bits (so "15"
+		 * is only one off of 2^4, but the MSB is the 3rd bit.
+		 */
+		len = msb(count) + 1;
+		/*
+		 * We now know we have on the order of 2^len objects, which
+		 * expects a collision at 2^(len/2). But we also care about hex
+		 * chars, not bits, and there are 4 bits per hex. So all
+		 * together we need to divide by 2; but we also want to round
+		 * odd numbers up, hence adding one before dividing.
+		 */
+		len = (len + 1) / 2;
+		/*
+		 * For very small repos, we stick with our regular fallback.
+		 */
+		if (len < FALLBACK_DEFAULT_ABBREV)
+			len = FALLBACK_DEFAULT_ABBREV;
 	}
+
 	sha1_to_hex_r(hex, sha1);
 	if (len == 40 || !len)
 		return 40;
 	exists = has_sha1_file(sha1);
 	while (len < 40) {
 		unsigned char sha1_ret[20];
-		status = get_short_sha1(hex, len, sha1_ret, flags);
+		status = get_short_sha1(hex, len, sha1_ret, GET_SHA1_QUIETLY);
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
-- 
2.10.0.618.g82cc264

