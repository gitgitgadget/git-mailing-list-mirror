From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] do not run pager with diff --no-index --quiet
Date: Fri, 15 Jun 2012 16:32:55 -0400
Message-ID: <20120615203255.GB12326@sigill.intra.peff.net>
References: <20120615202813.GA12253@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:33:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfdCY-0002t5-R2
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725Ab2FOUc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 16:32:58 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57786
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757589Ab2FOUc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 16:32:58 -0400
Received: (qmail 3903 invoked by uid 107); 15 Jun 2012 20:33:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 16:33:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 16:32:55 -0400
Content-Disposition: inline
In-Reply-To: <20120615202813.GA12253@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200096>

There is no point in running a pager when --quiet is given,
since we are producing no output. The regular diff code path
handles this already, because --quiet implies --exit-code,
and we check for --exit-code when deciding not to run the
pager.

However, the "quiet implies exit-code" logic is done in
diff_setup_done, and the no-index code path sets up its
pager before running diff_setup_done, and misses this case.

We can fix this by reordering our initialization.
Currently we do:

  1. read command line arguments into diff_options

  2. Set pager if EXIT_CODE not requested

  3. always set EXIT_CODE, since we are emulating
     traditional diff

  4. call diff_setup_done

We can fix the problem by moving pager initialization (step
2) after step 4. But step 3 must come after step 2 (since we
want to know whether the _user_ requested --exit-code, not
whether we turned it on unconditionally). So we must move
both.

Signed-off-by: Jeff King <peff@peff.net>
---
We could also just check for QUICK in setup_diff_pager, which should be
a no-op for the regular diff case. But I think doing things in the same
order as regular diff could help prevent similar bugs in the future.

 diff-no-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index fc1decd..77667b8 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -224,8 +224,6 @@ void diff_no_index(struct rev_info *revs,
 		}
 	}
 
-	setup_diff_pager(&revs->diffopt);
-
 	if (prefix) {
 		int len = strlen(prefix);
 		const char *paths[3];
@@ -250,13 +248,15 @@ void diff_no_index(struct rev_info *revs,
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
 	DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
 
 	revs->max_count = -2;
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
 
+	setup_diff_pager(&revs->diffopt);
+	DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
+
 	if (queue_diff(&revs->diffopt, revs->diffopt.pathspec.raw[0],
 		       revs->diffopt.pathspec.raw[1]))
 		exit(1);
-- 
1.7.11.rc2.4.g0b9de53
