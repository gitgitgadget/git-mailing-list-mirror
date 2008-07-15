From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC/PATCH 0/2] Enhance performance of blame -C -C
Date: Wed, 16 Jul 2008 01:58:34 +0400
Organization: TEPKOM
Message-ID: <200807160158.34994.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 23:59:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsYo-0005vw-Du
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbYGOV6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 17:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbYGOV6u
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:58:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:31325 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbYGOV6t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 17:58:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2348512fgg.17
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vM62En9Un4WLO6EKT5c9AT8iDYlQyDQyRN1MW4HRfWQ=;
        b=eiZLuRSP2YkCCNJu2fZbZE9rcWIp/11jjWQ3GlBx155NrejhHkB1vneESnmseIDRJA
         Q+QHp2Mx71oI+K0wL57q0Fktcv8C42JQtp5bEkGHtqq/7zka+nQ6k3kcfT1KzJtujSBx
         oXKJBeZJm97ZF6A+GwMLDHMRP8YZH9YFJKzb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=liF2JBJBkvXfaPWot23CFHOgfY3nqZPvi/oRSGNM+rMN93x7RYEAR6ZfmOaE6KlYtD
         nqnY/OJJplWj21ccv0RbUgv7bLAAHHm8KKMYC1+3wpQ+X5Cl0mtQiNxqChBVH9ruiOxz
         7LkhtgAbkcaUUngRxco82cE9Q1LGDNogoETBg=
Received: by 10.86.70.8 with SMTP id s8mr970891fga.31.1216159124830;
        Tue, 15 Jul 2008 14:58:44 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 3sm5520698fge.3.2008.07.15.14.58.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jul 2008 14:58:44 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88605>

This pair of patches aims at increasing performance of copy detection in blame
by avoiding unnecessary comparisons. Note that since I'm new to this code, I
might have misunderstood something.

There are two cases than I aim to fix:

1) Copy detection is done by comparing all outstanding chunks of the target file
  to all blobs in the parent. After that, chunks with suitable matches are split, and
  comparison is repeated again, until there are no new matches. The trouble is,
  chunks that didn't match the first time, and weren't split, are compared against
  the same set of blobs again and again. I add a flag to track that.

  On my test case it decreased blame -C -C time from over 10min to ~6min; 4min with -C80.

2) Chunks are split only if the match scores above a certain threshold. I understand
  that a split of an entry cannot score more than the entry itself. Thus, it is pointless
  to even try doing costly comparisons for small entries.

  (Time goes down to 4min; 2min with -C80)



Alexander Gavrilov (2):
      Avoid rescanning unchanged entries in search for copies.
      Do not try to detect move/copy for entries below threshold.


 builtin-blame.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)



diff --git a/builtin-blame.c b/builtin-blame.c
index b451f6c..01453e2 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -161,6 +161,10 @@ struct blame_entry {
 	 */
 	char guilty;
 
+	/* true if the entry has been scanned for copies in the current parent
+	 */
+	char scanned;
+
 	/* the line number of the first line of this group in the
 	 * suspect's file; internally all line numbers are 0 based.
 	 */
@@ -1016,7 +1020,8 @@ static int find_move_in_parent(struct scoreboard *sb,
 	while (made_progress) {
 		made_progress = 0;
 		for (e = sb->ent; e; e = e->next) {
-			if (e->guilty || !same_suspect(e->suspect, target))
+			if (e->guilty || !same_suspect(e->suspect, target) ||
+			    blame_move_score >= ent_score(sb, e))
 				continue;
 			find_copy_in_blob(sb, e, parent, split, &file_p);
 			if (split[1].suspect &&
@@ -1041,6 +1046,7 @@ struct blame_list {
  */
 static struct blame_list *setup_blame_list(struct scoreboard *sb,
 					   struct origin *target,
+					   int min_score,
 					   int *num_ents_p)
 {
 	struct blame_entry *e;
@@ -1048,12 +1054,16 @@ static struct blame_list *setup_blame_list(struct scoreboard *sb,
 	struct blame_list *blame_list = NULL;
 
 	for (e = sb->ent, num_ents = 0; e; e = e->next)
-		if (!e->guilty && same_suspect(e->suspect, target))
+		if (!e->scanned && !e->guilty &&
+		    same_suspect(e->suspect, target) &&
+		    ent_score(sb, e) > min_score)
 			num_ents++;
 	if (num_ents) {
 		blame_list = xcalloc(num_ents, sizeof(struct blame_list));
 		for (e = sb->ent, i = 0; e; e = e->next)
-			if (!e->guilty && same_suspect(e->suspect, target))
+			if (!e->scanned && !e->guilty &&
+			    same_suspect(e->suspect, target) &&
+			    ent_score(sb, e) > min_score)
 				blame_list[i++].ent = e;
 	}
 	*num_ents_p = num_ents;
@@ -1061,6 +1071,16 @@ static struct blame_list *setup_blame_list(struct scoreboard *sb,
 }
 
 /*
+ * Reset the scanned status on all entries.
+ */
+static void reset_scanned_flag(struct scoreboard *sb)
+{
+	struct blame_entry *e;
+	for (e = sb->ent; e; e = e->next)
+		e->scanned = 0;
+}
+
+/*
  * For lines target is suspected for, see if we can find code movement
  * across file boundary from the parent commit.  porigin is the path
  * in the parent we already tried.
@@ -1078,7 +1098,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	struct blame_list *blame_list;
 	int num_ents;
 
-	blame_list = setup_blame_list(sb, target, &num_ents);
+	blame_list = setup_blame_list(sb, target, blame_copy_score, &num_ents);
 	if (!blame_list)
 		return 1; /* nothing remains for this target */
 
@@ -1152,18 +1172,21 @@ static int find_copy_in_parent(struct scoreboard *sb,
 				split_blame(sb, split, blame_list[j].ent);
 				made_progress = 1;
 			}
+			else
+				blame_list[j].ent->scanned = 1;
 			decref_split(split);
 		}
 		free(blame_list);
 
 		if (!made_progress)
 			break;
-		blame_list = setup_blame_list(sb, target, &num_ents);
+		blame_list = setup_blame_list(sb, target, blame_copy_score, &num_ents);
 		if (!blame_list) {
 			retval = 1;
 			break;
 		}
 	}
+	reset_scanned_flag(sb);
 	diff_flush(&diff_opts);
 	diff_tree_release_paths(&diff_opts);
 	return retval;
