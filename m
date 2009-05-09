From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/10] bisect: use "sha1_array" to store skipped revisions
Date: Sat, 09 May 2009 17:55:38 +0200
Message-ID: <20090509155548.5387.50168.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p1k-00065t-9W
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbZEIQDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753712AbZEIQDn
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:43 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:53160 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbZEIQDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:38 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 962854B008E;
	Sat,  9 May 2009 18:03:33 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 61D684B015C;
	Sat,  9 May 2009 18:03:30 +0200 (CEST)
X-git-sha1: 76f46cf0a67349bc4034152b8646d23fc11db2be 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch creates a "struct sha1_array" to store skipped revisions,
so that the same struct can be reused in a later patch for good
revisions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4796aa9..12df855 100644
--- a/bisect.c
+++ b/bisect.c
@@ -9,9 +9,13 @@
 #include "run-command.h"
 #include "bisect.h"
 
-static unsigned char (*skipped_sha1)[20];
-static int skipped_sha1_nr;
-static int skipped_sha1_alloc;
+struct sha1_array {
+	unsigned char (*sha1)[20];
+	int sha1_nr;
+	int sha1_alloc;
+};
+
+static struct sha1_array skipped_revs;
 
 static const char **rev_argv;
 static int rev_argv_nr;
@@ -420,9 +424,9 @@ static int register_ref(const char *refname, const unsigned char *sha1,
 		ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
 		rev_argv[rev_argv_nr++] = good;
 	} else if (!prefixcmp(refname, "skip-")) {
-		ALLOC_GROW(skipped_sha1, skipped_sha1_nr + 1,
-			   skipped_sha1_alloc);
-		hashcpy(skipped_sha1[skipped_sha1_nr++], sha1);
+		ALLOC_GROW(skipped_revs.sha1, skipped_revs.sha1_nr + 1,
+			   skipped_revs.sha1_alloc);
+		hashcpy(skipped_revs.sha1[skipped_revs.sha1_nr++], sha1);
 	}
 
 	return 0;
@@ -466,7 +470,8 @@ static int skipcmp(const void *a, const void *b)
 
 static void prepare_skipped(void)
 {
-	qsort(skipped_sha1, skipped_sha1_nr, sizeof(*skipped_sha1), skipcmp);
+	qsort(skipped_revs.sha1, skipped_revs.sha1_nr,
+	      sizeof(*skipped_revs.sha1), skipcmp);
 }
 
 static const unsigned char *skipped_sha1_access(size_t index, void *table)
@@ -477,7 +482,7 @@ static const unsigned char *skipped_sha1_access(size_t index, void *table)
 
 static int lookup_skipped(unsigned char *sha1)
 {
-	return sha1_pos(sha1, skipped_sha1, skipped_sha1_nr,
+	return sha1_pos(sha1, skipped_revs.sha1, skipped_revs.sha1_nr,
 			skipped_sha1_access);
 }
 
@@ -489,7 +494,7 @@ struct commit_list *filter_skipped(struct commit_list *list,
 
 	*tried = NULL;
 
-	if (!skipped_sha1_nr)
+	if (!skipped_revs.sha1_nr)
 		return list;
 
 	prepare_skipped();
@@ -551,7 +556,7 @@ static void bisect_common(struct rev_info *revs, const char *prefix,
 		mark_edges_uninteresting(revs->commits, revs, NULL);
 
 	revs->commits = find_bisection(revs->commits, reaches, all,
-				       !!skipped_sha1_nr);
+				       !!skipped_revs.sha1_nr);
 }
 
 static void exit_if_skipped_commits(struct commit_list *tried,
-- 
1.6.3.rc1.112.g17e25
