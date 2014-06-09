From: Jeff King <peff@peff.net>
Subject: [PATCH 03/15] do not create "struct commit" with xcalloc
Date: Mon, 9 Jun 2014 14:10:08 -0400
Message-ID: <20140609181008.GC20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:10:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu41O-0006aK-U6
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbaFISKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:10:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:40341 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753825AbaFISKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:10:09 -0400
Received: (qmail 15655 invoked by uid 102); 9 Jun 2014 18:10:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:10:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:10:08 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251089>

In both blame and merge-recursive, we sometimes create a
"fake" commit struct for convenience (e.g., to represent the
HEAD state as if we would commit it). By allocating
ourselves rather than using alloc_commit_node, we do not
properly set the "index" field of the commit. This can
produce subtle bugs if we then use commit-slab on the
resulting commit, as we will share the "0" index with
another commit.

We can fix this by using alloc_commit_node() to allocate.
Note that we cannot free the result, as it is part of our
commit allocator. However, both cases were already leaking
the allocated commit anyway, so there's nothing to fix up.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c   | 2 +-
 merge-recursive.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a52a279..d6056a5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2286,7 +2286,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	struct strbuf msg = STRBUF_INIT;
 
 	time(&now);
-	commit = xcalloc(1, sizeof(*commit));
+	commit = alloc_commit_node();
 	commit->object.parsed = 1;
 	commit->date = now;
 	commit->object.type = OBJ_COMMIT;
diff --git a/merge-recursive.c b/merge-recursive.c
index cab16fa..2b37d42 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -40,7 +40,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
-	struct commit *commit = xcalloc(1, sizeof(struct commit));
+	struct commit *commit = alloc_commit_node();
 	struct merge_remote_desc *desc = xmalloc(sizeof(*desc));
 
 	desc->name = comment;
-- 
2.0.0.729.g520999f
