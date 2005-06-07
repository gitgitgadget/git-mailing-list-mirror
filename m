From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Tue, 07 Jun 2005 19:15:23 +1000
Message-ID: <20050607091523.14051.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 07 11:16:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfaAi-0002t8-69
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 11:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVFGJSm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 05:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVFGJSm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 05:18:42 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:64128 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261816AbVFGJP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2005 05:15:27 -0400
Received: (qmail 14059 invoked by uid 500); 7 Jun 2005 09:15:23 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list

This patch is a complete replacement for:
	[PATCH] Add support for --wrt flag to git-rev-list

This patch adds support for --wrt-author, --exclude-author and --author switches
to git-rev-list.

When --wrt-author is specified, --merge-order is implied but 
the linearisation of non-linear epochs is adjusted so that branches
contributed to by the author sort after branches contributed to by
others. This has the effect of presenting a linear history of changes as seen
by the author's own workspace.

For example, given this commit history:

a4 ---
| \   \
|  b4 |
|/ |  |
a3 |  |
|  |  |
a2 |  |
|  |  c3
|  |  |
|  |  c2
|  b3 |
|  | /|
|  b2 |
|  |  c1
|  | /
|  b1    <-- commit authored by author@domain
a1 |
|  |
a0 |
| /
root

--merge-order alone would sort it as follows:

= a4
| c3
| c2
| c1
^ b4
| b3
| b2
| b1
^ a3
| a2
| a1
| a0
= root

however, with --wrt-author --author=author@domain, git-rev-list sorts as follows:

= a4
| c3
| c2
| c1
^ b4
| a3
| a2
| a1
| a0
^ b3
| b2
| b1
= root

If --exclude-author is specified, then git-rev-list behaves as if a 
^argument had been added for each commit authored by the author.

The --exclude-author option allows an author to see a brief summary of 
changes since they last made a contribution to the commit graph. For example:

      git-rev-list --exclude-author --pretty HEAD 

