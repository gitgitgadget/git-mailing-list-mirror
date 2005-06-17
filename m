From: Jon Seymour <jon.seymour@gmail.com>
Subject: Rollup of Jon Seymour's HEAD [rev 2]
Date: Fri, 17 Jun 2005 12:18:51 +1000
Message-ID: <20050617021851.8839.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 17 04:20:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dj6Sd-0003zS-Sy
	for gcvg-git@gmane.org; Fri, 17 Jun 2005 04:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVFQCYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 22:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVFQCYt
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 22:24:49 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:46978 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261898AbVFQCS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 22:18:56 -0400
Received: (qmail 8849 invoked by uid 500); 17 Jun 2005 02:18:51 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This is a rollup of several patches I have recently submitted to the list.
(Patches marked with ! have not been separately posted).

They include:

  * the --wrt-author, --author and --prune-at-author [ including a fix ]
  * refactorization of git-commit-script and addition of support for .git/.nextmsg
  * fix to --merge-order, --max-age interaction

This applies against Linus' latest HEAD - 7875b50d1a9928e683299b283bfe94778b6c344e

! Introduced commit_date function into t6001-rev-list-merge-order.sh test case
! Merged with "Fix for --merge-order, --max-age interaction issue"
! Merged with "Test case that demonstrates problem with --merge-order, --max-age interaction"
[2/2] Fix for --merge-order, --max-age interaction issue
[1/2] Test case that demonstrates problem with --merge-order, --max-age interaction
[3/3] Adds support to git-commit-script for an optional .nextmsg file. [rev 4]
[2/3] Reorganization of git-commit-script [rev 4]
[1/3] Add test cases for git-commit-script.
[1/1] Fix to bug introduced into rev-list.c by [PATCH 5/7] Move...
[7/7] Move traversal parts of epoch.[ch] into traversal.[ch]
[6/7] Remove DUPCHECK, UNINTERESTING flags from epoch.h
[5/7] Move knowledge of UNINTERESTING flag into rev-list.c
[4/7] Move two general purpose commit-related functions into commit.[ch]
[3/7] Rename epoch.c entry points as traverse_* methods/stuctures
[2/7] Introduce new methods into the epoch_methods structure.
[1/7] Additional --merge-order tests and general cleanup of t/t6001-rev-list-merge-order.sh
[2/2] Add support for author-oriented git-rev-list switches [rev 11]
[1/2] Changes to non-epoch.c code required for author-oriented git-rev-list changes

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

Notes: The repo-log proposal has not been included since there is no executable code
associated with that patch yet.

This rollup is included for information and ease of application only. Review comments
should be submitted against each individual patch please!

jon.

[rev2] - sorry missed out 5 required files (user.h, traversal.h, traversal.c, t/t1200-commit-script.sh, user.c)
       - now tested on a clean directory
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,65 +9,114 @@ git-rev-list - Lists commit objects in r
 
 SYNOPSIS
 --------
-'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] [ *--min-age*=timestamp ] [ *--merge-order* [ *--show-breaks* ] ] <commit>
+'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] 
+[ *--min-age*=timestamp ] [ *--pretty* ] [ *--parents* ] [ *--header* ] 
+[ *--merge-order* ] [ *--show-breaks* ] [ *--wrt-author* ] 
+[ *--prune-at-author* ] [ *--author=author@domain* ]  
+<head-to-include> <head-to-include> ... 
+^<base-to-prune> 
+^<base-to-prune> ...
 
 DESCRIPTION
 -----------
-Lists commit objects in reverse chronological order starting at the
-given commit, taking ancestry relationship into account.  This is
-useful to produce human-readable log output.
-
-If *--merge-order* is specified, the commit history is decomposed into a
-unique sequence of minimal, non-linear epochs and maximal, linear epochs.
-Non-linear epochs are then linearised by sorting them into merge order, which
+
+Lists commit objects in reverse chronological order starting at the commits 
+specified by head-to-include values, taking ancestry relationship into account.  
+git-rev-list will not print any commits that are reachable by any of the 
+base-to-prune values. 
+
+If *--max-count* is specified, the number of commits output is 
+limited to the number specified.
+
+If *--max-age* is specified, commits older than the date specified 
+(in seconds since Jan 1, 1970) are excluded from the output.
+
+If *--min-age* is specified, commits younger than the date specified 
+(in seconds since Jan 1, 1970) are excluded from the output.
+
+If *--pretty* is specified, git-rev-list prints a short summary of each 
+commit on stdout. This can be usefully parsed by git-shortlog to produce a 
+short log of changes.
+
+If *--parents* is specified, git-rev-list prints a space separated list 
+of parents on the same line as the commit identifier.
+
+If *--header* is specified, git-rev-list prints to stdout, on lines after 
+the identifier of each commit, the contents of the commit's header followed by 
+a trailing NUL.
+
+If *--merge-order* is specified, the commit history is decomposed into a 
+unique sequence of minimal, non-linear epochs and maximal, linear epochs. 
+Non-linear epochs are then linearised by sorting them into merge order, which 
 is described below.
 
-Maximal, linear epochs correspond to periods of sequential development.
-Minimal, non-linear epochs correspond to periods of divergent development
-followed by a converging merge. The theory of epochs is described in more
-detail at
+Maximal, linear epochs correspond to periods of sequential development. 
+Minimal, non-linear epochs correspond to periods of divergent development 
+followed by a converging merge. The theory of epochs is described in more 
+detail at 
 link:http://blackcubes.dyndns.org/epoch/[http://blackcubes.dyndns.org/epoch/].
 
-The merge order for a non-linear epoch is defined as a linearisation for which
-the following invariants are true:
-
-    1. if a commit P is reachable from commit N, commit P sorts after commit N
-       in the linearised list.
-    2. if Pi and Pj are any two parents of a merge M (with i < j), then any
-       commit N, such that N is reachable from Pj but not reachable from Pi,
-       sorts before all commits reachable from Pi.
-
-Invariant 1 states that later commits appear before earlier commits they are
-derived from.
+The merge order for a non-linear epoch is defined as a linearisation for 
+which the following invariants are true:
 
-Invariant 2 states that commits unique to "later" parents in a merge, appear
-before all commits from "earlier" parents of a merge.
+    1. if a commit P is reachable from commit N, commit P sorts after 
+       commit N in the linearised list.
+    2. if Pi and Pj are any two parents of a merge M (with i < j), then 
+       any commit N, such that N is reachable from Pj but not reachable from 
+       Pi, sorts before all commits reachable from Pi.
+   
+Invariant 1 states that later commits appear before earlier commits 
+they are derived from.
+
+Invariant 2 states that commits unique to "later" parents in a merge, 
+appear before all commits from "earlier" parents of a merge.
+
+If *--show-breaks* is specified, each item of the list is output with a 
+2-character prefix consisting of one of:  (|), (^), (=) followed by a space. 
+ 
+Commits marked with (=) represent the boundaries of minimal, non-linear 
+epochs and correspond either to the start of a period of divergent development 
+or to the end of such a period. 
 
-If *--show-breaks* is specified, each item of the list is output with a
-2-character prefix consisting of one of: (|), (^), (=) followed by a space.
-
-Commits marked with (=) represent the boundaries of minimal, non-linear epochs
-and correspond either to the start of a period of divergent development or to
-the end of such a period.
-
-Commits marked with (|) are direct parents of commits immediately preceding
+Commits marked with (|) are direct parents of commits immediately preceding 
 the marked commit in the list.
 
-Commits marked with (^) are not parents of the immediately preceding commit.
-These "breaks" represent necessary discontinuities implied by trying to
+Commits marked with (^) are not parents of the immediately preceding commit. 
+These "breaks" represent necessary discontinuities implied by trying to 
 represent an arbtirary DAG in a linear form.
 
-*--show-breaks* is only valid if *--merge-order* is also specified.
+If *--wrt-author* is specified, then git-rev-list sorts commits so that 
+contemporaneously developed commits appear to occur after (that is, sort before) 
+any commits authored by the author specified by *--author*. This reflects the 
+order in which that author sees contemporaneously developed commits appear 
+in her own workspace.
+
+If *--prune-at-author* is specified, then the parent of any commit 
+authored by the author is marked as uninteresting as if it had been 
+specified with ^ on the command line. This option restricts git-rev-list's 
+output to just the changes including and following the last change
+contributed by any author in a given branch.
+
+The *--author* option is used to specify the author used by the 
+*--wrt-author* and *--prune-at-author* switches. If an *--author* option is 
+not specified, the author used is derived from GIT_AUTHOR_EMAIL or, ultimately, 
+from the local user, host and domain names as per the logic used by 
+git-commit-tree.
+
+Use of *--show-breaks*, *--prune-at-author* or *--wrt-author* 
+implies *--merge-order*.
 
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
 
-Original *--merge-order* logic by Jon Seymour <jon.seymour@gmail.com>
+Original *--merge-order*, *--wrt-author* and *--prune-at-author* logic 
+by Jon Seymour <jon.seymour@gmail.com>
 
 Documentation
 --------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by David Greaves, Junio C Hamano, Jon Seymour and 
+the git-list <git@vger.kernel.org>.
 
 GIT
 ---
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -43,9 +43,9 @@ install: $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o entry.o \
-	 epoch.o refs.o
+	 traversal.o refs.o user.o epoch.o
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h
+LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h traversal.h user.h
 
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
@@ -142,6 +142,8 @@ diffcore-pathspec.o : $(LIB_H) diffcore.
 diffcore-pickaxe.o : $(LIB_H) diffcore.h
 diffcore-break.o : $(LIB_H) diffcore.h
 diffcore-order.o : $(LIB_H) diffcore.h
