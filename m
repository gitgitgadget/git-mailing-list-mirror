From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] builtin-grep: do not use setup_revisions()
Date: Mon, 01 May 2006 16:24:35 -0700
Message-ID: <7vodyhqqfg.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
	<20060501140410.GA3505@mars.ravnborg.org>
	<20060501140704.GA6096@mars.ravnborg.org>
	<20060501145328.GA14856@mars.ravnborg.org>
	<Pine.LNX.4.64.0605010842130.21189@g5.osdl.org>
	<7v64kpsftv.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 01:24:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fahkv-00081e-44
	for gcvg-git@gmane.org; Tue, 02 May 2006 01:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWEAXYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 19:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWEAXYh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 19:24:37 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:21242 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932316AbWEAXYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 19:24:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060501232436.ZYCZ27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 May 2006 19:24:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v64kpsftv.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 01 May 2006 12:30:36 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19394>

Grep may want to grok multiple revisions, but it does not make
much sense to walk revisions while doing so.  This stops calling
the code to parse parameters for the revision walker.  The
parameter parsing for the optional "-e" option becomes a lot
simpler with it as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Junio C Hamano <junkio@cox.net> writes:

  >  * Still haven't improved the "-e" issue (and to a lesser extent
  >    I think requiring -- is not right in this context either),...

  So I did this.  This removes the ability to say:

  	git grep master..next -e foobar -- Documentation

  but if you want to walk the revision graph, you are interested
  in commits that actually changes things to be subject to grep,
  not just all commits in the range, so if that is what you are
  doing, you are better off using the pickaxe.

 builtin-grep.c |  255 +++++++++++++++++++++++++++++---------------------------
 1 files changed, 134 insertions(+), 121 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index c3e6701..4be1514 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -8,8 +8,7 @@ #include "blob.h"
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
-#include "diff.h"
-#include "revision.h"
+#include "tree-walk.h"
 #include "builtin.h"
 #include <regex.h>
 #include <fnmatch.h>
@@ -18,15 +17,15 @@ #include <fnmatch.h>
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
  * pathname wildcards are allowed.
  */
