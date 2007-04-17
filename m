From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] refs.c: add a function to sort a ref list,
	rather then sorting on add
Date: Tue, 17 Apr 2007 02:42:50 +0100
Message-ID: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 03:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdcoP-0006R5-PP
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 03:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbXDQBse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 21:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbXDQBse
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 21:48:34 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:41253 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753575AbXDQBsd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 21:48:33 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0E6C4C61AC
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 02:48:32 +0100 (BST)
Received: (qmail 8765 invoked by uid 103); 17 Apr 2007 02:47:52 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3087. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.025308 secs); 17 Apr 2007 01:47:52 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 17 Apr 2007 02:47:52 +0100
X-git-sha1: 0b7535b8c7d70f0493bcb4eeffd95ef95a6da5e8 
X-Mailer: git-mail-commits v0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44706>

Rather than sorting the refs list while building it, sort in one go
after it is built using a merge sort.  This has a large performance
boost with large numbers of refs.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

Having got builtin fetch to the point of generating a correct FETCH_HEAD (for a certain path through the code at least), I revisted the speed issue I brought up a while back with the sorting of refs.

Running fetch (builtin version) on a repo with >9000 refs which is up-to-date, using the old sort-on-add I get (best of 5, warm cache):

real    0m4.351s
user    0m4.068s
sys     0m0.219s

With this patch the same fetch gives (worst of 5, warm cache):

real    0m2.196s
user    0m1.870s
sys     0m0.212s

Since this is orthogonal to making fetch a builtin, I don't see that it needs to wait ...

 refs.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index d2b7b7f..23982fc 100644
--- a/refs.c
+++ b/refs.c
@@ -47,22 +47,7 @@ static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
 				struct ref_list **new_entry)
 {
 	int len;
-	struct ref_list **p = &list, *entry;
-
-	/* Find the place to insert the ref into.. */
-	while ((entry = *p) != NULL) {
-		int cmp = strcmp(entry->name, name);
-		if (cmp > 0)
-			break;
-
-		/* Same as existing entry? */
-		if (!cmp) {
-			if (new_entry)
-				*new_entry = entry;
-			return list;
-		}
-		p = &entry->next;
-	}
+	struct ref_list *entry;
 
 	/* Allocate it and add it in.. */
 	len = strlen(name) + 1;
@@ -71,11 +56,79 @@ static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
 	hashclr(entry->peeled);
 	memcpy(entry->name, name, len);
 	entry->flag = flag;
-	entry->next = *p;
-	*p = entry;
+	entry->next = list;
 	if (new_entry)
 		*new_entry = entry;
-	return list;
+	return entry;
+}
+
+/* merge sort the ref list */
+static struct ref_list *sort_ref_list(struct ref_list *list)
+{
+	int psize, qsize, last_merge_count;
+	struct ref_list *p, *q, *l, *e;
+	struct ref_list *new_list = list;
+	int k = 1;
+	int merge_count = 0;
+
+	if (!list)
+		return list;
+
+	do {
+		last_merge_count = merge_count;
+		merge_count = 0;
+
+		psize = 0;
+
+		p = new_list;
+		q = new_list;
+		new_list = NULL;
+		l = NULL;
+
+		while (p) {
+			merge_count++;
+
+			while (psize < k && q->next) {
+				q = q->next;
+				psize++;
+			}
+			qsize = k;
+
+			while ((psize > 0) || (qsize > 0 && q)) {
+				if (qsize == 0 || !q) {
+					e = p;
+					p = p->next;
+					psize--;
+				} else if (psize == 0) {
+					e = q;
+					q = q->next;
+					qsize--;
+				} else if (strcmp(q->name, p->name) < 0) {
+					e = q;
+					q = q->next;
+					qsize--;
+				} else {
+					e = p;
+					p = p->next;
+					psize--;
+				}
+
+				e->next = NULL;
+
+				if (l)
+					l->next = e;
+				if (!new_list)
+					new_list = e;
+				l = e;
+			}
+
+			p = q;
+		};
+
+		k = k * 2;
+	} while ((last_merge_count != merge_count) || (last_merge_count != 1));
+
+	return new_list;
 }
 
 /*
@@ -142,7 +195,7 @@ static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 		    !get_sha1_hex(refline + 1, sha1))
 			hashcpy(last->peeled, sha1);
 	}
-	cached_refs->packed = list;
+	cached_refs->packed = sort_ref_list(list);
 }
 
 static struct ref_list *get_packed_refs(void)
@@ -201,7 +254,7 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 		free(ref);
 		closedir(dir);
 	}
-	return list;
+	return sort_ref_list(list);
 }
 
 static struct ref_list *get_loose_refs(void)
-- 
1.5.1.1