+traversal.o: $(LIB_H)
+user.o: $(LIB_H)
 epoch.o: $(LIB_H)
 
 test: all
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
@@ -302,3 +308,92 @@ int count_parents(struct commit * commit
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
+
+int is_parent_of(struct commit *parent, struct commit *child)
+{
+	struct commit_list *parents;
+
+	for (parents = child->parents; parents; parents = parents->next)
+		if (parent==parents->item)
+			return 1;
+	return 0;
+}
+
+/**
+ * pre-condition: src && dst && *src && !(*dst)
+ * post-condition: result && !(*result) && src && dst && *dst
+ */
+struct commit_list ** move_commit(struct commit_list ** dst, struct commit_list ** src)
+{
+	*dst = *src;
+	*src = (*src)->next;
+	(*dst)->next = NULL;
+	return &(*dst)->next;
+}
+
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -53,4 +53,66 @@ struct commit *pop_most_recent_commit(st
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
+
+/*
+ * Return a non-zero value if "commit" is a parent of "child", zero otherwise.
+ */
+int is_parent_of(struct commit *commit, struct commit *child);
+
+
+/**
+ * Move an item pointed to by *src_ptr onto the tail of a list pointed 
+ * to by dst_tail and return the updated tail pointer. *src_ptr is 
+ * updated to refer to the next element on the source list 
+ * or NULL if there is no such element.
+ *
+ * Example:
+ * 
+ * struct commit_list * src = ...;
+ * struct commit_list * dst = NULL;
+ * struct commit_list ** dst_tail = &dst;
+ * struct commit_list ** src_ptr = &src;
+ * 
+ * while (*src_ptr) {
+ *       if (is_moveable(*src_ptr)) {
+ *                dst_tail = move_commit(dst_tail, src_ptr);
+ *       else {
+ *                src_ptr=&(*src_ptr)->next;
+ *       }
+ * }
+ */
+struct commit_list ** move_commit(struct commit_list ** dst_tail, struct commit_list ** src_ptr);
+
 #endif /* COMMIT_H */
+
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -7,22 +7,24 @@
  * for some of the algorithms used here.
  *
  */
-#include <stdlib.h>
-
+#include "commit.h"
+#include "epoch.h"
 /* Provides arbitrary precision integers required to accurately represent
  * fractional mass: */
 #include <openssl/bn.h>
 
-#include "cache.h"
-#include "commit.h"
-#include "epoch.h"
+
+#define ASSERT(x,m,c) /* not currently used - documentation only */
 
 struct fraction {
 	BIGNUM numerator;
 	BIGNUM denominator;
 };
 
-#define HAS_EXACTLY_ONE_PARENT(n) ((n)->parents && !(n)->parents->next)
+struct mass_counter {
+	struct fraction seen;
+	struct fraction pending;
+};
 
 static BN_CTX *context = NULL;
 static struct fraction *one = NULL;
@@ -30,9 +32,8 @@ static struct fraction *zero = NULL;
 
 static BN_CTX *get_BN_CTX()
 {
-	if (!context) {
+	if (!context)
 		context = BN_CTX_new();
-	}
 	return context;
 }
 
@@ -58,10 +59,10 @@ static struct fraction *divide(struct fr
 
 	BN_init(&bn_divisor);
 	BN_set_word(&bn_divisor, divisor);
-
 	BN_copy(&result->numerator, &fraction->numerator);
-	BN_mul(&result->denominator, &fraction->denominator, &bn_divisor, get_BN_CTX());
-
+	BN_mul(	&result->denominator, 
+		&fraction->denominator, 
+		&bn_divisor, get_BN_CTX());
 	BN_clear(&bn_divisor);
 	return result;
 }
@@ -86,9 +87,8 @@ static struct fraction *get_one()
 
 static struct fraction *get_zero()
 {
-	if (!zero) {
+	if (!zero)
 		zero = new_zero();
-	}
 	return zero;
 }
 
@@ -99,28 +99,44 @@ static struct fraction *copy(struct frac
 	return to;
 }
 
-static struct fraction *add(struct fraction *result, struct fraction *left, struct fraction *right)
+static struct fraction *inc(struct fraction *left, struct fraction *right)
 {
 	BIGNUM a, b, gcd;
 
 	BN_init(&a);
 	BN_init(&b);
 	BN_init(&gcd);
-
-	BN_mul(&a, &left->numerator, &right->denominator, get_BN_CTX());
-	BN_mul(&b, &left->denominator, &right->numerator, get_BN_CTX());
-	BN_mul(&result->denominator, &left->denominator, &right->denominator, get_BN_CTX());
-	BN_add(&result->numerator, &a, &b);
-
-	BN_gcd(&gcd, &result->denominator, &result->numerator, get_BN_CTX());
-	BN_div(&result->denominator, NULL, &result->denominator, &gcd, get_BN_CTX());
-	BN_div(&result->numerator, NULL, &result->numerator, &gcd, get_BN_CTX());
-
+	BN_mul(	&a, 
+		&left->numerator, 
+		&right->denominator, 
+		get_BN_CTX());
+	BN_mul(	&b, 
+		&left->denominator, 
+		&right->numerator, 
+		get_BN_CTX());
+	BN_mul( &left->denominator, 
+		&left->denominator, 
+		&right->denominator, 
+		get_BN_CTX());
+	BN_add(	&left->numerator, 
+		&a, 
+		&b);
+	BN_gcd(	&gcd, 
+		&left->denominator, 
+		&left->numerator, 
+		get_BN_CTX());
+	BN_div(	&left->denominator, 
+		NULL, &left->denominator, 
+		&gcd, 
+		get_BN_CTX());
+	BN_div(	&left->numerator, 
+		NULL, &left->numerator, 
+		&gcd, 
+		get_BN_CTX());
 	BN_clear(&a);
 	BN_clear(&b);
 	BN_clear(&gcd);
-
-	return result;
+	return left;
 }
 
 static int compare(struct fraction *left, struct fraction *right)
@@ -130,41 +146,26 @@ static int compare(struct fraction *left
 
 	BN_init(&a);
 	BN_init(&b);
-
 	BN_mul(&a, &left->numerator, &right->denominator, get_BN_CTX());
 	BN_mul(&b, &left->denominator, &right->numerator, get_BN_CTX());
-
 	result = BN_cmp(&a, &b);
-
 	BN_clear(&a);
 	BN_clear(&b);
-
 	return result;
 }
 
-struct mass_counter {
-	struct fraction seen;
-	struct fraction pending;
-};
-
 static struct mass_counter *new_mass_counter(struct commit *commit, struct fraction *pending)
 {
 	struct mass_counter *mass_counter = xmalloc(sizeof(*mass_counter));
-	memset(mass_counter, 0, sizeof(*mass_counter));
 
+	ASSERT(!commit->object.util, "not already initialized", commit);
+
+	memset(mass_counter, 0, sizeof(*mass_counter));
 	init_fraction(&mass_counter->seen);
 	init_fraction(&mass_counter->pending);
-
 	copy(&mass_counter->pending, pending);
 	copy(&mass_counter->seen, get_zero());
-
-	if (commit->object.util) {
-		die("multiple attempts to initialize mass counter for %s",
-		    sha1_to_hex(commit->object.sha1));
-	}
-
 	commit->object.util = mass_counter;
-
 	return mass_counter;
 }
 
@@ -212,89 +213,78 @@ static void free_mass_counter(struct mas
  * non-zero if, and only if, there was a problem parsing one of the
  * commits discovered during the traversal.
  */
-static int find_base_for_list(struct commit_list *list, struct commit **boundary)
+int find_base_for_list(struct commit_list *list, struct commit **boundary)
 {
 	int ret = 0;
 	struct commit_list *cleaner = NULL;
 	struct commit_list *pending = NULL;
 	struct fraction injected;
-	init_fraction(&injected);
-	*boundary = NULL;
 
+	*boundary = NULL;
+	init_fraction(&injected);
 	for (; list; list = list->next) {
 		struct commit *item = list->item;
 
-		if (item->object.util) {
-			die("%s:%d:%s: logic error: this should not have happened - commit %s",
-			    __FILE__, __LINE__, __FUNCTION__,
-			    sha1_to_hex(item->object.sha1));
-		}
-
-		new_mass_counter(list->item, get_one());
-		add(&injected, &injected, get_one());
-
-		commit_list_insert(list->item, &cleaner);
-		commit_list_insert(list->item, &pending);
+		ASSERT(!item->object.util, "no duplicates in list", item);
+		new_mass_counter(item, get_one());
+		inc(&injected, get_one());
+		commit_list_insert(item, &cleaner);
+		commit_list_insert(item, &pending);
 	}
-
 	while (!*boundary && pending && !ret) {
 		struct commit *latest = pop_commit(&pending);
-		struct mass_counter *latest_node = (struct mass_counter *) latest->object.util;
+		struct mass_counter *latest_node;		
 		int num_parents;
-
-		if ((ret = parse_commit(latest)))
+		
+		ret = parse_commit(latest);
+		if (ret)
 			continue;
-		add(&latest_node->seen, &latest_node->seen, &latest_node->pending);
-
+		latest_node = (struct mass_counter *) latest->object.util;
+		inc(&latest_node->seen, &latest_node->pending);
 		num_parents = count_parents(latest);
 		if (num_parents) {
-			struct fraction distribution;
-			struct commit_list *parents;
-
-			divide(init_fraction(&distribution), &latest_node->pending, num_parents);
+			struct fraction div;
+			struct commit_list *parents = latest->parents;
 
-			for (parents = latest->parents; parents; parents = parents->next) {
-				struct commit *parent = parents->item;
-				struct mass_counter *parent_node = (struct mass_counter *) parent->object.util;
-
-				if (!parent_node) {
-					parent_node = new_mass_counter(parent, &distribution);
-					insert_by_date(&pending, parent);
-					commit_list_insert(parent, &cleaner);
-				} else {
-					if (!compare(&parent_node->pending, get_zero()))
-						insert_by_date(&pending, parent);
-					add(&parent_node->pending, &parent_node->pending, &distribution);
-				}
+			divide(	init_fraction(&div), 
+				&latest_node->pending, 
+				num_parents);
+			while (parents) {
+				struct mass_counter * pmc;
+				struct commit *pc = parents->item;
+				
+				pmc = (struct mass_counter *) pc->object.util;
+				if (!pmc) {
+					pmc = new_mass_counter(pc, get_zero());
+					commit_list_insert(pc, &cleaner);
+				}				
+				if (!compare(&pmc->pending, get_zero()))
+					insert_by_date(&pending, pc);					
+				inc(&pmc->pending, &div);
+				parents = parents->next;
 			}
-
-			clear_fraction(&distribution);
+			clear_fraction(&div);
 		}
-
 		if (!compare(&latest_node->seen, &injected))
 			*boundary = latest;
 		copy(&latest_node->pending, get_zero());
 	}
-
 	while (cleaner) {
 		struct commit *next = pop_commit(&cleaner);
 		free_mass_counter((struct mass_counter *) next->object.util);
 		next->object.util = NULL;
 	}
-
 	if (pending)
 		free_commit_list(pending);
-
 	clear_fraction(&injected);
 	return ret;
 }
 
-
 /*
  * Finds the base of an minimal, non-linear epoch, headed at head, by
  * applying the find_base_for_list to a list consisting of the parents
  */
-static int find_base(struct commit *head, struct commit **boundary)
+int find_base(struct commit *head, struct commit **boundary)
 {
 	int ret = 0;
 	struct commit_list *pending = NULL;
@@ -305,7 +295,6 @@ static int find_base(struct commit *head
 	}
 	ret = find_base_for_list(pending, boundary);
 	free_commit_list(pending);
-
 	return ret;
 }
 
@@ -313,19 +302,15 @@ static int find_base(struct commit *head
  * This procedure traverses to the boundary of the first epoch in the epoch
  * sequence of the epoch headed at head_of_epoch. This is either the end of
  * the maximal linear epoch or the base of a minimal non-linear epoch.
- *
- * The queue of pending nodes is sorted in reverse date order and each node
- * is currently in the queue at most once.
  */
-static int find_next_epoch_boundary(struct commit *head_of_epoch, struct commit **boundary)
+int find_next_epoch_boundary(struct commit *head_of_epoch, struct commit **boundary)
 {
-	int ret;
 	struct commit *item = head_of_epoch;
+	int ret;
 
 	ret = parse_commit(item);
 	if (ret)
 		return ret;
-
 	if (HAS_EXACTLY_ONE_PARENT(item)) {
 		/*
 		 * We are at the start of a maximimal linear epoch.
@@ -336,7 +321,6 @@ static int find_next_epoch_boundary(stru
 			ret = parse_commit(item);
 		}
 		*boundary = item;
-
 	} else {
 		/*
 		 * Otherwise, we are at the start of a minimal, non-linear
@@ -344,306 +328,5 @@ static int find_next_epoch_boundary(stru
 		 */
 		ret = find_base(item, boundary);
 	}
-
-	return ret;
-}
-
-/*
- * Returns non-zero if parent is known to be a parent of child.
- */
-static int is_parent_of(struct commit *parent, struct commit *child)
-{
-	struct commit_list *parents;
-	for (parents = child->parents; parents; parents = parents->next) {
-		if (!memcmp(parent->object.sha1, parents->item->object.sha1,
-		            sizeof(parents->item->object.sha1)))
-			return 1;
-	}
-	return 0;
-}
-
-/*
- * Pushes an item onto the merge order stack. If the top of the stack is
- * marked as being a possible "break", we check to see whether it actually
- * is a break.
- */
-static void push_onto_merge_order_stack(struct commit_list **stack, struct commit *item)
-{
-	struct commit_list *top = *stack;
-	if (top && (top->item->object.flags & DISCONTINUITY)) {
-		if (is_parent_of(top->item, item)) {
-			top->item->object.flags &= ~DISCONTINUITY;
-		}
-	}
-	commit_list_insert(item, stack);
-}
-
-/*
- * Marks all interesting, visited commits reachable from this commit
- * as uninteresting. We stop recursing when we reach the epoch boundary,
- * an unvisited node or a node that has already been marking uninteresting.
- *
- * This doesn't actually mark all ancestors between the start node and the
- * epoch boundary uninteresting, but does ensure that they will eventually
- * be marked uninteresting when the main sort_first_epoch() traversal
- * eventually reaches them.
- */
-static void mark_ancestors_uninteresting(struct commit *commit)
-{
-	unsigned int flags = commit->object.flags;
-	int visited = flags & VISITED;
-	int boundary = flags & BOUNDARY;
-	int uninteresting = flags & UNINTERESTING;
-	struct commit_list *next;
-
-	commit->object.flags |= UNINTERESTING;
-
-	/*
-	 * We only need to recurse if
-	 *      we are not on the boundary and
-	 *      we have not already been marked uninteresting and
-	 *      we have already been visited.
-	 *
-	 * The main sort_first_epoch traverse will mark unreachable
-	 * all uninteresting, unvisited parents as they are visited
-	 * so there is no need to duplicate that traversal here.
-	 *
-	 * Similarly, if we are already marked uninteresting
-	 * then either all ancestors have already been marked
-	 * uninteresting or will be once the sort_first_epoch
-	 * traverse reaches them.
-	 */
-
-	if (uninteresting || boundary || !visited)
-		return;
-
-	for (next = commit->parents; next; next = next->next)
-		mark_ancestors_uninteresting(next->item);
-}
-
-/*
- * Sorts the nodes of the first epoch of the epoch sequence of the epoch headed at head
- * into merge order.
- */
-static void sort_first_epoch(struct commit *head, struct commit_list **stack)
-{
-	struct commit_list *parents;
-	struct commit_list *reversed_parents = NULL;
-
-	head->object.flags |= VISITED;
-
-	/*
-	 * parse_commit() builds the parent list in reverse order with respect
-	 * to the order of the git-commit-tree arguments. So we need to reverse
-	 * this list to output the oldest (or most "local") commits last.
-	 */
-	for (parents = head->parents; parents; parents = parents->next)
-		commit_list_insert(parents->item, &reversed_parents);
-
-	/*
-	 * TODO: By sorting the parents in a different order, we can alter the
-	 * merge order to show contemporaneous changes in parallel branches
-	 * occurring after "local" changes. This is useful for a developer
-	 * when a developer wants to see all changes that were incorporated
-	 * into the same merge as her own changes occur after her own
-	 * changes.
-	 */
-
-	while (reversed_parents) {
-		struct commit *parent = pop_commit(&reversed_parents);
-
-		if (head->object.flags & UNINTERESTING) {
-			/*
-			 * Propagates the uninteresting bit to all parents.
-			 * if we have already visited this parent, then
-			 * the uninteresting bit will be propagated to each
-			 * reachable commit that is still not marked
-			 * uninteresting and won't otherwise be reached.
-			 */
-			mark_ancestors_uninteresting(parent);
-		}
-
-		if (!(parent->object.flags & VISITED)) {
-			if (parent->object.flags & BOUNDARY) {
-				if (*stack) {
-					die("something else is on the stack - %s",
-					    sha1_to_hex((*stack)->item->object.sha1));
-				}
-				push_onto_merge_order_stack(stack, parent);
-				parent->object.flags |= VISITED;
-
-			} else {
-				sort_first_epoch(parent, stack);
-				if (reversed_parents) {
-					/*
-					 * This indicates a possible
-					 * discontinuity it may not be be
-					 * actual discontinuity if the head
-					 * of parent N happens to be the tail
-					 * of parent N+1.
-					 *
-					 * The next push onto the stack will
-					 * resolve the question.
-					 */
-					(*stack)->item->object.flags |= DISCONTINUITY;
-				}
-			}
-		}
-	}
-
-	push_onto_merge_order_stack(stack, head);
-}
-
-/*
- * Emit the contents of the stack.
- *
- * The stack is freed and replaced by NULL.
- *
- * Sets the return value to STOP if no further output should be generated.
- */
-static int emit_stack(struct commit_list **stack, emitter_func emitter)
-{
-	unsigned int seen = 0;
-	int action = CONTINUE;
-
-	while (*stack && (action != STOP)) {
-		struct commit *next = pop_commit(stack);
-		seen |= next->object.flags;
-		if (*stack)
-			action = (*emitter) (next);
-	}
-
-	if (*stack) {
-		free_commit_list(*stack);
-		*stack = NULL;
-	}
-
-	return (action == STOP || (seen & UNINTERESTING)) ? STOP : CONTINUE;
-}
-
-/*
- * Sorts an arbitrary epoch into merge order by sorting each epoch
- * of its epoch sequence into order.
- *
- * Note: this algorithm currently leaves traces of its execution in the
- * object flags of nodes it discovers. This should probably be fixed.
- */
-static int sort_in_merge_order(struct commit *head_of_epoch, emitter_func emitter)
-{
-	struct commit *next = head_of_epoch;
-	int ret = 0;
-	int action = CONTINUE;
-
-	ret = parse_commit(head_of_epoch);
-
-	while (next && next->parents && !ret && (action != STOP)) {
-		struct commit *base = NULL;
-
-		ret = find_next_epoch_boundary(next, &base);
-		if (ret)
-			return ret;
-		next->object.flags |= BOUNDARY;
-		if (base)
-			base->object.flags |= BOUNDARY;
-
-		if (HAS_EXACTLY_ONE_PARENT(next)) {
-			while (HAS_EXACTLY_ONE_PARENT(next)
-			       && (action != STOP)
-			       && !ret) {
-				if (next->object.flags & UNINTERESTING) {
-					action = STOP;
-				} else {
-					action = (*emitter) (next);
-				}
-				if (action != STOP) {
-					next = next->parents->item;
-					ret = parse_commit(next);
-				}
-			}
-
-		} else {
-			struct commit_list *stack = NULL;
-			sort_first_epoch(next, &stack);
-			action = emit_stack(&stack, emitter);
-			next = base;
-		}
-	}
-
-	if (next && (action != STOP) && !ret) {
-		(*emitter) (next);
-	}
-
-	return ret;
-}
-
-/*
- * Sorts the nodes reachable from a starting list in merge order, we
- * first find the base for the starting list and then sort all nodes
- * in this subgraph using the sort_first_epoch algorithm. Once we have
- * reached the base we can continue sorting using sort_in_merge_order.
- */
-int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter)
-{
-	struct commit_list *stack = NULL;
-	struct commit *base;
-	int ret = 0;
-	int action = CONTINUE;
-	struct commit_list *reversed = NULL;
-
-	for (; list; list = list->next) {
-		struct commit *next = list->item;
-
-		if (!(next->object.flags & UNINTERESTING)) {
-			if (next->object.flags & DUPCHECK) {
-				fprintf(stderr, "%s: duplicate commit %s ignored\n",
-					__FUNCTION__, sha1_to_hex(next->object.sha1));
-			} else {
-				next->object.flags |= DUPCHECK;
-				commit_list_insert(list->item, &reversed);
-			}
-		}
-	}
-
-	if (!reversed->next) {
-		/*
-		 * If there is only one element in the list, we can sort it
-		 * using sort_in_merge_order.
-		 */
-		base = reversed->item;
-	} else {
-		/*
-		 * Otherwise, we search for the base of the list.
-		 */
-		ret = find_base_for_list(reversed, &base);
-		if (ret)
-			return ret;
-		if (base)
-			base->object.flags |= BOUNDARY;
-
-		while (reversed) {
-			sort_first_epoch(pop_commit(&reversed), &stack);
-			if (reversed) {
-				/*
-				 * If we have more commits to push, then the
-				 * first push for the next parent may (or may
-				 * not) represent a discontinuity with respect
-				 * to the parent currently on the top of
-				 * the stack.
-				 *
-				 * Mark it for checking here, and check it
-				 * with the next push. See sort_first_epoch()
-				 * for more details.
-				 */
-				stack->item->object.flags |= DISCONTINUITY;
-			}
-		}
-
-		action = emit_stack(&stack, emitter);
-	}
-
-	if (base && (action != STOP)) {
-		ret = sort_in_merge_order(base, emitter);
-	}
-
 	return ret;
 }
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -1,20 +1,38 @@
+/*
+ * Copyright (c) 2005, Jon Seymour
+ *
+ * For more information about epoch theory on which this module is based,
+ * refer to http://blackcubes.dyndns.org/epoch/. That web page defines
+ * terms such as "epoch" and "minimal, non-linear epoch" and provides rationales
+ * for some of the algorithms used here.
+ *
+ */
 #ifndef EPOCH_H
 #define EPOCH_H
 
+#include "cache.h"
 
-// return codes for emitter_func
-#define STOP     0
-#define CONTINUE 1
-#define DO       2
-typedef int (*emitter_func) (struct commit *); 
+#define HAS_EXACTLY_ONE_PARENT(n) ((n)->parents && !(n)->parents->next)
 
-int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter);
-
-#define UNINTERESTING  (1u<<2)
-#define BOUNDARY       (1u<<3)
-#define VISITED        (1u<<4)
-#define DISCONTINUITY  (1u<<5)
-#define DUPCHECK       (1u<<6)
-
-
-#endif				/* EPOCH_H */
+/*
+ * Find the next articulation point in the graph
+ */
+int find_base_for_list(struct commit_list *list, struct commit **boundary);
+
+/*
+ * Find the base of the minimal, non-linear epoch headed at head.
+ *
+ * The base is the first articulation point of the graph reachable from head
+ * such that the only paths between the head and commits reachable from the 
+ * base are paths that include the base itself.
+ */
+int find_base(struct commit *head, struct commit **boundary);
+
+/*
+ * Find the boundary of the next epoch in the unique epoch sequence
+ * for the graph reachable from head. This is either the
+ * end of the base of a minimal, non-linear epoch (if head has >1 parents)
+ * or the end of a maximal, linear epoch (if head has exactly 1 parent)
+ */
+int find_next_epoch_boundary(struct commit *head, struct commit **boundary);
+#endif /* EPOCH_H */
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -1,44 +1,114 @@
 #!/bin/sh
+
+initial_commit() {
+cat <<EOF
+#
+# Initial commit:
+# 
+$(git-ls-files | sed "s/^/# New file: /")
+#
+EOF
+}
+
+merge_commit() {
+cat <<EOF
+#
+# It looks like your may be committing a MERGE.
+# If this is not correct, please remove the file
+# $GIT_DIR/MERGE_HEAD
+# and try again
+#
+EOF
+}
+
+print_status() {
+	if [ ! -r $GIT_DIR/HEAD ]; then
+		if [ -z "$(git-ls-files)" ]; then
+			echo Nothing to commit 1>&2
+			return 1
+		fi
+		initial_commit 
+	else
+		if [ -f $GIT_DIR/MERGE_HEAD ]; then
+			merge_commit
+		fi
+		git-status-script
+	fi
+}
+
+merge_next_message()
+{
+	status=$1
+	next=$2
+	mv -f $status .status.$$ || exit 1
+	cat >$status <<EOF
+$SENTINEL
+#---
+$(cat $next)
+#---
+$(cat .status.$$)
+EOF
+	rm .status.$$
+}
+
+save_next_message()
+{
+	status=$1
+	next=$2
+	grep -v "^#" < $status > $next
+	if grep "^$SENTINEL" < $status >/dev/null; then
+		:> $status
+		echo "commit aborted - you must delete the SENTINEL line to confirm the commit"
+	fi
+}
+
+edit_message() {
+	status=$1
+	msg=$2
+	next=$3
+
+	:> $msg
+	[ -f "$next" ] && merge_next_message "$status" "$next"
+	${VISUAL:-${EDITOR:-vi}} "$status"
+	[ -f "$next" ] && save_next_message "$status" "$next"
+	grep -v '^#' < $status | git-stripspace >$msg
+	[ -s $msg ] || exit 1
+}
+
+commit_parents() {
+	[ -f $GIT_DIR/HEAD ] &&
+	echo -n "-p HEAD" &&
+	[ -f $GIT_DIR/MERGE_HEAD ] &&
+	echo -n " -p MERGE_HEAD"
+	echo ""
+}
+
+exec_commit() {
+	msg=$1
+	tree=$(git-write-tree) || exit 1
+	parents=$(commit_parents) || exit 1
+	commit=$(cat $msg | git-commit-tree $tree $parents) || exit 1
+	echo $commit > $GIT_DIR/HEAD
+	rm -f -- $GIT_DIR/MERGE_HEAD
+}
+
+SENTINEL="#SENTINEL - delete this line to confirm the commit"
 : ${GIT_DIR=.git}
 if [ ! -d $GIT_DIR ]; then
 	echo Not a git directory 1>&2
 	exit 1
 fi
-PARENTS="-p HEAD"
-if [ ! -r $GIT_DIR/HEAD ]; then
-	if [ -z "$(git-ls-files)" ]; then
-		echo Nothing to commit 1>&2
-		exit 1
-	fi
-	(
-		echo "#"
-		echo "# Initial commit"
-		echo "#"
-		git-ls-files | sed 's/^/# New file: /'
-		echo "#"
-	) > .editmsg
-	PARENTS=""
-else
-	if [ -f $GIT_DIR/MERGE_HEAD ]; then
-		echo "#"
-		echo "# It looks like your may be committing a MERGE."
-		echo "# If this is not correct, please remove the file"
-		echo "#	$GIT_DIR/MERGE_HEAD"
-		echo "# and try again"
-		echo "#"
-		PARENTS="-p HEAD -p MERGE_HEAD"
-	fi > .editmsg
-	git-status-script >> .editmsg
-fi
-if [ "$?" != "0" ]
-then
+
+if ! print_status > .editmsg; then
 	cat .editmsg
+	rm .editmsg
 	exit 1
 fi
-${VISUAL:-${EDITOR:-vi}} .editmsg
-grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
-[ -s .cmitmsg ] || exit 1
-tree=$(git-write-tree) || exit 1
-commit=$(cat .cmitmsg | git-commit-tree $tree $PARENTS) || exit 1
-echo $commit > $GIT_DIR/HEAD
-rm -f -- $GIT_DIR/MERGE_HEAD
+
+if edit_message .editmsg .cmitmsg ${GIT_DIR}/.nextmsg ; then
+	exec_commit .cmitmsg
+	[ -f .editmsg ] && rm .editmsg
+	[ -f .cmitmsg ] && rm .cmitmsg
+	[ -f ${GIT_DIR}/.nextmsg ] && rm ${GIT_DIR}/.nextmsg
+	exit 0
+fi
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -1,18 +1,25 @@
 #include "cache.h"
 #include "commit.h"
-#include "epoch.h"
+#include "traversal.h"
+#include "user.h"
 
-#define SEEN		(1u << 0)
-#define INTERESTING	(1u << 1)
+#define INTERESTING	(LAST_TRAVERSAL_FLAG << 1)
+#define UNINTERESTING   (INTERESTING << 1)
+#define DUPCHECK        (UNINTERESTING << 1)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
-		      "  --max-count=nr\n"
-		      "  --max-age=epoch\n"
-		      "  --min-age=epoch\n"
-		      "  --header\n"
-		      "  --pretty\n"
-		      "  --merge-order [ --show-breaks ]";
+			"  --max-count=nr\n"
+			"  --max-age=epoch\n"
+			"  --min-age=epoch\n"
+			"  --header\n"
+			"  --parents\n"
+			"  --pretty\n"
+			"  --merge-order\n"
+			"  --wrt-author\n"
+			"  --prune-at-author\n"
+			"  --author=author@domain\n"
+			"  --show-breaks";
 
 static int verbose_header = 0;
 static int show_parents = 0;
@@ -24,16 +31,22 @@ static int max_count = -1;
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
 static int merge_order = 0;
 static int show_breaks = 0;
+static char * local_author = NULL;
+static int prune_at_author = 0;
+static int wrt_author = 0;
+static int stop_traversal = 0;
+static struct commit * last_printed = NULL;
 
 static void show_commit(struct commit *commit)
 {
+
 	if (show_breaks) {
 		prefix = "| ";
-		if (commit->object.flags & DISCONTINUITY) {
-			prefix = "^ ";     
-		} else if (commit->object.flags & BOUNDARY) {
+		if (commit->object.flags & BOUNDARY) {
 			prefix = "= ";
-		} 
+		} else if (last_printed && !is_parent_of(commit, last_printed)) {
+			prefix = "^ ";     
+		}
         }        		
 	printf("%s%s", prefix, sha1_to_hex(commit->object.sha1));
 	if (show_parents) {
@@ -49,22 +62,32 @@ static void show_commit(struct commit *c
 		pretty_print_commit(commit_format, commit->buffer, ~0, pretty_header, sizeof(pretty_header));
 		printf("%s%c", pretty_header, hdr_termination);
 	}	
+	last_printed = commit;
 }
 
 static int filter_commit(struct commit * commit)
 {
-	if (commit->object.flags & UNINTERESTING)
+	if (commit->object.flags & UNINTERESTING) {
+		stop_traversal=1;
 		return CONTINUE;
+	}
 	if (min_age != -1 && (commit->date > min_age))
 		return CONTINUE;
-	if (max_age != -1 && (commit->date < max_age))
-		return STOP;
+	if (max_age != -1 && (commit->date < max_age)) {
+		stop_traversal=1;
+		return merge_order ? CONTINUE : STOP;
+	}
 	if (max_count != -1 && !max_count--)
 		return STOP;
 
 	return DO;
 }
 
+static int continue_traversal(struct commit * commit)
+{
+	return !stop_traversal;
+}
+
 static int process_commit(struct commit * commit)
 {
 	int action=filter_commit(commit);
@@ -147,6 +170,130 @@ static enum cmit_fmt get_commit_format(c
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
+static void mark_authors_own_uninteresting(struct commit * commit, int first_visit)
+{
+        if (first_visit && is_local_author(commit)) {
+		struct commit_list * parents = commit->parents;
+		for (;parents;parents=parents->next) {
+			parents->item->object.flags |= UNINTERESTING;
+		}
+        }
+}
+
+/*
+ * Marks all interesting, visited commits reachable from this commit
+ * as uninteresting. We stop recursing when we reach the epoch boundary,
+ * an unvisited node or a node that has already been marked uninteresting.
+ *
+ * This doesn't actually mark all ancestors between the start node and the
+ * epoch boundary uninteresting, but does ensure that they will eventually
+ * be marked uninteresting when the main sort_unvisited() traversal
+ * eventually reaches them.
+ */
+static void mark_ancestors_uninteresting(struct commit * head, struct commit *parent)
+{
+	unsigned int flags, seen, boundary, uninteresting;
+	struct commit_list *next;
+
+	if (!(head->object.flags & UNINTERESTING)) {
+		return;
+	}
+
+	flags = parent->object.flags;
+	seen = flags & SEEN;
+	boundary = flags & BOUNDARY;
+	uninteresting = flags & UNINTERESTING;
+
+	parent->object.flags |= UNINTERESTING;
+	/*
+	 * We only need to recurse if
+	 *      we are not on the boundary and
+	 *      we have not already been marked uninteresting and
+	 *      we have already been seen.
+	 *
+	 * The main traversal will mark unreachable
+	 * all uninteresting, unvisited parents as they are visited
+	 * so there is no need to duplicate that traversal here.
+	 *
+	 * Similarly, if the parent is already marked uninteresting
+	 * then either all ancestors have already been marked
+	 * uninteresting or will be once the sort_unvisited
+	 * traverse reaches them.
+	 */
+	if (uninteresting || boundary || !seen)
+		return;
+	for (next = parent->parents; next; next = next->next)
+		mark_ancestors_uninteresting(parent, next->item);
+}
+
+static void merge_order_traversal(struct commit_list * list, int limited)
+{
+	struct traversal traversal;
+	struct commit_list * elided = NULL;
+	struct commit_list ** elided_tail = &elided;
+        struct commit_list ** ptr=&list;
+
+	/**
+	 * Remove duplicates and uninteresting items.
+	 */
+	for (; *ptr; ) {
+		if ((*ptr)->item->object.flags & (UNINTERESTING|DUPCHECK))
+			elided_tail = move_commit(elided_tail, ptr);
+		else {
+			(*ptr)->item->object.flags |= DUPCHECK;
+			ptr = &(*ptr)->next;
+		}
+	}	
+	if (elided) 
+		free_commit_list(elided);
+	if (!list) {
+		die("all of the specified heads are interesting - nothing to do");
+	}
+
+	/*
+         * Setup the traversal
+	 */
+	init_traversal(&traversal);
+	if ((prune_at_author|wrt_author) && !local_author) {
+		local_author = gitenv("GIT_AUTHOR_EMAIL") ? : NULL;			    
+		if (!local_author)
+			get_real_identity(&local_author, NULL);
+		else
+			local_author = strdup(local_author);
+	}
+	if (local_author) {
+		    /* add delimiters to improve accuracy of match */
+		    char * tmp=xmalloc(strlen(local_author)+3);
+		    sprintf(tmp, "<%s>", local_author);
+		    free(local_author);
+		    local_author = tmp;
+	}		 
+	traversal.emitter = &process_commit;		  
+	traversal.continue_traversal = &continue_traversal;
+	if (limited || prune_at_author)
+		traversal.edge_visitor = &mark_ancestors_uninteresting;
+	if (wrt_author)
+		traversal.local_test = &is_local_author;
+	if (prune_at_author)
+		traversal.commit_visitor = &mark_authors_own_uninteresting;
+
+	/*
+         * Do it.
+         */
+	if (traverse_from_list(list, &traversal))
+		die("merge order sort failed\n");
+}
 
 int main(int argc, char **argv)
 {
@@ -186,14 +333,26 @@ int main(int argc, char **argv)
 			show_parents = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--merge-order", 13)) {
+		if (!strcmp(arg, "--merge-order")) {
 		        merge_order = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--show-breaks", 13)) {
+		if (!strcmp(arg, "--show-breaks")) {
 			show_breaks = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--author=", 9)) {
+                        local_author=strdup(&arg[9]);
+			continue;
+		}
+		if (!strcmp(arg, "--wrt-author")) {
+		        wrt_author = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--prune-at-author")) {
+		        prune_at_author = 1;
+			continue;
+		}
 
 		flags = 0;
 		if (*arg == '^') {
@@ -201,7 +360,7 @@ int main(int argc, char **argv)
 			arg++;
 			limited = 1;
 		}
-		if (get_sha1(arg, sha1) || (show_breaks && !merge_order))
+		if (get_sha1(arg, sha1))
 			usage(rev_list_usage);
 		commit = lookup_commit_reference(sha1);
 		if (!commit || parse_commit(commit) < 0)
@@ -213,14 +372,18 @@ int main(int argc, char **argv)
 	if (!list)
 		usage(rev_list_usage);
 
+       	merge_order = 
+		merge_order
+		|| wrt_author 
+		|| prune_at_author 
+		|| show_breaks;
+
 	if (!merge_order) {		
 	        if (limited)
 			list = limit_list(list);
 		show_commit_list(list);
-	} else {
-		if (sort_list_in_merge_order(list, &process_commit)) {
-			  die("merge order sort failed\n");
-		}
+	} else {		
+		merge_order_traversal(list, limited);
 	}
 
 	return 0;
diff --git a/t/t1200-commit-script.sh b/t/t1200-commit-script.sh
new file mode 100755
--- /dev/null
+++ b/t/t1200-commit-script.sh
@@ -0,0 +1,188 @@
+#!/bin/sh
+#
+# Copyright (C) 2005 Rene Scharfe
+# Copyright (C) 2005 Jon Seymour [ adapted to git-commit-script ]
+#
+
+test_description='git-commit-script
+
+This test checks that git-commit-script works as expected.
+'
+
+. ./test-lib.sh
+
+one_line()
+{
+echo "this is a commit test"
+}
+
+expected_commit ()
+{
+	tree=$1
+	shift 1
+cat <<EOF
+tree $tree
+EOF
+
+	for p in $*
+	do
+cat <<EOF
+parent $p
+EOF
+	done
+
+cat <<EOF
+author Author Name <author@email> 1117148400 +0000
+committer Committer Name <committer@email> 1117150200 +0000
+
+$(one_line)
+EOF
+}
+
+cat >add_one_line_editor <<EOF
+#!/bin/sh
+file=\$1
+echo "$(one_line)" >> \$file
+EOF
+
+cat >do_nothing_editor <<EOF
+#!/bin/sh
+:
+EOF
+
+cat >delete_sentinel_editor <<EOF
+#!/bin/sh
+file=\$1
+mv \$file \$file.\$\$
+sed "/^#SENTINEL/d" < \$file.\$\$ >\$file
+EOF
+
+chmod u+x add_one_line_editor
+chmod u+x do_nothing_editor
+chmod u+x delete_sentinel_editor
+
+: > foo
+: > bar
+
+run_with_vars()
+{
+     GIT_AUTHOR_NAME="Author Name" \
+     GIT_AUTHOR_EMAIL="author@email" \
+     GIT_AUTHOR_DATE="2005-05-26 23:00" \
+     GIT_COMMITTER_NAME="Committer Name" \
+     GIT_COMMITTER_EMAIL="committer@email" \
+     GIT_COMMITTER_DATE="2005-05-26 23:30" \
+     TZ= "$@" 2>/dev/null
+}
+
+reset()
+{
+     [ -f .git/HEAD ] && rm .git/HEAD
+     [ -f .git/MERGE_HEAD ] && rm .git/MERGE_HEAD
+     [ -f .git/index ] && rm .git/index
+     [ -f treeid ] && rm treeid
+     [ -f commit ] && rm commit
+}
+
+test_phase1()
+{
+     condition=$1
+     editor=$2
+
+     test_expect_success \
+     "$condition - test preparation: add a file" \
+     'git-update-cache --add foo && git-write-tree > treeid'
+
+     test_expect_failure \
+     "$condition - Do not edit the commit message" \
+     "EDITOR=$editor run_with_vars git-commit-script"
+
+     test_expect_failure \
+     "$condition - No HEAD created when commit fails" \
+     '[ -f .git/HEAD ]'
+}
+
+test_phase2()
+{
+    condition=$1
+    editor=$2
+    test_expect_success \
+    "$condition - Single line message works" \
+    "EDITOR=$editor run_with_vars git-commit-script"
+
+    test_expect_success "$condition - HEAD created" '[ -f .git/HEAD ]'
+
+    test_expect_success \
+    "$condition - read commit 1" \
+    'git-cat-file commit HEAD >commit'
+
+    test_expect_success \
+    "$condition - compare commit" \
+    'expected_commit $(cat treeid) > expected && diff expected commit'
+
+    head=$(cat .git/HEAD)
+    test_expect_success \
+    "$condition - create a merge head" \
+    'merge_head=$(git-commit-tree $(cat treeid) -p HEAD < /dev/null)'
+
+    echo $merge_head > .git/MERGE_HEAD
+
+    test_expect_success \
+    "$condition - test preparation: write tree containing" \
+    'git-update-cache --add bar && git-write-tree > treeid.bar'
+
+}
+
+test_phase3()
+{
+    condition=$1
+    editor=$2
+
+    test_expect_success \
+    "$condition - write a tree with one merge head" \
+    "EDITOR=$editor run_with_vars git-commit-script"
+    
+    test_expect_success "$condition - MERGE_HEAD removed" '[ -f .git/HEAD ]'
+    test_expect_success "$condition - MERGE_HEAD removed by successful commit" '! [ -f .git/MERGE_HEAD ]'
+
+    test_expect_success \
+    "$condition - read commit 2" \
+    'git-cat-file commit HEAD >commit'
+
+    test_expect_success \
+    "$condition - compare commit 2" \
+    "expected_commit $(cat treeid.bar) ${head} ${merge_head} > expected && diff expected commit"
+
+}
+
+test_phase1 "without .nextmsg" ./do_nothing_editor
+test_phase2 "without .nextmsg" ./add_one_line_editor
+test_phase3 "without .nextmsg" ./add_one_line_editor
+
+reset
+
+one_line > .git/.nextmsg
+test_phase1 "with .nextmsg" ./do_nothing_editor
+test_expect_success ".nextmsg file kept" "[ -f .git/.nextmsg -a \"$(cat .git/.nextmsg)\" == \"$(one_line)\" ]"
+
+one_line    > .git/.nextmsg
+test_phase2 "with .nextmsg" ./delete_sentinel_editor
+test_expect_success ".nextmsg file deleted" '! [ -f .git/.nextmsg ]'
+
+one_line    > .git/.nextmsg
+test_phase3 "with .nextmsg" ./delete_sentinel_editor
+test_expect_success ".nextmsg file deleted" '! [ -f .git/.nextmsg ]'
+
+reset
+
+: > .git/.nextmsg
+test_phase1 "with .nextmsg, change preserved, sentinel kept" ./add_one_line_editor
+test_expect_success "edit preserved - sentinel not deleted" "[ -f .git/.nextmsg -a \"$(cat .git/.nextmsg | tr -d \\012 )\" == \"$(one_line)\" ]"
+
+reset
+
+: > .git/.nextmsg
+test_phase1 "with .nextmsg, no data, no edit, sentinel kept" ./do_nothing_editor
+test_expect_success "no change - sentinel not deleted" "[ -f .git/.nextmsg -a \"$(cat .git/.nextmsg)\" == \"\" ]"
+
+test_done
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
old mode 100644
new mode 100755
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -3,15 +3,122 @@
 # Copyright (c) 2005 Jon Seymour
 #
 
-test_description='Test rev-list --merge-order
-'
+test_description='Tests git-rev-list --merge-order functionality'
+
 . ./test-lib.sh
 
-function do_commit
+#
+# TODO: move the following block (upto --- end ...) into testlib.sh
+#
+[ -d .git/refs/tags ] || mkdir -p .git/refs/tags
+
+sed_script="";
+
+# Answer the sha1 has associated with the tag. The tag must exist in .git or .git/refs/tags
+function tag
+{
+	_tag=$1
+	[ -f .git/refs/tags/$_tag ] || error "tag: \"$_tag\" does not exist"
+	cat .git/refs/tags/$_tag
+}
+
+# Generate a commit using the text specified to make it unique and the tree
+# named by the tag specified.
+function unique_commit
+{
+	_text=$1
+        _tree=$2
+	shift 2
+    	echo $_text | git-commit-tree $(tag $_tree) "$@"
+}
+
+# Save the output of a command into the tag specified. Prepend
+# a substitution script for the tag onto the front of $sed_script
+function save_tag
+{
+	_tag=$1	
+	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
+	shift 1
+    	"$@" >.git/refs/tags/$_tag
+    	sed_script="s/$(tag $_tag)/$_tag/g${sed_script+;}$sed_script"
+}
+
+# Replace unhelpful sha1 hashses with their symbolic equivalents 
+function entag
+{
+	sed "$sed_script"
+}
+
+# Execute a command after first saving, then setting the GIT_AUTHOR_EMAIL
+# tag to a specified value. Restore the original value on return.
+function as_author
+{
+	_author=$1
+	shift 1
+        _save=$GIT_AUTHOR_EMAIL
+
+	export GIT_AUTHOR_EMAIL="$_author"
+	"$@"
+        export GIT_AUTHOR_EMAIL="$_save"
+}
+
+function commit_date 
+{
+        _commit=$1
+	git-cat-file commit $_commit | sed -n "s/^committer .*> \([0-9]*\) .*/\1/p" 
+}
+
+function on_committer_date {
+    _date=$1
+    shift 1
+    GIT_COMMITTER_DATE=$_date "$@"
+}
+
+# Execute a command and suppress any error output.
+function hide_error
 {
-    git-commit-tree "$@" </dev/null
+	"$@" 2>/dev/null
 }
 
+function check_output
+{
+	_name=$1
+	shift 1
+	if "$@" | entag > $_name.actual
+	then
+		diff $_name.expected $_name.actual
+	else
+		return 1;
+	fi
+	
+}
+
+# Turn a reasonable test description into a reasonable test name.
+# All alphanums translated into -'s which are then compressed and stripped
+# from front and back.
+function name_from_description
+{
+        tr "'" '-' | tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' '-' | tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
+}
+
+
+# Execute the test described by the first argument, by eval'ing
+# command line specified in the 2nd argument. Check the status code
+# is zero and that the output matches the stream read from 
+# stdin.
+function test_output_expect_success
+{	
+	_description=$1
+        _test=$2
+        [ $# -eq 2 ] || error "usage: test_output_expect_success description test <<EOF ... EOF"
+        _name=$(echo $_description | name_from_description)
+	cat > $_name.expected
+	test_expect_success "$_description" "check_output $_name $_test" 
+}
+
+# --- end of stuff to move ---
+
+# test-case specific test function
 function check_adjacency
 {
     read previous
@@ -28,43 +135,77 @@ function check_adjacency
     done
 }
 
-function sed_script
-{
-   for c in root a0 a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3 l0 l1 l2 l3 l4 l5
-   do
-       echo -n "s/${!c}/$c/;"
-   done
-}
+
 
 date >path0
 git-update-cache --add path0
-tree=$(git-write-tree)
-root=$(do_commit $tree 2>/dev/null)
-export GIT_COMMITTER_NAME=foobar  # to guarantee that the commit is different
-l0=$(do_commit $tree -p $root)
-l1=$(do_commit $tree -p $l0)
-l2=$(do_commit $tree -p $l1)
-a0=$(do_commit $tree -p $l2)
-a1=$(do_commit $tree -p $a0)
-export GIT_COMMITTER_NAME=foobar2 # to guarantee that the commit is different
-b1=$(do_commit $tree -p $a0)
-c1=$(do_commit $tree -p $b1)
-export GIT_COMMITTER_NAME=foobar3 # to guarantee that the commit is different
-b2=$(do_commit $tree -p $b1)
-b3=$(do_commit $tree -p $b2)
-c2=$(do_commit $tree -p $c1 -p $b2)
-c3=$(do_commit $tree -p $c2)
-a2=$(do_commit $tree -p $a1)
-a3=$(do_commit $tree -p $a2)
-b4=$(do_commit $tree -p $b3 -p $a3)
-a4=$(do_commit $tree -p $a3 -p $b4 -p $c3)
-l3=$(do_commit $tree -p $a4)
-l4=$(do_commit $tree -p $l3)
-l5=$(do_commit $tree -p $l4)
-echo $l5 > .git/HEAD
+save_tag tree git-write-tree
+on_committer_date "1971-08-16 00:00:00" hide_error save_tag root unique_commit root tree
+on_committer_date "1971-08-16 00:00:01" save_tag l0 unique_commit l0 tree -p root
+on_committer_date "1971-08-16 00:00:02" save_tag l1 unique_commit l1 tree -p l0
+on_committer_date "1971-08-16 00:00:03" save_tag l2 unique_commit l2 tree -p l1
+on_committer_date "1971-08-16 00:00:04" save_tag a0 unique_commit a0 tree -p l2
+on_committer_date "1971-08-16 00:00:05" save_tag a1 unique_commit a1 tree -p a0
+on_committer_date "1971-08-16 00:00:06" save_tag b1 unique_commit b1 tree -p a0
+on_committer_date "1971-08-16 00:00:07" save_tag c1 unique_commit c1 tree -p b1
+on_committer_date "1971-08-16 00:00:08" as_author foobar@example.com save_tag b2 unique_commit b2 tree -p b1
+on_committer_date "1971-08-16 00:00:09" save_tag b3 unique_commit b2 tree -p b2
+on_committer_date "1971-08-16 00:00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
+on_committer_date "1971-08-16 00:00:11" save_tag c3 unique_commit c3 tree -p c2
+on_committer_date "1971-08-16 00:00:12" save_tag a2 unique_commit a2 tree -p a1
+on_committer_date "1971-08-16 00:00:13" save_tag a3 unique_commit a3 tree -p a2
+on_committer_date "1971-08-16 00:00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
+on_committer_date "1971-08-16 00:00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
+on_committer_date "1971-08-16 00:00:16" save_tag l3 unique_commit l3 tree -p a4
+on_committer_date "1971-08-16 00:00:17" save_tag l4 unique_commit l4 tree -p l3
+on_committer_date "1971-08-16 00:00:18" save_tag l5 unique_commit l5 tree -p l4
+hide_error save_tag e1 as_author e@example.com unique_commit e1 tree
+save_tag e2 as_author e@example.com unique_commit e2 tree -p e1
+save_tag f1 as_author f@example.com unique_commit f1 tree -p e1
+save_tag e3 as_author e@example.com unique_commit e3 tree -p e2
+save_tag f2 as_author f@example.com unique_commit f2 tree -p f1
+save_tag e4 as_author e@example.com unique_commit e4 tree -p e3 -p f2
+save_tag e5 as_author e@example.com unique_commit e5 tree -p e4
+save_tag f3 as_author f@example.com unique_commit f3 tree -p f2
+save_tag f4 as_author f@example.com unique_commit f4 tree -p f3
+save_tag e6 as_author e@example.com unique_commit e6 tree -p e5 -p f4
+save_tag f5 as_author f@example.com unique_commit f5 tree -p f4
+save_tag f6 as_author f@example.com unique_commit f6 tree -p f5 -p e6
+save_tag e7 as_author e@example.com unique_commit e7 tree -p e6
+save_tag e8 as_author e@example.com unique_commit e8 tree -p e7
+save_tag e9 as_author e@example.com unique_commit e9 tree -p e8
+save_tag f7 as_author f@example.com unique_commit f7 tree -p f6
+save_tag f8 as_author f@example.com unique_commit f8 tree -p f7
+save_tag f9 as_author f@example.com unique_commit f9 tree -p f8
+save_tag e10 as_author e@example.com unique_commit e1 tree -p e9 -p f8
+
+hide_error save_tag g0 unique_commit g0 tree
+save_tag g1 unique_commit g1 tree -p g0
+save_tag h1 unique_commit g2 tree -p g0
+save_tag g2 unique_commit g3 tree -p g1 -p h1
+save_tag h2 unique_commit g4 tree -p g2
+save_tag g3 unique_commit g5 tree -p g2
+save_tag g4 unique_commit g6 tree -p g3 -p h2
+
+tag l5 > .git/HEAD
+
+#
+# cd to t/trash and use 
+#
+#    git-rev-list ... 2>&1 | sed "$(cat sed.script)" 
+#
+# if you ever want to manually debug the operation of git-rev-list
+#
+echo $sed_script > sed.script
+
+test_expect_success 'rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
+19
+EOF
 
-git-rev-list --merge-order --show-breaks HEAD | sed "$(sed_script)" > actual-merge-order
-cat > expected-merge-order <<EOF
+normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+test_expect_success '--merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
+test_output_expect_success 'simple merge order' 'git-rev-list --merge-order --show-breaks HEAD' <<EOF
 = l5
 | l4
 | l3
@@ -86,15 +227,17 @@ cat > expected-merge-order <<EOF
 = root
 EOF
 
-git-rev-list HEAD | check_adjacency | sed "$(sed_script)" > actual-default-order
-normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
-merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
-
-test_expect_success 'Testing that the rev-list has correct number of entries' '[ $(git-rev-list HEAD | wc -l) -eq 19 ]'
-test_expect_success 'Testing that --merge-order produces the correct result' 'diff expected-merge-order actual-merge-order'
-test_expect_success 'Testing that --merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
+test_output_expect_success 'two diamonds merge order (g6)' 'git-rev-list --merge-order --show-breaks g4' <<EOF
+= g4
+| h2
+^ g3
+= g2
+| h1
+^ g1
+= g0
+EOF
 
-cat > expected-merge-order-1 <<EOF
+test_output_expect_success 'multiple heads' 'git-rev-list --merge-order a3 b3 c3' <<EOF
 c3
 c2
 c1
@@ -111,10 +254,7 @@ l0
 root
 EOF
 
-git-rev-list --merge-order $a3 $b3 $c3 | sed "$(sed_script)" > actual-merge-order-1
-test_expect_success 'Testing multiple heads' 'diff expected-merge-order-1 actual-merge-order-1'
-
-cat > expected-merge-order-2 <<EOF
+test_output_expect_success 'multiple heads, prune at a1' 'git-rev-list --merge-order a3 b3 c3 ^a1' <<EOF
 c3
 c2
 c1
@@ -125,10 +265,7 @@ a3
 a2
 EOF
 
-git-rev-list --merge-order $a3 $b3 $c3 ^$a1 | sed "$(sed_script)" > actual-merge-order-2
-test_expect_success 'Testing stop' 'diff expected-merge-order-2 actual-merge-order-2'
-
-cat > expected-merge-order-3 <<EOF
+test_output_expect_success 'multiple heads, prune at l1' 'git-rev-list --merge-order a3 b3 c3 ^l1' <<EOF
 c3
 c2
 c1
@@ -142,10 +279,26 @@ a0
 l2
 EOF
 
-git-rev-list --merge-order $a3 $b3 $c3 ^$l1 | sed "$(sed_script)" > actual-merge-order-3
-test_expect_success 'Testing stop in linear epoch' 'diff expected-merge-order-3 actual-merge-order-3'
+test_output_expect_success 'cross-epoch, head at l5, prune at l1' 'git-rev-list --merge-order l5 ^l1' <<EOF
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+EOF
 
-cat > expected-merge-order-4 <<EOF
+test_output_expect_success 'duplicated head arguments' 'git-rev-list --merge-order l5 l5 ^l1' <<EOF
 l5
 l4
 l3
@@ -164,12 +317,215 @@ a0
 l2
 EOF
 
-git-rev-list --merge-order $l5 ^$l1 | sed "$(sed_script)" > actual-merge-order-4
-test_expect_success 'Testing start in linear epoch, stop after non-linear epoch' 'diff expected-merge-order-4 actual-merge-order-4'
+test_output_expect_success 'prune near merge' 'git-rev-list --merge-order a4 ^c3' <<EOF
+a4
+b4
+b3
+a3
+a2
+a1
+EOF
 
-git-rev-list --merge-order $l5 $l5 ^$l1 2>/dev/null | sed "$(sed_script)" > actual-merge-order-5
-test_expect_success 'Testing duplicated start arguments' 'diff expected-merge-order-4 actual-merge-order-5'
+test_output_expect_success '--wrt-author foobar@example.com' 'git-rev-list --merge-order --show-breaks --wrt-author --author=foobar@example.com HEAD' <<EOF
+= l5
+| l4
+| l3
+= a4
+| c3
+| c2
+| c1
+^ b4
+| a3
+| a2
+| a1
+^ b3
+| b2
+| b1
+= a0
+| l2
+| l1
+| l0
+= root
+EOF
 
-test_expect_success 'Testing exclusion near merge' 'git-rev-list --merge-order $a4 ^$c3 2>/dev/null'
+test_output_expect_success "prune at foobar@example.com" 'git-rev-list --show-breaks --wrt-author --author=foobar@example.com --prune-at-author HEAD' <<EOF
+= l5
+| l4
+| l3
+= a4
+| c3
+| c2
+| c1
+^ b4
+| a3
+| a2
+| a1
+^ b3
+| b2
+EOF
+
+test_output_expect_success "w.r.t e@example.com" 'git-rev-list --show-breaks --wrt-author --author=e@example.com e10 f9' <<EOF
+| f9
+^ e10
+| f8
+| f7
+| f6
+| f5
+^ e9
+| e8
+| e7
+| e6
+| f4
+| f3
+^ e5
+| e4
+| f2
+| f1
+^ e3
+| e2
+= e1
+EOF
+
+
+test_output_expect_success "w.r.t f@example.com" 'git-rev-list --show-breaks --wrt-author --author=f@example.com e10 f9' <<EOF
+| f9
+^ e10
+| f8
+| f7
+| f6
+| f5
+^ e9
+| e8
+| e7
+| e6
+| f4
+| f3
+^ e5
+| e4
+| e3
+| e2
+^ f2
+| f1
+= e1
+EOF
+
+as_author "" test_output_expect_success "w.r.t nobody" 'git-rev-list --show-breaks --wrt-author f9 e10' <<EOF
+| e10
+| e9
+| e8
+| e7
+^ f9
+| f8
+| f7
+| f6
+| e6
+| e5
+| e4
+| e3
+| e2
+^ f5
+| f4
+| f3
+| f2
+| f1
+= e1
+EOF
+
+test_output_expect_success "head has no parent" 'git-rev-list --show-breaks root' <<EOF
+= root
+EOF
+
+test_output_expect_success "two nodes - one head, one base" 'git-rev-list --show-breaks l0' <<EOF
+= l0
+= root
+EOF
+
+test_output_expect_success "three nodes one head, one internal, one base" 'git-rev-list --show-breaks l1' <<EOF
+= l1
+| l0
+= root
+EOF
+
+test_output_expect_success "linear prune l2 ^root" 'git-rev-list --show-breaks l2 ^root' <<EOF
+= l2
+| l1
+| l0
+EOF
+
+test_output_expect_success "linear prune l2 ^l0" 'git-rev-list --show-breaks l2 ^l0' <<EOF
+= l2
+| l1
+EOF
+
+test_output_expect_success "linear prune l2 ^l1" 'git-rev-list --show-breaks l2 ^l1' <<EOF
+= l2
+EOF
+
+test_output_expect_success "linear prune l5 ^a4" 'git-rev-list --show-breaks l5 ^a4' <<EOF
+= l5
+| l4
+| l3
+EOF
+
+test_output_expect_success "linear prune l5 ^l3" 'git-rev-list --show-breaks l5 ^l3' <<EOF
+= l5
+| l4
+EOF
+
+test_output_expect_success "linear prune l5 ^l4" 'git-rev-list --show-breaks l5 ^l4' <<EOF
+= l5
+EOF
+
+test_output_expect_success "max-count 10 - merge order" 'git-rev-list --show-breaks --max-count=10 l5' <<EOF
+= l5
+| l4
+| l3
+= a4
+| c3
+| c2
+| c1
+^ b4
+| b3
+| b2
+EOF
+
+test_output_expect_success "max-count 10 - non merge order" 'git-rev-list --max-count=10 l5 | sort' <<EOF
+a4
+b2
+b3
+b4
+c1
+c2
+c3
+l3
+l4
+l5
+EOF
+
+test_output_expect_success '--max-age=c3, no --merge-order' "git-rev-list --max-age=$(commit_date c3) l5" <<EOF
+l5
+l4
+l3
+a4
+b4
+a3
+a2
+c3
+EOF
+
+test_output_expect_success '--max-age=c3, --merge-order' "git-rev-list --merge-order --max-age=$(commit_date c3) l5" <<EOF
+l5
+l4
+l3
+a4
+c3
+b4
+a3
+a2
+EOF
+
+test_expect_failure "all heads uninteresting" 'git-rev-list --show-breaks a3 ^a3'
+#
+#
 
 test_done
diff --git a/traversal.c b/traversal.c
new file mode 100644
--- /dev/null
+++ b/traversal.c
@@ -0,0 +1,398 @@
+/*
+ * Copyright (c) 2005, Jon Seymour
+ *
+ * For more information about epoch theory on which this module is based,
+ * refer to http://blackcubes.dyndns.org/epoch/. That web page defines
+ * terms such as "epoch" and "minimal, non-linear epoch" and provides rationales
+ * for some of the algorithms used here.
+ *
+ */
+#include <stdlib.h>
+#include "cache.h"
+#include "commit.h"
+#include "traversal.h"
+#include "epoch.h"
+
+#define IS_SEEN(c) ((c)->object.flags & SEEN)
+#define IS_BASE(c) ((c)->object.flags & BASE)
+#define IS_LOCAL(c) ((c)->object.flags & LOCAL)
+
+/* leave the assertions defined for now, maybe null def them later */
+#define ASSERT(x,m,c) if (!(x)) { assertion_failed(__LINE__, __FUNCTION__, m, c); } else {}
+
+static void assertion_failed(int line, char * function, char * message, struct commit * item)
+{
+	die(	"%s:%d:%s: assertion_failed: %s: commit %s, flags %x",
+		__FILE__, 
+		line, 
+		function,
+		message,
+		item ? sha1_to_hex(item->object.sha1) : "[]",
+		item ? item->object.flags : 0xFFFFFFFF);
+}
+			
+/*
+ * This function calls the supplied commit_visitor method, if there is one.
+ */
+static void visit_commit(struct traversal * traversal, struct commit * commit, int first_visit)
+{
+	/*
+	 * pre-condition:
+	 * 	first_visit => object.util == NULL
+	 */
+	if (traversal->commit_visitor)
+		(*(traversal->commit_visitor))(commit, first_visit);
+}
+
+/*
+ * This function is called as each edge in the graph is identified. It 
+ * will always be called after visit_commit(...,from, 1). No guarantees
+ * are offered about when this call will be made w.r.t. to the call
+ * to visit_commit(..., to, 1)
+ */
+static void visit_edge(struct traversal * traversal, struct commit * from, struct commit * to)
+{
+	/*
+	 * pre-condition:
+	 * 	from->object.flags & SEEN &&
+	 * 	to->object.util => (to->object.flags & SEEN)
+	 */ 
+	if (traversal->edge_visitor)
+		(*(traversal->edge_visitor))(from, to);
+}
+
+/*
+ * This function is called exactly once for each commit discovered during
+ * the merge order traversal. If it ever returns a non-zero value, the
+ * merge order traversal will not continue past the current epoch boundary.
+ * It may, however, continue to emit nodes up until the epoch boundary.
+ * It is the implementer's responsibility to perform output limiting if 
+ * that is required.
+ */
+static int emit_commit(struct traversal * traversal, struct commit * commit)
+{
+	return (*(traversal->emitter))(commit);
+}
+
+/*
+ * Invoke a call back method to allow the tactics to release and storage
+ * allocated during a previous visit_commit or visit_edge call.
+ */
+static void clean_commit(struct traversal * traversal, struct commit * commit)
+{
+	if (traversal->clean)
+		(*(traversal->clean))(commit);
+	commit->object.util = NULL;
+	commit->object.flags &= ~(TRAVERSAL_FLAGS);
+	/*
+	 * post-condition:
+	 * 	commit->object.util == NULL && !(commit->object.flag & TRAVERSAL_FLAGS)
+	 */		
+}
+
+/**
+ * Ask the tactics if we should traverse into the epoch headed at head.
+ */
+static int continue_traversal(struct traversal * traversal, struct commit * head)
+{
+	if (head && head->parents) {
+		if (traversal->continue_traversal)
+			return (*(traversal->continue_traversal))(head);
+		else
+			return 1;
+	} else
+		return 0;
+}
+
+void init_traversal(struct traversal * traversal)
+{
+	memset(traversal, 0, sizeof(*traversal));
+}
+
+/*
+ * Sort the epoch in (adjusted) merge order.
+ */
+static void sort_unvisited(
+	struct commit *head, 
+	struct commit_list **stack, 
+	struct traversal * traversal)
+{
+	struct commit_list *parents = NULL;
+        struct commit * top = *stack?(*stack)->item:NULL;
+
+	if (IS_SEEN(head)) {
+		if (!IS_BASE(head)) {
+			visit_commit(traversal, head, 0);
+		}
+		return;
+	}
+	head->object.flags |= SEEN;
+        if (IS_BASE(head)) {
+		ASSERT(!top, "stack empty on visit to base", head);
+	} else {
+		if (!head->object.util) {
+                        parents = copy_parents_in_header_order(head);
+		} else {
+			parents = (struct commit_list *)head->object.util;
+                        head->object.util = NULL;
+		}
+		visit_commit(traversal, head, 1);
+		while (parents) {
+			struct commit *parent = pop_commit(&parents);
+
+			visit_edge(traversal, head, parent);
+			sort_unvisited(parent, stack, traversal);
+		}		
+		commit_list_insert(head, stack);	
+        }
+}
+
+/*
+ * Emit the contents of the stack.
+ * The stack is freed and replaced by NULL.
+ * Sets the return value to STOP if the traversal should stop.
+ */
+static int emit_stack(struct commit_list **stack, struct traversal * traversal)
+{
+	int stop = 0;
+
+	while (*stack) {
+		struct commit *next = pop_commit(stack);
+		
+		stop = stop || (emit_commit(traversal, next)==STOP);
+		clean_commit(traversal, next);
+	}
+	return stop ? STOP : CONTINUE;
+}
+
+/*
+ * Copy the parents of the commit and store the head of the list
+ * in object.util. Return the address of object.util itself.
+ */
+static struct commit_list ** copy_and_store_parents(struct commit * commit)
+{
+	struct commit_list * copied=copy_parents_in_header_order(commit);
+
+        commit->object.util = copied;
+	return (struct commit_list **)&commit->object.util;
+}
+
+/*
+ * Sort a list of commits in local first order. A commit is "local" 
+ * if any of its ancestors (except the base) causes (*local_test)() to 
+ * return a non-zero value.
+ *
+ * The sorted list is returned in *sorted. A side effect of this function 
+ * is to set each object.util pointer in each ancestor up until the base 
+ * to a list of parents is sorted in local first order.
+ *
+ * Does nothing if the list is empty.
+ * 
+ * The return value contains LOCAL if any of the list is local or had a 
+ * local ancestor.
+ */
+static unsigned int sort_local_branches_first(struct commit_list ** list, struct traversal * traversal)
+{
+	struct commit_list *local = NULL;
+	struct commit_list **local_tail = &local;
+	struct commit_list **non_local_ptr;
+
+	ASSERT(traversal->local_test, "local_test method is defined", NULL);
+	if (!*list) {
+		return 0;
+	}
+	for (non_local_ptr = list; *non_local_ptr; ) {
+		struct commit *item = (*non_local_ptr)->item;
+		
+		/*
+		 * We don't descend past the base or visit
+		 * a commit we have already visited.
+                 */
+		if (!IS_BASE(item) && !item->object.util) {
+			struct commit_list ** copied;
+			
+			if ((*(traversal->local_test)) (item))
+				item->object.flags |= LOCAL;
+			copied=copy_and_store_parents(item);
+			item->object.flags 
+			    |= sort_local_branches_first(copied, traversal);
+		}
+		/**
+		 * Move local items onto their own list.
+                 */
+		if (IS_LOCAL(item))
+			local_tail = move_commit(local_tail, non_local_ptr);
+		else
+			non_local_ptr = &(*non_local_ptr)->next;
+	}
+	/*
+         * Splice the non-local list onto the end of the local
+         * list, set head of the list to the head of the local list
+         * return if the LOCAL flag set if we have any local branches
+         */
+        *local_tail = *list;
+        *list = local;
+	return ((*list)->item->object.flags & LOCAL);
+}
+
+/*
+ * Sorting a maximal linear epoch involves traversing until we
+ * reach the base and emitting as we go. We don't emit the base
+ * now.
+ */
+static int sort_maximal_linear_epoch(struct commit *head, struct traversal * traversal)
+{
+	struct commit * next;
+	int stop = 0;
+	
+	/* invoke the visitors, if any */
+	if (traversal->commit_visitor || traversal->edge_visitor) {
+		for (next = head; !IS_BASE(next); next = next->parents->item) {
+			visit_commit(traversal, next, 1);
+			visit_edge(traversal, next, next->parents->item);
+		}
+	}		
+	/* now emit the nodes, and mark the base*/
+	for (next = head; !IS_BASE(next); next = next->parents->item) {
+		stop = stop || (emit_commit(traversal, next)==STOP);
+		clean_commit(traversal, next);
+	}
+	return stop ? STOP : CONTINUE;
+}
+
+/*
+ * Sorting a minimal non-linear epoch involves recursively apply
+ * sort_unvisited after doing a local_branches_first sort to the
+ * parents of each commit in the epoch, if required, then emitting
+ * the stack.
+ */
+static int sort_minimal_non_linear_epoch(struct commit *head, struct traversal * traversal)
+{
+	struct commit_list *stack = NULL;	
+
+	if (traversal->local_test) 
+		sort_local_branches_first(copy_and_store_parents(head),	traversal);
+	sort_unvisited(head, &stack, traversal);
+	return emit_stack(&stack, traversal);
+}
+
+/*
+ * see commit-graph.h
+ */
+int traverse_from_head(struct commit *head, struct traversal * traversal)
+{
+	struct commit *next = head;
+	int ret = 0;
+
+	ret = parse_commit(next);
+	if (ret) 
+		return ret; 
+        next->object.flags |= BOUNDARY;
+	while (continue_traversal(traversal, next)) { 
+		struct commit *base = NULL;
+		int next_action = CONTINUE;
+
+		/* scan to the base of the current epoch */
+		ret = find_next_epoch_boundary(next, &base);
+		
+		/* abort if we detected a parsing error */
+		if (ret)
+			return ret; /* parsing failure */
+			
+		/* mark the new base so we know when to stop sorting */
+		if (base)
+			base->object.flags |= (BOUNDARY|BASE);
+			
+		/* reset flags set by last iteration */
+		next->object.flags &= ~(BASE|SEEN);
+		
+		/* sort with the optimal algorithm */
+		if (HAS_EXACTLY_ONE_PARENT(next))
+			next_action = sort_maximal_linear_epoch(next, traversal);
+		else
+			next_action = sort_minimal_non_linear_epoch(next, traversal);
+			
+		/* stop or iterate */			
+		if (next_action == STOP)
+			return 0; 
+		else					
+			next = base;
+	}
+	if (next) {
+		emit_commit(traversal, next);
+		clean_commit(traversal, next);
+	}
+	return 0;
+}
+
+/*
+ * see commit-graph.h
+ *
+ * Traverses the nodes reachable from a starting list in merge order, we
+ * first find the base for the starting list and then sort all nodes
+ * in this subgraph using the sort_unvisited algorithm. Once we have
+ * reached the base we can continue sorting using traverse_from_head.
+ */
+int traverse_from_list(struct commit_list *list, struct traversal * traversal)
+{
+	struct commit_list *stack = NULL;
+	struct commit *base;
+	int ret = 0;
+
+	if (!traversal) 
+		die("traversal argument must not be null");
+	if (!traversal->emitter)
+		die("an emitter method must be supplied");
+	if (list->next) {
+		struct commit_list * copy=NULL;
+
+		/* 
+		 * Make a copy of the list we can sort.
+		 */
+		for(;list;list=list->next) {
+			commit_list_insert(list->item, &copy);
+		}
+		list=copy;
+
+		/*
+		 * With multiple items to start the search with,
+		 * we first sort the list into local order (if required)
+		 * 
+		 * This behaves as if a commit was performed which
+		 * referenced the list as parents. This
+		 * would create a minimal, non-linear epoch.
+		 */		 
+		ret = find_base_for_list(list, &base);
+		if (ret)
+			return ret; /* parsing failure */
+
+		/* mark the termination condition*/
+		if (base)
+			base->object.flags |= (BOUNDARY|BASE);
+
+		/* sort local branches first, so they print last */			
+		if (traversal->local_test)
+			sort_local_branches_first(&list, traversal);			
+
+		/* sort the unvisited part of the epoch in merge order */
+		while (list)
+			sort_unvisited(pop_commit(&list), &stack, traversal);
+		
+		/* output the stack */
+		if (emit_stack(&stack, traversal) == STOP) 
+			return STOP;			
+	} else {
+		/*
+		 * With only one item on the list, we just use
+		 * sort in merge order which handles maximal
+		 * linear epochs as well as minimal, non-linear epochs.
+		 */
+		base = list->item;
+	} 
+
+        /* sort the rest with the sort_in_merge_order algorithm. */
+	if (base)
+		ret = traverse_from_head(base, traversal);
+	return ret;
+}
+
diff --git a/traversal.h b/traversal.h
new file mode 100644
--- /dev/null
+++ b/traversal.h
@@ -0,0 +1,91 @@
+#ifndef TRAVERSAL_H
+#define TRAVERSAL_H
+
+/**
+ * Flags used by merge order logic and also by rev-list.c
+ */
+#define SEEN                    (1u<<0)
+#define BOUNDARY                (SEEN<<1)
+#define LOCAL                   (BOUNDARY<<1)
+#define BASE                    (LOCAL<<1)
+#define LAST_TRAVERSAL_FLAG     (BASE)
+
+#define TRAVERSAL_FLAGS         (BOUNDARY|SEEN|LOCAL|BASE)
+
+/**
+ * Return codes for emitter method. Also used by rev-list.c
+ */
+#define STOP           0
+#define CONTINUE       1
+#define DO             2
+
+struct traversal {
+	/*
+	 * Returns 0 if traversal should stop, non-zero if it should continue.
+	 */
+	int (*emitter)(struct commit *);
+
+	/* 
+	 * Returns non-zero if the commit is regarded "local", 0 otherwise.
+	 */
+	int (*local_test)(struct commit *);
+
+	/*
+	 * If defined, called on each visit to a vertex during the 
+         * sort phase of the traversal. first_visit will be
+         * non-zero on the first visit, zero otherwise.
+         *
+         * object.util is available for use by the visitor.
+	 */
+	void (*commit_visitor)(struct commit *, int first_visit);
+
+	/*
+         * Called at some point prior to visiting 'to' from 'from'.
+         * commit_visitor will already have been called at least once for 
+         * from node. It may or may not have already been called for the
+         * to node.
+	 */
+	void (*edge_visitor)(struct commit * from, struct commit * to);
+
+	/*
+         * Called sometime after the emitter function has been called.
+         * Once this call completes the object.util pointer will be set to NULL.
+         * Implementers should use this call to free any data structure
+         * allocated by the commit_visitor method.
+	 */
+	void (*clean)(struct commit *);
+
+	/*
+	 * Called at each epoch boundary. Implementers may return
+	 * non-zero if the traversal into the next epoch should
+	 * be stopped.
+	 */
+	int (*continue_traversal)(struct commit *);
+}
+;
+
+/**
+ * Initializes a traversal structure which
+ * may be customized by the caller by overriding any of the method pointers.
+ */
+extern void init_traversal(struct traversal *);
+
+/**
+ * Traverses the commit graph from the commits listed. 
+ *
+ * The traversal is performed in (optionally localised) merge order 
+ * which is defined by invariants specified in Documentation/git-rev-list.txt
+ *
+ * The tactics used during the traversal can be customized
+ * by configuring the traversal structure with appropriately
+ * defined method pointers.
+
+ */
+extern int traverse_from_list(struct commit_list *list, struct traversal * traversal);
+
+/**
+ * Traverses the commit graph from the head commit listed. In other
+ * respects, like traverse_from_list.
+ */
+extern int traverse_from_head(struct commit *head, struct traversal * traversal);
+#endif	/* TRAVERSAL_H */
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
