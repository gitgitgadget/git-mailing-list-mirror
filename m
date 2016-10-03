Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B06207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbcJCW1I (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:27:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:51597 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752672AbcJCW1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:27:05 -0400
Received: (qmail 25132 invoked by uid 109); 3 Oct 2016 22:27:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 22:27:04 +0000
Received: (qmail 31130 invoked by uid 111); 3 Oct 2016 22:27:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 18:27:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 18:27:02 -0400
Date:   Mon, 3 Oct 2016 18:27:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] abbrev: auto size the default abbreviation
Message-ID: <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net>
References: <20161001001937.10884-1-gitster@pobox.com>
 <20161001001937.10884-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161001001937.10884-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 05:19:37PM -0700, Junio C Hamano wrote:

> Introduce a mechanism, where we estimate the number of objects in
> the repository upon the first request to abbreviate an object name
> with the default setting and come up with a sane default for the
> repository.  Based on the expectation that we would see collision in
> a repository with 2^(2N) objects when using object names shortened
> to first N bits, use sufficient number of hexdigits to cover the
> number of objects in the repository.  Each hexdigit (4-bits) we add
> to the shortened name allows us to have four times (2-bits) as many
> objects in the repository.
> 
> ---
>  cache.h       |  1 +
>  environment.c |  2 +-
>  sha1_name.c   | 28 +++++++++++++++++++++++++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)

For reference, here's a working version that just uses a separate
counting function (no commit message, because I would just steal the one
from Linus ;) ).

---
 cache.h       |  6 ++++++
 environment.c |  2 +-
 sha1_file.c   | 27 +++++++++++++++++++++++++++
 sha1_name.c   | 20 ++++++++++++++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 5a651b8..f22ace5 100644
--- a/cache.h
+++ b/cache.h
@@ -1455,6 +1455,12 @@ extern void prepare_packed_git(void);
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
 
diff --git a/environment.c b/environment.c
index 44fb107..6f9d290 100644
--- a/environment.c
+++ b/environment.c
@@ -16,7 +16,7 @@ int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
-int minimum_abbrev = 4, default_abbrev = FALLBACK_DEFAULT_ABBREV;
+int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
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
index 3b647fd..ecc4b54 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -455,10 +455,30 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
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
 
+	if (len < 0) {
+		unsigned long count = approximate_object_count();
+		len = (msb(count) + 1) / 2;
+		if (len < 0)
+			len = FALLBACK_DEFAULT_ABBREV;
+	}
+
 	sha1_to_hex_r(hex, sha1);
 	if (len == 40 || !len)
 		return 40;
-- 
2.10.0.618.g82cc264

