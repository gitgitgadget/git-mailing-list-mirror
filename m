From: fork0@t-online.de (Alex Riesen)
Subject: Re: CFT: merge-recursive in C (updated)
Date: Wed, 28 Jun 2006 00:32:49 +0200
Message-ID: <20060627223249.GA8177@steel.home>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 28 00:33:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvM7h-0005Jj-Sc
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 00:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWF0Wda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWF0Wd3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 18:33:29 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:61333 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1422688AbWF0Wd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 18:33:26 -0400
Received: from fwd31.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1FvM7D-0001j0-02; Wed, 28 Jun 2006 00:33:03 +0200
Received: from tigra.home (EXSgbiZZYe7+SH-WfYOtgkgOA7P35o51MAphF82mQ9MUNxx-5jhX4V@[84.160.93.205]) by fwd31.sul.t-online.de
	with esmtp id 1FvM72-19xaWO0; Wed, 28 Jun 2006 00:32:52 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6BB35277B5;
	Wed, 28 Jun 2006 00:32:51 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FvM70-0003ZO-6K; Wed, 28 Jun 2006 00:32:50 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-ID: EXSgbiZZYe7+SH-WfYOtgkgOA7P35o51MAphF82mQ9MUNxx-5jhX4V
X-TOI-MSGID: a75a0445-faa2-4751-b127-4a6b576211ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22757>

Johannes Schindelin, Tue, Jun 27, 2006 18:42:51 +0200:
> > - use a pipe to "git-update-index --index-info" instead of using command 
> > line
> 
> It might be an even better idea to call the cache functions directly. But 
> in that case, you definitely want a function set_index_file() in 
> environment.c, as well as a way to invalidate the active cache. Something 
> like
> 
> 	if (active_cache) {
> 		free(active_cache);
> 		active_cache = NULL;
> 		active_nr = active_alloc = 0;
> 		free(active_cache_tree);
> 		active_cache_tree = NULL;
> 		read_cache();
> 	}

We should check how will that work across recursive calls to merge
(that long function in the middle of merge-recursive.c), but yes,
it's certanly worth a try.

> > Path list optimization should be next (and I'll be glad if someone does 
> > this before me).
> 
> See below.
> 

Aah, thanks. Merged, tried, tested, left in patch.
The reallocs can cause some undesirable heap fragmentation, don't you
think?

> > Also graph algos have a greate optimization potential (intersection, all 
> > parents of a node, node_by_sha).
> 
> The longer I look at it, the more I am convinced that this graph thing is 
> not necessary. I was hesitant at first that addCommonRoot() would not be 
> possible, but nobody says we cannot override commit->parents.

I tried to replace that code completely with a call to git-merge-base
(it does not happen too often). So far it passed all tests.

> I have some commits in a private branch to split out get_merge_bases() 
> from merge-base.c, so I'll try that next.

Thanks, that'd be nice.

> BTW, before actually finishing this, we might want to do away with 
> capitalizedFunctionNames and 4-space indent.

4-space indent should be gone by now, the names pending (they were
important in initial debugging after conversion).

And I almost forgot about using git-merge-tree instead of
"git-read-tree -m". I hope this message will remind me tomorrow
to think more about that.

Updated patch (your path_list and git-merge-base instead of graph's
common ancestors):


diff --git a/Makefile b/Makefile
index cde619c..660f09b 100644
--- a/Makefile
+++ b/Makefile
@@ -163,7 +163,8 @@ PROGRAMS = \
 	git-upload-pack$X git-verify-pack$X \
 	git-symbolic-ref$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
-	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
+	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X \
+	git-merge-recur$X
 
 BUILT_INS = git-log$X git-whatchanged$X git-show$X git-update-ref$X \
 	git-count-objects$X git-diff$X git-push$X git-mailsplit$X \
@@ -595,6 +596,10 @@ git-http-push$X: revision.o http.o http-
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-merge-recur$X: merge-recursive.o graph.o path-list.o $(LIB_FILE)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS)
+
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 $(DIFF_OBJS): diffcore.h
diff --git a/git-merge.sh b/git-merge.sh
index fc25f8d..7d81122 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -9,7 +9,7 @@ USAGE='[-n] [--no-commit] [--squash] [-s
 LF='
 '
 
-all_strategies='recursive octopus resolve stupid ours'
+all_strategies='recur recursive octopus resolve stupid ours'
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
 no_trivial_merge_strategies='ours'
@@ -17,7 +17,7 @@ use_strategies=
 
 index_merge=t
 if test "@@NO_PYTHON@@"; then
-	all_strategies='resolve octopus stupid ours'
+	all_strategies='recur resolve octopus stupid ours'
 	default_twohead_strategies='resolve'
 fi
 
