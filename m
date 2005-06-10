From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Changes to non-epoch.c code required for author-oriented git-rev-list changes
Date: Fri, 10 Jun 2005 19:23:34 +1000
Message-ID: <20050610092334.3913.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 10 11:19:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgfgB-0003IG-I6
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 11:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVFJJYB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 05:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVFJJYA
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 05:24:00 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:35714 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262531AbVFJJXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 05:23:38 -0400
Received: (qmail 3923 invoked by uid 500); 10 Jun 2005 09:23:34 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch contains some changes to the remainder of git required by
the second patch of the set. The second patch adds author oriented 
functionality to git-rev-list.

This patch:
    * factors out get_real_identity from commit-tree.c into user.c/h
      so that it can later be re-used by rev-list.c

    * introduces three new functions to commit.c
       copy_commit_header
	    copies the value of a specified commit header into a buffer

       copy_author
	    uses copy_commit_header to extract the author

       copy_parents_in_header_order
            makes an implicit coupling between epoch.c and commit.c
            explicit so as to improve future maintainability of both

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

I have split this patch into 2 because the epoch.c changes in the next
patch of the set swamp the changes to parts of git that other people
care about and I wanted to make these changes easy to review.

The 2nd patch of this 2 patch set is:

[PATCH 2/2] Add support for author-oriented git-rev-list switches [rev 11]

Diverged from aa16021efcd969a44b480d0964e07d52167517db by Linus Torvalds <torvalds@ppc970.osdl.org>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -42,9 +42,9 @@ install: $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o entry.o \
-	 epoch.o refs.o
+	 epoch.o refs.o user.o
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h
+LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h user.h
 
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
@@ -141,6 +141,7 @@ diffcore-pickaxe.o : $(LIB_H) diffcore.h
 diffcore-break.o : $(LIB_H) diffcore.h
 diffcore-order.o : $(LIB_H) diffcore.h
 epoch.o: $(LIB_H)
+user.o: $(LIB_H)
 
 test: all
 	$(MAKE) -C t/ all
diff --git a/commit-tree.c b/commit-tree.c
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -4,8 +4,8 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "user.h"
 
-#include <pwd.h>
 #include <time.h>
 #include <ctype.h>
 
@@ -100,17 +100,16 @@ static char *commit_tree_usage = "git-co
 
 int main(int argc, char **argv)
 {
-	int i, len;
+	int i;
 	int parents = 0;
 	unsigned char tree_sha1[20];
 	unsigned char parent_sha1[MAXPARENT][20];
 	unsigned char commit_sha1[20];
 	char *gecos, *realgecos, *commitgecos;
-	char *email, *commitemail, realemail[1000];
+	char *email, *commitemail, *realemail;
 	char date[50], realdate[50];
 	char *audate, *cmdate;
 	char comment[1000];
-	struct passwd *pw;
 	char *buffer;
 	unsigned int size;
 
@@ -128,19 +127,7 @@ int main(int argc, char **argv)
 	}
 	if (!parents)
 		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
