From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix some "git ls-files -o" fallout from gitlinks
Date: Sat, 14 Apr 2007 16:22:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704141609170.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 01:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcrZQ-0005c4-QT
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 01:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbXDNXWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 19:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbXDNXWN
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 19:22:13 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40408 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbXDNXWM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 19:22:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3ENM9Is011359
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 14 Apr 2007 16:22:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3ENM8La002302;
	Sat, 14 Apr 2007 16:22:09 -0700
X-Spam-Status: No, hits=-0.455 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44472>


Since "git ls-files" doesn't really pass down any details on what it 
really wants done to the directory walking code, the directory walking 
code doesn't really know whether the caller wants to know about gitlink 
directories, or whether it wants to just know about ignored files.

So the directory walking code will return those gitlink directories unless 
the caller has explicitly told it not to ("dir->show_other_directories" 
tells the directory walker to only show "other" directories).

This kind of confuses "git ls-files -o", because
 - it didn't really expect to see entries listed that were already in the 
   index, unless they  were unmerged, and would die on that unexpected 
   setup, rather than just "continue".
 - it didn't know how to match directory entries with the final "/" 

This trivial change updates the "show_other_files()" function to handle 
both of these issues gracefully. There really was no reason to die, when 
the obviously correct thing for the function was to just ignore files it 
already knew about (that's what "other" means here!).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Quite frankly, I also debated just telling the directory reading functions 
exactly what we wanted, and we migth want to do that too (moving all the 
"static int" flags in builtin-ls-files.c to just be bitfield members of 
the "struct dir_struct" instead). 

But regardless of whether we'd like to extend and flesh out the 
"read_directory()" interface, this is definitely the right thing to do 
*anyway*.

 builtin-ls-files.c |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 74a6aca..f7c066b 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -89,20 +89,38 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 static void show_other_files(struct dir_struct *dir)
 {
 	int i;
+
+
+	/*
+	 * Skip matching and unmerged entries for the paths,
+	 * since we want just "others".
+	 *
+	 * (Matching entries are normally pruned during
+	 * the directory tree walk, but will show up for
+	 * gitlinks because we don't necessarily have
+	 * dir->show_other_directories set to suppress
+	 * them).
+	 */
 	for (i = 0; i < dir->nr; i++) {
-		/* We should not have a matching entry, but we
-		 * may have an unmerged entry for this path.
-		 */
 		struct dir_entry *ent = dir->entries[i];
-		int pos = cache_name_pos(ent->name, ent->len);
+		int len, pos;
 		struct cache_entry *ce;
+
+		/*
+		 * Remove the '/' at the end that directory
+		 * walking adds for directory entries.
+		 */
+		len = ent->len;
+		if (len && ent->name[len-1] == '/')
+			len--;
+		pos = cache_name_pos(ent->name, len);
 		if (0 <= pos)
-			die("bug in show-other-files");
+			continue;	/* exact match */
 		pos = -pos - 1;
 		if (pos < active_nr) { 
 			ce = active_cache[pos];
-			if (ce_namelen(ce) == ent->len &&
-			    !memcmp(ce->name, ent->name, ent->len))
+			if (ce_namelen(ce) == len &&
+			    !memcmp(ce->name, ent->name, len))
 				continue; /* Yup, this one exists unmerged */
 		}
 		show_dir_entry(tag_other, ent);
