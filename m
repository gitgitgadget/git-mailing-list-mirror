From: Jeff King <peff@peff.net>
Subject: [PATCH 02/17] replace dangerous uses of strbuf_attach
Date: Tue, 10 Jun 2014 17:38:38 -0400
Message-ID: <20140610213838.GB19147@sigill.intra.peff.net>
References: <20140610213509.GA26979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 23:38:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTkh-0003XQ-Id
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbaFJVij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:38:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:41358 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752302AbaFJVij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:38:39 -0400
Received: (qmail 19371 invoked by uid 102); 10 Jun 2014 21:38:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:38:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:38:38 -0400
Content-Disposition: inline
In-Reply-To: <20140610213509.GA26979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251245>

It is not a good idea to strbuf_attach an arbitrary pointer
just because a function you are calling wants a strbuf.
Attaching implies a transfer of memory ownership; if anyone
were to modify or release the resulting strbuf, we would
free() the pointer, leading to possible problems:

  1. Other users of the original pointer might access freed
     memory.

  2. The pointer might not be the start of a malloc'd
     area, so calling free() on it in the first place would
     be wrong.

In the two cases modified here, we are fortunate that nobody
touches the strbuf once it is attached, but it is an
accident waiting to happen.  Since the previous commit,
commit_tree and friends take a pointer/buf pair, so we can
just do away with the strbufs entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
I also manually checked the other dozen or so calls to strbuf_attach,
and they all look good.

 notes-cache.c | 6 ++----
 notes-merge.c | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/notes-cache.c b/notes-cache.c
index 4ad0799..c4e9bb7 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -48,7 +48,6 @@ int notes_cache_write(struct notes_cache *c)
 {
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
-	struct strbuf msg = STRBUF_INIT;
 
 	if (!c || !c->tree.initialized || !c->tree.ref || !*c->tree.ref)
 		return -1;
@@ -57,9 +56,8 @@ int notes_cache_write(struct notes_cache *c)
 
 	if (write_notes_tree(&c->tree, tree_sha1))
 		return -1;
-	strbuf_attach(&msg, c->validity,
-		      strlen(c->validity), strlen(c->validity) + 1);
-	if (commit_tree(msg.buf, msg.len, tree_sha1, NULL, commit_sha1, NULL, NULL) < 0)
+	if (commit_tree(c->validity, strlen(c->validity), tree_sha1, NULL,
+			commit_sha1, NULL, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
 		       0, UPDATE_REFS_QUIET_ON_ERR) < 0)
diff --git a/notes-merge.c b/notes-merge.c
index 9d94210..697cec3 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -673,7 +673,6 @@ int notes_merge_commit(struct notes_merge_options *o,
 	struct dirent *e;
 	struct strbuf path = STRBUF_INIT;
 	char *msg = strstr(partial_commit->buffer, "\n\n");
-	struct strbuf sb_msg = STRBUF_INIT;
 	int baselen;
 
 	strbuf_addstr(&path, git_path(NOTES_MERGE_WORKTREE));
@@ -720,10 +719,8 @@ int notes_merge_commit(struct notes_merge_options *o,
 		strbuf_setlen(&path, baselen);
 	}
 
-	strbuf_attach(&sb_msg, msg, strlen(msg), strlen(msg) + 1);
 	create_notes_commit(partial_tree, partial_commit->parents,
-			    sb_msg.buf, sb_msg.len,
-			    result_sha1);
+			    msg, strlen(msg), result_sha1);
 	if (o->verbosity >= 4)
 		printf("Finalized notes merge commit: %s\n",
 			sha1_to_hex(result_sha1));
-- 
2.0.0.729.g520999f
