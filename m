From: mhagger@alum.mit.edu
Subject: [PATCH 7/7] refs: remove the extra_refs API
Date: Sat, 11 Feb 2012 07:21:01 +0100
Message-ID: <1328941261-29746-8-git-send-email-mhagger@alum.mit.edu>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 07:21:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw6L8-0001rt-VE
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 07:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab2BKGVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 01:21:34 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50494 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab2BKGVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 01:21:33 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED675.dip.t-dialin.net [84.190.214.117])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B6L6CH019131;
	Sat, 11 Feb 2012 07:21:24 +0100
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190490>

From: Michael Haggerty <mhagger@alum.mit.edu>

The extra_refs provided a kludgy way to create fake references at a
global level in the hope that they would only affect some particular
code path.  The last user of this API been rewritten, so strip this
stuff out before somebody else gets the bad idea of using it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   23 +----------------------
 refs.h |    8 --------
 2 files changed, 1 insertions(+), 30 deletions(-)

diff --git a/refs.c b/refs.c
index b8843bb..c9f6835 100644
--- a/refs.c
+++ b/refs.c
@@ -183,12 +183,6 @@ static struct ref_cache {
 
 static struct ref_entry *current_ref;
 
-/*
- * Never call sort_ref_array() on the extra_refs, because it is
- * allowed to contain entries with duplicate names.
- */
-static struct ref_array extra_refs;
-
 static void clear_ref_array(struct ref_array *array)
 {
 	int i;
@@ -289,16 +283,6 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 	}
 }
 
-void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
-{
-	add_ref(&extra_refs, create_ref_entry(refname, sha1, flag, 0));
-}
-
-void clear_extra_refs(void)
-{
-	clear_ref_array(&extra_refs);
-}
-
 static struct ref_array *get_packed_refs(struct ref_cache *refs)
 {
 	if (!refs->did_packed) {
@@ -733,16 +717,11 @@ fallback:
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
 			   int trim, int flags, void *cb_data)
 {
-	int retval = 0, i, p = 0, l = 0;
+	int retval = 0, p = 0, l = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
 	struct ref_array *packed = get_packed_refs(refs);
 	struct ref_array *loose = get_loose_refs(refs);
 
-	struct ref_array *extra = &extra_refs;
-
-	for (i = 0; i < extra->nr; i++)
-		retval = do_one_ref(base, fn, trim, flags, cb_data, extra->refs[i]);
-
 	sort_ref_array(packed);
 	sort_ref_array(loose);
 	while (p < packed->nr && l < loose->nr) {
diff --git a/refs.h b/refs.h
index 00ba1e2..33202b0 100644
--- a/refs.h
+++ b/refs.h
@@ -56,14 +56,6 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
  */
 extern void add_packed_ref(const char *refname, const unsigned char *sha1);
 
-/*
- * Extra refs will be listed by for_each_ref() before any actual refs
- * for the duration of this process or until clear_extra_refs() is
- * called. Only extra refs added before for_each_ref() is called will
- * be listed on a given call of for_each_ref().
- */
-extern void add_extra_ref(const char *refname, const unsigned char *sha1, int flags);
-extern void clear_extra_refs(void);
 extern int ref_exists(const char *);
 
 extern int peel_ref(const char *refname, unsigned char *sha1);
-- 
1.7.9
