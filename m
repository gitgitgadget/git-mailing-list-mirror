From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Allow more than true/false to attributes.
Date: Tue, 17 Apr 2007 01:08:35 -0700
Message-ID: <11767973183627-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 10:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdik1-0001Yq-UJ
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 10:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbXDQIIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 04:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbXDQIIm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 04:08:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43224 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXDQIIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 04:08:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417080838.RRHP1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Tue, 17 Apr 2007 04:08:38 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o88e1W01q1kojtg0000000; Tue, 17 Apr 2007 04:08:39 -0400
X-Mailer: git-send-email 1.5.1.1.125.g402f-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44740>

This allows you to define three values (and possibly more) to
each attribute: true, false, and unset.

Typically the handlers that notice and act on attribute values
treat "unset" attribute to mean "do your default thing"
(e.g. crlf that is unset would trigger "guess from contents"),
so being able to override a setting to an unset state is
actually useful.

 - If you want to set the attribute value to true, have an entry
   in .gitattributes file that mentions the attribute name; e.g.

	*.o	binary

 - If you want to set the attribute value explicitly to false,
   use '-'; e.g.

	*.a	-diff

 - If you want to make the attribute value _unset_, perhaps to
   override an earlier entry, use '!'; e.g.

	*.a	-diff
	c.i.a	!diff

This also allows string values to attributes, with the natural
syntax:

	attrname=attrvalue

but you cannot use it, as nobody takes notice and acts on
it yet.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 attr.c               |  194 +++++++++++++++++++++++++++++++------------------
 attr.h               |   12 +++-
 builtin-check-attr.c |   14 +++-
 convert.c            |   16 ++++-
 diff.c               |   15 +++-
 5 files changed, 169 insertions(+), 82 deletions(-)

diff --git a/attr.c b/attr.c
index 60fe48f..b3496a6 100644
--- a/attr.c
+++ b/attr.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "attr.h"
 
+#define ATTR__UNKNOWN	((void *) -2)
+
 /*
  * The basic design decision here is that we are not going to have
  * insanely large number of attributes.
@@ -83,6 +85,7 @@ struct git_attr *git_attr(const char *name, int len)
 	check_all_attr = xrealloc(check_all_attr,
 				  sizeof(*check_all_attr) * attr_nr);
 	check_all_attr[a->attr_nr].attr = a;
+	check_all_attr[a->attr_nr].value = ATTR__UNKNOWN;
 	return a;
 }
 
@@ -92,12 +95,14 @@ struct git_attr *git_attr(const char *name, int len)
  * (1) glob pattern.
  * (2) whitespace
  * (3) whitespace separated list of attribute names, each of which
- *     could be prefixed with '-' to mean "not set".
+ *     could be prefixed with '-' to mean "set to false", '!' to mean
+ *     "unset".
  */
 
