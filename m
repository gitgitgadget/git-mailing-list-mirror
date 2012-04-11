From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] fast-import: allow atom_table to grow dynamically
Date: Wed, 11 Apr 2012 07:14:14 -0500
Message-ID: <20120411121414.GD19568@burratino>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
 <20120411121259.GB19568@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:14:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHwRO-0008GO-Dc
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 14:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758883Ab2DKMOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 08:14:22 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45287 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab2DKMOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 08:14:21 -0400
Received: by iagz16 with SMTP id z16so1197965iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TKtS28VcFAEsGvQ9tHo7lohBVNyQxTcQGcQ/loRGYsM=;
        b=VP0+SnjhEhdapACtEx+FyQG31AXX2Iaq0C/ste6cqY/JVD2+WyxEM/XATgDlgHNF8O
         rif5qhFwYshTOKA7/2HsFTBgKetDXNRYUMd1n7KrbKk2vLjZSjmMWPFne+s6qJd1tm5s
         PzLppYuqLFcYCB1svVmIfyv0HpOFZ4fY/6C1d4dJqA8nWqBAw5+KgiWnt0UHvZjLff4x
         xszNIqPXFZQg8zYoh2V6uKWNjO52P7DouHTN+w4a8rqDijU+y588saBr6ksrrnGqcGFZ
         1TpS1gYA/65yDzz8P9Tm9kGROWtfY6dKgtFQzn7ruM+nZtOVKPGZMlmgRVYm8lJWn8ob
         2jzw==
Received: by 10.50.45.200 with SMTP id p8mr5335905igm.23.1334146460965;
        Wed, 11 Apr 2012 05:14:20 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hq3sm57036603igc.0.2012.04.11.05.14.20
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 05:14:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120411121259.GB19568@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195173>

From: David Barr <david.barr@cordelta.com>
Date: Thu, 31 Mar 2011 22:59:57 +1100

Use a struct hash_table to allow the table for atom strings to
grow.  See the previous commit for explanations.

[jn: with init_hash call, even though it's technically not needed]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a79a1260..67769573 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -299,9 +299,8 @@ static size_t total_allocd;
 static struct mem_pool *mem_pool;
 
 /* Atom management */
-static unsigned int atom_table_sz = 4451;
 static unsigned int atom_cnt;
-static struct atom_str **atom_table;
+static struct hash_table atom_table;
 
 /* The .pack file being generated */
 static unsigned int pack_id;
@@ -691,10 +690,11 @@ static struct object_entry *find_mark(uintmax_t idnum)
 
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
 
@@ -702,8 +702,12 @@ static struct atom_str *to_atom(const char *s, unsigned short len)
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
@@ -3270,7 +3274,7 @@ int main(int argc, const char **argv)
 
 	alloc_objects(object_entry_alloc);
 	strbuf_init(&command_buf, 0);
-	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str*));
+	init_hash(&atom_table);
 	branch_table = xcalloc(branch_table_sz, sizeof(struct branch*));
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
 	init_hash(&object_table);
-- 
1.7.10
