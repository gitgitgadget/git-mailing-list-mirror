From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] attribute macro support
Date: Sat, 14 Apr 2007 18:01:13 -0700
Message-ID: <7v8xcu78o6.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	<200704131033.15751.andyparkins@gmail.com>
	<7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 03:01:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hct7G-00045D-1a
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 03:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXDOBBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 21:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbXDOBBP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 21:01:15 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43023 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbXDOBBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 21:01:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415010114.XCFN1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Apr 2007 21:01:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nD1D1W0011kojtg0000000; Sat, 14 Apr 2007 21:01:13 -0400
In-Reply-To: <7vejmm78qp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 14 Apr 2007 17:59:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44477>

This adds "attribute macros" (for lack of better name).  So far,
we have low-level attributes such as crlf and diff, which are
defined in operational terms --- setting or unsetting them on a
particular path directly affects what is done to the path.  For
example, in order to decline diffs or crlf conversions on a
binary blob, no diffs on PostScript files, and treat all other
files normally, you would have something like these:

	*		diff crlf
	*.ps		!diff
	proprietary.o	!diff !crlf

That is fine as the operation goes, but gets unwieldy rather
rapidly, when we start adding more low-level attributes that are
defined in operational terms.  A near-term example of such an
attribute would be 'merge-3way' which would control if git
should attempt the usual 3-way file-level merge internally, or
leave merging to a specialized external program of user's
choice.  When it is added, we do _not_ want to force the users
to update the above to:

	*		diff crlf merge-3way
	*.ps		!diff
	proprietary.o	!diff !crlf !merge-3way

The way this patch solves this issue is to realize that the
attributes the user is assigning to paths are not defined in
terms of operations but in terms of what they are.

All of the three low-level attributes usually make sense for
most of the files that sane SCM users have git operate on (these
files are typically called "text').  Only a few cases, such as
binary blob, need exception to decline the "usual treatment
given to text files" -- and people mark them as "binary".

So this allows the $GIT_DIR/info/alternates and .gitattributes
at the toplevel of the project to also specify attributes that
assigns other attributes.  The syntax is '[attr]' followed by an
attribute name followed by a list of attribute names:

	[attr] binary	!diff !crlf !merge-3way

When "binary" attribute is set to a path, if the path has not
got diff/crlf/merge-3way attribute set or unset by other rules,
this rule unsets the three low-level attributes.

It is expected that the user level .gitattributes will be
expressed mostly in terms of attributes based on what the files
are, and the above sample would become like this:

	(built-in attribute configuration)
	[attr] binary	!diff !crlf !merge-3way
	*		diff crlf merge-3way

	(project specific .gitattributes)
	proprietary.o	binary

	(user preference $GIT_DIR/info/attributes)
	*.ps		!diff

There are a few caveats.

 * As described above, you can define these macros only in
   $GIT_DIR/info/attributes and toplevel .gitattributes.

 * There is no attempt to detect circular definition of macro
   attributes, and definitions are evaluated from bottom to top
   as usual to fill in other attributes that have not yet got
   values.  The following would work as expected:

	[attr] text	diff crlf
	[attr] ps	text !diff
	*.ps	ps

   while this would most likely not (I haven't tried):

	[attr] ps	text !diff
	[attr] text	diff crlf
	*.ps	ps

 * When a macro says "[attr] A B !C", saying that a path does
   not have attribute A does not let you tell anything about
   attributes B or C.  That is, given this:

	[attr] text	diff crlf
	[attr] ps	text !diff
	*.txt !ps

  path hello.txt, which would match "*.txt" pattern, would have
  "ps" attribute set to zero, but that does not make text
  attribute of hello.txt set to false (nor diff attribute set to
  true).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 attr.c  |  140 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
 cache.h |    1 +
 2 files changed, 108 insertions(+), 33 deletions(-)

diff --git a/attr.c b/attr.c
index 7435d92..3a14df1 100644
--- a/attr.c
+++ b/attr.c
@@ -16,9 +16,12 @@
 struct git_attr {
 	struct git_attr *next;
 	unsigned h;
+	int attr_nr;
 	char name[FLEX_ARRAY];
 };
+static int attr_nr;
 
+static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 static unsigned hash_name(const char *name, int namelen)
@@ -50,7 +53,12 @@ struct git_attr *git_attr(const char *name, int len)
 	a->name[len] = 0;
 	a->h = hval;
 	a->next = git_attr_hash[pos];
+	a->attr_nr = attr_nr++;
 	git_attr_hash[pos] = a;
+
+	check_all_attr = xrealloc(check_all_attr,
+				  sizeof(*check_all_attr) * attr_nr);
+	check_all_attr[a->attr_nr].attr = a;
 	return a;
 }
 
@@ -69,26 +77,46 @@ struct attr_state {
 };
 
 struct match_attr {
-	char *pattern;
+	union {
+		char *pattern;
+		struct git_attr *attr;
+	} u;
+	char is_macro;
 	unsigned num_attr;
 	struct attr_state state[FLEX_ARRAY];
 };
 
 static const char blank[] = " \t\r\n";
 
-static struct match_attr *parse_attr_line(const char *line)
+static struct match_attr *parse_attr_line(const char *line, const char *src,
+					  int lineno, int macro_ok)
 {
 	int namelen;
 	int num_attr;
 	const char *cp, *name;
 	struct match_attr *res = res;
 	int pass;
+	int is_macro;
 
 	cp = line + strspn(line, blank);
 	if (!*cp || *cp == '#')
 		return NULL;
 	name = cp;
 	namelen = strcspn(name, blank);
+	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
+	    !prefixcmp(name, ATTRIBUTE_MACRO_PREFIX)) {
+		if (!macro_ok) {
+			fprintf(stderr, "%s not allowed: %s:%d\n",
+				name, src, lineno);
+			return NULL;
+		}
+		is_macro = 1;
+		name += strlen(ATTRIBUTE_MACRO_PREFIX);
+		name += strspn(name, blank);
+		namelen = strcspn(name, blank);
+	}
+	else
+		is_macro = 0;
 
 	for (pass = 0; pass < 2; pass++) {
 		/* pass 0 counts and allocates, pass 1 fills */
@@ -113,13 +141,19 @@ static struct match_attr *parse_attr_line(const char *line)
 		}
 		if (pass)
 			break;
+
 		res = xcalloc(1,
 			      sizeof(*res) +
 			      sizeof(struct attr_state) * num_attr +
-			      namelen + 1);
-		res->pattern = (char*)&(res->state[num_attr]);
-		memcpy(res->pattern, name, namelen);
-		res->pattern[namelen] = 0;
+			      (is_macro ? 0 : namelen + 1));
+		if (is_macro)
+			res->u.attr = git_attr(name, namelen);
+		else {
+			res->u.pattern = (char*)&(res->state[num_attr]);
+			memcpy(res->u.pattern, name, namelen);
+			res->u.pattern[namelen] = 0;
+		}
+		res->is_macro = is_macro;
 		res->num_attr = num_attr;
 	}
 	return res;
