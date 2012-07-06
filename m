From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 2/2] Replace strlen() with ce_namelen()
Date: Fri,  6 Jul 2012 18:07:30 +0200
Message-ID: <1341590850-15653-3-git-send-email-t.gummerer@gmail.com>
References: <7vtxxns4z4.fsf@alter.siamese.dyndns.org>
 <1341590850-15653-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, gitster@pobox.com, mhagger@alum.mit.edu,
	pclouds@gmail.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 18:08:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnB58-0000fP-C4
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 18:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab2GFQIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 12:08:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52473 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab2GFQI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 12:08:27 -0400
Received: by eaak11 with SMTP id k11so3714678eaa.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UnR9+UxYLtAeIdwWKX/aLQlYQpSdnlBdwhdF1tpNbXo=;
        b=uXZPpEoVRqvdKeJZxwtXvo2Vl1ZUK43PdqgAnY2TUu21xYQL8CBcn1M+POzGDD5yS7
         hKuPzAMbRe8MsJJXWVcVD+lgwai1uB/JqL5oCpvxjsJDchiro6S+ZUJR3t95nj+4U6G5
         2yKnoNrRXkYEvtp82VvH6qng3y1ZvjsrRqOw5/ypUOTYUb6CufhQMmXjAI3I0d6M19BI
         YWYU5Ezp5i4LcIuu9GGGGxWGL6pwWCciw1Rx9YWDoibJpLVPvbZutSXDwsUjieyPUL76
         KH5c9oE6zdw+GyRMq4qMYOuMGoMp/TOFWavaY/oNaTybW68aCTvmd+/oqwFjyM/TPWhk
         SbGA==
Received: by 10.14.37.11 with SMTP id x11mr7607116eea.63.1341590906498;
        Fri, 06 Jul 2012 09:08:26 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id h53sm72701261eea.1.2012.07.06.09.08.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 09:08:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1341590850-15653-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201118>

Replace strlen(ce->name) with ce_namelen() in a couple
of places which gives us some additional bits of
performance.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c   |    4 ++--
 unpack-trees.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index ea75c89..a77877a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1124,7 +1124,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			continue;
 
 		if (pathspec &&
-		    !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
+		    !match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
@@ -1852,7 +1852,7 @@ int read_index_unmerged(struct index_state *istate)
 		if (!ce_stage(ce))
 			continue;
 		unmerged = 1;
-		len = strlen(ce->name);
+		len = ce_namelen(ce);
 		size = cache_entry_size(len);
 		new_ce = xcalloc(1, size);
 		memcpy(new_ce->name, ce->name, len);
diff --git a/unpack-trees.c b/unpack-trees.c
index 9981dd3..abd0988 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1289,7 +1289,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce,
 	 * First let's make sure we do not have a local modification
 	 * in that directory.
 	 */
-	namelen = strlen(ce->name);
+	namelen = ce_namelen(ce);
 	for (i = locate_in_src_index(ce, o);
 	     i < o->src_index->cache_nr;
 	     i++) {
-- 
1.7.10.GIT
