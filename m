From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 7/6] Fix thinko in subproject entry sorting
Date: Wed, 11 Apr 2007 14:39:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111423420.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbkX9-0005tS-U6
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 23:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbXDKVjR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 17:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbXDKVjR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 17:39:17 -0400
Received: from smtp.osdl.org ([65.172.181.24]:33569 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161006AbXDKVjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 17:39:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3BLdDVZ023367
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 14:39:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3BLdCNs015111;
	Wed, 11 Apr 2007 14:39:13 -0700
X-Spam-Status: No, hits=-0.955 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44259>


This fixes a total thinko in my original series: subprojects do *not* sort 
like directories, because the index is sorted purely by full pathname, and 
since a subproject shows up in the index as a normal NUL-terminated 
string, it never has the issues with sorting with the '/' at the end.

So if you have a subproject "proj" and a file "proj.c", the subproject 
sorts alphabetically before the file in the index (and must thus also sort 
that way in a tree object, since trees sort as the index).

In contrast, it you have two files "proj/file" and "proj.c", the "proj.c" 
will sort alphabetically before "proj/file" in the index. The index 
itself, of course, does not actually contain an entry "proj/", but in the 
*tree* that gets written out, the tree entry "proj" will sort before the 
file entry "proj.c", which is the only real magic sorting rule.

In other words: the magic sorting rule only affects tree entries, and 
*only* affects tree entries that point to other trees (ie are of the type 
S_IFDIR).

Anyway, that thinko just means that we should remove the special case to 
make S_ISDIRLNK entries sort like S_ISDIR entries. They don't.  They sort 
like normal files.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Junio, you could just fix the patch that I sent out and rebase, but you 
seem to have merged it into "next" already, and besides, I think it's ok 
to have this separate correction patch just to explain *why* I was wrong 
to add that special case in the first place. Normally, I don't like 
leaving errors in the history - if they teach anybody anything, it is just 
to make more errors - but this may be one of the rare cases where the 
error was actually instructive.

		Linus
---
diff --git a/read-cache.c b/read-cache.c
index fde2427..795fc5d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -280,9 +280,9 @@ int base_name_compare(const char *name1, int len1, int mode1,
 		return cmp;
 	c1 = name1[len];
 	c2 = name2[len];
-	if (!c1 && (S_ISDIR(mode1) || S_ISDIRLNK(mode1)))
+	if (!c1 && S_ISDIR(mode1))
 		c1 = '/';
-	if (!c2 && (S_ISDIR(mode2) || S_ISDIRLNK(mode2)))
+	if (!c2 && S_ISDIR(mode2))
 		c2 = '/';
 	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
 }
