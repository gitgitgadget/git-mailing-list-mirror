From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] Don't recurse into parents marked uninteresting.
Date: Thu, 09 Mar 2006 05:04:36 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2006.03.09.04.04.34.617873@smurf.noris.de>
References: <pan.2006.03.08.20.04.24.62170@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Mar 09 05:11:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHCUK-0004GS-Ku
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 05:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWCIEKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 23:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWCIEKo
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 23:10:44 -0500
Received: from main.gmane.org ([80.91.229.2]:51076 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030180AbWCIEKo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 23:10:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FHCU3-0004AY-4L
	for git@vger.kernel.org; Thu, 09 Mar 2006 05:10:39 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Mar 2006 05:10:39 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Mar 2006 05:10:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17397>

revision.c:make_parents_uninteresting() is exponential with the number
of merges in the tree. That's fine -- unless some other part of git
already has pulled the whole commit tree into memory ...

---

... or, in other words, "Don't do that, please."

With this patch, all tests still succeed, and the "git push" which
triggered the problem takes 5min instead of an estimated 10mio years.

---

 revision.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

32c9750691d1ef225ca1641fdf6902e53c25fe5b
diff --git a/revision.c b/revision.c
index 2a33637..713f27e 100644
--- a/revision.c
+++ b/revision.c
@@ -82,18 +82,20 @@ void mark_parents_uninteresting(struct c
 
 	while (parents) {
 		struct commit *commit = parents->item;
-		commit->object.flags |= UNINTERESTING;
+		if (!(commit->object.flags & UNINTERESTING)) {
+			commit->object.flags |= UNINTERESTING;
 
-		/*
-		 * Normally we haven't parsed the parent
-		 * yet, so we won't have a parent of a parent
-		 * here. However, it may turn out that we've
-		 * reached this commit some other way (where it
-		 * wasn't uninteresting), in which case we need
-		 * to mark its parents recursively too..
-		 */
-		if (commit->parents)
-			mark_parents_uninteresting(commit);
+			/*
+			 * Normally we haven't parsed the parent
+			 * yet, so we won't have a parent of a parent
+			 * here. However, it may turn out that we've
+			 * reached this commit some other way (where it
+			 * wasn't uninteresting), in which case we need
+			 * to mark its parents recursively too..
+			 */
+			if (commit->parents)
+				mark_parents_uninteresting(commit);
+		}
 
 		/*
 		 * A missing commit is ok iff its parent is marked
-- 
Matthias Urlichs
