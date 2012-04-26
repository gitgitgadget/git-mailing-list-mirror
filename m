From: mhagger@alum.mit.edu
Subject: [PATCH v2 10/18] bisect: copy filename string obtained from git_path()
Date: Fri, 27 Apr 2012 00:26:59 +0200
Message-ID: <1335479227-7877-11-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:28:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXAe-0000Fw-Hu
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759534Ab2DZW17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:59 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37113 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755679Ab2DZW1a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:30 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 37A71248140;
	Fri, 27 Apr 2012 00:27:29 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196441>

From: Michael Haggerty <mhagger@alum.mit.edu>

Prevent the string from being overwritten by other callers of
git_path() and friends before we are done using it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Otherwise, this bug will be triggered by later patches in the series.

I didn't do a careful code audit of this problem, but it seems very
plausible that that check_ancestors() and/or check_merge_bases() are
guilty.  They certainly do a lot more than should be done while
holding on to a pointer to a statically-allocated buffer.

I cursorily checked other code in the neighborhood for similar abuses,
but it would be good for an expert to look it over.

 bisect.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6e186e2..48acf73 100644
--- a/bisect.c
+++ b/bisect.c
@@ -833,7 +833,7 @@ static int check_ancestors(const char *prefix)
  */
 static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 {
-	const char *filename = git_path("BISECT_ANCESTORS_OK");
+	char *filename = xstrdup(git_path("BISECT_ANCESTORS_OK"));
 	struct stat st;
 	int fd;
 
@@ -842,11 +842,11 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
-		return;
+		goto done;
 
 	/* Bisecting with no good rev is ok. */
 	if (good_revs.nr == 0)
-		return;
+		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
 	if (check_ancestors(prefix))
@@ -859,6 +859,8 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 			filename, strerror(errno));
 	else
 		close(fd);
+ done:
+	free(filename);
 }
 
 /*
-- 
1.7.10
