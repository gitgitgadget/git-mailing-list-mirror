From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "git help" sort git commands in columns
Date: Sun, 18 Dec 2005 12:41:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512181229370.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Dec 18 21:43:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo5Lb-0002Hb-PE
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 21:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVLRUlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 15:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVLRUlX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 15:41:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751167AbVLRUlW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 15:41:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBIKfDDZ011162
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Dec 2005 12:41:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBIKfAQ0025460;
	Sun, 18 Dec 2005 12:41:12 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <exon@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13803>


This changes "pretty_print_string_list()" to show the git commands 
alphabetically in column order, which is the normal one. 

Ie instead of doing

	git commands available in '/home/torvalds/bin'
	----------------------------------------------
	  add                am                 ...
	  applypatch         archimport         ...
	  cat-file           check-ref-format   ...
	...

it does

	git commands available in '/home/torvalds/bin'
	----------------------------------------------
	  add                diff-tree          ...
	  am                 fetch              ...
	  apply              fetch-pack         ...
	...

where each column is sorted.

This is how "ls" sorts things too, and since visually the columns are much 
more distinct than the rows, so it _looks_ more sorted.

The "ls" command has a "-x" option that lists entries by lines (the way 
git.c used to): if somebody wants to do that, the new print-out logic 
could be easily accomodated to that too. Matter of taste and preference, I 
guess.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Side note: this is independent of the other patch I just sent out. Take 
either or both.

----
diff --git a/git.c b/git.c
index c26cac6..0fd95bf 100644
--- a/git.c
+++ b/git.c
@@ -74,25 +85,28 @@ static int cmdname_compare(const void *a
 
 static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 {
-	int cols = 1;
+	int cols = 1, rows;
 	int space = longest + 1; /* min 1 SP between words */
 	int max_cols = term_columns() - 1; /* don't print *on* the edge */
-	int i;
+	int i, j;
 
 	if (space < max_cols)
 		cols = max_cols / space;
+	rows = (cmdname_cnt + cols - 1) / cols;
 
 	qsort(cmdname, cmdname_cnt, sizeof(*cmdname), cmdname_compare);
 
-	for (i = 0; i < cmdname_cnt; ) {
-		int c;
+	for (i = 0; i < rows; i++) {
 		printf("  ");
 
-		for (c = cols; c && i < cmdname_cnt; i++) {
-			printf("%s", cmdname[i]->name);
-
-			if (--c)
-				mput_char(' ', space - cmdname[i]->len);
+		for (j = 0; j < cols; j++) {
+			int n = j * rows + i;
+			int size = space;
+			if (n >= cmdname_cnt)
+				break;
+			if (j == cols-1 || n + rows >= cmdname_cnt)
+				size = 1;
+			printf("%-*s", size, cmdname[n]->name);
 		}
 		putchar('\n');
 	}
