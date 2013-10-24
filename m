From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] checkout: do not die when leaving broken detached HEAD
Date: Thu, 24 Oct 2013 04:54:53 -0400
Message-ID: <20131024085452.GF1346@sigill.intra.peff.net>
References: <20131024085213.GA1267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 10:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZGh1-0006Rl-It
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 10:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab3JXIy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 04:54:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:54660 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752036Ab3JXIyz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 04:54:55 -0400
Received: (qmail 7611 invoked by uid 102); 24 Oct 2013 08:54:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 03:54:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 04:54:53 -0400
Content-Disposition: inline
In-Reply-To: <20131024085213.GA1267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236581>

If we move away from a detached HEAD that has broken or
corrupted commits, we might die in two places:

  1. Printing the "old HEAD was..." message.

  2. Printing the list of orphaned commits.

In both cases, we ignore the return value of parse_commit
and feed the resulting commit to the pretty-print machinery,
which will die() upon failing to read the commit object
itself.

Since both cases are ancillary to the real operation being
performed, let's be more robust and keep going. This lets
users more easily checkout away from broken history.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 34a2e43..1df55c0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -380,8 +380,8 @@ static void show_local_changes(struct object *head,
 static void describe_detached_head(const char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
-	parse_commit(commit);
-	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
+	if (!parse_commit(commit))
+		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
 	fprintf(stderr, "%s %s... %s\n", msg,
 		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
 	strbuf_release(&sb);
@@ -677,12 +677,12 @@ static int add_pending_uninteresting_ref(const char *refname,
 
 static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 {
-	parse_commit(commit);
 	strbuf_addstr(sb, "  ");
 	strbuf_addstr(sb,
 		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 	strbuf_addch(sb, ' ');
-	pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
+	if (!parse_commit(commit))
+		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
 	strbuf_addch(sb, '\n');
 }
 
-- 
1.8.4.1.898.g8bf8a41.dirty
