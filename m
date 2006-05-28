From: Linus Torvalds <torvalds@osdl.org>
Subject: Don't use "sscanf()" for tree mode scanning
Date: Sun, 28 May 2006 16:16:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605281559100.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 01:16:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkUUh-0003K1-7o
	for gcvg-git@gmane.org; Mon, 29 May 2006 01:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWE1XQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 19:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWE1XQU
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 19:16:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751042AbWE1XQU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 19:16:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4SNGG2g000625
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 May 2006 16:16:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4SNGFqu018423;
	Sun, 28 May 2006 16:16:15 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20908>


Doing an oprofile run on the result of my git rev-list memory leak fixes 
and tree parsing cleanups, I was surprised by the third-highest entry 
being

	samples  %        image name               app name                 symbol name
	179751    2.7163  libc-2.4.so              libc-2.4.so              _IO_vfscanf@@GLIBC_2.4

where that 2.7% is actually more than 5% of one CPU, because this was run 
on a dual CPU setup with the other CPU just being idle.

That seems to all be from the use of 'sscanf(tree, "%o", &mode)' for the 
tree buffer parsing.

So do the trivial octal parsing by hand, which also gives us where the 
first space in the string is (and thus where the pathname starts) so we 
can get rid of the "strchr(tree, ' ')" call too.

This brings the "git rev-list --all --objects" time down from 63 seconds 
to 55 seconds on the historical kernel archive for me, so it's quite 
noticeable - tree parsing is a lot of what we end up doing when following 
all the objects.

[ I also see a 5% speedup on a full "git fsck-objects" on the current 
  kernel archive, so that sscanf() really does seem to have hurt our
  performance by a surprising amount ]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>

---
 tree-walk.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 9f7abb7..3922058 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -47,18 +47,33 @@ void update_tree_entry(struct tree_desc 
 	desc->size = size - len;
 }
 
+static const char *get_mode(const char *str, unsigned int *modep)
+{
+	unsigned char c;
+	unsigned int mode = 0;
+
+	while ((c = *str++) != ' ') {
+		if (c < '0' || c > '7')
+			return NULL;
+		mode = (mode << 3) + (c - '0');
+	}
+	*modep = mode;
+	return str;
+}
+
 const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
 {
 	void *tree = desc->buf;
 	unsigned long size = desc->size;
 	int len = strlen(tree)+1;
 	const unsigned char *sha1 = tree + len;
-	const char *path = strchr(tree, ' ');
+	const char *path;
 	unsigned int mode;
 
-	if (!path || size < len + 20 || sscanf(tree, "%o", &mode) != 1)
+	path = get_mode(tree, &mode);
+	if (!path || size < len + 20)
 		die("corrupt tree file");
-	*pathp = path+1;
+	*pathp = path;
 	*modep = canon_mode(mode);
 	return sha1;
 }