-static int pathspec_matches(struct diff_options *opt, const char *name)
+static int pathspec_matches(const char **paths, const char *name)
 {
 	int namelen, i;
-	if (!opt->nr_paths)
+	if (!paths || !*paths)
 		return 1;
 	namelen = strlen(name);
-	for (i = 0; i < opt->nr_paths; i++) {
-		const char *match = opt->paths[i];
-		int matchlen = opt->pathlens[i];
+	for (i = 0; paths[i]; i++) {
+		const char *match = paths[i];
+		int matchlen = strlen(match);
 		const char *slash, *cp;
 
 		if ((matchlen <= namelen) &&
@@ -241,7 +240,7 @@ static int grep_file(struct grep_opt *op
 	return i;
 }
 
-static int grep_cache(struct grep_opt *opt, struct rev_info *revs, int cached)
+static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 {
 	int hit = 0;
 	int nr;
@@ -251,7 +250,7 @@ static int grep_cache(struct grep_opt *o
 		struct cache_entry *ce = active_cache[nr];
 		if (ce_stage(ce) || !S_ISREG(ntohl(ce->ce_mode)))
 			continue;
-		if (!pathspec_matches(&revs->diffopt, ce->name))
+		if (!pathspec_matches(paths, ce->name))
 			continue;
 		if (cached)
 			hit |= grep_sha1(opt, ce->sha1, ce->name);
@@ -261,7 +260,7 @@ static int grep_cache(struct grep_opt *o
 	return hit;
 }
 
-static int grep_tree(struct grep_opt *opt, struct rev_info *revs,
+static int grep_tree(struct grep_opt *opt, const char **paths,
 		     struct tree_desc *tree,
 		     const char *tree_name, const char *base)
 {
@@ -297,7 +296,7 @@ static int grep_tree(struct grep_opt *op
 			 */
 			strcpy(path_buf + len + pathlen, "/");
 
-		if (!pathspec_matches(&revs->diffopt, down))
+		if (!pathspec_matches(paths, down))
 			;
 		else if (S_ISREG(mode))
 			hit |= grep_sha1(opt, sha1, path_buf);
@@ -310,7 +309,7 @@ static int grep_tree(struct grep_opt *op
 				die("unable to read tree (%s)",
 				    sha1_to_hex(sha1));
 			sub.buf = data;
-			hit |= grep_tree(opt, revs, &sub, tree_name, down);
+			hit |= grep_tree(opt, paths, &sub, tree_name, down);
 			free(data);
 		}
 		update_tree_entry(tree);
@@ -318,7 +317,7 @@ static int grep_tree(struct grep_opt *op
 	return hit;
 }
 
-static int grep_object(struct grep_opt *opt, struct rev_info *revs,
+static int grep_object(struct grep_opt *opt, const char **paths,
 		       struct object *obj, const char *name)
 {
 	if (!strcmp(obj->type, blob_type))
@@ -333,7 +332,7 @@ static int grep_object(struct grep_opt *
 		if (!data)
 			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
 		tree.buf = data;
-		hit = grep_tree(opt, revs, &tree, name, "");
+		hit = grep_tree(opt, paths, &tree, name, "");
 		free(data);
 		return hit;
 	}
@@ -345,102 +344,119 @@ static const char builtin_grep_usage[] =
 
 int cmd_grep(int argc, const char **argv, char **envp)
 {
-	struct rev_info rev;
-	const char **dst, **src;
 	int err;
 	int hit = 0;
-	int no_more_arg = 0;
-	int seen_range = 0;
+	int no_more_flags = 0;
 	int seen_noncommit = 0;
 	int cached = 0;
 	struct grep_opt opt;
-	struct object_list *list;
+	struct object_list *list, **tail, *object_list = NULL;
+	const char *prefix = setup_git_directory();
+	const char **paths = NULL;
 
 	memset(&opt, 0, sizeof(opt));
 	opt.regflags = REG_NEWLINE;
 
 	/*
-	 * Interpret and remove the grep options upfront.  Sigh...
+	 * No point using rev_info, really.
 	 */
-	for (dst = src = &argv[1]; src < argc + argv; ) {
-		const char *arg = *src++;
-		if (!no_more_arg) {
-			if (!strcmp("--", arg)) {
-				no_more_arg = 1;
-				*dst++ = arg;
-				continue;
-			}
-			if (!strcmp("--cached", arg)) {
-				cached = 1;
-				continue;
-			}
-			if (!strcmp("-i", arg) ||
-			    !strcmp("--ignore-case", arg)) {
-				opt.regflags |= REG_ICASE;
-				continue;
-			}
-			if (!strcmp("-v", arg) ||
-			    !strcmp("--invert-match", arg)) {
-				opt.invert = 1;
-				continue;
-			}
-			if (!strcmp("-E", arg) ||
-			    !strcmp("--extended-regexp", arg)) {
-				opt.regflags |= REG_EXTENDED;
-				continue;
-			}
-			if (!strcmp("-G", arg) ||
-			    !strcmp("--basic-regexp", arg)) {
-				opt.regflags &= ~REG_EXTENDED;
-				continue;
-			}
-			if (!strcmp("-e", arg)) {
-				if (src < argc + argv) {
-					opt.pattern = *src++;
-					continue;
-				}
+	while (1 < argc) {
+		const char *arg = argv[1];
+		argc--; argv++;
+		if (!strcmp("--cached", arg)) {
+			cached = 1;
+			continue;
+		}
+		if (!strcmp("-i", arg) ||
+		    !strcmp("--ignore-case", arg)) {
+			opt.regflags |= REG_ICASE;
+			continue;
+		}
+		if (!strcmp("-v", arg) ||
+		    !strcmp("--invert-match", arg)) {
+			opt.invert = 1;
+			continue;
+		}
+		if (!strcmp("-E", arg) ||
+		    !strcmp("--extended-regexp", arg)) {
+			opt.regflags |= REG_EXTENDED;
+			continue;
+		}
+		if (!strcmp("-G", arg) ||
+		    !strcmp("--basic-regexp", arg)) {
+			opt.regflags &= ~REG_EXTENDED;
+			continue;
+		}
+		if (!strcmp("-n", arg)) {
+			opt.linenum = 1;
+			continue;
+		}
+		if (!strcmp("-H", arg)) {
+			/* We always show the pathname, so this
+			 * is a noop.
+			 */
+			continue;
+		}
+		if (!strcmp("-l", arg) ||
+		    !strcmp("--files-with-matches", arg)) {
+			opt.name_only = 1;
+			continue;
+		}
+		if (!strcmp("-A", arg) ||
+		    !strcmp("-B", arg) ||
+		    !strcmp("-C", arg)) {
+			unsigned num;
+			if (argc <= 1 ||
+			    sscanf(*++argv, "%u", &num) != 1)
 				usage(builtin_grep_usage);
+			argc--;
+			switch (arg[1]) {
+			case 'A':
+				opt.post_context = num;
+				break;
+			case 'C':
+				opt.post_context = num;
+			case 'B':
+				opt.pre_context = num;
+				break;
 			}
-			if (!strcmp("-n", arg)) {
-				opt.linenum = 1;
-				continue;
-			}
-			if (!strcmp("-H", arg)) {
-				/* We always show the pathname, so this
-				 * is a noop.
+			continue;
+		}
+		if (!strcmp("-e", arg)) {
+			if (1 < argc) {
+				/* We probably would want to do
+				 * -e pat1 -e pat2 as well later...
 				 */
+				if (opt.pattern)
+					die("more than one pattern?");
+				opt.pattern = *++argv;
+				argc--;
 				continue;
 			}
-			if (!strcmp("-l", arg) ||
-			    !strcmp("--files-with-matches", arg)) {
-				opt.name_only = 1;
-				continue;
-			}
-			if (!strcmp("-A", arg) ||
-			    !strcmp("-B", arg) ||
-			    !strcmp("-C", arg)) {
-				unsigned num;
-				if ((argc + argv <= src) ||
-				    sscanf(*src++, "%u", &num) != 1)
-					usage(builtin_grep_usage);
-				switch (arg[1]) {
-				case 'A':
-					opt.post_context = num;
-					break;
-				case 'C':
-					opt.post_context = num;
-				case 'B':
-					opt.pre_context = num;
-					break;
-				}
-				continue;
-			}
+			usage(builtin_grep_usage);
+		}
+		if (!strcmp("--", arg)) {
+			no_more_flags = 1;
+			continue;
+		}
+		/* Either unrecognized option or a single pattern */
+		if (!no_more_flags && *arg == '-')
+			usage(builtin_grep_usage);
+		if (!opt.pattern) {
+			opt.pattern = arg;
+			break;
+		}
+		else {
+			/* We are looking at the first path or rev;
+			 * it is found at argv[0] after leaving the
+			 * loop.
+			 */
+			argc++; argv--;
+			break;
 		}
-		*dst++ = arg;
 	}
 	if (!opt.pattern)
 		die("no pattern given.");
-
 	err = regcomp(&opt.regexp, opt.pattern, opt.regflags);
 	if (err) {
 		char errbuf[1024];
@@ -448,11 +464,32 @@ int cmd_grep(int argc, const char **argv
 		regfree(&opt.regexp);
 		die("'%s': %s", opt.pattern, errbuf);
 	}
+	tail = &object_list;
+	while (1 < argc) {
+		struct object *object;
+		struct object_list *elem;
+		const char *arg = argv[1];
+		unsigned char sha1[20];
+		if (get_sha1(arg, sha1) < 0)
+			break;
+		object = parse_object(sha1);
+		if (!object)
+			die("bad object %s", arg);
+		elem = object_list_insert(object, tail);
+		elem->name = arg;
+		tail = &elem->next;
+		argc--; argv++;
+	}
+	if (1 < argc)
+		paths = get_pathspec(prefix, argv + 1);
+	else if (prefix) {
+		paths = xcalloc(2, sizeof(const char *));
+		paths[0] = prefix;
+		paths[1] = NULL;
+	}
 
-	init_revisions(&rev);
-	*dst = NULL;
-	argc = setup_revisions(dst - argv, argv, &rev, NULL);
-
+	if (!object_list)
+		return !grep_cache(&opt, paths, cached);
 	/*
 	 * Do not walk "grep -e foo master next pu -- Documentation/"
 	 * but do walk "grep -e foo master..next -- Documentation/".
@@ -460,43 +497,19 @@ int cmd_grep(int argc, const char **argv
 	 * "grep -e foo v1.0.0:Documentation/ master..next"
 	 * so detect that and complain.
 	 */
-	for (list = rev.pending_objects; list; list = list->next) {
+	for (list = object_list; list; list = list->next) {
 		struct object *real_obj;
-		if (list->item->flags & UNINTERESTING)
-			seen_range = 1;
 		real_obj = deref_tag(list->item, NULL, 0);
 		if (strcmp(real_obj->type, commit_type))
 			seen_noncommit = 1;
 	}
-	if (!rev.pending_objects)
-		return !grep_cache(&opt, &rev, cached);
 	if (cached)
 		die("both --cached and revisions given.");
 
-	if (seen_range && seen_noncommit)
-		die("both A..B and non commit are given.");
-	if (seen_range) {
-		struct commit *commit;
-		prepare_revision_walk(&rev);
-		while ((commit = get_revision(&rev)) != NULL) {
-			unsigned char *sha1 = commit->object.sha1;
-			const char *n = find_unique_abbrev(sha1, rev.abbrev);
-			char rev_name[41];
-			strcpy(rev_name, n);
-			if (grep_object(&opt, &rev, &commit->object, rev_name))
-				hit = 1;
-			commit->buffer = NULL;
-		}
-		return !hit;
-	}
-
-	/* all of them are non-commit; do not walk, and
-	 * do not lose their names.
-	 */
-	for (list = rev.pending_objects; list; list = list->next) {
+	for (list = object_list; list; list = list->next) {
 		struct object *real_obj;
 		real_obj = deref_tag(list->item, NULL, 0);
-		if (grep_object(&opt, &rev, real_obj, list->name))
+		if (grep_object(&opt, paths, real_obj, list->name))
 			hit = 1;
 	}
 	return !hit;
-- 
1.3.1.gd233
