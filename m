From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] branch: improve error message for missing
 --set-upstream-to ref
Date: Tue, 2 Apr 2013 15:04:27 -0400
Message-ID: <20130402190427.GC32316@sigill.intra.peff.net>
References: <20130402190134.GA17784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Garrett Cooper <yaneurabeya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6W9-0007LU-Hj
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959Ab3DBTEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52490 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932947Ab3DBTEb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:31 -0400
Received: (qmail 12864 invoked by uid 107); 2 Apr 2013 19:06:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 15:06:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 15:04:27 -0400
Content-Disposition: inline
In-Reply-To: <20130402190134.GA17784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219841>

If we are trying to set the upstream config for a branch,
the create_branch function will check both that the name
resolves as a ref, and that it is either a local or
remote-tracking branch.

However, before we do so we run get_sha1 on it to find out
whether it resolves at all (since the create_branch function
is also used to create actual branches, it wants to know
where to start the new branch). This means that if you feed
a ref that does not exist to "branch --set-upstream-to",
rather than getting a helpful message about tracking, you
only get "not a valid object name".

Signed-off-by: Jeff King <peff@peff.net>
---
 branch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 1acbd4e..060e9e3 100644
--- a/branch.c
+++ b/branch.c
@@ -199,6 +199,8 @@ N_("Cannot setup tracking information; starting point is not a branch.");
 
 static const char upstream_not_branch[] =
 N_("Cannot setup tracking information; starting point is not a branch.");
+static const char upstream_missing[] =
+N_("Cannot setup tracking information; starting point does not exist");
 
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
@@ -227,8 +229,11 @@ void create_branch(const char *head,
 	}
 
 	real_ref = NULL;
-	if (get_sha1(start_name, sha1))
+	if (get_sha1(start_name, sha1)) {
+		if (explicit_tracking)
+			die(_(upstream_missing));
 		die("Not a valid object name: '%s'.", start_name);
+	}
 
 	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
 	case 0:
-- 
1.8.2.rc0.33.gd915649