+/* What does a matched pattern decide? */
 struct attr_state {
-	int unset;
 	struct git_attr *attr;
+	void *setto;
 };
 
 struct match_attr {
@@ -112,13 +117,63 @@ struct match_attr {
 
 static const char blank[] = " \t\r\n";
 
+static const char *parse_attr(const char *src, int lineno, const char *cp,
+			      int *num_attr, struct match_attr *res)
+{
+	const char *ep, *equals;
+	int len;
+
+	ep = cp + strcspn(cp, blank);
+	equals = strchr(cp, '=');
+	if (equals && ep < equals)
+		equals = NULL;
+	if (equals)
+		len = equals - cp;
+	else
+		len = ep - cp;
+	if (!res) {
+		if (*cp == '-' || *cp == '!') {
+			cp++;
+			len--;
+		}
+		if (invalid_attr_name(cp, len)) {
+			fprintf(stderr,
+				"%.*s is not a valid attribute name: %s:%d\n",
+				len, cp, src, lineno);
+			return NULL;
+		}
+	} else {
+		struct attr_state *e;
+
+		e = &(res->state[*num_attr]);
+		if (*cp == '-' || *cp == '!') {
+			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
+			cp++;
+			len--;
+		}
+		else if (!equals)
+			e->setto = ATTR__TRUE;
+		else {
+			char *value;
+			int vallen = ep - equals;
+			value = xmalloc(vallen);
+			memcpy(value, equals+1, vallen-1);
+			value[vallen-1] = 0;
+			e->setto = value;
+		}
+		e->attr = git_attr(cp, len);
+	}
+	(*num_attr)++;
+	return ep + strspn(ep, blank);
+}
+
 static struct match_attr *parse_attr_line(const char *line, const char *src,
 					  int lineno, int macro_ok)
 {
 	int namelen;
 	int num_attr;
 	const char *cp, *name;
-	struct match_attr *res = res;
+	struct match_attr *res = NULL;
 	int pass;
 	int is_macro;
 
@@ -153,42 +208,16 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		num_attr = 0;
 		cp = name + namelen;
 		cp = cp + strspn(cp, blank);
-		while (*cp) {
-			const char *ep;
-			ep = cp + strcspn(cp, blank);
-			if (!pass) {
-				if (*cp == '-')
-					cp++;
-				if (invalid_attr_name(cp, ep - cp)) {
-					fprintf(stderr,
-						"%.*s is not a valid attribute name: %s:%d\n",
-						(int)(ep - cp), cp,
-						src, lineno);
-					return NULL;
-				}
-			} else {
-				struct attr_state *e;
-
-				e = &(res->state[num_attr]);
-				if (*cp == '-') {
-					e->unset = 1;
-					cp++;
-				}
-				e->attr = git_attr(cp, ep - cp);
-			}
-			num_attr++;
-			cp = ep + strspn(ep, blank);
-		}
+		while (*cp)
+			cp = parse_attr(src, lineno, cp, &num_attr, res);
 		if (pass)
 			break;
-
 		res = xcalloc(1,
 			      sizeof(*res) +
 			      sizeof(struct attr_state) * num_attr +
 			      (is_macro ? 0 : namelen + 1));
-		if (is_macro) {
+		if (is_macro)
 			res->u.attr = git_attr(name, namelen);
-		}
 		else {
 			res->u.pattern = (char*)&(res->state[num_attr]);
 			memcpy(res->u.pattern, name, namelen);
@@ -205,9 +234,9 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * come from many places.
  *
  * (1) .gitattribute file of the same directory;
- * (2) .gitattribute file of the parent directory if (1) does not have any match;
- *     this goes recursively upwards, just like .gitignore
- * (3) perhaps $GIT_DIR/info/attributes, as the final fallback.
+ * (2) .gitattribute file of the parent directory if (1) does not have
+ *      any match; this goes recursively upwards, just like .gitignore.
+ * (3) $GIT_DIR/info/attributes, which overrides both of the above.
  *
  * In the same file, later entries override the earlier match, so in the
  * global list, we would have entries from info/attributes the earliest
@@ -229,8 +258,21 @@ static void free_attr_elem(struct attr_stack *e)
 {
 	int i;
 	free(e->origin);
-	for (i = 0; i < e->num_matches; i++)
-		free(e->attrs[i]);
+	for (i = 0; i < e->num_matches; i++) {
+		struct match_attr *a = e->attrs[i];
+		int j;
+		for (j = 0; j < a->num_attr; j++) {
+			void *setto = a->state[j].setto;
+			if (setto == ATTR__TRUE ||
+			    setto == ATTR__FALSE ||
+			    setto == ATTR__UNSET ||
+			    setto == ATTR__UNKNOWN)
+				;
+			else
+				free(setto);
+		}
+		free(a);
+	}
 	free(e);
 }
 
@@ -288,10 +330,19 @@ static void debug_info(const char *what, struct attr_stack *elem)
 {
 	fprintf(stderr, "%s: %s\n", what, elem->origin ? elem->origin : "()");
 }
-static void debug_set(const char *what, const char *match, struct git_attr *attr, int set)
+static void debug_set(const char *what, const char *match, struct git_attr *attr, void *v)
 {
-	fprintf(stderr, "%s: %s => %d (%s)\n",
-		what, attr->name, set, match);
+	const char *value = v;
+
+	if (ATTR_TRUE(value))
+		value = "set";
+	else if (ATTR_FALSE(value))
+		value = "unset";
+	else if (ATTR_UNSET(value))
+		value = "unspecified";
+
+	fprintf(stderr, "%s: %s => %s (%s)\n",
+		what, attr->name, (char *) value, match);
 }
 #define debug_push(a) debug_info("push", (a))
 #define debug_pop(a) debug_info("pop", (a))
@@ -420,56 +471,53 @@ static int path_matches(const char *pathname, int pathlen,
 	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
 }
 
+static int fill_one(const char *what, struct match_attr *a, int rem)
+{
+	struct git_attr_check *check = check_all_attr;
+	int i;
+
+	for (i = 0; 0 < rem && i < a->num_attr; i++) {
+		struct git_attr *attr = a->state[i].attr;
+		void **n = &(check[attr->attr_nr].value);
+		void *v = a->state[i].setto;
+
+		if (*n == ATTR__UNKNOWN) {
+			debug_set(what, a->u.pattern, attr, v);
+			*n = v;
+			rem--;
+		}
+	}
+	return rem;
+}
+
 static int fill(const char *path, int pathlen, struct attr_stack *stk, int rem)
 {
+	int i;
 	const char *base = stk->origin ? stk->origin : "";
-	int i, j;
-	struct git_attr_check *check = check_all_attr;
 
 	for (i = stk->num_matches - 1; 0 < rem && 0 <= i; i--) {
 		struct match_attr *a = stk->attrs[i];
 		if (a->is_macro)
 			continue;
 		if (path_matches(path, pathlen,
-				 a->u.pattern, base, strlen(base))) {
-			for (j = 0; 0 < rem && j < a->num_attr; j++) {
-				struct git_attr *attr = a->state[j].attr;
-				int set = !a->state[j].unset;
-				int *n = &(check[attr->attr_nr].isset);
-
-				if (*n < 0) {
-					debug_set("fill", a->u.pattern, attr, set);
-					*n = set;
-					rem--;
-				}
-			}
-		}
+				 a->u.pattern, base, strlen(base)))
+			rem = fill_one("fill", a, rem);
 	}
 	return rem;
 }
 
 static int macroexpand(struct attr_stack *stk, int rem)
 {
-	int i, j;
+	int i;
 	struct git_attr_check *check = check_all_attr;
 
 	for (i = stk->num_matches - 1; 0 < rem && 0 <= i; i--) {
 		struct match_attr *a = stk->attrs[i];
 		if (!a->is_macro)
 			continue;
-		if (check[a->u.attr->attr_nr].isset < 0)
+		if (check[a->u.attr->attr_nr].value != ATTR__TRUE)
 			continue;
-		for (j = 0; 0 < rem && j < a->num_attr; j++) {
-			struct git_attr *attr = a->state[j].attr;
-			int set = !a->state[j].unset;
-			int *n = &(check[attr->attr_nr].isset);
-
-			if (*n < 0) {
-				debug_set("expand", a->u.attr->name, attr, set);
-				*n = set;
-				rem--;
-			}
-		}
+		rem = fill_one("expand", a, rem);
 	}
 	return rem;
 }
@@ -482,7 +530,7 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 
 	bootstrap_attr_stack();
 	for (i = 0; i < attr_nr; i++)
-		check_all_attr[i].isset = -1;
+		check_all_attr[i].value = ATTR__UNKNOWN;
 
 	pathlen = strlen(path);
 	cp = strrchr(path, '/');
@@ -498,8 +546,12 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
 		rem = macroexpand(stk, rem);
 
-	for (i = 0; i < num; i++)
-		check[i].isset = check_all_attr[check[i].attr->attr_nr].isset;
+	for (i = 0; i < num; i++) {
+		void *value = check_all_attr[check[i].attr->attr_nr].value;
+		if (value == ATTR__UNKNOWN)
+			value = ATTR__UNSET;
+		check[i].value = value;
+	}
 
 	return 0;
 }
diff --git a/attr.h b/attr.h
index 1e5ab40..8ec2d3d 100644
--- a/attr.h
+++ b/attr.h
@@ -6,9 +6,19 @@ struct git_attr;
 
 struct git_attr *git_attr(const char *, int);
 
+/* Internal use */
+#define ATTR__TRUE	((void *) 1)
+#define ATTR__FALSE	((void *) 0)
+#define ATTR__UNSET	((void *) -1)
+
+/* For public to check git_attr_check results */
+#define ATTR_TRUE(v) ((v) == ATTR__TRUE)
+#define ATTR_FALSE(v) ((v) == ATTR__FALSE)
+#define ATTR_UNSET(v) ((v) == ATTR__UNSET)
+
 struct git_attr_check {
 	struct git_attr *attr;
-	int isset;
+	void *value;
 };
 
 int git_checkattr(const char *path, int, struct git_attr_check *);
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 634be9e..6983a73 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -42,11 +42,17 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		if (git_checkattr(argv[i], cnt, check))
 			die("git_checkattr died");
 		for (j = 0; j < cnt; j++) {
+			void *value = check[j].value;
+
+			if (ATTR_TRUE(value))
+				value = "set";
+			else if (ATTR_FALSE(value))
+				value = "unset";
+			else if (ATTR_UNSET(value))
+				value = "unspecified";
+
 			write_name_quoted("", 0, argv[i], 1, stdout);
-			printf(": %s: %s\n", argv[j+1],
-			       (check[j].isset < 0) ? "unspecified" :
-			       (check[j].isset == 0) ? "unset" :
-			       "set");
+			printf(": %s: %s\n", argv[j+1], (char *) value);
 		}
 	}
 	return 0;
