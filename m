From: skimo@liacs.nl
Subject: [PATCH 4/6] refs.c: lock cached_refs during for_each_ref
Date: Thu, 12 Jul 2007 21:06:01 +0200
Message-ID: <11842671632300-git-send-email-skimo@liacs.nl>
References: <11842671631744-git-send-email-skimo@liacs.nl>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I941X-0004QU-NU
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 21:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbXGLTHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 15:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbXGLTHs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 15:07:48 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:46133 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080AbXGLTHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 15:07:48 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l6CJ63RO029833;
	Thu, 12 Jul 2007 21:06:08 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id C47123C00E; Thu, 12 Jul 2007 21:06:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
In-Reply-To: <11842671631744-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52327>

From: Sven Verdoolaege <skimo@kotnet.org>

If the function called by for_each_ref modifies a ref in any way,
the cached_refs that for_each_ref was looping over would be
removed, resulting in undefined behavior.

This patch prevents the cached_refs from being removed
while for_each_ref is still iterating over them.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 refs.c |   37 +++++++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 4dc7e8b..e710903 100644
--- a/refs.c
+++ b/refs.c
@@ -153,6 +153,8 @@ static struct ref_list *sort_ref_list(struct ref_list *list)
 static struct cached_refs {
 	char did_loose;
 	char did_packed;
+	char is_locked;
+	char is_invalidated;
 	struct ref_list *loose;
 	struct ref_list *packed;
 } cached_refs;
@@ -170,6 +172,11 @@ static void invalidate_cached_refs(void)
 {
 	struct cached_refs *ca = &cached_refs;
 
+	if (ca->is_locked) {
+		ca->is_invalidated = 1;
+		return;
+	}
+
 	if (ca->did_loose && ca->loose)
 		free_ref_list(ca->loose);
 	if (ca->did_packed && ca->packed)
@@ -178,6 +185,24 @@ static void invalidate_cached_refs(void)
 	ca->did_loose = ca->did_packed = 0;
 }
 
+static void lock_cached_refs(void)
+{
+	struct cached_refs *ca = &cached_refs;
+
+	ca->is_locked = 1;
+}
+
+static void unlock_cached_refs(void)
+{
+	struct cached_refs *ca = &cached_refs;
+
+	ca->is_locked = 0;
+	if (ca->is_invalidated) {
+		invalidate_cached_refs();
+		ca->is_invalidated = 0;
+	}
+}
+
 static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 {
 	struct ref_list *list = NULL;
@@ -518,10 +543,12 @@ int peel_ref(const char *ref, unsigned char *sha1)
 static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
 			   void *cb_data)
 {
-	int retval;
+	int retval = 0;
 	struct ref_list *packed = get_packed_refs();
 	struct ref_list *loose = get_loose_refs();
 
+	lock_cached_refs();
+
 	while (packed && loose) {
 		struct ref_list *entry;
 		int cmp = strcmp(packed->name, loose->name);
@@ -538,15 +565,17 @@ static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
 		}
 		retval = do_one_ref(base, fn, trim, cb_data, entry);
 		if (retval)
-			return retval;
+			goto out;
 	}
 
 	for (packed = packed ? packed : loose; packed; packed = packed->next) {
 		retval = do_one_ref(base, fn, trim, cb_data, packed);
 		if (retval)
-			return retval;
+			goto out;
 	}
-	return 0;
+ out:
+	unlock_cached_refs();
+	return retval;
 }
 
 int head_ref(each_ref_fn fn, void *cb_data)
-- 
1.5.3.rc0.100.ge60b4
