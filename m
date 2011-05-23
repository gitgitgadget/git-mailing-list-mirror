From: Anthony Foiani <anthony.foiani@gmail.com>
Subject: [PATCH] Only use core 'git diff' if both paths are within the repo.
Date: Sun, 22 May 2011 22:44:16 -0600
Message-ID: <4dd9e779.6300440a.1871.ffffcd9d@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 06:50:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QON5m-0007Bt-Hb
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 06:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab1EWEuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 00:50:05 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:60882 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab1EWEuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 00:50:03 -0400
Received: by pxi16 with SMTP id 16so3619572pxi.4
        for <git@vger.kernel.org>; Sun, 22 May 2011 21:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:from:date:subject:to;
        bh=j/pA8pjF+9OC9d28+WwdHsX9rZnGKqiPc8dI5govsBM=;
        b=NywGs/vQggTi/tPElIJDMXvbKZH7/6s1AGJebO+RjSub1Lqw/ojPcUTL51LOxsTivB
         QGYRAafcHxY+bzrn+iNOfanvValytx0cl0aVDt3QbeDqUiGHMqZ+yq5ZNSZM/jnKC0ro
         Og8kolhpiJZWXgTVHWs25B4jTFocf9KdWDUyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:subject:to;
        b=KdpwqZIDYwYo153kPuteC9TJd+xdtAkrJv5/y9iEnmUzxkLHTZZq7oPF+i2f5na45/
         e+pgZ0PVrrWfBIEi0gvBnicU5vBbkwYsXBzx9jaUVkHyyZ5Q2/H8LOq3FmhOIIA5KbcG
         d5asmniUkqpxvp8iymakQgwawJSbWw977PHgQ=
Received: by 10.68.63.5 with SMTP id c5mr1989281pbs.87.1306126202748;
        Sun, 22 May 2011 21:50:02 -0700 (PDT)
Received: from localhost (c-76-113-6-93.hsd1.nm.comcast.net [76.113.6.93])
        by mx.google.com with ESMTPS id 3sm4109526pbd.100.2011.05.22.21.50.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 May 2011 21:50:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174224>

The core 'git diff' engine can only handle pathspecs that are within a
given repo.  Make sure that we don't invoke it unless both pathspec
values are in the repo.

Signed-off-by: Anthony Foiani <anthony.foiani@gmail.com>
---
 diff-no-index.c |   39 ++++++++++++---------------------------
 1 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 3172788..b651f6d 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -227,43 +227,28 @@ void diff_no_index(struct rev_info *revs,
 	/* If --no-index wasn't specified explicitly, check to see if
 	 * we need to force it. */
 	if (!no_index) {
-
-		/* The first pathspec is the "left hand side" */
-		const char *lhs = (n_paths >= 1) ? argv[i] : NULL;
-		const int lhs_in_repo = lhs && path_in_repo(lhs);
-
-		/* And the second is the "right hand side" */
-		const char *rhs = (n_paths >= 2) ? argv[i+1] : NULL;
-		const int rhs_in_repo = rhs && path_in_repo(rhs);
-
-		int force_no_index = 0;
-
 		if (nongit) {
 			warning("'git diff' outside a repo, forcing --no-index");
-			force_no_index = 1;
 		}
 		else {
-			if (lhs_in_repo || rhs_in_repo)
-				return; /* Normal git diff, let core handle it. */
-
-			const int lhs_untracked = (lhs && !lhs_in_repo);
-			const int rhs_untracked = (rhs && !rhs_in_repo);
+			/* lhs = "left hand side", rhs = "right hand side" */
+			const char *lhs = (n_paths >= 1) ? argv[i] : NULL;
+			const char *rhs = (n_paths >= 2) ? argv[i+1] : NULL;
+			const int lhs_tracked = lhs && path_in_repo(lhs);
+			const int rhs_tracked = rhs && path_in_repo(rhs);
 
-			if (lhs_untracked && rhs_untracked)
-				warning("neither '%s' nor '%s' are tracked,"
-					" forcing --no-index", lhs, rhs );
-			else if (lhs_untracked)
+			if (lhs_tracked && rhs_tracked)
+				return; /* Normal git diff, let core handle it. */
+			else if (!lhs_tracked)
 				warning("'%s' is not tracked,"
 					" forcing --no-index", lhs );
-			else if (rhs_untracked)
+			else if (!rhs_tracked)
 				warning("'%s' is not tracked,"
 					" forcing --no-index", rhs );
-
-			force_no_index = lhs_untracked || rhs_untracked;
+			else
+				warning("neither '%s' nor '%s' are tracked,"
+					" forcing --no-index", lhs, rhs );
 		}
-
-		if (!force_no_index) /* Impossible? */
-			die("--no-index not set and not forced");
 	}
 
 	if (n_paths != 2) {
-- 
1.7.4.4
