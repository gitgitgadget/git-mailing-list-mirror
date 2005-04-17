From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [1/5] Parsing code in revision.h
Date: Sun, 17 Apr 2005 11:24:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171120400.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:20:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBZN-0003A1-Ee
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVDQPYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVDQPYI
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:24:08 -0400
Received: from iabervon.org ([66.92.72.58]:58631 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261329AbVDQPYD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 11:24:03 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNBdF-00063j-00; Sun, 17 Apr 2005 11:24:21 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds support to revision.h for parsing commit records (but not going
any further than parsing a single record). Something like this is needed
by anything that uses revision.h, but older programs open-code it.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: revision.h
===================================================================
--- 45f926575d2c44072bfcf2317dbf3f0fbb513a4e/revision.h  (mode:100644 sha1:28d0de3261a61f68e4e0948a25a416a515cd2e83)
+++ 37a0b01b85c2999243674d48bfc71cdba0e5518e/revision.h  (mode:100644 sha1:523bde6e14e18bb0ecbded8f83ad4df93fc467ab)
@@ -24,6 +24,7 @@
 	unsigned int flags;
 	unsigned char sha1[20];
 	unsigned long date;
+	unsigned char tree[20];
 	struct parent *parent;
 };
 
@@ -111,4 +112,29 @@
 	}
 }
 
+static int parse_commit_object(struct revision *rev)
+{
+	if (!(rev->flags & SEEN)) {
+		void *buffer, *bufptr;
+		unsigned long size;
+		char type[20];
+		unsigned char parent[20];
+
+		rev->flags |= SEEN;
+		buffer = bufptr = read_sha1_file(rev->sha1, type, &size);
+		if (!buffer || strcmp(type, "commit"))
+			return -1;
+		get_sha1_hex(bufptr + 5, rev->tree);
+		bufptr += 46; /* "tree " + "hex sha1" + "\n" */
+		while (!memcmp(bufptr, "parent ", 7) && 
+		       !get_sha1_hex(bufptr+7, parent)) {
+			add_relationship(rev, parent);
+			bufptr += 48;   /* "parent " + "hex sha1" + "\n" */
+		}
+		//rev->date = parse_commit_date(bufptr);
+		free(buffer);
+	}
+	return 0;
+}
+
 #endif /* REVISION_H */

