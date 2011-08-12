From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/6] Allocate cached_refs objects dynamically
Date: Sat, 13 Aug 2011 00:36:27 +0200
Message-ID: <1313188589-2330-5-git-send-email-mhagger@alum.mit.edu>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 00:37:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs0MO-0005WE-Ev
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 00:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab1HLWho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 18:37:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41162 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab1HLWhn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 18:37:43 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CMaXJR010513;
	Sat, 13 Aug 2011 00:37:23 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179263>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index e043555..102ed03 100644
--- a/refs.c
+++ b/refs.c
@@ -157,7 +157,7 @@ static struct cached_refs {
 	char did_packed;
 	struct ref_list *loose;
 	struct ref_list *packed;
-} cached_refs, submodule_refs;
+} *cached_refs, *submodule_refs;
 static struct ref_list *current_ref;
 
 static struct ref_list *extra_refs;
@@ -181,6 +181,15 @@ static void clear_cached_refs(struct cached_refs *ca)
 	ca->did_loose = ca->did_packed = 0;
 }
 
+struct cached_refs *create_cached_refs()
+{
+	struct cached_refs *refs;
+	refs = xmalloc(sizeof(struct cached_refs));
+	refs->did_loose = refs->did_packed = 0;
+	refs->loose = refs->packed = NULL;
+	return refs;
+}
+
 /*
  * Return a pointer to a cached_refs for the specified submodule. For
  * the main repository, use submodule==NULL. The returned structure
@@ -189,12 +198,17 @@ static void clear_cached_refs(struct cached_refs *ca)
  */
 static struct cached_refs *get_cached_refs(const char *submodule)
 {
-	if (! submodule)
-		return &cached_refs;
-	else {
-		/* For now, don't reuse the refs cache for submodules. */
-		clear_cached_refs(&submodule_refs);
-		return &submodule_refs;
+	if (! submodule) {
+		if (!cached_refs)
+			cached_refs = create_cached_refs();
+		return cached_refs;
+	} else {
+		if (!submodule_refs)
+			submodule_refs = create_cached_refs();
+		else
+			/* For now, don't reuse the refs cache for submodules. */
+			clear_cached_refs(submodule_refs);
+		return submodule_refs;
 	}
 }
 
-- 
1.7.6.8.gd2879
