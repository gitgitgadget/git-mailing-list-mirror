From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] use parse_commit_or_die instead of custom message
Date: Tue, 8 Oct 2013 09:57:50 -0400
Message-ID: <20131008135750.GD7650@sigill.intra.peff.net>
References: <20131008134843.GA7530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 09 18:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTwlH-0001kT-U7
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 18:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab3JIQhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 12:37:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:46328 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751692Ab3JIQhP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 12:37:15 -0400
Received: (qmail 22640 invoked by uid 102); 8 Oct 2013 13:57:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Oct 2013 08:57:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Oct 2013 09:57:50 -0400
Content-Disposition: inline
In-Reply-To: <20131008134843.GA7530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235823>

Many calls to parse_commit detect errors and die. In some
cases, the custom error messages are more useful than what
parse_commit_or_die could produce, because they give some
context, like which ref the commit came from. Some, however,
just say "invalid commit". Let's convert the latter to use
parse_commit_or_die; its message is slightly more informative,
and it makes the error more consistent throughout git.

Signed-off-by: Jeff King <peff@peff.net>
---
 shallow.c     | 3 +--
 upload-pack.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/shallow.c b/shallow.c
index cdf37d6..961cf6f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -90,8 +90,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 				cur_depth = *(int *)commit->util;
 			}
 		}
-		if (parse_commit(commit))
-			die("invalid commit");
+		parse_commit_or_die(commit);
 		cur_depth++;
 		if (cur_depth >= depth) {
 			commit_list_insert(commit, &result);
diff --git a/upload-pack.c b/upload-pack.c
index a6c54e0..abe6636 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -649,8 +649,7 @@ static void receive_needs(void)
 				/* make sure the real parents are parsed */
 				unregister_shallow(object->sha1);
 				object->parsed = 0;
-				if (parse_commit((struct commit *)object))
-					die("invalid commit");
+				parse_commit_or_die((struct commit *)object);
 				parents = ((struct commit *)object)->parents;
 				while (parents) {
 					add_object_array(&parents->item->object,
-- 
1.8.4.1.4.gf327177