@@ -167,10 +201,13 @@ static struct attr_stack *read_attr_from_array(const char **list)
 {
 	struct attr_stack *res;
 	const char *line;
+	int lineno = 0;
 
 	res = xcalloc(1, sizeof(*res));
 	while ((line = *(list++)) != NULL) {
-		struct match_attr *a = parse_attr_line(line);
+		struct match_attr *a;
+
+		a = parse_attr_line(line, "[builtin]", ++lineno, 1);
 		if (!a)
 			continue;
 		res->attrs = xrealloc(res->attrs, res->num_matches + 1);
@@ -179,11 +216,12 @@ static struct attr_stack *read_attr_from_array(const char **list)
 	return res;
 }
 
-static struct attr_stack *read_attr_from_file(const char *path)
+static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 {
 	FILE *fp;
 	struct attr_stack *res;
 	char buf[2048];
+	int lineno = 0;
 
 	res = xcalloc(1, sizeof(*res));
 	fp = fopen(path, "r");
@@ -191,7 +229,9 @@ static struct attr_stack *read_attr_from_file(const char *path)
 		return res;
 
 	while (fgets(buf, sizeof(buf), fp)) {
-		struct match_attr *a = parse_attr_line(buf);
+		struct match_attr *a;
+
+		a = parse_attr_line(buf, path, ++lineno, macro_ok);
 		if (!a)
 			continue;
 		res->attrs = xrealloc(res->attrs, res->num_matches + 1);
@@ -206,11 +246,17 @@ static void debug_info(const char *what, struct attr_stack *elem)
 {
 	fprintf(stderr, "%s: %s\n", what, elem->origin ? elem->origin : "()");
 }
+static void debug_set(const char *what, const char *match, struct git_attr *attr, int set)
+{
+	fprintf(stderr, "%s: %s => %d (%s)\n",
+		what, attr->name, set, match);
+}
 #define debug_push(a) debug_info("push", (a))
 #define debug_pop(a) debug_info("pop", (a))
 #else
 #define debug_push(a) do { ; } while (0)
 #define debug_pop(a) do { ; } while (0)
+#define debug_set(a,b,c,d) do { ; } while (0)
 #endif
 
 static void prepare_attr_stack(const char *path, int dirlen)
@@ -238,13 +284,13 @@ static void prepare_attr_stack(const char *path, int dirlen)
 		elem->prev = attr_stack;
 		attr_stack = elem;
 
-		elem = read_attr_from_file(GITATTRIBUTES_FILE);
+		elem = read_attr_from_file(GITATTRIBUTES_FILE, 1);
 		elem->origin = strdup("");
 		elem->prev = attr_stack;
 		attr_stack = elem;
 		debug_push(elem);
 
-		elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE));
+		elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
 		elem->origin = NULL;
 		elem->prev = attr_stack;
 		attr_stack = elem;
@@ -286,7 +332,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 		memcpy(pathbuf + dirlen, "/", 2);
 		cp = strchr(pathbuf + len + 1, '/');
 		strcpy(cp + 1, GITATTRIBUTES_FILE);
-		elem = read_attr_from_file(pathbuf);
+		elem = read_attr_from_file(pathbuf, 0);
 		*cp = '\0';
 		elem->origin = strdup(pathbuf);
 		elem->prev = attr_stack;
@@ -324,31 +370,26 @@ static int path_matches(const char *pathname, int pathlen,
 	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
 }
 
-/*
- * I do not like this at all.  Only because we allow individual
- * attribute to be set or unset incrementally by individual
- * lines in .gitattribute files, we need to do this triple
- * loop which looks quite wasteful.
- */
-static int fill(const char *path, int pathlen,
-		struct attr_stack *stk, struct git_attr_check *check,
-		int num, int rem)
+static int fill(const char *path, int pathlen, struct attr_stack *stk, int rem)
 {
-	int i, j, k;
 	const char *base = stk->origin ? stk->origin : "";
+	int i, j;
+	struct git_attr_check *check = check_all_attr;
 
 	for (i = stk->num_matches - 1; 0 < rem && 0 <= i; i--) {
 		struct match_attr *a = stk->attrs[i];
+		if (a->is_macro)
+			continue;
 		if (path_matches(path, pathlen,
-				 a->pattern, base, strlen(base))) {
-			for (j = 0; j < a->num_attr; j++) {
+				 a->u.pattern, base, strlen(base))) {
+			for (j = 0; 0 < rem && j < a->num_attr; j++) {
 				struct git_attr *attr = a->state[j].attr;
 				int set = !a->state[j].unset;
-				for (k = 0; k < num; k++) {
-					if (0 <= check[k].isset ||
-					    check[k].attr != attr)
-						continue;
-					check[k].isset = set;
+				int *n = &(check[attr->attr_nr].isset);
+
+				if (*n < 0) {
+					debug_set("fill", a->u.pattern, attr, set);
+					*n = set;
 					rem--;
 				}
 			}
@@ -357,14 +398,40 @@ static int fill(const char *path, int pathlen,
 	return rem;
 }
 
+static int macroexpand(struct attr_stack *stk, int rem)
+{
+	int i, j;
+	struct git_attr_check *check = check_all_attr;
+
+	for (i = stk->num_matches - 1; 0 < rem && 0 <= i; i--) {
+		struct match_attr *a = stk->attrs[i];
+		if (!a->is_macro)
+			continue;
+		if (check[a->u.attr->attr_nr].isset < 0)
+			continue;
+		for (j = 0; 0 < rem && j < a->num_attr; j++) {
+			struct git_attr *attr = a->state[j].attr;
+			int set = !a->state[j].unset;
+			int *n = &(check[attr->attr_nr].isset);
+
+			if (*n < 0) {
+				debug_set("expand", a->u.attr->name, attr, set);
+				*n = set;
+				rem--;
+			}
+		}
+	}
+	return rem;
+}
+
 int git_checkattr(const char *path, int num, struct git_attr_check *check)
 {
 	struct attr_stack *stk;
 	const char *cp;
 	int dirlen, pathlen, i, rem;
 
-	for (i = 0; i < num; i++)
-		check[i].isset = -1;
+	for (i = 0; i < attr_nr; i++)
+		check_all_attr[i].isset = -1;
 
 	pathlen = strlen(path);
 	cp = strrchr(path, '/');
@@ -373,8 +440,15 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 	else
 		dirlen = cp - path;
 	prepare_attr_stack(path, dirlen);
-	rem = num;
+	rem = attr_nr;
+	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
+		rem = fill(path, pathlen, stk, rem);
+
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
-		rem = fill(path, pathlen, stk, check, num, rem);
+		rem = macroexpand(stk, rem);
+
+	for (i = 0; i < num; i++)
+		check[i].isset = check_all_attr[check[i].attr->attr_nr].isset;
+
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 63af43f..38ad006 100644
--- a/cache.h
+++ b/cache.h
@@ -153,6 +153,7 @@ enum object_type {
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
+#define ATTRIBUTE_MACRO_PREFIX "[attr]"
 
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
-- 
1.5.1.1.810.gac3a
