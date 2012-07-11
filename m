From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/3] Replace strlen() with ce_namelen()
Date: Wed, 11 Jul 2012 11:22:38 +0200
Message-ID: <1341998558-8502-4-git-send-email-t.gummerer@gmail.com>
References: <7vy5mtlebz.fsf@alter.siamese.dyndns.org>
 <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 11:23:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sot8z-0001ya-1S
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 11:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab2GKJXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 05:23:25 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53868 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab2GKJXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 05:23:24 -0400
Received: by eekb15 with SMTP id b15so151988eek.19
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=55zqRLx12AX+nAGS3XwjSL1ORFnlzkaEKUoK3vl5m0c=;
        b=BrvsNsJJ00SWl0k96RILHHBaQs165noVSU+N47vnumA1Zp30YGq8Foh8PhcRfftwtN
         GXlXlIBjGjKT97bHJ/xpQsEdxZVWhVawivG2O0eoicuD+qXeDFs49Sw6w6kMT7AqRCW3
         9+cTpt0oSGtUsZki2oh3HUvVTDAU8ag0UdmCMyWXRujzSqd+x154XiR45OGKvt1CKdYG
         NQlRiigZMC/gYw/MkA22I6TrN/H+KQUTyGJ3awZP5KilhWjZuWLfvndbd/3g22jYQskL
         TxSPns9Fjp1Mx2yoCmZzTBffYhW7qhvio0NFXmyhnmmUdVLmGJ6KwLX9GujAUi3XnFVS
         yuAA==
Received: by 10.14.37.11 with SMTP id x11mr11735451eea.63.1341998602802;
        Wed, 11 Jul 2012 02:23:22 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id u56sm3885643eef.7.2012.07.11.02.23.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 02:23:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201292>

Replace strlen(ce->name) with ce_namelen() in a couple
of places which gives us some additional bits of
performance.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c   |    4 ++--
 unpack-trees.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index ac13bca..2f8159f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1128,7 +1128,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			continue;
 
 		if (pathspec &&
-		    !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
+		    !match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
@@ -1856,7 +1856,7 @@ int read_index_unmerged(struct index_state *istate)
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