diff --git a/graph.c b/graph.c
new file mode 100644
index 0000000..fa2bfee
--- /dev/null
+++ b/graph.c
@@ -0,0 +1,252 @@
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include "cache.h"
+#include "commit.h"
+#include "graph.h"
+
+// does not belong here
+struct tree *git_write_tree()
+{
+#if 0
+	fprintf(stderr, "GIT_INDEX_FILE='%s' git-write-tree\n",
+		getenv("GIT_INDEX_FILE"));
+#endif
+	FILE *fp = popen("git-write-tree 2>/dev/null", "r");
+	char buf[41];
+	unsigned char sha1[20];
+	int ch;
+	unsigned i = 0;
+	while ( (ch = fgetc(fp)) != EOF )
+		if ( i < sizeof(buf)-1 && ch >= '0' && ch <= 'f' )
+			buf[i++] = ch;
+		else
+			break;
+	int rc = pclose(fp);
+	if ( rc == -1 || WEXITSTATUS(rc) )
+		return NULL;
+	buf[i] = '\0';
+	if ( get_sha1(buf, sha1) != 0 )
+		return NULL;
+	return lookup_tree(sha1);
+}
+
+const char *node_title(struct node *node, int *len)
+{
+	const char *s = "(null commit)";
+	*len = strlen(s);
+
+	if ( node->virtual ) {
+		s = node->comment;
+		*len = strlen(s);
+	} else if ( node->commit ) {
+		if ( parse_commit(node->commit) != 0 ) {
+			s = "(bad commit)";
+			*len = strlen(s);
+		} else {
+			s = node->commit->buffer;
+			char prev = '\0';
+			while ( *s ) {
+				if ( '\n' == prev && '\n' == *s ) {
+					++s;
+					break;
+				}
+				prev = *s++;
+			}
+			*len = 0;
+			while ( s[*len] && '\n' != s[*len] )
+				++(*len);
+		}
+	}
+	return s;
+}
+
+const unsigned char *node_sha(const struct node *node)
+{
+	return node->commit->object.sha1;
+}
+
+const char *node_hex_sha1(const struct node *node)
+{
+	return node->commit ?  sha1_to_hex(node->commit->object.sha1):
+		node->virtual ? "virtual": "undefined";
+}
+
+static int sha_eq(const unsigned char *a, const unsigned char *b)
+{
+	if ( !a && !b )
+		return 2;
+	return a && b && memcmp(a, b, 20) == 0;
+}
+
+static struct node_list *node_list_pool = NULL;
+static unsigned node_list_pool_size = 0;
+
+unsigned node_list_count(const struct node_list *l)
+{
+	unsigned c = 0;
+	while ( l ) {
+		++c;
+		l = l->next;
+	}
+	return c;
+}
+
+struct node_list *node_list_insert(struct node *node, struct node_list **list)
+{
+	struct node_list *e;
+	if ( node_list_pool )
+		e = node_list_shift(&node_list_pool);
+	else
+		e = malloc(sizeof(struct node_list));
+	e->next = *list;
+	e->node = node;
+	*list = e;
+	return e;
+}
+
+struct node_list *node_list_free1(struct node_list *list, int free_nodes)
+{
+	struct node_list *next = list->next;
+	if ( free_nodes )
+		free(list->node);
+
+	if ( node_list_pool_size < 1000 ) {
+		list->node = NULL;
+		list->next = node_list_pool;
+		node_list_pool = list;
+	} else
+		free(list);
+	return next;
+}
+
+void node_list_free(struct node_list **list, int free_nodes)
+{
+	while ( *list )
+		node_list_free1(node_list_shift(list), free_nodes);
+}
+
+struct node *node_alloc(struct commit *commit)
+{
+	struct node *node = malloc(sizeof(struct node));
+	node->parents = NULL;
+	node->parents_count = 0;
+	node->children = NULL;
+	node->virtual = 0;
+	node->commit = commit;
+	if ( parse_commit(commit) == 0 )
+		node->tree = commit->tree;
+	else
+		die("failed to parse commit %s", sha1_to_hex(commit->object.sha1));
+
+	return node;
+}
+
+struct node *node_alloc_virtual(struct tree *tree, const char *comment)
+{
+	struct node *node = malloc(sizeof(struct node));
+	node->parents = NULL;
+	node->children = NULL;
+	node->commit = NULL;
+	node->tree = tree;
+	node->virtual = 1;
+	static unsigned virtual_id = 0;
+	node->virtual_id = virtual_id++;
+	node->comment = comment;
+	return node;
+}
+
+void node_set_parents(struct node *node, struct node_list *parents)
+{
+	struct node_list *p;
+	node->parents_count = 0;
+	for_each_node_list(p, node->parents = parents) {
+		node_list_insert(node, &p->node->children);
+		node->parents_count++;
+	}
+}
+
+static inline int node_eq(const struct node *a, const struct node *b)
+{
+	if ( a == b )
+		return 1;
+	if ( a->virtual != b->virtual )
+		return 0;
+	if ( a->virtual )
+		return a->virtual_id == b->virtual_id;
+	if ( a->commit == b->commit )
+		return 1;
+	return sha_eq(a->commit->object.sha1, b->commit->object.sha1);
+}
+
+struct node_list *node_list_find_node(const struct node *node,
+				      const struct node_list *list)
+{
+	const struct node_list *p;
+	for_each_node_list(p, list)
+		if ( node_eq(p->node, node) )
+			break;
+	return (struct node_list*)p;
+}
+
+// a & b. a and are invalid after the call,
+// the result will contain all the common nodes
+struct node_list *node_list_intersect(struct node_list *a,
+				      struct node_list *b)
+{
+	struct node_list *result = NULL;
+	struct node_list *p = a;
+	while ( p ) {
+		struct node_list *next = p->next;
+		struct node_list *bn = node_list_find_node(p->node, b);
+		if ( bn ) {
+			p->next = result;
+			result = p;
+		} else
+			node_list_free1(p, 0);
+		p = next;
+	}
+	node_list_free(&b, 0);
+	return result;
+}
+
+struct node *graph_add_node(struct graph *graph, struct node *node)
+{
+	struct node_list **bucket;
+	if ( node->virtual )
+		// virtual nodes hashed by lowest byte of virtual_id
+		bucket = graph->commits + (node->virtual_id & 0xff);
+	else
+		bucket = graph->commits + node->commit->object.sha1[0];
+	node_list_insert(node, bucket);
+	return node;
+}
+
+struct node *graph_node_bysha(const struct graph *graph,
+			      const unsigned char *sha)
+{
+	const struct node_list *head = *(graph->commits + sha[0]);
+	while ( head ) {
+		if ( !head->node->virtual &&
+		     sha_eq(head->node->commit->object.sha1, sha) ) {
+			return head->node;
+		}
+		head = head->next;
+	}
+	return NULL;
+}
+
+#if 0
+void node_list_print(const char *msg, const struct node_list *list)
+{
+    const struct node_list *p;
+    printf("%s\n", msg);
+    for_each_node_list(p, list) {
+	int len;
+	const char *msg = node_title(p->node, &len);
+	printf("\t%s %.*s\n", node_hex_sha1(p->node), len, msg);
+    }
+}
+#endif
+
+// vim: sw=8 noet
diff --git a/graph.h b/graph.h
new file mode 100644
index 0000000..3b8ca5c
--- /dev/null
+++ b/graph.h
@@ -0,0 +1,80 @@
+#ifndef _GRAPH_H_
+#define _GRAPH_H_
+
+struct node;
+struct graph;
+struct commit;
+struct tree;
+struct commit_list;
+
+struct node_list
+{
+	struct node_list *next;
+	struct node *node;
+};
+
+struct node
+{
+	struct commit *commit;
+	struct tree *tree;
+
+	unsigned parents_count;
+	struct node_list *parents;
+	struct node_list *children;
+
+	unsigned virtual:1;
+	unsigned virtual_id;
+	const char *comment;
+};
+
+struct node_list *node_list_insert(struct node *node, struct node_list **list);
+void node_list_free(struct node_list **list, int free_nodes);
+struct node_list *node_list_free1(struct node_list *list, int free_node);
+
+static inline struct node_list *node_list_shift(struct node_list **list)
+{
+	struct node_list *head = *list;
+	*list = head->next;
+	return head;
+}
+
+static inline struct node *node_list_shift_node(struct node_list **list)
+{
+	struct node *node = (*list)->node;
+	*list = node_list_free1(*list, 0);
+	return node;
+}
+
+struct node *node_alloc(struct commit *);
+struct node *node_alloc_virtual(struct tree *, const char *comment);
+
+void node_set_parents(struct node *node, struct node_list *parents);
+unsigned node_list_count(const struct node_list *);
+
+struct node_list *node_list_find_node(const struct node *node,
+				      const struct node_list *list);
+
+
+struct graph
+{
+	// hashed by first byte of SHA-1 or low byte of virtual_id
+	struct node_list *commits[256];
+};
+
+struct node *graph_add_node(struct graph *graph, struct node *node);
+struct node *graph_node_bysha(const struct graph *graph,
+			      const unsigned char *sha);
+
+#define for_each_node_list(p,list) \
+	for ( p = (list); p; p = p->next )
+
+const char *node_title(struct node *, int *len);
+const unsigned char *node_sha(const struct node *);
+const char *node_hex_sha1(const struct node *);
+void node_list_print(const char *msg, const struct node_list *list);
+
+struct tree *git_write_tree();
+
+#endif /* _GRAPH_H_ */
+
+// vim: sw=8 noet
diff --git a/merge-recursive.c b/merge-recursive.c
new file mode 100644
index 0000000..9bbb426
--- /dev/null
+++ b/merge-recursive.c
@@ -0,0 +1,1576 @@
+//
+// Recursive Merge algorithm stolen from git-merge-recursive.py by
+// Fredrik Kuivinen.
+//
+#include <stdarg.h>
+#include <string.h>
+#include <assert.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include "cache.h"
+#include "commit.h"
+#include "blob.h"
+#include "tree-walk.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "run-command.h"
+
+#include "graph.h"
+#include "path-list.h"
+
+#define for_each_commit(p,list) for ( p = (list); p; p = p->next )
+
+struct merge_result
+{
+	struct node *commit;
+	unsigned clean:1;
+};
+
+struct merge_tree_result
+{
+	struct tree *tree;
+	unsigned clean:1;
+};
+
+struct index_entry
+{
+	struct index_entry *next;
+	struct
+	{
+		unsigned mode;
+		unsigned char sha[20];
+	} stages[4];
+	unsigned processed:1;
+	char path[1];
+};
+
+struct index_entry *index_entry_alloc(const char *path)
+{
+	size_t n = strlen(path); // index_entry::path has room for \0
+	struct index_entry *p = xmalloc(sizeof(struct index_entry) + n);
+	if ( !p )
+		return NULL;
+	memcpy(p->path, path, n + 1);
+	p->next = NULL;
+	p->processed = 0;
+	return p;
+}
+
+#if 0
+static
+void print_index_entry(const char *text, const struct index_entry *e)
+{
+    printf("%s%s next: %p %s\n", text,
+	   e ? e->path: NULL,
+	   e ? e->next: NULL,
+	   e && e->processed ? "processed": "");
+    if ( e ) {
+	int i;
+	for ( i = 1; i < 4; ++i )
+	    printf("\tstage[%d]: %06o %s\n", i,
+		   e->stages[i].mode,
+		   sha1_to_hex(e->stages[i].sha));
+    }
+}
+#endif
+
+static struct path_list currentFileSet = {NULL, 0, 0};
+static struct path_list currentDirectorySet = {NULL, 0, 0};
+
+static int output_indent = 0;
+
+static void output(const char *fmt, ...)
+{
+	va_list args;
+	int i;
+	for ( i = output_indent; i--; )
+		fputs("  ", stdout);
+	va_start(args, fmt);
+	vfprintf(stdout, fmt, args);
+	va_end(args);
+	fputc('\n', stdout);
+}
+
+static const char *original_index_file;
+static const char *temporary_index_file;
+
+static void setup_index(int temp)
+{
+	const char *idx = temp ? temporary_index_file: original_index_file;
+	unlink(temporary_index_file);
+	setenv("GIT_INDEX_FILE", idx, 1);
+}
+
+// This is a global variable which is used in a number of places but
+// only written to in the 'merge' function.
+
+// index_only == 1    => Don't leave any non-stage 0 entries in the cache and
+//                       don't update the working directory.
+//               0    => Leave unmerged entries in the cache and update
+//                       the working directory.
+static int index_only = 0; // cacheOnly
+
+static int git_read_tree(const struct tree *tree)
+{
+#if 0
+	fprintf(stderr, "GIT_INDEX_FILE='%s' git-read-tree %s\n",
+		getenv("GIT_INDEX_FILE"),
+		sha1_to_hex(tree->object.sha1));
+#endif
+	const char *argv[] = { "git-read-tree", NULL, NULL, };
+	argv[1] = sha1_to_hex(tree->object.sha1);
+	int rc = run_command_v(2, argv);
+	return rc < 0 ? -1: rc;
+}
+
+static int git_merge_trees(const char *update_arg,
+			   struct tree *common,
+			   struct tree *head,
+			   struct tree *merge)
+{
+#if 0
+	fprintf(stderr, "GIT_INDEX_FILE='%s' git-read-tree %s -m %s %s %s\n",
+		getenv("GIT_INDEX_FILE"),
+		update_arg,
+		sha1_to_hex(common->object.sha1),
+		sha1_to_hex(head->object.sha1),
+		sha1_to_hex(merge->object.sha1));
+#endif
+	const char *argv[] = {
+		"git-read-tree", NULL, "-m", NULL, NULL, NULL,
+		NULL,
+	};
+	argv[1] = update_arg;
+	argv[3] = sha1_to_hex(common->object.sha1);
+	argv[4] = sha1_to_hex(head->object.sha1);
+	argv[5] = sha1_to_hex(merge->object.sha1);
+	int rc = run_command_v(6, argv);
+	return rc < 0 ? -1: rc;
+}
+
+struct merge_tree_result merge_trees(struct tree *head,
+				     struct tree *merge,
+				     struct tree *common,
+				     const char *branch1Name,
+				     const char *branch2Name);
+
+static int fget_sha1(unsigned char *sha, FILE *fp, int *ch);
+
+// The entry point to the merge code
+
+// Merge the commits h1 and h2, return the resulting virtual
+// commit object and a flag indicating the cleaness of the merge.
+static
+struct merge_result merge(struct node *h1,
+			  struct node *h2,
+			  const char *branch1Name,
+			  const char *branch2Name,
+			  struct graph *graph,
+			  int callDepth /* =0 */,
+			  struct node *ancestor /* =None */)
+{
+	struct merge_result result = { NULL, 0 };
+
+	const char *msg;
+	int msglen;
+	output("Merging:");
+	msg = node_title(h1, &msglen);
+	output("%s %.*s", node_hex_sha1(h1), msglen, msg);
+	msg = node_title(h2, &msglen);
+	output("%s %.*s", node_hex_sha1(h2), msglen, msg);
+	if ( !ancestor && !graph )
+		die("graph is not initialized");
+	struct node_list *ca = NULL;
+	if ( ancestor )
+		node_list_insert(ancestor, &ca);
+	else {
+		struct node_list **pca = &ca;
+		char cmd[100];
+		sprintf(cmd, "git-merge-base --all %s %s",
+			node_hex_sha1(h1),
+			node_hex_sha1(h2));
+		FILE *fp = popen(cmd, "r");
+		while (!feof(fp)) {
+			unsigned char sha1[20];
+			int ch;
+			if (fget_sha1(sha1, fp, &ch) == 0) {
+				struct node *n;
+				n = node_alloc(lookup_commit(sha1));
+				node_list_insert(n, pca);
+				pca = &(*pca)->next;
+			}
+		}
+		pclose(fp);
+	}
+
+	output("found %u common ancestor(s):", node_list_count(ca));
+	struct node_list *x;
+	for_each_node_list(x,ca) {
+		msg = node_title(x->node, &msglen);
+		output("%s %.*s", node_hex_sha1(x->node), msglen, msg);
+	}
+
+	struct node *mergedCA = node_list_shift_node(&ca);
+
+	struct node_list *h;
+	for_each_commit(h,ca) {
+		output_indent = callDepth + 1;
+		result = merge(mergedCA, h->node,
+			       "Temporary merge branch 1",
+			       "Temporary merge branch 2",
+			       graph,
+			       callDepth + 1,
+			       NULL);
+		mergedCA = result.commit;
+		output_indent = callDepth;
+
+		if ( !mergedCA )
+			die("merge returned no commit");
+	}
+
+	if ( callDepth == 0 ) {
+		setup_index(0);
+		index_only = 0;
+	} else {
+		setup_index(1);
+		git_read_tree(h1->tree);
+		index_only = 1;
+	}
+
+	struct merge_tree_result mtr;
+	mtr = merge_trees(h1->tree, h2->tree,
+			  mergedCA->tree, branch1Name, branch2Name);
+
+	if ( !ancestor && (mtr.clean || index_only) ) {
+		result.commit = node_alloc_virtual(mtr.tree, "merged tree");
+		struct node_list *parents = NULL;
+		node_list_insert(h1, &parents);
+		node_list_insert(h2, &parents->next);
+		node_set_parents(result.commit, parents);
+		graph_add_node(graph, result.commit);
+	} else
+		result.commit = NULL;
+
+	result.clean = mtr.clean;
+	return result;
+}
+
+#define READ_TREE_FOUND 2
+typedef int (*read_tree_rt_fn_t)(const char *sha1,
+				 const char *path,
+				 unsigned mode,
+				 void *data);
+
+// git-ls-tree -r -t <tree>
+static int read_tree_rt(struct tree *tree,
+			const char *base,
+			int baselen,
+			read_tree_rt_fn_t fn,
+			void *data)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+
+	if (parse_tree(tree))
+		return -1;
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+
+	while ( tree_entry(&desc, &entry) ) {
+		int retval;
+		char *path = xmalloc(baselen + entry.pathlen + 2);
+		memcpy(path, base, baselen);
+		memcpy(path + baselen, entry.path, entry.pathlen);
+		path[baselen + entry.pathlen] = '\0';
+
+		switch ( retval = fn(entry.sha1, path, entry.mode, data) ) {
+		case READ_TREE_RECURSIVE:
+			break;
+		case 0:
+			free(path);
+			continue;
+		default:
+			free(path);
+			return retval;
+		}
+		if (S_ISDIR(entry.mode)) {
+			path[baselen + entry.pathlen] = '/';
+			path[baselen + entry.pathlen + 1] = '\0';
+			retval = read_tree_rt(lookup_tree(entry.sha1),
+					      path,
+					      baselen + entry.pathlen + 1,
+					      fn, data);
+			path[baselen + entry.pathlen] = '\0';
+			if (retval) {
+				free(path);
+				return retval;
+			}
+		}
+		free(path);
+	}
+	return 0;
+}
+
+struct files_and_dirs
+{
+	struct path_list *files;
+	struct path_list *dirs;
+};
+
+static int save_files_dirs(const char *sha1,
+			   const char *path_,
+			   unsigned mode,
+			   void *data_)
+{
+	struct files_and_dirs *data = data_;
+	char *path = strdup(path_);
+
+	if (S_ISDIR(mode))
+		path_list_insert(path, data->dirs);
+	else
+		path_list_insert(path, data->files);
+	return READ_TREE_RECURSIVE;
+}
+
+int getFilesAndDirs(struct tree *tree,
+		    struct path_list *files,
+		    struct path_list *dirs)
+{
+	struct files_and_dirs data;
+	path_list_clear(files, 1);
+	path_list_clear(dirs, 1);
+	data.files = files;
+	data.dirs = dirs;
+	if ( read_tree_rt(tree, "", 0, save_files_dirs, &data) != 0 )
+		return 0;
+	return path_list_count(files) + path_list_count(dirs);
+}
+
+struct index_entry *index_entry_find(struct index_entry *ents, const char *path)
+{
+	struct index_entry *e;
+	for ( e = ents; e; e = e->next )
+		if ( strcmp(e->path, path) == 0 )
+			break;
+	return e;
+}
+
+struct index_entry *index_entry_get(struct index_entry **ents, const char *path)
+{
+	struct index_entry *e, **tail = ents;
+	for ( e = *ents; e; e = e->next ) {
+		if ( strcmp(e->path, path) == 0 )
+			return e;
+		tail = &e->next;
+	}
+	e = index_entry_alloc(path);
+	memset(e->stages, 0, sizeof(e->stages));
+	return *tail = e;
+}
+
+struct find_entry
+{
+	const char *path;
+	unsigned char *sha;
+	unsigned *mode;
+};
+
+static int find_entry(const char *sha,
+		      const char *path,
+		      unsigned mode,
+		      void *data_)
+{
+	struct find_entry *data = data_;
+	if ( strcmp(path, data->path) == 0 ) {
+		memcpy(data->sha, sha, 20);
+		*data->mode = mode;
+		return READ_TREE_FOUND;
+	}
+	return READ_TREE_RECURSIVE;
+}
+
+// Returns a CacheEntry object which doesn't have to correspond to
+// a real cache entry in Git's index.
+struct index_entry *index_entry_from_db(const char *path,
+					struct tree *o,
+					struct tree *a,
+					struct tree *b)
+{
+	struct index_entry *e = index_entry_alloc(path);
+	struct find_entry data;
+	data.path = path;
+	data.sha = e->stages[1].sha;
+	data.mode = &e->stages[1].mode;
+	if ( read_tree_rt(o, "", 0, find_entry, &data) != READ_TREE_FOUND ) {
+		// fprintf(stderr, "1: %s:%s not found\n",
+		// 	sha1_to_hex(o->object.sha1), path);
+		memcpy(e->stages[1].sha, null_sha1, 20);
+		e->stages[1].mode = 0;
+	}
+	data.sha = e->stages[2].sha;
+	data.mode = &e->stages[2].mode;
+	if ( read_tree_rt(a, "", 0, find_entry, &data) != READ_TREE_FOUND ) {
+		// fprintf(stderr, "2: %s:%s not found\n",
+		// 	sha1_to_hex(a->object.sha1), path);
+		memcpy(e->stages[2].sha, null_sha1, 20);
+		e->stages[2].mode = 0;
+	}
+	data.sha = e->stages[3].sha;
+	data.mode = &e->stages[3].mode;
+	if ( read_tree_rt(b, "", 0, find_entry, &data) != READ_TREE_FOUND ) {
+		// fprintf(stderr, "3: %s:%s not found\n",
+		// 	sha1_to_hex(b->object.sha1), path);
+		memcpy(e->stages[3].sha, null_sha1, 20);
+		e->stages[3].mode = 0;
+	}
+	return e;
+}
+
+void free_index_entries(struct index_entry **ents)
+{
+	while ( *ents ) {
+		struct index_entry *next = (*ents)->next;
+		free(*ents);
+		*ents = next;
+	}
+}
+
+static int fget_mode(unsigned *mode, FILE *fp, int *ch)
+{
+	int p;
+	char buf[8];
+	for ( p = 0; (*ch = fgetc(fp)) != EOF && p < 6; ) {
+		if ( *ch == '\x20' || *ch == '\t' || *ch == '\n' || *ch == '\r' )
+			break;
+		if ( *ch < '0' || *ch > '7' )
+			return -1;
+		buf[p++] = *ch;
+	}
+	buf[p] = '\0';
+	*mode = strtoul(buf, 0, 8);
+	return 0;
+}
+
+static int fget_sha1(unsigned char *sha, FILE *fp, int *ch)
+{
+	char buf[40];
+	int p;
+	for ( p = 0; (*ch = fgetc(fp)) != EOF && p < 40; ) {
+		if ( ('0' <= *ch && *ch <= '9') ||
+		     ('a' <= *ch && *ch <= 'f') ||
+		     ('A' <= *ch && *ch <= 'F') )
+			buf[p++] = *ch;
+		else
+			return -1;
+	}
+	if ( p != 40 || get_sha1_hex(buf, sha) == -1 )
+		return -1;
+	return 0;
+}
+// Create a dictionary mapping file names to CacheEntry objects. The
+// dictionary contains one entry for every path with a non-zero stage entry.
+struct index_entry *unmergedCacheEntries()
+{
+	struct index_entry *unmerged = NULL;
+	FILE *fp = popen("git-ls-files -z --unmerged", "r");
+	if ( !fp )
+		return NULL;
+	int ch;
+	while ( !feof(fp) ) {
+		unsigned mode;
+		unsigned char sha[20];
+		char stage = '0';
+		char path[PATH_MAX];
+		int p;
+		// mode
+		if ( fget_mode(&mode, fp, &ch) )
+			goto wait_eol;
+		if ( '\x20' != ch )
+			goto wait_eol;
+		// SHA1
+		if ( fget_sha1(sha, fp, &ch) )
+			goto wait_eol;
+		if ( '\x20' != ch )
+			goto wait_eol;
+		// stage
+		if ( (ch = fgetc(fp)) != EOF ) {
+			stage = ch;
+			if ( ch < '1' || ch > '3' )
+				goto wait_eol;
+		}
+		if ( (ch = fgetc(fp)) == EOF || '\t' != ch )
+			goto wait_eol;
+		// path
+		for ( p = 0; (ch = fgetc(fp)) != EOF; ++p ) {
+			path[p] = ch;
+			if ( !ch )
+				break;
+			if ( p == sizeof(path) - 1 ) {
+				path[p] = '\0';
+				error("path too long: %s", path);
+				goto wait_eol;
+			}
+		}
+		if ( ch )
+			goto wait_eol;
+		// printf("unmerged %08o %s %c %s\n",mode,sha1_to_hex(sha),stage,path);
+		struct index_entry *e = index_entry_get(&unmerged, path);
+		e->stages[stage - '1' + 1].mode = mode;
+		memcpy(e->stages[stage - '1' + 1].sha, sha, 20);
+		continue;
+	wait_eol:
+		while ( (ch = fgetc(fp)) != EOF && ch );
+	}
+	pclose(fp);
+	return unmerged;
+}
+
+struct rename_entry
+{
+	struct rename_entry *next;
+
+	char *src;
+	unsigned char src_sha[20];
+	unsigned src_mode;
+	struct index_entry *src_entry;
+
+	char *dst;
+	unsigned char dst_sha[20];
+	unsigned dst_mode;
+	struct index_entry *dst_entry;
+
+	unsigned score;
+	unsigned processed:1;
+};
+
+struct rename_entry *find_rename_bysrc(struct rename_entry *e,
+				       const char *name)
+{
+	while ( e ) {
+		if ( strcmp(e->src, name) == 0 )
+			break;
+		e = e->next;
+	}
+	return e;
+}
+
+struct rename_entry *find_rename_bydst(struct rename_entry *e,
+				       const char *name)
+{
+	while ( e ) {
+		if ( strcmp(e->dst, name) == 0 )
+			break;
+		e = e->next;
+	}
+	return e;
+}
+
+void rename_entry_free(struct rename_entry *p)
+{
+	free(p->src);
+	free(p->dst);
+	free(p);
+}
+
+void free_rename_entries(struct rename_entry **list)
+{
+	while ( *list ) {
+		struct rename_entry *next = (*list)->next;
+		rename_entry_free(*list);
+		*list = next;
+	}
+}
+
+// Get information of all renames which occured between 'oTree' and
+// 'tree'. We need the three trees in the merge ('oTree', 'aTree' and
+// 'bTree') to be able to associate the correct cache entries with
+// the rename information. 'tree' is always equal to either aTree or bTree.
+struct rename_entry *getRenames(struct tree *tree,
+				struct tree *oTree,
+				struct tree *aTree,
+				struct tree *bTree,
+				struct index_entry **entries)
+{
+	struct rename_entry *renames = NULL;
+	struct rename_entry **rptr = &renames;
+	struct diff_options opts;
+	diff_setup(&opts);
+	opts.recursive = 1;
+	opts.detect_rename = DIFF_DETECT_RENAME;
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	if (diff_setup_done(&opts) < 0)
+		die("diff setup failed");
+	diff_tree_sha1(oTree->object.sha1, tree->object.sha1, "", &opts);
+	diffcore_std(&opts);
+	int i;
+	for (i = 0; i < diff_queued_diff.nr; ++i) {
+		struct rename_entry *re;
+		struct diff_filepair *pair = diff_queued_diff.queue[i];
+		if (pair->status != 'R')
+			continue;
+		re = xmalloc(sizeof(*re));
+		re->next = NULL;
+		re->processed = 0;
+		re->score = pair->score;
+		memcpy(re->src_sha, pair->one->sha1, 20);
+		re->src = strdup(pair->one->path);
+		re->src_mode = pair->one->mode;
+		memcpy(re->dst_sha, pair->two->sha1, 20);
+		re->dst = strdup(pair->two->path);
+		re->dst_mode = pair->two->mode;
+		re->src_entry = index_entry_find(*entries, re->src);
+		if ( !re->src_entry ) {
+			re->src_entry = index_entry_from_db(re->src, oTree, aTree, bTree);
+			re->src_entry->next = *entries;
+			*entries = re->src_entry;
+		}
+		re->dst_entry = index_entry_find(*entries, re->dst);
+		if ( !re->dst_entry ) {
+			re->dst_entry = index_entry_from_db(re->dst, oTree, aTree, bTree);
+			re->dst_entry->next = *entries;
+			*entries = re->dst_entry;
+		}
+		*rptr = re;
+		rptr = &re->next;
+	}
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_flush(&opts);
+	return renames;
+}
+
+static FILE *git_update_index_pipe()
+{
+	return popen("git-update-index -z --index-info", "w");
+}
+
+int setIndexStages(FILE *fp,
+		   const char *path,
+		   unsigned char *osha, unsigned omode,
+		   unsigned char *asha, unsigned amode,
+		   unsigned char *bsha, unsigned bmode,
+		   int clear /* =True */)
+{
+	if ( !fp )
+		return -1;
+	if ( clear ) {
+		fprintf(fp, "0 %s\t%s", sha1_to_hex(null_sha1), path);
+		fputc('\0', fp);
+	}
+	if ( omode ) {
+		fprintf(fp, "0%o %s 1\t%s", omode, sha1_to_hex(osha), path);
+		fputc('\0', fp);
+	}
+	if ( amode ) {
+		fprintf(fp, "0%o %s 2\t%s", amode, sha1_to_hex(asha), path);
+		fputc('\0', fp);
+	}
+	if ( bmode ) {
+		fprintf(fp, "0%o %s 3\t%s", bmode, sha1_to_hex(bsha), path);
+		fputc('\0', fp);
+	}
+	return 0;
+}
+
+static int remove_path(const char *name)
+{
+	int ret;
+	char *slash;
+
+	ret = unlink(name);
+	if ( ret )
+		return ret;
+	int len = strlen(name);
+	char *dirs = malloc(len+1);
+	memcpy(dirs, name, len);
+	dirs[len] = '\0';
+	while ( (slash = strrchr(name, '/')) ) {
+		*slash = '\0';
+		len = slash - name;
+		if ( rmdir(name) != 0 )
+			break;
+	}
+	free(dirs);
+	return ret;
+}
+
+int removeFile(FILE *fp, int clean, const char *path)
+{
+	int updateCache = index_only || clean;
+	int updateWd = !index_only;
+
+	if ( updateCache ) {
+		if ( !fp )
+			return -1;
+		fprintf(fp, "0 %s\t%s", sha1_to_hex(null_sha1), path);
+		fputc('\0', fp);
+		return 0;
+	}
+	if ( updateWd )
+	{
+		unlink(path);
+		if ( errno != ENOENT || errno != EISDIR )
+			return -1;
+		remove_path(path);
+	}
+	return 0;
+}
+
+char *uniquePath(const char *path, const char *branch)
+{
+	char *newpath = xmalloc(strlen(path) + 1 + strlen(branch) + 8 + 1);
+	strcpy(newpath, path);
+	strcat(newpath, "~");
+	char *p = newpath + strlen(newpath);
+	strcpy(p, branch);
+	for ( ; *p; ++p )
+		if ( '/' == *p )
+			*p = '_';
+	int suffix = 0;
+	struct stat st;
+	while ( path_list_has_path(&currentFileSet, newpath) ||
+		path_list_has_path(&currentDirectorySet, newpath) ||
+		lstat(newpath, &st) == 0 ) {
+		sprintf(p, "_%d", suffix++);
+	}
+	path_list_insert(newpath, &currentFileSet);
+	return newpath;
+}
+
+int mkdir_p(const char *path, unsigned long mode, int create_last)
+{
+	char *buf = strdup(path);
+	char *p;
+
+	for ( p = buf; *p; ++p ) {
+		if ( *p != '/' )
+			continue;
+		*p = '\0';
+		if (mkdir(buf, mode)) {
+			int e = errno;
+			if ( e == EEXIST ) {
+				struct stat st;
+				if ( !stat(buf, &st) && S_ISDIR(st.st_mode) )
+					goto next; /* ok */
+				errno = e;
+			}
+			free(buf);
+			return -1;
+		}
+	next:
+		*p = '/';
+	}
+	free(buf);
+	if ( create_last && mkdir(path, mode) )
+		return -1;
+	return 0;
+}
+
+/* stolen from builtin-cat-file.c */
+static void flush_buffer(int fd, const char *buf, unsigned long size)
+{
+	while (size > 0) {
+		long ret = xwrite(fd, buf, size);
+		if (ret < 0) {
+			/* Ignore epipe */
+			if (errno == EPIPE)
+				break;
+			die("git-cat-file: %s", strerror(errno));
+		} else if (!ret) {
+			die("git-cat-file: disk full?");
+		}
+		size -= ret;
+		buf += ret;
+	}
+}
+
+void updateFileExt(FILE *fp,
+		   const unsigned char *sha,
+		   unsigned mode,
+		   const char *path,
+		   int updateCache,
+		   int updateWd)
+{
+	if ( index_only )
+		updateWd = 0;
+
+	if ( updateWd ) {
+		char type[20];
+		void *buf;
+		unsigned long size;
+
+		buf = read_sha1_file(sha, type, &size);
+		if (!buf)
+			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
+		if ( strcmp(type, blob_type) != 0 )
+			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
+
+		if ( S_ISREG(mode) ) {
+			if ( mkdir_p(path, 0777, 0 /* don't create last element */) )
+				die("failed to create path %s: %s", path, strerror(errno));
+			unlink(path);
+			if ( mode & 0100 )
+				mode = 0777;
+			else
+				mode = 0666;
+			int fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
+			if ( fd < 0 )
+				die("failed to open %s: %s", path, strerror(errno));
+			flush_buffer(fd, buf, size);
+			close(fd);
+		} else if ( S_ISLNK(mode) ) {
+			char *linkTarget = malloc(size + 1);
+			memcpy(linkTarget, buf, size);
+			linkTarget[size] = '\0';
+			mkdir_p(path, 0777, 0);
+			symlink(linkTarget, path);
+		} else
+			die("do not know what to do with %06o %s '%s'",
+			    mode, sha1_to_hex(sha), path);
+	}
+	if ( updateCache )
+	{
+		// XXX just always use "git update-index --index-info"?
+		fprintf(fp, "%06o %s\t%s", mode, sha1_to_hex(sha), path);
+		fputc('\0', fp);
+	}
+}
+
+void updateFile(FILE *fp,
+		int clean,
+		const unsigned char *sha,
+		unsigned mode,
+		const char *path)
+{
+	updateFileExt(fp, sha, mode, path, index_only || clean, !index_only);
+}
+
+// Low level file merging, update and removal
+// ------------------------------------------
+struct merge_file_info
+{
+	unsigned char sha[20];
+	unsigned mode;
+	unsigned clean:1;
+	unsigned merge:1;
+};
+
+static char *git_unpack_file(unsigned char *sha1, char *path)
+{
+	void *buf;
+	char type[20];
+	unsigned long size;
+	int fd;
+
+	buf = read_sha1_file(sha1, type, &size);
+	if (!buf || strcmp(type, blob_type))
+		die("unable to read blob object %s", sha1_to_hex(sha1));
+
+	strcpy(path, ".merge_file_XXXXXX");
+	fd = mkstemp(path);
+	if (fd < 0)
+		die("unable to create temp-file");
+	if (write(fd, buf, size) != size)
+		die("unable to write temp-file");
+	close(fd);
+	return path;
+}
+
+struct merge_file_info
+mergeFile(const char *oPath, unsigned char *oSha, unsigned oMode,
+	  const char *aPath, unsigned char *aSha, unsigned aMode,
+	  const char *bPath, unsigned char *bSha, unsigned bMode,
+	  const char *branch1Name, const char *branch2Name)
+{
+	struct merge_file_info result;
+	result.merge = 0;
+	result.clean = 1;
+
+	if ( (S_IFMT & aMode) != (S_IFMT & bMode) ) {
+		result.clean = 0;
+		if ( S_ISREG(aMode) ) {
+			result.mode = aMode;
+			memcpy(result.sha, aSha, 20);
+		} else {
+			result.mode = bMode;
+			memcpy(result.sha, bSha, 20);
+		}
+	} else {
+		if ( memcmp(aSha, oSha, 20) != 0 && memcmp(bSha, oSha, 20) != 0 )
+			result.merge = 1;
+
+		result.mode = aMode == oMode ? bMode: aMode;
+
+		if ( memcmp(aSha, oSha, 20) == 0 )
+			memcpy(result.sha, bSha, 20);
+		else if ( memcmp(bSha, oSha, 20) == 0 )
+			memcpy(result.sha, aSha, 20);
+		else if ( S_ISREG(aMode) ) {
+
+			int code = 1;
+			char orig[PATH_MAX];
+			char src1[PATH_MAX];
+			char src2[PATH_MAX];
+
+			git_unpack_file(oSha, orig);
+			git_unpack_file(aSha, src1);
+			git_unpack_file(bSha, src2);
+
+			const char *argv[] = {
+				"merge", "-L", NULL, "-L", NULL, "-L", NULL,
+				src1, orig, src2,
+				NULL
+			};
+			char *la, *lb, *lo;
+			argv[2] = la = malloc(strlen(branch1Name) + 2 + strlen(aPath));
+			strcat(strcat(strcpy(la, branch1Name), "/"), aPath);
+			argv[6] = lb = malloc(strlen(branch2Name) + 2 + strlen(bPath));
+			strcat(strcat(strcpy(lb, branch2Name), "/"), bPath);
+			argv[4] = lo = malloc(7 + strlen(oPath));
+			strcat(strcpy(lo, "orig/"), oPath);
+
+#if 0
+			printf("%s %s %s %s %s %s %s %s %s %s\n",
+			       argv[0], argv[1], argv[2], argv[3], argv[4],
+			       argv[5], argv[6], argv[7], argv[8], argv[9]);
+#endif
+			code = run_command_v(10, argv);
+
+			free(la);
+			free(lb);
+			free(lo);
+			if ( code && code < -256 ) {
+				die("Failed to execute 'merge'. merge(1) is used as the "
+				    "file-level merge tool. Is 'merge' in your path?");
+			}
+			char cmd[PATH_MAX];
+			snprintf(cmd, sizeof(cmd), "git-hash-object -t blob -w %s", src1);
+			FILE *fp = popen(cmd, "r");
+			if ( !fp )
+				die("cannot run git-hash-object: %s", strerror(errno));
+			int ch;
+			if ( fget_sha1(result.sha, fp, &ch) )
+				die("invalid output from git-hash-object");
+			pclose(fp);
+
+			unlink(orig);
+			unlink(src1);
+			unlink(src2);
+
+			result.clean = WEXITSTATUS(code) == 0;
+		} else {
+			if ( !(S_ISLNK(aMode) || S_ISLNK(bMode)) )
+				die("cannot merge modes?");
+
+			memcpy(result.sha, aSha, 20);
+
+			if ( memcmp(aSha, bSha, 20) != 0 )
+				result.clean = 0;
+		}
+	}
+
+	return result;
+}
+
+static void memswp(void *p1, void *p2, unsigned n)
+{
+	unsigned char *a = p1, *b = p2;
+	while ( n-- ) {
+		*a ^= *b;
+		*b ^= *a;
+		*a ^= *b;
+		++a;
+		++b;
+	}
+}
+
+int processRenames(struct rename_entry *renamesA,
+		   struct rename_entry *renamesB,
+		   const char *branchNameA,
+		   const char *branchNameB)
+{
+	int cleanMerge = 1;
+	//    printf("process renames %s:%s -> %s:%s\n",
+	//	   branchNameA, renamesA ? renamesA->src: "(none)",
+	//	   branchNameB, renamesB ? renamesB->dst: "(none)");
+
+	struct path_list srcNames = {NULL, 0, 0};
+	const struct rename_entry *sre;
+	char **src;
+
+	for (sre = renamesA; sre; sre = sre->next)
+		path_list_insert(sre->src, &srcNames);
+	for (sre = renamesB; sre; sre = sre->next)
+		path_list_insert(sre->src, &srcNames);
+
+	FILE *fp = git_update_index_pipe();
+	for_each_path(src,&srcNames) {
+		struct rename_entry *renames1, *renames2, *ren1, *ren2;
+		const char *branchName1, *branchName2;
+		ren1 = find_rename_bysrc(renamesA, *src);
+		ren2 = find_rename_bysrc(renamesB, *src);
+		if ( ren1 ) {
+			renames1 = renamesA;
+			renames2 = renamesB;
+			branchName1 = branchNameA;
+			branchName2 = branchNameB;
+		} else {
+			renames1 = renamesB;
+			renames2 = renamesA;
+			branchName1 = branchNameB;
+			branchName2 = branchNameA;
+			struct rename_entry *tmp = ren2;
+			ren2 = ren1;
+			ren1 = tmp;
+		}
+
+		ren1->dst_entry->processed = 1;
+		ren1->src_entry->processed = 1;
+
+		if ( ren1->processed )
+			continue;
+		ren1->processed = 1;
+
+		if ( ren2 ) {
+			// Renamed in 1 and renamed in 2
+			if ( strcmp(ren1->src, ren2->src) != 0 )
+				die("ren1.srcName != ren2.srcName");
+			ren2->dst_entry->processed = 1;
+			ren2->processed = 1;
+			if ( strcmp(ren1->dst, ren2->dst) != 0 ) {
+				output("CONFLICT (rename/rename): "
+				       "Rename %s->%s in branch %s "
+				       "rename %s->%s in %s",
+				       *src, ren1->dst, branchName1,
+				       *src, ren2->dst, branchName2);
+				cleanMerge = 0;
+				char *dstName1 = ren1->dst, *dstName2 = ren2->dst;
+				if ( path_list_has_path(&currentDirectorySet, ren1->dst) ) {
+					dstName1 = uniquePath(ren1->dst, branchName1);
+					output("%s is a directory in %s adding as %s instead",
+					       ren1->dst, branchName2, dstName1);
+					removeFile(fp, 0, ren1->dst);
+				}
+				if ( path_list_has_path(&currentDirectorySet, ren2->dst) ) {
+					dstName2 = uniquePath(ren2->dst, branchName2);
+					output("%s is a directory in %s adding as %s instead",
+					       ren2->dst, branchName1, dstName2);
+					removeFile(fp, 0, ren2->dst);
+				}
+				setIndexStages(fp, dstName1,
+					       NULL, 0,
+					       ren1->dst_sha, ren1->dst_mode,
+					       NULL, 0,
+					       1 /* clear */);
+				setIndexStages(fp, dstName2,
+					       NULL, 0,
+					       NULL, 0,
+					       ren2->dst_sha, ren2->dst_mode,
+					       1 /* clear */);
+			} else {
+				removeFile(fp, 1, ren1->src);
+				struct merge_file_info mfi;
+				mfi = mergeFile(ren1->src, ren1->src_sha, ren1->src_mode,
+						ren1->dst, ren1->dst_sha, ren1->dst_mode,
+						ren2->dst, ren2->dst_sha, ren2->dst_mode,
+						branchName1, branchName2);
+				if ( mfi.merge || !mfi.clean )
+					output("Renaming %s->%s", *src, ren1->dst);
+
+				if ( mfi.merge )
+					output("Auto-merging %s", ren1->dst);
+
+				if ( !mfi.clean ) {
+					output("CONFLICT (content): merge conflict in %s",
+					       ren1->dst);
+					cleanMerge = 0;
+
+					if ( !index_only )
+						setIndexStages(fp,
+							       ren1->dst,
+							       ren1->src_sha, ren1->src_mode,
+							       ren1->dst_sha, ren1->dst_mode,
+							       ren2->dst_sha, ren2->dst_mode,
+							       1 /* clear */);
+				}
+				updateFile(fp, mfi.clean, mfi.sha, mfi.mode, ren1->dst);
+			}
+		} else {
+			// Renamed in 1, maybe changed in 2
+			removeFile(fp, 1, ren1->src);
+
+			unsigned char srcShaOtherBranch[20], dstShaOtherBranch[20];
+			unsigned srcModeOtherBranch, dstModeOtherBranch;
+
+			int stage = renamesA == renames1 ? 3: 2;
+
+			memcpy(srcShaOtherBranch, ren1->src_entry->stages[stage].sha, 20);
+			srcModeOtherBranch = ren1->src_entry->stages[stage].mode;
+
+			memcpy(dstShaOtherBranch, ren1->dst_entry->stages[stage].sha, 20);
+			dstModeOtherBranch = ren1->dst_entry->stages[stage].mode;
+
+			int tryMerge = 0;
+			char *newPath;
+			struct rename_entry *dst2;
+
+			if ( path_list_has_path(&currentDirectorySet, ren1->dst) ) {
+				newPath = uniquePath(ren1->dst, branchName1);
+				output("CONFLICT (rename/directory): Rename %s->%s in %s "
+				       " directory %s added in %s",
+				       ren1->src, ren1->dst, branchName1,
+				       ren1->dst, branchName2);
+				output("Renaming %s to %s instead", ren1->src, newPath);
+				cleanMerge = 0;
+				removeFile(fp, 0, ren1->dst);
+				updateFile(fp, 0, ren1->dst_sha, ren1->dst_mode, newPath);
+			} else if ( memcmp(srcShaOtherBranch, null_sha1, 20) == 0 ) {
+				output("CONFLICT (rename/delete): Rename %s->%s in %s "
+				       "and deleted in %s",
+				       ren1->src, ren1->dst, branchName1,
+				       branchName2);
+				cleanMerge = 0;
+				updateFile(fp, 0, ren1->dst_sha, ren1->dst_mode, ren1->dst);
+			} else if ( memcmp(dstShaOtherBranch, null_sha1, 20) != 0 ) {
+				newPath = uniquePath(ren1->dst, branchName2);
+				output("CONFLICT (rename/add): Rename %s->%s in %s. "
+				       "%s added in %s",
+				       ren1->src, ren1->dst, branchName1,
+				       ren1->dst, branchName2);
+				output("Adding as %s instead", newPath);
+				updateFile(fp, 0, dstShaOtherBranch, dstModeOtherBranch, newPath);
+				cleanMerge = 0;
+				tryMerge = 1;
+			} else if ( (dst2 = find_rename_bydst(renames2, ren1->dst)) ) {
+				char *newPath1 = uniquePath(ren1->dst, branchName1);
+				char *newPath2 = uniquePath(dst2->dst, branchName2);
+				output("CONFLICT (rename/rename): Rename %s->%s in %s. "
+				       "Rename %s->%s in %s",
+				       ren1->src, ren1->dst, branchName1,
+				       dst2->src, dst2->dst, branchName2);
+				output("Renaming %s to %s and %s to %s instead",
+				       ren1->src, newPath1, dst2->src, newPath2);
+				removeFile(fp, 0, ren1->dst);
+				updateFile(fp, 0, ren1->dst_sha, ren1->dst_mode, newPath1);
+				updateFile(fp, 0, dst2->dst_sha, dst2->dst_mode, newPath2);
+				dst2->processed = 1;
+				cleanMerge = 0;
+			} else
+				tryMerge = 1;
+
+			if ( tryMerge ) {
+				char *oname = ren1->src;
+				char *aname = ren1->dst;
+				char *bname = ren1->src;
+				unsigned char osha[20], asha[20], bsha[20];
+				unsigned omode = ren1->src_mode;
+				unsigned amode = ren1->dst_mode;
+				unsigned bmode = srcModeOtherBranch;
+				memcpy(osha, ren1->src_sha, 20);
+				memcpy(asha, ren1->dst_sha, 20);
+				memcpy(bsha, srcShaOtherBranch, 20);
+				const char *aBranch = branchName1;
+				const char *bBranch = branchName2;
+
+				if ( renamesA != renames1 ) {
+					memswp(&aname, &bname, sizeof(aname));
+					memswp(asha, bsha, 20);
+					memswp(&aBranch, &bBranch, sizeof(aBranch));
+				}
+				struct merge_file_info mfi;
+				mfi = mergeFile(oname, osha, omode,
+						aname, asha, amode,
+						bname, bsha, bmode,
+						aBranch, bBranch);
+
+				if ( mfi.merge || !mfi.clean )
+					output("Renaming %s => %s", ren1->src, ren1->dst);
+				if ( mfi.merge )
+					output("Auto-merging %s", ren1->dst);
+				if ( !mfi.clean ) {
+					output("CONFLICT (rename/modify): Merge conflict in %s",
+					       ren1->dst);
+					cleanMerge = 0;
+
+					if ( !index_only )
+						setIndexStages(fp,
+							       ren1->dst,
+							       osha, omode,
+							       asha, amode,
+							       bsha, bmode,
+							       1 /* clear */);
+				}
+				updateFile(fp, mfi.clean, mfi.sha, mfi.mode, ren1->dst);
+			}
+		}
+	}
+	path_list_clear(&srcNames, 0);
+	if (pclose(fp)) {
+		die("git update-index --index-info failed");
+	}
+	return cleanMerge;
+}
+
+static unsigned char *has_sha(const unsigned char *sha)
+{
+	return memcmp(sha, null_sha1, 20) == 0 ? NULL: (unsigned char *)sha;
+}
+
+static int sha_eq(const unsigned char *a, const unsigned char *b)
+{
+	if ( !a && !b )
+		return 2;
+	return a && b && memcmp(a, b, 20) == 0;
+}
+
+// Per entry merge function
+// ------------------------
+// Merge one cache entry.
+int processEntry(struct index_entry *entry,
+		 const char *branch1Name,
+		 const char *branch2Name)
+{
+	//    printf("processing entry, clean cache: %s\n", index_only ? "yes": "no");
+	//    print_index_entry("\tpath: ", entry);
+	int cleanMerge = 1;
+	const char *path = entry->path;
+	unsigned char *oSha = has_sha(entry->stages[1].sha);
+	unsigned char *aSha = has_sha(entry->stages[2].sha);
+	unsigned char *bSha = has_sha(entry->stages[3].sha);
+	unsigned oMode = entry->stages[1].mode;
+	unsigned aMode = entry->stages[2].mode;
+	unsigned bMode = entry->stages[3].mode;
+	FILE *fp = git_update_index_pipe();
+
+	if ( oSha && (!aSha || !bSha) ) {
+		//
+		// Case A: Deleted in one
+		//
+		if ( (!aSha && !bSha) ||
+		     (sha_eq(aSha, oSha) && !bSha) ||
+		     (!aSha && sha_eq(bSha, oSha)) ) {
+			// Deleted in both or deleted in one and unchanged in the other
+			if ( aSha )
+				output("Removing %s", path);
+			removeFile(fp, 1, path);
+		} else {
+			// Deleted in one and changed in the other
+			cleanMerge = 0;
+			if ( !aSha ) {
+				output("CONFLICT (delete/modify): %s deleted in %s "
+				       "and modified in %s. Version %s of %s left in tree.",
+				       path, branch1Name,
+				       branch2Name, branch2Name, path);
+				updateFile(fp, 0, bSha, bMode, path);
+			} else {
+				output("CONFLICT (delete/modify): %s deleted in %s "
+				       "and modified in %s. Version %s of %s left in tree.",
+				       path, branch2Name,
+				       branch1Name, branch1Name, path);
+				updateFile(fp, 0, aSha, aMode, path);
+			}
+		}
+
+	} else if ( (!oSha && aSha && !bSha) ||
+		    (!oSha && !aSha && bSha) ) {
+		//
+		// Case B: Added in one.
+		//
+		const char *addBranch;
+		const char *otherBranch;
+		unsigned mode;
+		const unsigned char *sha;
+		const char *conf;
+
+		if ( aSha ) {
+			addBranch = branch1Name;
+			otherBranch = branch2Name;
+			mode = aMode;
+			sha = aSha;
+			conf = "file/directory";
+		} else {
+			addBranch = branch2Name;
+			otherBranch = branch1Name;
+			mode = bMode;
+			sha = bSha;
+			conf = "directory/file";
+		}
+		if ( path_list_has_path(&currentDirectorySet, path) ) {
+			cleanMerge = 0;
+			const char *newPath = uniquePath(path, addBranch);
+			output("CONFLICT (%s): There is a directory with name %s in %s. "
+			       "Adding %s as %s",
+			       conf, path, otherBranch, path, newPath);
+			removeFile(fp, 0, path);
+			updateFile(fp, 0, sha, mode, newPath);
+		} else {
+			output("Adding %s", path);
+			updateFile(fp, 1, sha, mode, path);
+		}
+	} else if ( !oSha && aSha && bSha ) {
+		//
+		// Case C: Added in both (check for same permissions).
+		//
+		if ( sha_eq(aSha, bSha) ) {
+			if ( aMode != bMode ) {
+				cleanMerge = 0;
+				output("CONFLICT: File %s added identically in both branches, "
+				       "but permissions conflict %06o->%06o",
+				       path, aMode, bMode);
+				output("CONFLICT: adding with permission: %06o", aMode);
+				updateFile(fp, 0, aSha, aMode, path);
+			} else {
+				// This case is handled by git-read-tree
+				assert(0 && "This case must be handled by git-read-tree");
+			}
+		} else {
+			cleanMerge = 0;
+			const char *newPath1 = uniquePath(path, branch1Name);
+			const char *newPath2 = uniquePath(path, branch2Name);
+			output("CONFLICT (add/add): File %s added non-identically "
+			       "in both branches. Adding as %s and %s instead.",
+			       path, newPath1, newPath2);
+			removeFile(fp, 0, path);
+			updateFile(fp, 0, aSha, aMode, newPath1);
+			updateFile(fp, 0, bSha, bMode, newPath2);
+		}
+
+	} else if ( oSha && aSha && bSha ) {
+		//
+		// case D: Modified in both, but differently.
+		//
+		output("Auto-merging %s\n", path);
+		struct merge_file_info mfi;
+		mfi = mergeFile(path, oSha, oMode,
+				path, aSha, aMode,
+				path, bSha, bMode,
+				branch1Name, branch2Name);
+
+		if ( mfi.clean )
+			updateFile(fp, 1, mfi.sha, mfi.mode, path);
+		else {
+			cleanMerge = 0;
+			output("CONFLICT (content): Merge conflict in %s", path);
+
+			if ( index_only )
+				updateFile(fp, 0, mfi.sha, mfi.mode, path);
+			else
+				updateFileExt(fp, mfi.sha, mfi.mode, path,
+					      0 /* updateCache */, 1 /* updateWd */);
+		}
+	} else
+		die("Fatal merge failure, shouldn't happen.");
+
+	if (pclose(fp))
+		die("updating entry failed in git update-index");
+	return cleanMerge;
+}
+
+struct merge_tree_result merge_trees(struct tree *head,
+				     struct tree *merge,
+				     struct tree *common,
+				     const char *branch1Name,
+				     const char *branch2Name)
+{
+	int code;
+	struct merge_tree_result result = { NULL, 0 };
+	if ( !memcmp(common->object.sha1, merge->object.sha1, 20) ) {
+		output("Already uptodate!");
+		result.tree = head;
+		result.clean = 1;
+		return result;
+	}
+
+	code = git_merge_trees(index_only ? "-i": "-u", common, head, merge);
+
+	if ( code != 0 )
+		die("merging of trees %s and %s failed",
+		    sha1_to_hex(head->object.sha1),
+		    sha1_to_hex(merge->object.sha1));
+
+	result.tree = git_write_tree();
+
+	if ( !result.tree ) {
+		struct path_list filesM = {NULL, 0, 0}, dirsM = {NULL, 0, 0};
+
+		getFilesAndDirs(head, &currentFileSet, &currentDirectorySet);
+		getFilesAndDirs(merge, &filesM, &dirsM);
+
+		path_list_union_update(&currentFileSet, &filesM);
+		path_list_union_update(&currentDirectorySet, &dirsM);
+
+		struct index_entry *entries = unmergedCacheEntries();
+		struct rename_entry *renamesHead, *renamesMerge;
+		renamesHead  = getRenames(head, common, head, merge, &entries);
+		renamesMerge = getRenames(merge, common, head, merge, &entries);
+		result.clean = processRenames(renamesHead, renamesMerge,
+					      branch1Name, branch2Name);
+		struct index_entry *e;
+		for ( e = entries; e; e = e->next ) {
+			if ( e->processed )
+				continue;
+			if ( !processEntry(e, branch1Name, branch2Name) )
+				result.clean = 0;
+			if ( result.clean || index_only )
+				result.tree = git_write_tree();
+			else
+				result.tree = NULL;
+		}
+		free_rename_entries(&renamesMerge);
+		free_rename_entries(&renamesHead);
+		free_index_entries(&entries);
+	} else {
+		result.clean = 1;
+		printf("merging of trees %s and %s resulted in %s\n",
+		       sha1_to_hex(head->object.sha1),
+		       sha1_to_hex(merge->object.sha1),
+		       sha1_to_hex(result.tree->object.sha1));
+	}
+
+	return result;
+}
+
+static void collect_nodes(struct node *node, struct node_list **res)
+{
+    node_list_insert(node, res);
+    struct node_list *p;
+    for ( p = node->parents; p; p = p->next )
+	collect_nodes(node, res);
+}
+
+struct node_list *reachable_nodes(struct node *n1, struct node *n2)
+{
+    struct node_list *res = NULL;
+    collect_nodes(n1, &res);
+    collect_nodes(n2, &res);
+    return res;
+}
+
+struct graph *graph_build(struct node_list *commits)
+{
+	struct graph *graph = malloc(sizeof(struct graph));
+	memset(graph->commits, 0, sizeof(graph->commits));
+
+	char cmd[256];
+	strcpy(cmd, "git-rev-list --parents");
+	struct node_list *cp;
+	for_each_node_list(cp,commits) {
+		graph_add_node(graph, cp->node);
+		strcat(cmd, " ");
+		strcat(cmd, node_hex_sha1(cp->node));
+	}
+	assert(strlen(cmd) < sizeof(cmd));
+
+	FILE *fp = popen(cmd, "r");
+	if (!fp)
+		die("%s failed: %s", cmd, strerror(errno));
+	while (!feof(fp)) {
+		unsigned char sha[20];
+		int ch;
+		if (fget_sha1(sha, fp, &ch))
+			break;
+		if (EOF == ch)
+			break;
+		// a commit
+		struct node *node = graph_node_bysha(graph, sha);
+		if (!node)
+		{
+			node = node_alloc(lookup_commit(sha));
+			graph_add_node(graph, node);
+		}
+		// ...and its parents. I assume a parent cannot be mentioned
+		// before the children.
+		struct node_list *parents = NULL;
+		while ('\n' != ch) {
+			if (fget_sha1(sha, fp, &ch)) {
+				die("invalid output from %s, "
+				    "sha1 (parents) expected",
+				    cmd);
+				break;
+			}
+			if (EOF == ch)
+				break;
+			struct node *pn = graph_node_bysha(graph, sha);
+			if (!pn) {
+				pn = node_alloc(lookup_commit(sha));
+				graph_add_node(graph, pn);
+			}
+			node_list_insert(pn, &parents);
+		}
+		node_set_parents(node, parents);
+	}
+	pclose(fp);
+	return graph;
+}
+
+static int get_sha1_0(const char *ref, unsigned char *sha)
+{
+	size_t n = strlen(ref);
+	char *t = xmalloc(n + 4);
+	memcpy(t, ref, n);
+	strcpy(t + n, "^0");
+	int rc = get_sha1(t, sha);
+	free(t);
+	return rc;
+}
+
+int main(int argc, char *argv[])
+{
+	static const char *bases[2];
+	static unsigned bases_count = 0;
+
+	original_index_file = getenv("GIT_INDEX_FILE");
+
+	if (!original_index_file)
+		original_index_file = strdup(git_path("index"));
+
+	temporary_index_file = strdup(git_path("mrg-rcrsv-tmp-idx"));
+
+	if (argc < 4)
+		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
+
+	int i;
+	for (i = 1; i < argc; ++i) {
+		if (!strcmp(argv[i], "--"))
+			break;
+		if (bases_count < sizeof(bases)/sizeof(*bases))
+			bases[bases_count++] = argv[i];
+	}
+	if (argc - i != 3) /* "--" "<head>" "<remote>" */
+		die("Not handling anything other than two heads merge.");
+
+	unsigned char sha1[20], sha2[20];
+	const char *branch1, *branch2;
+
+	branch1 = argv[++i];
+	if (get_sha1_0(branch1, sha1) != 0)
+		die("invalid first branch %s", branch1);
+
+	branch2 = argv[++i];
+	if (get_sha1_0(branch2, sha2) != 0)
+		die("invalid second branch %s", branch2);
+
+	printf("Merging %s with %s\n", branch1, branch2);
+
+	struct merge_result result;
+	struct node *h1 = node_alloc(lookup_commit(sha1));
+	struct node *h2 = node_alloc(lookup_commit(sha2));
+
+	if (bases_count == 1) {
+		unsigned char shabase[20];
+		if (get_sha1_0(bases[0], shabase) != 0)
+			die("invalid base commit %s", bases[0]);
+		struct node *ancestor = node_alloc(lookup_commit(shabase));
+		result = merge(h1, h2, branch1, branch2, NULL, 0, ancestor);
+	} else {
+		struct node_list *commits = NULL;
+		node_list_insert(h1, &commits);
+		node_list_insert(h2, &commits->next);
+		struct graph *graph = graph_build(commits);
+		result = merge(h1, h2, branch1, branch2, graph, 0, NULL);
+	}
+	return result.clean ? 0: 1;
+}
+
+// vim: sw=8 noet
diff --git a/path-list.c b/path-list.c
new file mode 100644
index 0000000..fbfc103
--- /dev/null
+++ b/path-list.c
@@ -0,0 +1,110 @@
+#include <stdio.h>
+#include "cache.h"
+#include "path-list.h"
+
+/* if there is no exact match, point to the index where the entry could be
+ * inserted */
+static int get_entry_index(const struct path_list *container, const char *path,
+		int *exact_match)
+{
+	int left = -1, right = container->nr;
+
+	while (left + 1 < right) {
+		int middle = (left + right) / 2;
+		int compare = strcmp(path, container->paths[middle]);
+		if (compare < 0)
+			right = middle;
+		else if (compare > 0)
+			left = middle;
+		else {
+			*exact_match = 1;
+			return middle;
+		}
+	}
+
+	*exact_match = 0;
+	return right;
+}
+
+/* returns -1-index if already exists */
+static int add_entry(struct path_list *container, const char *path)
+{
+	int exact_match;
+	int index = get_entry_index(container, path, &exact_match);
+
+	if (exact_match)
+		return -1 - index;
+
+	if (container->nr + 1 >= container->alloc) {
+		container->alloc += 32;
+		container->paths = realloc(container->paths,
+				container->alloc * sizeof(char *));
+	}
+	if (index < container->nr)
+		memmove(container->paths + index + 1,
+				container->paths + index,
+				(container->nr - index) * sizeof(char *));
+	container->paths[index] = strdup(path);
+	container->nr++;
+
+	return index;
+}
+
+char *path_list_insert(char *path, struct path_list *list)
+{
+	int index = add_entry(list, path);
+
+	if (index < 0)
+		index = 1 - index;
+
+	return list->paths[index];
+}
+
+int path_list_has_path(const struct path_list *list, const char *path)
+{
+	int exact_match;
+	get_entry_index(list, path, &exact_match);
+	return exact_match;
+}
+
+// in place
+void path_list_union_update(struct path_list *dst, const struct path_list *src)
+{
+	char **new_paths;
+	int i = 0, j = 0, nr = 0, alloc = dst->nr + dst->nr;
+
+	new_paths = xcalloc(sizeof(char *), alloc);
+
+	while (i < dst->nr || j < src->nr) {
+		char **entry = new_paths + nr++;
+		if (i == dst->nr)
+			*entry = src->paths[j++];
+		else if (j == src->nr)
+			*entry = dst->paths[i++];
+		else {
+			int compare = strcmp(dst->paths[i], src->paths[j]);
+			if (compare > 0)
+				*entry = src->paths[j++];
+			else {
+				*entry = dst->paths[i++];
+				if (!compare)
+					free(src->paths[j++]);
+			}
+		}
+	}
+
+	free(dst->paths);
+	dst->paths = new_paths;
+	dst->nr = nr;
+	dst->alloc = alloc;
+}
+
+void print_path_list(const char *text, const struct path_list *p)
+{
+	int i;
+	if ( text )
+		printf("%s\n", text);
+	for (i = 0; i < p->nr; i++)
+		printf("%s\n", p->paths[i]);
+}
+
diff --git a/path-list.h b/path-list.h
new file mode 100644
index 0000000..a12c7a4
--- /dev/null
+++ b/path-list.h
@@ -0,0 +1,32 @@
+#ifndef _PATH_LIST_H_
+#define _PATH_LIST_H_
+
+struct path_list
+{
+    char **paths;
+    unsigned int nr, alloc;
+};
+
+#define for_each_path(p,list) for ( p = (list)->paths; p != (list)->paths + (list)->nr; p++ )
+
+void print_path_list(const char *text, const struct path_list *p);
+
+#define path_list_count(list) (list)->nr
+
+int path_list_has_path(const struct path_list *list, const char *path);
+void path_list_union_update(struct path_list *dst, const struct path_list *src);
+static inline void path_list_clear(struct path_list *list, int free_paths)
+{
+	if (list->paths) {
+		int i;
+		if (free_paths)
+			for (i = 0; i < list->nr; i++)
+				free(list->paths[i]);
+		free(list->paths);
+	}
+	list->paths = NULL;
+	list->nr = list->alloc = 0;
+}
+char *path_list_insert(char *path, struct path_list *list);
+
+#endif /* _PATH_LIST_H_ */