To configure which author git-rev-list uses when processing the --wrt-author 
and --exclude-author switches, use the --author=author@domain option. If this 
option is not specified, git-rev-list uses GIT_AUTHOR_EMAIL or a value
derived from the local user, host and domain names (per git-commit-tree's algorithm)

To support this change, some additional functions were added to commit.c to allow
the extraction of author from the commit header.

Also, --show-breaks, like --wrt-author now implies --merge-order rather than requires it.

This change also updates Documentation/git-rev-list.txt to include documentation for
--wrt-author and other git-rev-list options not currently documented.

A test case has been included in t/t6000-rev-list.sh to verify this change works as
expected.

Use of --wrt-author implies a small overhead (linear with respect to nodes printed) compared with --merge-order.

This change extracts real email id formatting functions from commit-tree.c into user.c and user.h.

NOTE TO REVIEWERS: please pay special attention to get_real_identity() 
which was extracted from commit-tree.c and placed into user.c. It was essentially 
a cut and paste, but since this has the potential to affect the operation of git-commit-tree, 
it would be worth being very careful about checking this change.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

Diverged from ed37b5b2b94398f3ab8312dfdf23cfd25549e3ec by Linus Torvalds <torvalds@ppc970.osdl.org>
---
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,13 +9,25 @@ git-rev-list - Lists commit objects in r
 
 SYNOPSIS
 --------
-'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] [ *--min-age*=timestamp ] [ *--merge-order* [ *--show-breaks* ] ] <commit>
+'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] [ *--min-age*=timestamp ] [ *--pretty* ] [ *--parents* ] [ *--header* ] [ *--merge-order* ] [ *--show-breaks* ] [ *--wrt-author* ] [ *--exclude-author* ] [ *--author=author@domain* ]  <head-to-include> <head-to-include> ... 
+^<base-to-exclude> 
+^<base-to-exclude> ...
 
 DESCRIPTION
 -----------
-Lists commit objects in reverse chronological order starting at the
-given commit, taking ancestry relationship into account.  This is
-useful to produce human-readable log output.
+
+Lists commit objects in reverse chronological order starting at the commits specified by head-to-include values, 
+taking ancestry relationship into account.  git-rev-list will not print any commits that are reachable 
+by any of the base-to-exclude values. 
+
+If *--pretty* is specified, git-rev-list prints a short summary of each commit on stdout. This can be usefully
+parsed by git-shortlog to produce a short log of changes.
+
+If *--parents* is specified, git-rev-list prints a space separated list of parents on the same line as the
+commit identifier.
+
+If *--header* is specified, git-rev-list prints to stdout, on line after the identifier of each commit, 
+the contents of the commit's header followed by a trailing NUL.
 
 If *--merge-order* is specified, the commit history is decomposed into a unique sequence of minimal, non-linear
 epochs and maximal, linear epochs. Non-linear epochs are then linearised by sorting them into merge order, which 
@@ -42,17 +54,30 @@ Commits marked with (=) represent the bo
 Commits marked with (|) are direct parents of commits immediately preceding the marked commit in the list.
 Commits marked with (^) are not parents of the immediately preceding commit. These "breaks" represent necessary discontinuities implied by trying to represent an arbtirary DAG in a linear form.
 
-*--show-breaks* is only valid if *--merge-order* is also specified.
+The *--author* option is used to specify the author used by the *--wrt-author* and *--exclude-author* switches. If 
+an *--author* option is not specified, the author used is derived from GIT_AUTHOR_EMAIL or, ultimately, 
+from the local user, host and domain names as per the logic used by git-commit-tree.
+
+If *--wrt=author* is specified, then git-rev-list sorts commits so that contemporaneously 
+developed commits appear to occur after (that is, sort before) any commits authored by the 
+author specified by *--author*. This reflects the order in which that author 
+sees contemporaneously developed commits appear in her own workspace.
+
+If *--exclude-author* is specified, then any commit authored by the author is marked as uninteresting as if it 
+had been specified with ^ on the command line. This option restricts git-rev-list's to just the changes since 
+the author contributed a change. 
+
+Use of *--show-breaks*, *--exclude-author* or *--wrt-author* implies *--merge-order*.
 
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
 
-Original *--merge-order* logic by Jon Seymour <jon.seymour@gmail.com>
+Original *--merge-order*, *--wrt-author* and *--exclude-author* logic by Jon Seymour <jon.seymour@gmail.com>
 
 Documentation
 --------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by David Greaves, Junio C Hamano, Jon Seymour and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -41,9 +41,9 @@ install: $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o entry.o \
-	 epoch.o refs.o
+	 epoch.o refs.o user.o
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h
+LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h user.h
 
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
@@ -138,6 +138,7 @@ diffcore-pickaxe.o : $(LIB_H) diffcore.h
 diffcore-break.o : $(LIB_H) diffcore.h
 diffcore-order.o : $(LIB_H) diffcore.h
 epoch.o: $(LIB_H)
+user.o: $(LIB_H)
 
 test: all
 	$(MAKE) -C t/ all
diff --git a/commit-tree.c b/commit-tree.c
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -4,10 +4,11 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "user.h"
 
-#include <pwd.h>
 #include <time.h>
 #include <ctype.h>
+#include <pwd.h>
 
 #define BLOCKING (1ul << 14)
 
@@ -100,17 +101,16 @@ static char *commit_tree_usage = "git-co
 
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
 
@@ -128,18 +128,8 @@ int main(int argc, char **argv)
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
+
+        get_real_identity(&realemail, &realgecos);
 
 	datestamp(realdate, sizeof(realdate));
 	strcpy(date, realdate);
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -302,3 +302,65 @@ int count_parents(struct commit * commit
         return count;
 }
 
+int copy_commit_header(struct commit * commit, char * header, int index, char * buffer, int len)
+{
+	char * p = commit->buffer;
+	
+	while (*p) {		
+
+		char * q = header;
+		if (*p == '\n') {
+			break;
+		}
+
+		int matched;
+
+		for (matched = 1; *p != ' ' && *p != '\n'; p++, q++) {
+			matched = matched & (*q==*p);
+		}
+		
+		if (matched && index) {
+			// if we matched but we haven't seen the index'th element yet, 
+			// just decrement the index then pretend we didn't match
+			index--;
+			matched = 0;
+		}
+		
+		if (!matched) {
+			
+			// skip to start of next header line
+			
+			for (;*p!='\n';p++)
+				;
+			p++;
+			
+		} else {
+			
+			int count = 0; // number of characters in value
+			
+			if (*p == ' ') {				
+				p++;
+				
+				for (count = 0; *p != '\n'; p++, count++, len--) {
+					if (len > 0) {
+						*buffer++=*p;				
+					}						
+				}
+								
+			} 
+			
+			if (len > 0) {
+				*buffer = 0;
+			}
+			
+			return (len > 0) ? count+1 : -(count+1);
+			
+		}			
+	}
+	return 0;
+}
+
+int copy_author(struct commit * commit, char * buffer, int len)
+{
+	return copy_commit_header(commit, "author", 0, buffer, len);
+}
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -53,4 +53,17 @@ struct commit *pop_most_recent_commit(st
 struct commit *pop_commit(struct commit_list **stack);
 
 int count_parents(struct commit * commit);
+
+//
+// Copies the value of the (index+1)'th commit header matching the name specified
+// into the buffer supplied and append a trailing NUL.
+//
+// Returns n<0 if the buffer was too short (-n is the required length)
+// Returns 0 if the header doesn't exist.
+// Returns n>0 where n is the length of the copied zero-terminated value, including the terminating zero.
+//
+int copy_commit_header(struct commit * commit, char * header, int index, char * buffer, int len);
+
+// Copies the commit's author value into the buffer supplied. Return values as per copy_commit_header.
+int copy_author(struct commit * commit, char * buffer, int len);
 #endif /* COMMIT_H */
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -450,11 +450,15 @@ static void mark_ancestors_uninteresting
 // Sorts the nodes of the first epoch of the epoch sequence of the epoch headed at head
 // into merge order.
 //
-static void sort_first_epoch(struct commit *head, struct commit_list **stack)
+static void sort_first_epoch(struct commit *head, struct commit_list **stack, marker_func marker)
 {
 	struct commit_list *parents;
 	struct commit_list *reversed_parents = NULL;
 
+        if (marker) {
+	        (*marker)(head);
+        }
+
 	head->object.flags |= VISITED;
 
 	//
@@ -464,17 +468,21 @@ static void sort_first_epoch(struct comm
 	// so we need to reverse this list to output the oldest (or most "local") commits last.
 	//
 
-	for (parents = head->parents; parents; parents = parents->next)
-		commit_list_insert(parents->item, &reversed_parents);
-
-	//
-	// todo: by sorting the parents in a different order, we can alter the 
-	// merge order to show contemporaneous changes in parallel branches
-	// occurring after "local" changes. This is useful for a developer
-	// when a developer wants to see all changes that were incorporated
-	// into the same merge as her own changes occur after her own
-	// changes.
-	//
+	if (!head->object.util) {	
+		
+		for (parents = head->parents; parents; parents = parents->next)
+			commit_list_insert(parents->item, &reversed_parents);
+			
+	} else {
+		
+		// reverse the locally sorted parents and reset utility pointer to NULL
+		
+		parents = (struct commit_list *)head->object.util;
+		head->object.util = NULL;
+		while (parents) {
+			commit_list_insert(pop_commit(&parents), &reversed_parents);
+		}
+	}			
 
 	while (reversed_parents) {
 
@@ -502,7 +510,7 @@ static void sort_first_epoch(struct comm
 
 			} else {
 
-				sort_first_epoch(parent, stack);
+				sort_first_epoch(parent, stack, marker);
 
 				if (reversed_parents) {
 					//
@@ -555,13 +563,82 @@ static int emit_stack(struct commit_list
 }
 
 //
+// Sort a list of commits in local last order. A commit is "local" if any of its ancestors (except the base)
+// causes (*local_test)() to return a non-zero value.
+//
+// The sorted list is returned in *sorted. A side effect of this function is to set each object.util 
+// pointer to a list of parents sorted in local_last order.
+//
+// Does nothing except set *sorted to NULL if either list or local_test are NULL.
+//
+static void sort_list_in_local_last_order(struct commit_list * list, local_test_func local_test, struct commit_list ** sorted)
+{
+	if (!list || !local_test) {
+		*sorted = NULL;
+		return;
+	}
+	
+        struct commit_list * next;
+        
+	for ( next = list ; next; next = next->next) {
+		
+		struct commit * item = next->item;
+		
+		if (item->object.flags & BOUNDARY || item->object.util) {
+			// we have already visited this item or we have
+			// reached the boundary.
+			continue;
+		}
+		
+ 		if ((*local_test)(item)) {
+			item->object.flags |= LOCAL;			
+ 		}			
+		
+		sort_list_in_local_last_order(item->parents, local_test, (struct commit_list **)&item->object.util);		
+		
+		struct commit_list * sorted_parents = (struct commit_list *)&item->object.util;
+		
+		if (sorted_parents && (sorted_parents->item->object.flags & LOCAL)) {
+			item->object.flags |= LOCAL;
+		}					
+	}
+	
+	//
+	// Iterate over the original list and generate two lists - a list of the
+	// non-local parents and list of local parents. Then splice the list
+	// of local parents onto the end of the non-local parents to form
+	// a new list.
+	//
+	
+        struct commit_list * non_local = NULL;
+        struct commit_list * local = NULL;                
+        struct commit_list **p = &local;
+        struct commit_list **q = &non_local;
+        
+	for (next = list; next; next = next->next) {
+		
+		if (next->item->object.flags & LOCAL) { 
+			*p = commit_list_insert(next->item, p);
+			p = &(*p)->next;
+		} else {
+			*q = commit_list_insert(next->item, q);
+			q = &(*q)->next;
+		}
+	}
+	
+	*q = local;	
+	*sorted = non_local;
+	
+}
+
+//
 // Sorts an arbitrary epoch into merge order by sorting each epoch
 // of its epoch sequence into order.
 //
 // Note: this algorithm currently leaves traces of its execution in the
 // object flags of nodes it discovers. This should probably be fixed.
 //
-static int sort_in_merge_order(struct commit *head_of_epoch, emitter_func emitter)
+static int sort_in_merge_order(struct commit *head_of_epoch, emitter_func emitter, local_test_func local_test, marker_func marker)
 {
 	struct commit *next = head_of_epoch;
 	int ret = 0;
@@ -586,6 +663,10 @@ static int sort_in_merge_order(struct co
 			while (HAS_EXACTLY_ONE_PARENT(next)
 			       && (action != STOP)
 			       && !ret) {
+                                
+			        if (marker) {
+				         (*marker)(next);
+                                }
 
 				if (next->object.flags & UNINTERESTING) {
 					action = STOP;
@@ -602,7 +683,10 @@ static int sort_in_merge_order(struct co
 		} else {
 
 			struct commit_list *stack = NULL;
-			sort_first_epoch(next, &stack);
+
+			sort_list_in_local_last_order(next->parents, local_test, (struct commit_list **)&next->object.util);
+			
+			sort_first_epoch(next, &stack, marker);
 			action = emit_stack(&stack, emitter);
 			next = base;
 
@@ -623,7 +707,7 @@ static int sort_in_merge_order(struct co
 // subgraph using the sort_first_epoch algorithm. Once we have reached the base
 // we can continue sorting using sort_in_merge_order.
 //
-int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter)
+int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter, local_test_func local_test, marker_func marker)
 {
 	struct commit_list *stack = NULL;
 	struct commit *base;
@@ -631,7 +715,8 @@ int sort_list_in_merge_order(struct comm
 	int ret = 0;
 	int action = CONTINUE;
 
-	struct commit_list *reversed = NULL;
+	struct commit_list *filtered = NULL;
+	struct commit_list **p = &filtered;
 
 	for (; list; list = list->next) {
 
@@ -642,37 +727,50 @@ int sort_list_in_merge_order(struct comm
 				fprintf(stderr, "%s: duplicate commit %s ignored\n", __FUNCTION__, sha1_to_hex(next->object.sha1));
 			} else {
 				next->object.flags |= DUPCHECK;
-				commit_list_insert(list->item, &reversed);
+				*p = commit_list_insert(list->item, p);
+				p = &(*p)->next;
 			}
 		}
 	}
 
-	if (!reversed->next) {
+	if (!filtered->next) {
 
 		// if there is only one element in the list, we can sort it using 
 		// sort_in_merge_order.
 
-		base = reversed->item;
+		base = filtered->item;
 
 	} else {
 
 		// otherwise, we search for the base of the list
 
-		if ((ret = find_base_for_list(reversed, &base)))
+		if ((ret = find_base_for_list(filtered, &base)))
 			return ret;
 
 		if (base) {
 			base->object.flags |= BOUNDARY;
 		}
-
+		
+		struct commit_list * sorted;
+		
+		sort_list_in_local_last_order(filtered, local_test, &sorted);
+		
+		if (!sorted) {
+			sorted = filtered;
+		}
+		
+		struct commit_list * reversed = NULL;
+		while (sorted) 
+			commit_list_insert(pop_commit(&sorted), &reversed);
+		
 		while (reversed) {
-			sort_first_epoch(pop_commit(&reversed), &stack);
+			sort_first_epoch(pop_commit(&reversed), &stack, marker);
 			if (reversed) {
 				//
 				// if we have more commits to push, then the
-				// first push for the next parent may (or may not)
+				// first push for the next commit may (or may not)
 				// represent a discontinuity with respect to the
-				// parent currently on the top of the stack.
+				// commit currently on the top of the stack.
 				//
 				// mark it for checking here, and check it
 				// with the next push...see sort_first_epoch for
@@ -686,8 +784,9 @@ int sort_list_in_merge_order(struct comm
 	}
 
 	if (base && (action != STOP)) {
-		ret = sort_in_merge_order(base, emitter);
+		ret = sort_in_merge_order(base, emitter, local_test, marker);
 	}
 
 	return ret;
 }
+
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -8,13 +8,19 @@
 #define DO       2
 typedef int (*emitter_func) (struct commit *); 
 
-int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter);
+// functions of this type return non-zero if the commit is "local" by some private assessment of
+// what it is for a commit to be local.
+typedef int (*local_test_func) (struct commit *); 
+typedef void (*marker_func) (struct commit *); 
+
+extern int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter, local_test_func local_test, marker_func marker);
 
 #define UNINTERESTING  (1u<<2)
 #define BOUNDARY       (1u<<3)
 #define VISITED        (1u<<4)
 #define DISCONTINUITY  (1u<<5)
 #define DUPCHECK       (1u<<6)
+#define LOCAL          (1u<<7)
 
 
 #endif				/* EPOCH_H */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "epoch.h"
+#include "user.h"
 
 #define SEEN		(1u << 0)
 #define INTERESTING	(1u << 1)
@@ -11,8 +12,13 @@ static const char rev_list_usage[] =
 		      "  --max-age=epoch\n"
 		      "  --min-age=epoch\n"
 		      "  --header\n"
+		      "  --parents\n"
 		      "  --pretty\n"
-		      "  --merge-order [ --show-breaks ]";
+		      "  --merge-order\n"
+		      "  --wrt-author\n"
+                      "  --exclude-author\n"
+                      "  --author author@domain\n"
+                      "  --show-breaks ]";
 
 static int verbose_header = 0;
 static int show_parents = 0;
@@ -24,6 +30,9 @@ static int max_count = -1;
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
 static int merge_order = 0;
 static int show_breaks = 0;
+static char * local_author = NULL;
+static int exclude_author = 0;
+static int wrt_author = 0;
 
 static void show_commit(struct commit *commit)
 {
@@ -147,6 +156,23 @@ static enum cmit_fmt get_commit_format(c
 	usage(rev_list_usage);	
 }			
 
+static int is_local_author(struct commit * commit)
+{
+	static char author[16384];
+	if (copy_author(commit, author, sizeof(author)) > 0) {
+		if (strstr(author, local_author)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static void mark_authors_own_uninteresting(struct commit * commit)
+{
+        if (is_local_author(commit)) {
+		commit->object.flags |= UNINTERESTING;
+        }
+}
 
 int main(int argc, char **argv)
 {
@@ -192,6 +218,19 @@ int main(int argc, char **argv)
 		}
 		if (!strncmp(arg, "--show-breaks", 13)) {
 			show_breaks = 1;
+                        merge_order = 1;
+			continue;
+		}
+		if (!strncmp(arg, "--author=", 9)) {
+                        local_author=strdup(&arg[9]);
+			continue;
+		}
+		if (!strncmp(arg, "--wrt-author", 6)) {
+		        wrt_author = 1;
+			continue;
+		}
+		if (!strncmp(arg, "--exclude-author", 16)) {
+		        exclude_author = 1;
 			continue;
 		}
 
@@ -201,7 +240,7 @@ int main(int argc, char **argv)
 			arg++;
 			limited = 1;
 		}
-		if (get_sha1(arg, sha1) || (show_breaks && !merge_order))
+		if (get_sha1(arg, sha1))
 			usage(rev_list_usage);
 		commit = lookup_commit_reference(sha1);
 		if (!commit || parse_commit(commit) < 0)
@@ -213,6 +252,8 @@ int main(int argc, char **argv)
 	if (!list)
 		usage(rev_list_usage);
 
+        merge_order = merge_order || wrt_author || exclude_author || show_breaks;
+
 	if (!merge_order) {		
 	
 	        if (limited) 
@@ -220,11 +261,31 @@ int main(int argc, char **argv)
 		show_commit_list(list);
 			
 	} else {
+
+	        if ((exclude_author|wrt_author) && !local_author) {
+		        local_author = strdup(gitenv("GIT_AUTHOR_EMAIL")) ? : NULL;
+                        if (!local_author) {
+			         get_real_identity(&local_author, NULL);
+                        }
+	        }
 		
-		if (sort_list_in_merge_order(list, &process_commit)) {
-			  die("merge order sort failed\n");
+		if (local_author) {
+		        // add delimiters to improve accuracy of match
+		        char * tmp=xmalloc(strlen(local_author)+3);
+		        sprintf(tmp, "<%s>", local_author);
+                        free(local_author);
+                        local_author = tmp;
+                }
+
+		if (sort_list_in_merge_order(
+			list, 
+			&process_commit, 
+			local_author ? &is_local_author : NULL, 
+			exclude_author ? &mark_authors_own_uninteresting : NULL)
+		    ) {
+	      		die("merge order sort failed\n");
 		}
-					
+
 	}
 
 	return 0;
diff --git a/user.c b/user.c
new file mode 100644
--- /dev/null
+++ b/user.c
@@ -0,0 +1,32 @@
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
+		getdomainname(buffer + strlen(buffer), sizeof(buffer) - strlen(buffer) - 1);
+	}
+
+	if (gecos) {
+		*gecos = strdup(pw->pw_gecos);
+	}
+
+	if (email) {
+		*email = strdup(buffer);
+	}
+}
diff --git a/user.h b/user.h
new file mode 100644
--- /dev/null
+++ b/user.h
@@ -0,0 +1,8 @@
+#ifndef USER_H
+#define USER_H
+//
+// Allocates two new strings to contain the real email and
+// name of the current user.
+//
+extern void get_real_identity(char **email, char **gecos);
+#endif
