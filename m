From: Jeff King <peff@peff.net>
Subject: [PATCH 02/15] commit: push commit_index update into alloc_commit_node
Date: Mon, 9 Jun 2014 14:09:59 -0400
Message-ID: <20140609180959.GB20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:10:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu41G-0006U6-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbaFISKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:10:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:40334 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754071AbaFISKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:10:00 -0400
Received: (qmail 15594 invoked by uid 102); 9 Jun 2014 18:10:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:10:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:09:59 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251088>

Whenever we create a commit object via lookup_commit, we
give it a unique index to be used with the commit-slab API.
The theory is that any "struct commit" we create would
follow this code path, so any such struct would get an
index. However, callers could use alloc_commit_node()
directly (and get multiple commits with index 0).

Let's push the indexing into alloc_commit_node so that it's
hard for callers to get it wrong.

Signed-off-by: Jeff King <peff@peff.net>
---
This will make the alloc_report output a little uglier (it will say
raw_commit), but I don't think anyone cares. And I wanted to make sure
there wasn't an easy way to accidentally call the wrong alloc function
that doesn't handle the index.

 alloc.c  | 12 ++++++++++--
 commit.c |  2 --
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/alloc.c b/alloc.c
index 38ff7e7..eb22a45 100644
--- a/alloc.c
+++ b/alloc.c
@@ -47,10 +47,18 @@ union any_object {
 
 DEFINE_ALLOCATOR(blob, struct blob)
 DEFINE_ALLOCATOR(tree, struct tree)
-DEFINE_ALLOCATOR(commit, struct commit)
+DEFINE_ALLOCATOR(raw_commit, struct commit)
 DEFINE_ALLOCATOR(tag, struct tag)
 DEFINE_ALLOCATOR(object, union any_object)
 
+void *alloc_commit_node(void)
+{
+	static int commit_count;
+	struct commit *c = alloc_raw_commit_node();
+	c->index = commit_count++;
+	return c;
+}
+
 static void report(const char *name, unsigned int count, size_t size)
 {
 	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
@@ -64,7 +72,7 @@ void alloc_report(void)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
-	REPORT(commit, struct commit);
+	REPORT(raw_commit, struct commit);
 	REPORT(tag, struct tag);
 	REPORT(object, union any_object);
 }
diff --git a/commit.c b/commit.c
index f479331..21957ee 100644
--- a/commit.c
+++ b/commit.c
@@ -17,7 +17,6 @@ static struct commit_extra_header *read_commit_extra_header_lines(const char *bu
 int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
-static int commit_count;
 
 static struct commit *check_commit(struct object *obj,
 				   const unsigned char *sha1,
@@ -64,7 +63,6 @@ struct commit *lookup_commit(const unsigned char *sha1)
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
 		struct commit *c = alloc_commit_node();
-		c->index = commit_count++;
 		return create_object(sha1, OBJ_COMMIT, c);
 	}
 	if (!obj->type)
-- 
2.0.0.729.g520999f
