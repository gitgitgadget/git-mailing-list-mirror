From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 1/2] fast-import: use struct hash_table for atom strings
Date: Thu, 31 Mar 2011 22:59:57 +1100
Message-ID: <1301572798-9973-2-git-send-email-david.barr@cordelta.com>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5GYE-0002jn-A6
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374Ab1CaMA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 08:00:29 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:52135 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757324Ab1CaMA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 08:00:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 631A9C057;
	Thu, 31 Mar 2011 22:57:20 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t32gz31cg-am; Thu, 31 Mar 2011 22:57:17 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 5005AC058;
	Thu, 31 Mar 2011 22:57:17 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170476>

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 fast-import.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 65d65bf..0592b21 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -300,9 +300,8 @@ static size_t total_allocd;
 static struct mem_pool *mem_pool;
 
 /* Atom management */
-static unsigned int atom_table_sz = 4451;
 static unsigned int atom_cnt;
-static struct atom_str **atom_table;
+static struct hash_table atom_table;
 
 /* The .pack file being generated */
 static unsigned int pack_id;
@@ -680,10 +679,11 @@ static struct object_entry *find_mark(uintmax_t idnum)
 
 static struct atom_str *to_atom(const char *s, unsigned short len)
 {
-	unsigned int hc = hc_str(s, len) % atom_table_sz;
+	unsigned int hc = hc_str(s, len);
 	struct atom_str *c;
+	void **pos;
 
-	for (c = atom_table[hc]; c; c = c->next_atom)
+	for (c = lookup_hash(hc, &atom_table); c; c = c->next_atom)
 		if (c->str_len == len && !strncmp(s, c->str_dat, len))
 			return c;
 
@@ -691,8 +691,12 @@ static struct atom_str *to_atom(const char *s, unsigned short len)
 	c->str_len = len;
 	strncpy(c->str_dat, s, len);
 	c->str_dat[len] = 0;
-	c->next_atom = atom_table[hc];
-	atom_table[hc] = c;
+	c->next_atom = NULL;
+	pos = insert_hash(hc, c, &atom_table);
+	if (pos) {
+		c->next_atom = *pos;
+		*pos = c;
+	}
 	atom_cnt++;
 	return c;
 }
@@ -3263,7 +3267,6 @@ int main(int argc, const char **argv)
 
 	alloc_objects(object_entry_alloc);
 	strbuf_init(&command_buf, 0);
-	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str*));
 	branch_table = xcalloc(branch_table_sz, sizeof(struct branch*));
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
 	marks = pool_calloc(1, sizeof(struct mark_set));
-- 
1.7.3.2.846.gf4b062
