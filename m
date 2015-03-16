From: Andreas Krey <a.krey@gmx.de>
Subject: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Mon, 16 Mar 2015 15:20:26 +0100
Message-ID: <20150316142026.GJ7847@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 15:45:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXWGY-0007kE-PX
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 15:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbbCPOpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 10:45:10 -0400
Received: from continuum.iocl.org ([217.140.74.2]:57082 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653AbbCPOpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 10:45:07 -0400
X-Greylist: delayed 1477 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2015 10:45:06 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t2GEKQO08105;
	Mon, 16 Mar 2015 15:20:26 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265560>

get_ref_cache used a linear list, which obviously is O(n^2).
Use a fixed bucket hash which just takes a factor of 100000
(~ 317^2) out of the n^2 - which is enough.

Signed-off-by: Andreas Krey <a.krey@gmx.de>
---

This brings 'git clean -ndx' times down from 17 minutes
to 11 seconds on one of our workspaces (which accumulated
a lot of ignored directories). Actuallly using adaptive
hashing or other structures seems overkill.

 refs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index e23542b..8198d9e 100644
--- a/refs.c
+++ b/refs.c
@@ -982,6 +982,8 @@ struct packed_ref_cache {
 	struct stat_validity validity;
 };
 
+#define REF_CACHE_HASH 317
+
 /*
  * Future: need to be in "struct repository"
  * when doing a full libification.
@@ -996,7 +998,7 @@ static struct ref_cache {
 	 * is initialized correctly.
 	 */
 	char name[1];
-} ref_cache, *submodule_ref_caches;
+} ref_cache, *submodule_ref_caches[REF_CACHE_HASH];
 
 /* Lock used for the main packed-refs file: */
 static struct lock_file packlock;
@@ -1065,18 +1067,19 @@ static struct ref_cache *create_ref_cache(const char *submodule)
  */
 static struct ref_cache *get_ref_cache(const char *submodule)
 {
-	struct ref_cache *refs;
+	struct ref_cache *refs, **bucketp;
+	bucketp = submodule_ref_caches + strhash(submodule) % REF_CACHE_HASH;
 
 	if (!submodule || !*submodule)
 		return &ref_cache;
 
-	for (refs = submodule_ref_caches; refs; refs = refs->next)
+	for (refs = *bucketp; refs; refs = refs->next)
 		if (!strcmp(submodule, refs->name))
 			return refs;
 
 	refs = create_ref_cache(submodule);
-	refs->next = submodule_ref_caches;
-	submodule_ref_caches = refs;
+	refs->next = *bucketp;
+	*bucketp = refs;
 	return refs;
 }
 
-- 
2.3.2.223.g7a9409c
