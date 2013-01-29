From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] commit: look up commit info in metapack
Date: Tue, 29 Jan 2013 04:16:37 -0500
Message-ID: <20130129091637.GF9999@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 10:17:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U07JQ-00085n-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 10:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab3A2JQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 04:16:42 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53259 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab3A2JQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 04:16:41 -0500
Received: (qmail 20049 invoked by uid 107); 29 Jan 2013 09:18:03 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 04:18:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 04:16:37 -0500
Content-Disposition: inline
In-Reply-To: <20130129091434.GA6975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214922>

Now that we have the plumbing in place to generate and read
commit metapacks, we can hook them up to parse_commit to
fill in the traversal information much more quickly.

We only do so if save_commit_buffer is turned off;
otherwise, the callers will expect to be able to read
commit->buffer after parse_commit returns (and since our
cache obviously does not have that information, we must
leave it NULL). As callers learn to handle a NULL
commit->buffer, we can eventually relax this (while it might
seem like a useless no-op to use the cache if we are going
to load the commit anyway, many callers may first filter
based on the traversal, and end up loading the commit
message for only a subset of the commits).

With this patch (and having run "git metapack --all
--commits"), my best-of-five warm-cache "git rev-list
--count --all" traversal of linux-2.6.git drops from 4.219s
to 0.659s.

Similarly, cold-cache drops from 13.696s to 4.763s due to
the compactness of the cache data (but you are penalized, of
course, if you then want to actually look at the commit
messages, since you have not warmed them into the cache).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/commit.c b/commit.c
index e8eb0ae..b326201 100644
--- a/commit.c
+++ b/commit.c
@@ -8,6 +8,7 @@
 #include "notes.h"
 #include "gpg-interface.h"
 #include "mergesort.h"
+#include "commit-metapack.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -306,6 +307,24 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	return 0;
 }
 
+static int parse_commit_metapack(struct commit *item)
+{
+	unsigned char *tree, *p1, *p2;
+	uint32_t ts;
+
+	if (commit_metapack(item->object.sha1, &ts, &tree, &p1, &p2) < 0)
+		return -1;
+
+	item->date = ts;
+	item->tree = lookup_tree(tree);
+	commit_list_insert(lookup_commit(p1), &item->parents);
+	if (!is_null_sha1(p2))
+		commit_list_insert(lookup_commit(p2), &item->parents->next);
+
+	item->object.parsed = 1;
+	return 0;
+}
+
 int parse_commit(struct commit *item)
 {
 	enum object_type type;
@@ -317,6 +336,10 @@ int parse_commit(struct commit *item)
 		return -1;
 	if (item->object.parsed)
 		return 0;
+
+	if (!save_commit_buffer && !parse_commit_metapack(item))
+		return 0;
+
 	buffer = read_sha1_file(item->object.sha1, &type, &size);
 	if (!buffer)
 		return error("Could not read %s",
-- 
1.8.0.2.16.g72e2fc9
