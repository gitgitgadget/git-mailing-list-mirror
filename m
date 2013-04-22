From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/33] search_ref_dir(): return an index rather than a pointer
Date: Mon, 22 Apr 2013 21:52:26 +0200
Message-ID: <1366660361-21831-19-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:01:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMvX-0006em-JM
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab3DVUBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:23 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63501 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754900Ab3DVUBW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:22 -0400
X-AuditID: 12074412-b7f216d0000008d4-56-517595516eb4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id EF.7F.02260.15595715; Mon, 22 Apr 2013 15:53:53 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOV008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:52 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqBs4tTTQ4Ee7tkXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGf09C1gKlgoVtHQ38bSwHhc
	sIuRk0NCwETi4d6TTBC2mMSFe+vZuhi5OIQELjNK/D59jAXCucAkcfnKV3aQKjYBXYlFPc1g
	HSICahIT2w6xgNjMAg4Smz83MoLYwgKBEt83rQWrYRFQlei6/IsZxOYVcJX4tWErI8Q2BYnj
	27eB2ZxA8dMdJ8DmCAm4SKw4OJVlAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Znq5
	mSV6qSmlmxghwSK0g3H9SblDjAIcjEo8vALupYFCrIllxZW5hxglOZiURHk5pgCF+JLyUyoz
	Eosz4otKc1KLDzFKcDArifCK5gPleFMSK6tSi/JhUtIcLErivD8Xq/sJCaQnlqRmp6YWpBbB
	ZGU4OJQkeL9NBmoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VGfDEwOkBSPEB7
	5UFu4i0uSMwFikK0nmLU5Zi19clrRiGWvPy8VClxXrdJQEUCIEUZpXlwK2Cp4RWjONDHwrx8
	IKN4gGkFbtIroCVMQEsyE0pAlpQkIqSkGhjXzJh4Pqn2oOE+yxu2ct8/Hl8U7ihWscq7nD8r
	eq1YKbf6vHlnpTW6dTz2zV/88XzUZSGWl3xmGVWBFqne3q3PVkfud9X9vGZv/KZ7ff0xGsw/
	sx7vzn9lK99zofVbhf2qwr/MX0tzSroMFjItkZh1/HzvnO+bes9rtb00MWh1d1v9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222074>

Change search_ref_dir() to return the index of the sought entry (or -1
on error) rather than a pointer to the entry.  This will make it more
natural to use the function for removing an entry from the list.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 2957f6d..9fd49e8 100644
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
