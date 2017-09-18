Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68DD2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 15:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754202AbdIRPyc (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 11:54:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:42352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752920AbdIRPyb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 11:54:31 -0400
Received: (qmail 22681 invoked by uid 109); 18 Sep 2017 15:54:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Sep 2017 15:54:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26830 invoked by uid 111); 18 Sep 2017 15:55:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Sep 2017 11:55:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Sep 2017 11:54:29 -0400
Date:   Mon, 18 Sep 2017 11:54:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] read_info_alternates: read contents into strbuf
Message-ID: <20170918155429.hgql4ngayun5nbyd@sigill.intra.peff.net>
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The link_alt_odb_entries() function has always taken a
ptr/len pair as input. Until cf3c635210 (alternates: accept
double-quoted paths, 2016-12-12), we made a copy of those
bytes in a string. But after that commit, we switched to
parsing the input left-to-right, and we ignore "len"
totally, instead reading until we hit a NUL.

This has mostly gone unnoticed for a few reasons:

  1. All but one caller passes a NUL-terminated string, with
     "len" pointing to the NUL.

  2. The remaining caller, read_info_alternates(), passes in
     an mmap'd file. Unless the file is an exact multiple of
     the page size, it will generally be followed by NUL
     padding to the end of the page, which just works.

The easiest way to demonstrate the problem is to build with:

  make SANITIZE=address NO_MMAP=Nope test

Any test which involves $GIT_DIR/info/alternates will fail,
as the mmap emulation (correctly) does not add an extra NUL,
and ASAN complains about reading past the end of the buffer.

One solution would be to teach link_alt_odb_entries() to
respect "len". But it's actually a bit tricky, since we
depend on unquote_c_style() under the hood, and it has no
ptr/len variant.

We could also just make a NUL-terminated copy of the input
bytes and operate on that. But since all but one caller
already is passing a string, instead let's just fix that
caller to provide NUL-terminated input in the first place,
by swapping out mmap for strbuf_read_file().

There's no advantage to using mmap on the alternates file.
It's not expected to be large (and anyway, we're copying its
contents into an in-memory linked list). Nor is using
git_open() buying us anything here, since we don't keep the
descriptor open for a long period of time.

Let's also drop the "len" parameter entirely from
link_alt_odb_entries(), since it's completely ignored. That
will avoid any new callers re-introducing a similar bug.

Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
I didn't reproduce with the mmap even-page-size thing, but I
think it's the same reason we didn't notice the "git log -G"
read-past-mmap issues for a long time. Which makes testing
with ASAN and NO_MMAP an interesting combination, as it
should find out any similar cases (and after this, the whole
test suite passes with that configuration).

 sha1_file.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5f71bbac3e..b1e4193679 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -398,7 +398,7 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(const char *alt, int len, int sep,
+static void link_alt_odb_entries(const char *alt, int sep,
 				 const char *relative_base, int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
@@ -427,28 +427,17 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 
 static void read_info_alternates(const char * relative_base, int depth)
 {
-	char *map;
-	size_t mapsz;
-	struct stat st;
 	char *path;
-	int fd;
+	struct strbuf buf = STRBUF_INIT;
 
 	path = xstrfmt("%s/info/alternates", relative_base);
-	fd = git_open(path);
-	free(path);
-	if (fd < 0)
-		return;
-	if (fstat(fd, &st) || (st.st_size == 0)) {
-		close(fd);
+	if (strbuf_read_file(&buf, path, 1024) < 0) {
+		free(path);
 		return;
 	}
-	mapsz = xsize_t(st.st_size);
-	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
-	close(fd);
 
-	link_alt_odb_entries(map, mapsz, '\n', relative_base, depth);
-
-	munmap(map, mapsz);
+	link_alt_odb_entries(buf.buf, '\n', relative_base, depth);
+	strbuf_release(&buf);
 }
 
 struct alternate_object_database *alloc_alt_odb(const char *dir)
@@ -503,7 +492,7 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(lock))
 			die_errno("unable to move new alternates file into place");
 		if (alt_odb_tail)
-			link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
+			link_alt_odb_entries(reference, '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -516,7 +505,7 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
+	link_alt_odb_entries(reference, '\n', NULL, 0);
 }
 
 /*
@@ -619,7 +608,7 @@ void prepare_alt_odb(void)
 	if (!alt) alt = "";
 
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
+	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
 }
-- 
2.14.1.1014.g252e627ae0

