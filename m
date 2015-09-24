From: Jeff King <peff@peff.net>
Subject: [PATCH 29/68] use strip_suffix and xstrfmt to replace suffix
Date: Thu, 24 Sep 2015 17:07:09 -0400
Message-ID: <20150924210709.GZ30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:10:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDml-0004jk-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbbIXVHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:35969 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753203AbbIXVHM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:12 -0400
Received: (qmail 11964 invoked by uid 102); 24 Sep 2015 21:07:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:11 -0500
Received: (qmail 29221 invoked by uid 107); 24 Sep 2015 21:07:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:09 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278626>

When we want to convert "foo.pack" to "foo.idx", we do it by
duplicating the original string and then munging the bytes
in place. Let's use strip_suffix and xstrfmt instead, which
has several advantages:

  1. It's more clear what the intent is.

  2. It does not implicitly rely on the fact that
     strlen(".idx") <= strlen(".pack") to avoid an overflow.

  3. We communicate the assumption that the input file ends
     with ".pack" (and get a run-time check that this is so).

  4. We drop calls to strcpy, which makes auditing the code
     base easier.

Likewise, we can do this to convert ".pack" to ".bitmap",
avoiding some manual memory computation.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c        |  7 ++++---
 pack-bitmap.c | 13 ++++---------
 sha1_file.c   |  6 ++++--
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/http.c b/http.c
index 7b02259..e0ff876 100644
--- a/http.c
+++ b/http.c
@@ -1511,6 +1511,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
 	char *tmp_idx;
+	size_t len;
 	struct child_process ip = CHILD_PROCESS_INIT;
 	const char *ip_argv[8];
 
@@ -1524,9 +1525,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	tmp_idx = xstrdup(preq->tmpfile);
-	strcpy(tmp_idx + strlen(tmp_idx) - strlen(".pack.temp"),
-	       ".idx.temp");
+	if (!strip_suffix(preq->tmpfile, ".pack.temp", &len))
+		die("BUG: pack tmpfile does not end in .pack.temp?");
+	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile);
 
 	ip_argv[0] = "index-pack";
 	ip_argv[1] = "-o";
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 637770a..7dfcb34 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -252,16 +252,11 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 
 static char *pack_bitmap_filename(struct packed_git *p)
 {
-	char *idx_name;
-	int len;
-
-	len = strlen(p->pack_name) - strlen(".pack");
-	idx_name = xmalloc(len + strlen(".bitmap") + 1);
-
-	memcpy(idx_name, p->pack_name, len);
-	memcpy(idx_name + len, ".bitmap", strlen(".bitmap") + 1);
+	size_t len;
 
-	return idx_name;
+	if (!strip_suffix(p->pack_name, ".pack", &len))
+		die("BUG: pack_name does not end in .pack");
+	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
 }
 
 static int open_pack_bitmap_1(struct packed_git *packfile)
diff --git a/sha1_file.c b/sha1_file.c
index 592226e..2be1afd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -671,13 +671,15 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 int open_pack_index(struct packed_git *p)
 {
 	char *idx_name;
+	size_t len;
 	int ret;
 
 	if (p->index_data)
 		return 0;
 
-	idx_name = xstrdup(p->pack_name);
-	strcpy(idx_name + strlen(idx_name) - strlen(".pack"), ".idx");
+	if (!strip_suffix(p->pack_name, ".pack", &len))
+		die("BUG: pack_name does not end in .pack");
+	idx_name = xstrfmt("%.*s.idx", (int)len, p->pack_name);
 	ret = check_packed_git_idx(idx_name, p);
 	free(idx_name);
 	return ret;
-- 
2.6.0.rc3.454.g204ad51
