From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/33] search_ref_dir(): return an index rather than a pointer
Date: Sun, 14 Apr 2013 14:54:33 +0200
Message-ID: <1365944088-10588-19-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMU6-0005OY-Pf
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab3DNM4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:34 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:65523 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751397Ab3DNMzo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:44 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-cc-516aa750aff9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FA.52.02295.057AA615; Sun, 14 Apr 2013 08:55:44 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkF007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:42 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqBuwPCvQYMJGIYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M64vPkiU8FCsYp5/TdYGxiPC3YxcnJICJhIPF0zgx3CFpO4cG89WxcjF4eQwGVGiTd9
	m1khnLNMEkdvvmcFqWIT0JVY1NPM1MXIwSEikC2xe608SJhZwEFi8+dGRhBbWMBPou/lNmYQ
	m0VAVaJh1QSwBbwCrhJTZx9ihFimIHF8+zYwmxMoPv35MbAaIQEXiVmbZ7NOYORdwMiwilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyMkpHh2MH5bJ3OIUYCDUYmH9wVjVqAQ
	a2JZcWXuIUZJDiYlUd6Ty4BCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgdW4FyvCmJlVWpRfkw
	KWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkODiUJ3osgQwWLUtNTK9Iyc0oQ0kwcnCDDuaRE
	ilPzUlKLEktLMuJBkRFfDIwNkBQP0N67IO28xQWJuUBRiNZTjLocs7Y+ec0oxJKXn5cqJc57
	FqRIAKQoozQPbgUsgbxiFAf6WBiiigeYfOAmvQJawgS0xGdvOsiSkkSElFQDI1fJFFf5xEWO
	OcH6M+++es95oXCry5uon5WeUo9TwyLut0854nH6t/XzKSKuuvOsXFc8WKbx688pWZ3d3HbC
	v+NnRynpBD5SqDrT9Fty7dPAdy5vl7oz9ppNDnrbtHviee15hbwLGhq5Mu7HLjhk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221121>

Change search_ref_dir() to return the index of the sought entry (or -1
on error) rather than a pointer to the entry.  This will make it more
natural to use the function for removing an entry from the list.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index eadbc2a..0c0668b 100644
--- a/refs.c
+++ b/refs.c
@@ -366,18 +366,17 @@ static int ref_entry_cmp_sslice(const void *key_, const void *ent_)
 }
 
 /*
- * Return the entry with the given refname from the ref_dir
- * (non-recursively), sorting dir if necessary.  Return NULL if no
- * such entry is found.  dir must already be complete.
+ * Return the index of the entry with the given refname from the
+ * ref_dir (non-recursively), sorting dir if necessary.  Return -1 if
+ * no such entry is found.  dir must already be complete.
  */
-static struct ref_entry *search_ref_dir(struct ref_dir *dir,
-					const char *refname, size_t len)
+static int search_ref_dir(struct ref_dir *dir, const char *refname, size_t len)
 {
 	struct ref_entry **r;
 	struct string_slice key;
 
 	if (refname == NULL || !dir->nr)
-		return NULL;
+		return -1;
 
 	sort_ref_dir(dir);
 	key.len = len;
@@ -386,9 +385,9 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir,
 		    ref_entry_cmp_sslice);
 
 	if (r == NULL)
-		return NULL;
+		return -1;
 
-	return *r;
+	return r - dir->entries;
 }
 
 /*
@@ -402,8 +401,9 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 					 const char *subdirname, size_t len,
 					 int mkdir)
 {
-	struct ref_entry *entry = search_ref_dir(dir, subdirname, len);
-	if (!entry) {
+	int entry_index = search_ref_dir(dir, subdirname, len);
+	struct ref_entry *entry;
+	if (entry_index == -1) {
 		if (!mkdir)
 			return NULL;
 		/*
@@ -414,6 +414,8 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 		 */
 		entry = create_dir_entry(dir->ref_cache, subdirname, len, 0);
 		add_entry_to_dir(dir, entry);
+	} else {
+		entry = dir->entries[entry_index];
 	}
 	return get_ref_dir(entry);
 }
@@ -452,12 +454,16 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
  */
 static struct ref_entry *find_ref(struct ref_dir *dir, const char *refname)
 {
+	int entry_index;
 	struct ref_entry *entry;
 	dir = find_containing_dir(dir, refname, 0);
 	if (!dir)
 		return NULL;
-	entry = search_ref_dir(dir, refname, strlen(refname));
-	return (entry && !(entry->flag & REF_DIR)) ? entry : NULL;
+	entry_index = search_ref_dir(dir, refname, strlen(refname));
+	if (entry_index == -1)
+		return NULL;
+	entry = dir->entries[entry_index];
+	return (entry->flag & REF_DIR) ? NULL : entry;
 }
 
 /*
-- 
1.8.2.1
