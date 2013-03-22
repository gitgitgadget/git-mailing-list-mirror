From: Jeff King <peff@peff.net>
Subject: [PATCH 7/4] submodule: clarify logic in show_submodule_summary
Date: Fri, 22 Mar 2013 12:19:56 -0400
Message-ID: <20130322161955.GA25857@sigill.intra.peff.net>
References: <20130322161837.GG3083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 17:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ4hn-0003U3-F3
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 17:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933802Ab3CVQUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 12:20:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35850 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933747Ab3CVQUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 12:20:04 -0400
Received: (qmail 2113 invoked by uid 107); 22 Mar 2013 16:21:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 12:21:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 12:19:56 -0400
Content-Disposition: inline
In-Reply-To: <20130322161837.GG3083@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218818>

There are two uses of the "left" and "right" commit
variables that make it hard to be sure what values they
have (both for the reader, and for gcc, which wrongly
complains that they might be used uninitialized).

The functions starts with a cascading if statement, checking
that the input sha1s exist, and finally working up to
preparing a revision walk. We only prepare the walk if the
cascading conditional did not find any problems, which we
check by seeing whether it set the "message" variable or
not. It's simpler and more obvious to just add a condition
to the end of the cascade.

Later, we check the same "message" variable when deciding
whether to clear commit marks on the left/right commits; if
it is set, we presumably never started the walk. This is
wrong, though; we might have started the walk and munged
commit flags, only to encounter an error afterwards. We
should always clear the flags on left/right if they exist,
whether the walk was successful or not.

Signed-off-by: Jeff King <peff@peff.net>
---
 submodule.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9ba1496..975bc87 100644
--- a/submodule.c
+++ b/submodule.c
@@ -261,7 +261,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
-	struct commit *left = left, *right = right;
+	struct commit *left = NULL, *right = NULL;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
 	int fast_forward = 0, fast_backward = 0;
@@ -275,10 +275,8 @@ void show_submodule_summary(FILE *f, const char *path,
 	else if (!(left = lookup_commit_reference(one)) ||
 		 !(right = lookup_commit_reference(two)))
 		message = "(commits not present)";
-
-	if (!message &&
-	    prepare_submodule_summary(&rev, path, left, right,
-					&fast_forward, &fast_backward))
+	else if (prepare_submodule_summary(&rev, path, left, right,
+					   &fast_forward, &fast_backward))
 		message = "(revision walker failed)";
 
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
@@ -302,11 +300,12 @@ void show_submodule_summary(FILE *f, const char *path,
 		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
 	fwrite(sb.buf, sb.len, 1, f);
 
-	if (!message) {
+	if (!message) /* only NULL if we succeeded in setting up the walk */
 		print_submodule_summary(&rev, f, del, add, reset);
+	if (left)
 		clear_commit_marks(left, ~0);
+	if (right)
 		clear_commit_marks(right, ~0);
-	}
 
 	strbuf_release(&sb);
 }
-- 
1.8.2.13.g0f18d3c
