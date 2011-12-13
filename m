From: mhagger@alum.mit.edu
Subject: [PATCH 4/6] Store extra_refs in a separate data structure
Date: Tue, 13 Dec 2011 21:06:49 +0100
Message-ID: <1323806811-5798-5-git-send-email-mhagger@alum.mit.edu>
References: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYdG-0001PP-PF
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733Ab1LMUHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:07:17 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:37205 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab1LMUHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:07:04 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RaYUU-0006aj-O2; Tue, 13 Dec 2011 20:58:18 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187053>

From: Michael Haggerty <mhagger@alum.mit.edu>

Extra references really don't have much to do with real references,
and we want to change how real references are handled.  So hold extra
references in a separate data structure.

Since extra references cannot be broken, don't store flags with them
and don't pass the flags argument (a different "flags"!) to
do_for_each_extra_ref().

Finally, current_ref is not useful while iterating through the
extra_refs.  In fact, peel_ref() doesn't even work for extra refs
because they cannot be peeled themselves, and moreover they might
coincidentally have the same name as a "real" reference.  So
explicitly set current_ref to NULL while iterating over extra_refs to
avoid confusion.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Strictly speaking, this patch changes how an extra reference with an
invalid SHA1 would be treated.  In the old code, it would be skipped
over (assuming DO_FOR_EACH_INCLUDE_BROKEN is not set).  In the new
code the SHA1 is not checked.  However, from my understanding of how
extra_refs are used, they should never have invalid SHA1s and so the
old test is superfluous.

 refs.c |   38 ++++++++++++++++++++++++++++----------
 1 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 268bda9..843c530 100644
--- a/refs.c
+++ b/refs.c
@@ -146,7 +146,11 @@ static struct ref_cache {
 
 static struct ref_entry *current_ref;
 
-static struct ref_array extra_refs;
+static struct extra_ref {
+	struct extra_ref *next;
+	unsigned char sha1[20];
+	char name[FLEX_ARRAY];
+} *extra_refs;
 
 static void free_ref_array(struct ref_array *array)
 {
@@ -250,12 +254,21 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 
 void add_extra_ref(const char *name, const unsigned char *sha1)
 {
-	add_ref(name, sha1, 0, 0, &extra_refs, NULL);
+	int len = strlen(name) + 1;
+	struct extra_ref *entry = xmalloc(sizeof(struct extra_ref) + len);
+	hashcpy(entry->sha1, sha1);
+	memcpy(entry->name, name, len);
+	entry->next = extra_refs;
+	extra_refs = entry;
 }
 
 void clear_extra_refs(void)
 {
-	free_ref_array(&extra_refs);
+	while (extra_refs) {
+		struct extra_ref *entry = extra_refs;
+		extra_refs = entry->next;
+		free(entry);
+	}
 }
 
 static struct ref_array *get_packed_refs(const char *submodule)
@@ -694,13 +707,18 @@ fallback:
 }
 
 static int do_for_each_extra_ref(const char *base, each_ref_fn fn,
-				 int trim, int flags, void *cb_data)
+				 int trim, void *cb_data)
 {
-	int i;
-	for (i = 0; i < extra_refs.nr; i++) {
-		int retval = do_one_ref(base, fn, trim, flags, cb_data, extra_refs.refs[i]);
-		if (retval)
-			return retval;
+	struct extra_ref *extra;
+
+	current_ref = NULL;
+	for (extra = extra_refs; extra; extra = extra->next) {
+		if (!prefixcmp(extra->name, base)) {
+			int retval = fn(extra->name + trim, extra->sha1,
+					0, cb_data);
+			if (retval)
+				return retval;
+		}
 	}
 	return 0;
 }
@@ -712,7 +730,7 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	struct ref_array *packed = get_packed_refs(submodule);
 	struct ref_array *loose = get_loose_refs(submodule);
 
-	retval = do_for_each_extra_ref(base, fn, trim, flags, cb_data);
+	retval = do_for_each_extra_ref(base, fn, trim, cb_data);
 	if (retval)
 		goto end_each;
 
-- 
1.7.8
