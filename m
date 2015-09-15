From: Jeff King <peff@peff.net>
Subject: [PATCH 61/67] notes: document length of fanout path with a constant
Date: Tue, 15 Sep 2015 12:13:11 -0400
Message-ID: <20150915161310.GI29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:13:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsr8-0007Or-8t
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbbIOQNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:13:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:59468 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752461AbbIOQNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:13:13 -0400
Received: (qmail 14544 invoked by uid 102); 15 Sep 2015 16:13:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:13:13 -0500
Received: (qmail 7973 invoked by uid 107); 15 Sep 2015 16:13:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:13:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:13:11 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277966>

We know that a fanned-out sha1 in a notes tree cannot be
more than "aa/bb/cc/...", and we have an assert() to confirm
that. But let's factor out that length into a constant so we
can be sure it is used consistently. And even though we
assert() earlier, let's replace a strcpy with xsnprintf, so
it is clear to a reader that all cases are covered.

Signed-off-by: Jeff King <peff@peff.net>
---
 notes.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/notes.c b/notes.c
index eacd2a6..db77922 100644
--- a/notes.c
+++ b/notes.c
@@ -539,6 +539,9 @@ static unsigned char determine_fanout(struct int_node *tree, unsigned char n,
 	return fanout + 1;
 }
 
+/* hex SHA1 + 19 * '/' + NUL */
+#define FANOUT_PATH_MAX 40 + 19 + 1
+
 static void construct_path_with_fanout(const unsigned char *sha1,
 		unsigned char fanout, char *path)
 {
@@ -551,7 +554,7 @@ static void construct_path_with_fanout(const unsigned char *sha1,
 		path[i++] = '/';
 		fanout--;
 	}
-	strcpy(path + i, hex_sha1 + j);
+	xsnprintf(path + i, FANOUT_PATH_MAX - i, "%s", hex_sha1 + j);
 }
 
 static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
@@ -562,7 +565,7 @@ static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
 	void *p;
 	int ret = 0;
 	struct leaf_node *l;
-	static char path[40 + 19 + 1];  /* hex SHA1 + 19 * '/' + NUL */
+	static char path[FANOUT_PATH_MAX];
 
 	fanout = determine_fanout(tree, n, fanout);
 	for (i = 0; i < 16; i++) {
@@ -595,7 +598,7 @@ redo:
 				/* invoke callback with subtree */
 				unsigned int path_len =
 					l->key_sha1[19] * 2 + fanout;
-				assert(path_len < 40 + 19);
+				assert(path_len < FANOUT_PATH_MAX - 1);
 				construct_path_with_fanout(l->key_sha1, fanout,
 							   path);
 				/* Create trailing slash, if needed */
-- 
2.6.0.rc2.408.ga2926b9