-	pw = getpwuid(getuid());
-	if (!pw)
-		die("You don't exist. Go away!");
-	realgecos = pw->pw_gecos;
-	len = strlen(pw->pw_name);
-	memcpy(realemail, pw->pw_name, len);
-	realemail[len] = '@';
-	gethostname(realemail+len+1, sizeof(realemail)-len-1);
-	if (!strchr(realemail+len+1, '.')) {
-		strcat(realemail, ".");
-		getdomainname(realemail+strlen(realemail), sizeof(realemail)-strlen(realemail)-1);
-	}
-
+	get_real_identity(&realemail, &realgecos);
 	datestamp(realdate, sizeof(realdate));
 	strcpy(date, realdate);
 
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -76,6 +76,12 @@ int parse_commit_buffer(struct commit *i
 	       !get_sha1_hex(bufptr + 7, parent)) {
 		struct commit *new_parent = lookup_commit(parent);
 		if (new_parent) {
+			/** 
+                         * note to maintainers - 
+                         * please read and modify copy_parents_in_header_order
+                         * if this behaviour ever changes from stacking
+                         * to queueing behaviour.
+			 */
 			commit_list_insert(new_parent, &item->parents);
 			add_ref(&item->object, &new_parent->object);
 		}
@@ -302,3 +308,69 @@ int count_parents(struct commit * commit
         return count;
 }
 
+int copy_commit_header(struct commit * commit, char * header, int index, char * buffer, int len)
+{
+	char * p = commit->buffer;
+
+	while (*p != '\n') {		
+		char * q = header;
+		int matched;
+
+		for (matched = 1; *p != ' ' && *p != '\n'; p++, q++) {
+			matched = matched && (*q==*p);
+		}
+		if (matched && index) {
+			/*
+			 * if we matched but we haven't seen the 
+			 * index'th element yet, just decrement 
+			 * the index then pretend we didn't match
+			 */
+			index--;
+			matched = 0;
+		}
+		if (!matched) {			
+			/* skip to start of next header line */			
+			for (;*p!='\n';p++)
+				;
+			p++;
+		} else {			
+			int count = 0; /* number of characters in value */
+			if (*p == ' ') {				
+				p++;
+				count = 0;
+				while(*p != '\n') {
+					if (len > 0)
+						*buffer++=*p;				
+					p++;
+					count++;
+					len--;
+				}					
+			} 
+			if (len > 0)
+				*buffer = 0;
+			return (len > 0) ? count+1 : -(count+1);
+		}			
+	}
+	return 0;
+}
+
+int copy_author(struct commit * commit, char * buffer, int len)
+{
+	return copy_commit_header(commit, "author", 0, buffer, len);
+}
+
+/*
+ * Always produces a list of parents in the order they actually
+ * appear in the commit header. The correct implementation 
+ * of this function depends on decisions made in parse_commit().
+ */
+struct commit_list * copy_parents_in_header_order(struct commit * commit)
+{
+	struct commit_list * parents = commit->parents;
+        struct commit_list * result = NULL;
+
+	for (parents = commit->parents;parents;parents = parents->next) {
+		commit_list_insert(parents->item, &result);
+	}
+	return result;
+}
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -53,4 +53,35 @@ struct commit *pop_most_recent_commit(st
 struct commit *pop_commit(struct commit_list **stack);
 
 int count_parents(struct commit * commit);
+
+/*
+ * Copies the value of the (index+1)'th commit header matching the name 
+ * specified into the buffer supplied and append a trailing NUL.
+ *
+ * Returns n<0 if the buffer was too short, where -n is the required length.
+ * 
+ * Returns 0 if the header doesn't exist.
+ * 
+ * Returns n>0 where n is the length of the copied zero-terminated value, 
+ * including the terminating zero.
+ */
+int copy_commit_header(struct commit * commit, char * header, int index, char * buffer, int len);
+
+/*
+ * Copies the commit's author value into the buffer supplied. 
+ * Return values as per copy_commit_header.
+ */
+int copy_author(struct commit * commit, char * buffer, int len);
+
+/*
+ * Make a copy of the parents in header order. This is the
+ * reverse of the parse order. Callers who need guarantees
+ * about parents being in header order should use this 
+ * call whose semantics will never change even if the
+ * implementation of parse_commit does.
+ *
+ * Callers are expected to destroy the copied list when
+ * they are finished with it.
+ */
+struct commit_list * copy_parents_in_header_order(struct commit * commit);
 #endif /* COMMIT_H */
diff --git a/user.c b/user.c
new file mode 100644
--- /dev/null
+++ b/user.c
@@ -0,0 +1,29 @@
+#include "cache.h"
+#include "user.h"
+#include <string.h>
+#include <pwd.h>
+
+void get_real_identity(char **email, char **gecos)
+{
+	static char buffer[1000];
+	struct passwd *pw;
+	int len;
+
+	pw = getpwuid(getuid());
+	if (!pw)
+		die("You don't exist. Go away!");
+
+	len = strlen(pw->pw_name);
+	memcpy(buffer, pw->pw_name, len);
+	buffer[len] = '@';
+	gethostname(buffer + len + 1, sizeof(buffer) - len - 1);
+	if (!strchr(buffer + len + 1, '.')) {
+		strcat(buffer, ".");
+		getdomainname(buffer + strlen(buffer), 
+				sizeof(buffer) - strlen(buffer) - 1);
+	}
+	if (gecos)
+		*gecos = strdup(pw->pw_gecos);
+	if (email)
+		*email = strdup(buffer);
+}
diff --git a/user.h b/user.h
new file mode 100644
--- /dev/null
+++ b/user.h
@@ -0,0 +1,8 @@
+#ifndef USER_H
+#define USER_H
+/*
+ * Allocates two new strings to contain the real email and
+ * name of the current user.
+ */
+extern void get_real_identity(char **email, char **gecos);
+#endif