diff --git a/convert.c b/convert.c
index d0d4b81..68bb70f 100644
--- a/convert.c
+++ b/convert.c
@@ -225,9 +225,19 @@ static int git_path_check_crlf(const char *path)
 
 	setup_crlf_check(&attr_crlf_check);
 
-	if (git_checkattr(path, 1, &attr_crlf_check))
-		return -1;
-	return attr_crlf_check.isset;
+	if (!git_checkattr(path, 1, &attr_crlf_check)) {
+		void *value = attr_crlf_check.value;
+		if (ATTR_TRUE(value))
+			return 1;
+		else if (ATTR_FALSE(value))
+			return 0;
+		else if (ATTR_UNSET(value))
+			;
+		else
+			die("unknown value %s given to 'crlf' attribute",
+			    (char *)value);
+	}
+	return -1;
 }
 
 int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
diff --git a/diff.c b/diff.c
index dcea405..a32078e 100644
--- a/diff.c
+++ b/diff.c
@@ -1068,9 +1068,18 @@ static int file_is_binary(struct diff_filespec *one)
 	struct git_attr_check attr_diff_check;
 
 	setup_diff_attr_check(&attr_diff_check);
-	if (!git_checkattr(one->path, 1, &attr_diff_check) &&
-	    (0 <= attr_diff_check.isset))
-		return !attr_diff_check.isset;
+	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
+		void *value = attr_diff_check.value;
+		if (ATTR_TRUE(value))
+			return 0;
+		else if (ATTR_FALSE(value))
+			return 1;
+		else if (ATTR_UNSET(value))
+			;
+		else
+			die("unknown value %s given to 'diff' attribute",
+			    (char *)value);
+	}
 
 	if (!one->data) {
 		if (!DIFF_FILE_VALID(one))
-- 
1.5.1.1.821.g88bdb
