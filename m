From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add "git show-ref" builtin command
Date: Fri, 15 Sep 2006 14:00:25 -0700
Message-ID: <7vmz90g80m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609151108560.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 15 23:00:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOKnY-0006aG-Nw
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 23:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWIOVA2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 17:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWIOVA2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 17:00:28 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63699 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932261AbWIOVA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 17:00:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060915210026.CYWC2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 15 Sep 2006 17:00:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Nl0E1V0021kojtg0000000
	Fri, 15 Sep 2006 17:00:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27100>

Linus Torvalds <torvalds@osdl.org> writes:

> It's kind of like "git peek-remote", but works only locally (and thus 
> avoids the whole overhead of git_connect()) and has some extra 
> verification features.
>...
> NOTE! This is against the current master branch, and does _not_ depend on 
> my other ref-work. In fact, I'd argue that this is much better to merge 
> first and independently of the packed references branch, because it allows 
> us to much more easily update the scripts etc to be totally unaware of how 
> the refs are actually stored.

Looks sane.  Thanks.

Having said that....

Gaaah.  I had been doing a "show-refs" that does something quite
different from this X-<.

I'll rename it; I think the new name makes more sense anyway.

-- >8 --
From: Junio C Hamano <junkio@cox.net>
Date: Fri, 15 Sep 2006 13:30:02 -0700
Subject: [PATCH] Add git-for-each-ref: helper for language bindings

This adds a new command, git-for-each-ref.  You can have it iterate
over refs and have it output various aspects of the objects they
refer to.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 .gitignore                         |    1 
 Documentation/git-for-each-ref.txt |  164 +++++++
 Makefile                           |    1 
 builtin-for-each-ref.c             |  845 ++++++++++++++++++++++++++++++++++++
 builtin.h                          |    3 
 git.c                              |    1 
 object.c                           |   68 ++-
 object.h                           |    6 
 quote.c                            |   38 ++
 quote.h                            |    4 
 10 files changed, 1103 insertions(+), 28 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0d608fe..0b08f37 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,6 +36,7 @@ git-fetch
 git-fetch-pack
 git-findtags
 git-fmt-merge-msg
+git-for-each-ref
 git-format-patch
 git-fsck-objects
 git-get-tar-commit-id
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
new file mode 100644
index 0000000..74dd735
--- /dev/null
+++ b/Documentation/git-for-each-ref.txt
@@ -0,0 +1,164 @@
+git-for-each-ref(1)
+===================
+
+NAME
+----
+git-for-each-ref - Output information on each ref
+
+SYNOPSIS
+--------
+'git-for-each-ref' [--count=<count>]* [--shell|--perl|--python] [--sort=<key>]* [--format=<format>] [<pattern>]
+
+DESCRIPTION
+-----------
+
+Iterate over all refs that match `<pattern>` and show them
+according to the given `<format>`, after sorting them according
+to the given `<sortkeys>`.  If `<max>` is given, stop after
+showing that many refs.  The interporated values in `<format>`
+can optionally be quoted as string literals in the specified
+host language.
+
+OPTIONS
+-------
+<count>::
+	By default the command shows all refs that match
+	`<pattern>`.  This option makes it stop after showing
+	that many refs.
+
+<key>::
+	A field name to sort on.  Prefix `-` to sort in
+	descending order of the value.  When unspecified,
+	`refname` is used.  More than one sort keys can be
+	given.
+
+<format>::
+	A string that interpolates `%(fieldname)` from the
+	object pointed at by a ref being shown.  If `fieldname`
+	is prefixed with an asterisk (`*`) and the ref points
+	at a tag object, the value for the field in the object
+	tag refers is used.  When unspecified, defaults to
+	`%(refname)`.
+
+<pattern>::
+	If given, the name of the ref is matched against this
+	using fnmatch(3).  Refs that do not match the pattern
+	are not shown.
+
+--shell, --perl, --python::
+	If given, strings that substitute `%(fieldname)`
+	placeholders are quoted as string literals suitable for
+	the specified host language.  This is meant to produce
+	a scriptlet that can directly be `eval`ed.
+
+
+FIELD NAMES
+-----------
+
+Various values from structured fields in referenced objects can
+be used to interpolate into the resulting output, or as sort
+keys.
+
+For all objects, the following names can be used:
+
+refname::
+	The name of the ref (the part after $GIT_DIR/refs/).
+
+objecttype::
+	The type of the object (`blob`, `tree`, `commit`, `tag`).
+
+objectsize::
+	The size of the object (the same as `git-cat-file -s` reports).
+
+objectname::
+	The object name (aka SHA-1).
+
+In addition to the above, for commit and tag objects, the header
+field names (`tree`, `parent`, `object`, `type`, and `tag`) can
+be used to specify the value in the header field.
+
+Fields that have name-email-date tuple as its value (`author`,
+`committer`, and `tagger`) can be suffixed with `name`, `email`,
+and `date` to extract the named component.
+
+The first line of the message in a commit and tag object is
+`subject`, the remaining lines are `body`.  The whole message
+is `contents`.
+
+For sorting purposes, fields with numeric values sort in numeric
+order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
+All other fields are used to sort in their byte-value order.
+
+In any case, a field name that refers to a field inapplicable to
+the object referred by the ref does not cause an error.  It
+returns an empty string instead.
+
+
+EXAMPLES
+--------
+
+Show the most recent 3 tagged commits::
+
+------------
+#!/bin/sh
+
+git-for-each-ref --count=3 --sort='-*authordate' \
+--format='From: %(*authorname) %(*authoremail)
+Subject: %(*subject)
+Date: %(*authordate)
+Ref: %(*refname)
+
+%(*body)
+' 'refs/tags'
+------------
+
+A bit more elaborate report on tags::
+------------
+#!/bin/sh
+
+fmt='
+	r=%(refname)
+	t=%(*objecttype)
+	T=${r#refs/tags/}
+
+	o=%(*objectname)
+	n=%(*authorname)
+	e=%(*authoremail)
+	s=%(*subject)
+	d=%(*authordate)
+	b=%(*body)
+
+	kind=Tag
+	if test "z$t" = z
+	then
+		# could be a lightweight tag
+		t=%(objecttype)
+		kind="Lightweight tag"
+		o=%(objectname)
+		n=%(authorname)
+		e=%(authoremail)
+		s=%(subject)
+		d=%(authordate)
+		b=%(body)
+	fi
+	echo "$kind $T points at a $t object $o"
+	if test "z$t" = zcommit
+	then
+		echo "The commit was authored by $n $e
+at $d, and titled
+
+    $s
+
+Its message reads as:
+"
+		echo "$b" | sed -e "s/^/    /"
+		echo
+	fi
+'
+
+eval=`git-for-each-ref -s --format="$fmt" \
+	--sort='*objecttype' \
+	--sort=-taggerdate \
+	refs/tags`
+eval "$eval"
+------------
diff --git a/Makefile b/Makefile
index 7b3114f..f0e2e51 100644
--- a/Makefile
+++ b/Makefile
@@ -267,6 +267,7 @@ BUILTIN_OBJS = \
 	builtin-diff-stages.o \
 	builtin-diff-tree.o \
 	builtin-fmt-merge-msg.o \
+	builtin-for-each-ref.o \
 	builtin-grep.o \
 	builtin-init-db.o \
 	builtin-log.o \
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
new file mode 100644
index 0000000..f064e7e
--- /dev/null
+++ b/builtin-for-each-ref.c
@@ -0,0 +1,845 @@
+#include "cache.h"
+#include "refs.h"
+#include "object.h"
+#include "tag.h"
+#include "commit.h"
+#include "tree.h"
+#include "blob.h"
+#include "quote.h"
+#include <fnmatch.h>
+
+/* Quoting styles */
+#define QUOTE_NONE 0
+#define QUOTE_SHELL 1
+#define QUOTE_PERL 2
+#define QUOTE_PYTHON 3
+
+typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
+
+struct atom_value {
+	const char *s;
+	unsigned long ul; /* used for sorting when not FIELD_STR */
+};
+
+struct ref_sort {
+	struct ref_sort *next;
+	int atom; /* index into used_atom array */
+	unsigned reverse : 1;
+};
+
+struct refinfo {
+	char *refname;
+	unsigned char objectname[20];
+	struct atom_value *value;
+};
+
+static struct {
+	const char *name;
+	cmp_type cmp_type;
+} valid_atom[] = {
+	{ "refname" },
+	{ "objecttype" },
+	{ "objectsize", FIELD_ULONG },
+	{ "objectname" },
+	{ "tree" },
+	{ "parent" }, /* NEEDSWORK: how to address 2nd and later parents? */
+	{ "numparent", FIELD_ULONG },
+	{ "object" },
+	{ "type" },
+	{ "tag" },
+	{ "author" },
+	{ "authorname" },
+	{ "authoremail" },
+	{ "authordate", FIELD_TIME },
+	{ "committer" },
+	{ "committername" },
+	{ "committeremail" },
+	{ "committerdate", FIELD_TIME },
+	{ "tagger" },
+	{ "taggername" },
+	{ "taggeremail" },
+	{ "taggerdate", FIELD_TIME },
+	{ "subject" },
+	{ "body" },
+	{ "contents" },
+};
+
+/*
+ * An atom is a valid field atom listed above, possibly prefixed with
+ * a "*" to denote deref_tag().
+ *
+ * We parse given format string and sort specifiers, and make a list
+ * of properties that we need to extract out of objects.  refinfo
+ * structure will hold an array of values extracted that can be
+ * indexed with the "atom number", which is an index into this
+ * array.
+ */
+static const char **used_atom;
+static cmp_type *used_atom_type;
+static int used_atom_cnt, sort_atom_limit, need_tagged;
+
+/*
+ * Used to parse format string and sort specifiers
+ */
+static int parse_atom(const char *atom, const char *ep)
+{
+	const char *sp;
+	char *n;
+	int i, at;
+
+	sp = atom;
+	if (*sp == '*' && sp < ep)
+		sp++; /* deref */
+	if (ep <= sp)
+		die("malformed field name: %.*s", (int)(ep-atom), atom);
+
+	/* Do we have the atom already used elsewhere? */
+	for (i = 0; i < used_atom_cnt; i++) {
+		int len = strlen(used_atom[i]);
+		if (len == ep - atom && !memcmp(used_atom[i], atom, len))
+			return i;
+	}
+
+	/* Is the atom a valid one? */
+	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
+		int len = strlen(valid_atom[i].name);
+		if (len == ep - sp && !memcmp(valid_atom[i].name, sp, len))
+			break;
+	}
+
+	if (ARRAY_SIZE(valid_atom) <= i)
+		die("unknown field name: %.*s", (int)(ep-atom), atom);
+
+	/* Add it in, including the deref prefix */
+	at = used_atom_cnt;
+	used_atom_cnt++;
+	used_atom = xrealloc(used_atom,
+			     (sizeof *used_atom) * used_atom_cnt);
+	used_atom_type = xrealloc(used_atom_type,
+				  (sizeof(*used_atom_type) * used_atom_cnt));
+	n = xmalloc(ep - atom + 1);
+	memcpy(n, atom, ep - atom);
+	n[ep-atom] = 0;
+	used_atom[at] = n;
+	used_atom_type[at] = valid_atom[i].cmp_type;
+	return at;
+}
+
+/*
+ * In a format string, find the next occurrence of %(atom).
+ */
+static const char *find_next(const char *cp)
+{
+	while (*cp) {
+		if (*cp == '%') {
+			/* %( is the start of an atom;
+			 * %% is a quoteed per-cent.
+			 */
+			if (cp[1] == '(')
+				return cp;
+			else if (cp[1] == '%')
+				cp++; /* skip over two % */
+			/* otherwise this is a singleton, literal % */
+		}
+		cp++;
+	}
+	return NULL;
+}
+
+/*
+ * Make sure the format string is well formed, and parse out
+ * the used atoms.
+ */
+static void verify_format(const char *format)
+{
+	const char *cp, *sp;
+	for (cp = format; *cp && (sp = find_next(cp)); ) {
+		const char *ep = strchr(sp, ')');
+		if (!ep)
+			die("malformatted format string %s", sp);
+		/* sp points at "%(" and ep points at the closing ")" */
+		parse_atom(sp + 2, ep);
+		cp = ep + 1;
+	}
+}
+
+/*
+ * Given an object name, read the object data and size, and return a
+ * "struct object".  If the object data we are returning is also borrowed
+ * by the "struct object" representation, set *eaten as well---it is a
+ * signal from parse_object_buffer to us not to free the buffer.
+ */
+static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned long *sz, int *eaten)
+{
+	char type[20];
+	void *buf = read_sha1_file(sha1, type, sz);
+
+	if (buf)
+		*obj = parse_object_buffer(sha1, type, *sz, buf, eaten);
+	else
+		*obj = NULL;
+	return buf;
+}
+
+/* See grab_values */
+static void grab_common_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+{
+	int i;
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &val[i];
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+		if (!strcmp(name, "objecttype"))
+			v->s = type_names[obj->type];
+		else if (!strcmp(name, "objectsize")) {
+			char *s = xmalloc(40);
+			sprintf(s, "%lu", sz);
+			v->ul = sz;
+			v->s = s;
+		}
+		else if (!strcmp(name, "objectname")) {
+			char *s = xmalloc(41);
+			strcpy(s, sha1_to_hex(obj->sha1));
+			v->s = s;
+		}
+	}
+}
+
+/* See grab_values */
+static void grab_tag_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+{
+	int i;
+	struct tag *tag = (struct tag *) obj;
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &val[i];
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+		if (!strcmp(name, "tag"))
+			v->s = tag->tag;
+	}
+}
+
+static int num_parents(struct commit *commit)
+{
+	struct commit_list *parents;
+	int i;
+
+	for (i = 0, parents = commit->parents;
+	     parents;
+	     parents = parents->next)
+		i++;
+	return i;
+}
+
+/* See grab_values */
+static void grab_commit_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+{
+	int i;
+	struct commit *commit = (struct commit *) obj;
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &val[i];
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+		if (!strcmp(name, "tree")) {
+			char *s = xmalloc(41);
+			strcpy(s, sha1_to_hex(commit->tree->object.sha1));
+			v->s = s;
+		}
+		if (!strcmp(name, "numparent")) {
+			char *s = xmalloc(40);
+			sprintf(s, "%lu", v->ul);
+			v->s = s;
+			v->ul = num_parents(commit);
+		}
+		else if (!strcmp(name, "parent")) {
+			int num = num_parents(commit);
+			int i;
+			struct commit_list *parents;
+			char *s = xmalloc(42 * num);
+			v->s = s;
+			for (i = 0, parents = commit->parents;
+			     parents;
+			     parents = parents->next, i = i + 42) {
+				struct commit *parent = parents->item;
+				strcpy(s+i, sha1_to_hex(parent->object.sha1));
+				if (parents->next)
+					s[i+40] = ' ';
+			}
+		}
+	}
+}
+
+static const char *find_wholine(const char *who, int wholen, const char *buf, unsigned long sz)
+{
+	const char *eol;
+	while (*buf) {
+		if (!strncmp(buf, who, wholen) &&
+		    buf[wholen] == ' ')
+			return buf + wholen + 1;
+		eol = strchr(buf, '\n');
+		if (!eol)
+			return "";
+		eol++;
+		if (eol[1] == '\n')
+			return ""; /* end of header */
+		buf = eol;
+	}
+	return "";
+}
+
+static char *copy_line(const char *buf)
+{
+	const char *eol = strchr(buf, '\n');
+	char *line;
+	int len;
+	if (!eol)
+		return "";
+	len = eol - buf;
+	line = xmalloc(len + 1);
+	memcpy(line, buf, len);
+	line[len] = 0;
+	return line;
+}
+
+static char *copy_name(const char *buf)
+{
+	const char *eol = strchr(buf, '\n');
+	const char *eoname = strstr(buf, " <");
+	char *line;
+	int len;
+	if (!(eoname && eol && eoname < eol))
+		return "";
+	len = eoname - buf;
+	line = xmalloc(len + 1);
+	memcpy(line, buf, len);
+	line[len] = 0;
+	return line;
+}
+
+static char *copy_email(const char *buf)
+{
+	const char *email = strchr(buf, '<');
+	const char *eoemail = strchr(email, '>');
+	char *line;
+	int len;
+	if (!email || !eoemail)
+		return "";
+	eoemail++;
+	len = eoemail - email;
+	line = xmalloc(len + 1);
+	memcpy(line, email, len);
+	line[len] = 0;
+	return line;
+}
+
+static void grab_date(const char *buf, struct atom_value *v)
+{
+	const char *eoemail = strstr(buf, "> ");
+	char *zone;
+	unsigned long timestamp;
+	long tz;
+
+	if (!eoemail)
+		goto bad;
+	timestamp = strtoul(eoemail + 2, &zone, 10);
+	if (timestamp == ULONG_MAX)
+		goto bad;
+	tz = strtol(zone, NULL, 10);
+	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
+		goto bad;
+	v->s = xstrdup(show_date(timestamp, tz, 0));
+	v->ul = timestamp;
+	return;
+ bad:
+	v->s = "";
+	v->ul = 0;
+}
+
+/* See grab_values */
+static void grab_person(const char *who, struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+{
+	int i;
+	int wholen = strlen(who);
+	const char *wholine = NULL;
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &val[i];
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+		if (strncmp(who, name, wholen))
+			continue;
+		if (name[wholen] != 0 &&
+		    strcmp(name + wholen, "name") &&
+		    strcmp(name + wholen, "email") &&
+		    strcmp(name + wholen, "date"))
+			continue;
+		if (!wholine)
+			wholine = find_wholine(who, wholen, buf, sz);
+		if (!wholine)
+			return; /* no point looking for it */
+		if (name[wholen] == 0)
+			v->s = copy_line(wholine);
+		else if (!strcmp(name + wholen, "name"))
+			v->s = copy_name(wholine);
+		else if (!strcmp(name + wholen, "email"))
+			v->s = copy_email(wholine);
+		else if (!strcmp(name + wholen, "date"))
+			grab_date(wholine, v);
+	}
+}
+
+static void find_subpos(const char *buf, unsigned long sz, const char **sub, const char **body)
+{
+	while (*buf) {
+		const char *eol = strchr(buf, '\n');
+		if (!eol)
+			return;
+		if (eol[1] == '\n') {
+			buf = eol + 1;
+			break; /* found end of header */
+		}
+		buf = eol + 1;
+	}
+	while (*buf == '\n')
+		buf++;
+	if (!*buf)
+		return;
+	*sub = buf; /* first non-empty line */
+	buf = strchr(buf, '\n');
+	if (!buf)
+		return; /* no body */
+	while (*buf == '\n')
+		buf++; /* skip blank between subject and body */
+	*body = buf;
+}
+
+/* See grab_values */
+static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+{
+	int i;
+	const char *subpos = NULL, *bodypos = NULL;
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &val[i];
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+		if (strcmp(name, "subject") &&
+		    strcmp(name, "body") &&
+		    strcmp(name, "contents"))
+			continue;
+		if (!subpos)
+			find_subpos(buf, sz, &subpos, &bodypos);
+		if (!subpos)
+			return;
+
+		if (!strcmp(name, "subject"))
+			v->s = copy_line(subpos);
+		else if (!strcmp(name, "body"))
+			v->s = bodypos;
+		else if (!strcmp(name, "contents"))
+			v->s = subpos;
+	}
+}
+
+/* We want to have empty print-string for field requests
+ * that do not apply (e.g. "authordate" for a tag object)
+ */
+static void fill_missing_values(struct atom_value *val)
+{
+	int i;
+	for (i = 0; i < used_atom_cnt; i++) {
+		struct atom_value *v = &val[i];
+		if (v->s == NULL)
+			v->s = "";
+	}
+}
+
+/*
+ * val is a list of atom_value to hold returned values.  Extract
+ * the values for atoms in used_atom array out of (obj, buf, sz).
+ * when deref is false, (obj, buf, sz) is the object that is
+ * pointed at by the ref itself; otherwise it is the object the
+ * ref (which is a tag) refers to.
+ */
+static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+{
+	grab_common_values(val, deref, obj, buf, sz);
+	switch (obj->type) {
+	case OBJ_TAG:
+		grab_tag_values(val, deref, obj, buf, sz);
+		grab_sub_body_contents(val, deref, obj, buf, sz);
+		grab_person("tagger", val, deref, obj, buf, sz);
+		break;
+	case OBJ_COMMIT:
+		grab_commit_values(val, deref, obj, buf, sz);
+		grab_sub_body_contents(val, deref, obj, buf, sz);
+		grab_person("author", val, deref, obj, buf, sz);
+		grab_person("committer", val, deref, obj, buf, sz);
+		break;
+	case OBJ_TREE:
+		// grab_tree_values(val, deref, obj, buf, sz);
+		break;
+	case OBJ_BLOB:
+		// grab_blob_values(val, deref, obj, buf, sz);
+		break;
+	default:
+		die("Eh?  Object of type %d?", obj->type);
+	}
+}
+
+/*
+ * Parse the object referred by ref, and grab needed value.
+ */
+static void populate_value(struct refinfo *ref)
+{
+	void *buf;
+	struct object *obj;
+	int eaten, i;
+	unsigned long size;
+	const unsigned char *tagged;
+
+	ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
+
+	buf = get_obj(ref->objectname, &obj, &size, &eaten);
+	if (!buf)
+		die("missing object %s for %s",
+		    sha1_to_hex(ref->objectname), ref->refname);
+	if (!obj)
+		die("parse_object_buffer failed on %s for %s",
+		    sha1_to_hex(ref->objectname), ref->refname);
+
+	/* Fill in specials first */
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &ref->value[i];
+		if (!strcmp(name, "refname"))
+			v->s = ref->refname;
+		else if (!strcmp(name, "*refname")) {
+			int len = strlen(ref->refname);
+			char *s = xmalloc(len + 4);
+			sprintf(s, "%s^{}", ref->refname);
+			v->s = s;
+		}
+	}
+
+	grab_values(ref->value, 0, obj, buf, size);
+	if (!eaten)
+		free(buf);
+
+	/* If there is no atom that wants to know about tagged
+	 * object, we are done.
+	 */
+	if (!need_tagged || (obj->type != OBJ_TAG))
+		return;
+
+	/* If it is a tag object, see if we use a value that derefs
+	 * the object, and if we do grab the object it refers to.
+	 */
+	tagged = ((struct tag *)obj)->tagged->sha1;
+
+	/* NEEDSWORK: This derefs tag only once, which
+	 * is good to deal with chains of trust, but
+	 * is not consistent with what deref_tag() does
+	 * which peels the onion to the core.
+	 */
+	buf = get_obj(tagged, &obj, &size, &eaten);
+	if (!buf)
+		die("missing object %s for %s",
+		    sha1_to_hex(tagged), ref->refname);
+	if (!obj)
+		die("parse_object_buffer failed on %s for %s",
+		    sha1_to_hex(tagged), ref->refname);
+	grab_values(ref->value, 1, obj, buf, size);
+	if (!eaten)
+		free(buf);
+}
+
+/*
+ * Given a ref, return the value for the atom.  This lazily gets value
+ * out of the object by calling populate value.
+ */
+static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
+{
+	if (!ref->value) {
+		populate_value(ref);
+		fill_missing_values(ref->value);
+	}
+	*v = &ref->value[atom];
+}
+
+static struct refinfo **grab_array;
+static const char **grab_pattern;
+static int *grab_cnt;
+
+/*
+ * A call-back given to for_each_ref().  It is unfortunate that we
+ * need to use global variables to pass extra information to this
+ * function.
+ */
+static int grab_single_ref(const char *refname, const unsigned char *sha1)
+{
+	struct refinfo *ref;
+	int cnt;
+
+	if (*grab_pattern) {
+		const char **pattern;
+		int namelen = strlen(refname);
+		for (pattern = grab_pattern; *pattern; pattern++) {
+			const char *p = *pattern;
+			int plen = strlen(p);
+
+			if ((plen <= namelen) &&
+			    !strncmp(refname, p, plen) &&
+			    (refname[plen] == '\0' ||
+			     refname[plen] == '/'))
+				break;
+			if (!fnmatch(p, refname, FNM_PATHNAME))
+				break;
+		}
+		if (!*pattern)
+			return 0;
+	}
+
+	/* We do not open the object yet; sort may only need refname
+	 * to do its job and the resulting list may yet to be pruned
+	 * by maxcount logic.
+	 */
+	ref = xcalloc(1, sizeof(*ref));
+	ref->refname = xstrdup(refname);
+	hashcpy(ref->objectname, sha1);
+
+	cnt = *grab_cnt;
+	grab_array = xrealloc(grab_array, sizeof(*grab_array) * (cnt + 1));
+	grab_array[cnt++] = ref;
+	*grab_cnt = cnt;
+	return 0;
+}
+
+static struct refinfo **grab_refs(const char **pattern, int *cnt)
+{
+	/* Sheesh, we really should make for-each-ref to take
+	 * callback data.
+	 */
+	*cnt = 0;
+	grab_pattern = pattern;
+	grab_cnt = cnt;
+	for_each_ref(grab_single_ref);
+	return grab_array;
+}
+
+static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
+{
+	struct atom_value *va, *vb;
+	int cmp;
+	cmp_type cmp_type = used_atom_type[s->atom];
+
+	get_value(a, s->atom, &va);
+	get_value(b, s->atom, &vb);
+	switch (cmp_type) {
+	case FIELD_STR:
+		cmp = strcmp(va->s, vb->s);
+		break;
+	default:
+		if (va->ul < vb->ul)
+			cmp = -1;
+		else if (va->ul == vb->ul)
+			cmp = 0;
+		else
+			cmp = 1;
+		break;
+	}
+	return (s->reverse) ? -cmp : cmp;
+}
+
+static struct ref_sort *ref_sort;
+static int compare_refs(const void *a_, const void *b_)
+{
+	struct refinfo *a = *((struct refinfo **)a_);
+	struct refinfo *b = *((struct refinfo **)b_);
+	struct ref_sort *s;
+
+	for (s = ref_sort; s; s = s->next) {
+		int cmp = cmp_ref_sort(s, a, b);
+		if (cmp)
+			return cmp;
+	}
+	return 0;
+}
+
+static void sort_refs(struct ref_sort *sort, struct refinfo **refs, int num_refs)
+{
+	ref_sort = sort;
+	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
+}
+
+static void print_value(struct refinfo *ref, int atom, int quote_style)
+{
+	struct atom_value *v;
+	get_value(ref, atom, &v);
+	switch (quote_style) {
+	case QUOTE_NONE:
+		fputs(v->s, stdout);
+		break;
+	case QUOTE_SHELL:
+		sq_quote_print(stdout, v->s);
+		break;
+	case QUOTE_PERL:
+		perl_quote_print(stdout, v->s);
+		break;
+	case QUOTE_PYTHON:
+		python_quote_print(stdout, v->s);
+		break;
+	}
+}
+
+static void emit(const char *cp, const char *ep)
+{
+	while (*cp && (!ep || cp < ep)) {
+		if (*cp == '%')
+			if (cp[1] == '%')
+				cp++;
+		putchar(*cp);
+		cp++;
+	}
+}
+
+static void show_ref(struct refinfo *info, const char *format, int quote_style)
+{
+	const char *cp, *sp, *ep;
+
+	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
+		ep = strchr(sp, ')');
+		if (cp < sp)
+			emit(cp, sp);
+		print_value(info, parse_atom(sp + 2, ep), quote_style);
+	}
+	if (*cp)
+		fputs(cp, stdout);
+	putchar('\n');
+}
+
+static struct ref_sort *default_sort(void)
+{
+	static const char cstr_name[] = "refname";
+
+	struct ref_sort *sort = xcalloc(1, sizeof(*sort));
+
+	sort->next = NULL;
+	sort->atom = parse_atom(cstr_name, cstr_name + strlen(cstr_name));
+	return sort;
+}
+
+int cmd_for_each_ref(int ac, const char **av, char *prefix)
+{
+	int i, num_refs;
+	const char *format = NULL;
+	struct ref_sort *sort = NULL, **sort_tail = &sort;
+	int maxcount = 0;
+	int quote_style = -1; /* unspecified yet */
+	struct refinfo **refs;
+
+	for (i = 1; i < ac; i++) {
+		const char *arg = av[i];
+		if (arg[0] != '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strncmp(arg, "--format=", 9)) {
+			if (format)
+				die("more than one --format?");
+			format = arg + 9;
+			continue;
+		}
+		if (!strcmp(arg, "-s") || !strcmp(arg, "--shell") ) {
+			if (0 <= quote_style)
+				die("more than one quoting style?");
+			quote_style = QUOTE_SHELL;
+			continue;
+		}
+		if (!strcmp(arg, "-p") || !strcmp(arg, "--perl") ) {
+			if (0 <= quote_style)
+				die("more than one quoting style?");
+			quote_style = QUOTE_PERL;
+			continue;
+		}
+		if (!strcmp(arg, "--python") ) {
+			if (0 <= quote_style)
+				die("more than one quoting style?");
+			quote_style = QUOTE_PYTHON;
+			continue;
+		}
+		if (!strncmp(arg, "--count=", 8)) {
+			if (maxcount)
+				die("more than one --count?");
+			maxcount = atoi(arg + 8);
+			if (maxcount <= 0)
+				die("The number %s did not parse", arg);
+			continue;
+		}
+		if (!strncmp(arg, "--sort=", 7)) {
+			struct ref_sort *s = xcalloc(1, sizeof(*s));
+			int len;
+
+			s->next = NULL;
+			*sort_tail = s;
+			sort_tail = &s->next;
+
+			arg += 7;
+			if (*arg == '-') {
+				s->reverse = 1;
+				arg++;
+			}
+			len = strlen(arg);
+			sort->atom = parse_atom(arg, arg+len);
+			continue;
+		}
+		break;
+	}
+	if (quote_style < 0)
+		quote_style = QUOTE_NONE;
+
+	if (!sort)
+		sort = default_sort();
+	sort_atom_limit = used_atom_cnt;
+	if (!format)
+		format = "%(objectname) %(objecttype)\t%(refname)";
+
+	verify_format(format);
+
+	refs = grab_refs(av + i, &num_refs);
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		if (used_atom[i][0] == '*') {
+			need_tagged = 1;
+			break;
+		}
+	}
+
+	sort_refs(sort, refs, num_refs);
+
+	if (!maxcount || num_refs < maxcount)
+		maxcount = num_refs;
+	for (i = 0; i < maxcount; i++)
+		show_ref(refs[i], format, quote_style);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 25431d7..87d3326 100644
--- a/builtin.h
+++ b/builtin.h
@@ -26,6 +26,7 @@ extern int cmd_diff(int argc, const char
 extern int cmd_diff_stages(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
+extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
@@ -47,8 +48,8 @@ extern int cmd_repo_config(int argc, con
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
-extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
+extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 8c182a5..10db27b 100644
--- a/git.c
+++ b/git.c
@@ -231,6 +231,7 @@ static void handle_internal_command(int 
 		{ "diff-stages", cmd_diff_stages, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
+		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
 		{ "format-patch", cmd_format_patch, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP },
diff --git a/object.c b/object.c
index 9281300..de244e2 100644
--- a/object.c
+++ b/object.c
@@ -138,42 +138,56 @@ struct object *lookup_unknown_object(con
 	return obj;
 }
 
+struct object *parse_object_buffer(const unsigned char *sha1, const char *type, unsigned long size, void *buffer, int *eaten_p)
+{
+	struct object *obj;
+	int eaten = 0;
+
+	if (!strcmp(type, blob_type)) {
+		struct blob *blob = lookup_blob(sha1);
+		parse_blob_buffer(blob, buffer, size);
+		obj = &blob->object;
+	} else if (!strcmp(type, tree_type)) {
+		struct tree *tree = lookup_tree(sha1);
+		obj = &tree->object;
+		if (!tree->object.parsed) {
+			parse_tree_buffer(tree, buffer, size);
+			eaten = 1;
+		}
+	} else if (!strcmp(type, commit_type)) {
+		struct commit *commit = lookup_commit(sha1);
+		parse_commit_buffer(commit, buffer, size);
+		if (!commit->buffer) {
+			commit->buffer = buffer;
+			eaten = 1;
+		}
+		obj = &commit->object;
+	} else if (!strcmp(type, tag_type)) {
+		struct tag *tag = lookup_tag(sha1);
+		parse_tag_buffer(tag, buffer, size);
+		obj = &tag->object;
+	} else {
+		obj = NULL;
+	}
+	*eaten_p = eaten;
+	return obj;
+}
+
 struct object *parse_object(const unsigned char *sha1)
 {
 	unsigned long size;
 	char type[20];
+	int eaten;
 	void *buffer = read_sha1_file(sha1, type, &size);
+
 	if (buffer) {
 		struct object *obj;
 		if (check_sha1_signature(sha1, buffer, size, type) < 0)
 			printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
-		if (!strcmp(type, blob_type)) {
-			struct blob *blob = lookup_blob(sha1);
-			parse_blob_buffer(blob, buffer, size);
-			obj = &blob->object;
-		} else if (!strcmp(type, tree_type)) {
-			struct tree *tree = lookup_tree(sha1);
-			obj = &tree->object;
-			if (!tree->object.parsed) {
-				parse_tree_buffer(tree, buffer, size);
-				buffer = NULL;
-			}
-		} else if (!strcmp(type, commit_type)) {
-			struct commit *commit = lookup_commit(sha1);
-			parse_commit_buffer(commit, buffer, size);
-			if (!commit->buffer) {
-				commit->buffer = buffer;
-				buffer = NULL;
-			}
-			obj = &commit->object;
-		} else if (!strcmp(type, tag_type)) {
-			struct tag *tag = lookup_tag(sha1);
-			parse_tag_buffer(tag, buffer, size);
-			obj = &tag->object;
-		} else {
-			obj = NULL;
-		}
-		free(buffer);
+
+		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
+		if (!eaten)
+			free(buffer);
 		return obj;
 	}
 	return NULL;
diff --git a/object.h b/object.h
index 3d4ff46..caee733 100644
--- a/object.h
+++ b/object.h
@@ -59,6 +59,12 @@ void created_object(const unsigned char 
 /** Returns the object, having parsed it to find out what it is. **/
 struct object *parse_object(const unsigned char *sha1);
 
+/* Given the result of read_sha1_file(), returns the object after
+ * parsing it.  eaten_p indicates if the object has a borrowed copy
+ * of buffer and the caller should not free() it.
+ */
+struct object *parse_object_buffer(const unsigned char *sha1, const char *type, unsigned long size, void *buffer, int *eaten_p);
+
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
 
diff --git a/quote.c b/quote.c
index e3a4d4a..ee7d62c 100644
--- a/quote.c
+++ b/quote.c
@@ -349,3 +349,41 @@ void write_name_quoted(const char *prefi
 	else
 		goto no_quote;
 }
+
+/* quoting as a string literal for other languages */
+
+void perl_quote_print(FILE *stream, const char *src)
+{
+	const char sq = '\'';
+	const char bq = '\\';
+	char c;
+
+	fputc(sq, stream);
+	while ((c = *src++)) {
+		if (c == sq || c == bq)
+			fputc(bq, stream);
+		fputc(c, stream);
+	}
+	fputc(sq, stream);
+}
+
+void python_quote_print(FILE *stream, const char *src)
+{
+	const char sq = '\'';
+	const char bq = '\\';
+	const char nl = '\n';
+	char c;
+
+	fputc(sq, stream);
+	while ((c = *src++)) {
+		if (c == nl) {
+			fputc(bq, stream);
+			fputc('n', stream);
+			continue;
+		}
+		if (c == sq || c == bq)
+			fputc(bq, stream);
+		fputc(c, stream);
+	}
+	fputc(sq, stream);
+}
diff --git a/quote.h b/quote.h
index 1a29e79..b55e699 100644
--- a/quote.h
+++ b/quote.h
@@ -52,4 +52,8 @@ extern char *unquote_c_style(const char 
 extern void write_name_quoted(const char *prefix, int prefix_len,
 			      const char *name, int quote, FILE *out);
 
+/* quoting as a string literal for other languages */
+extern void perl_quote_print(FILE *stream, const char *src);
+extern void python_quote_print(FILE *stream, const char *src);
+
 #endif
-- 
1.4.2.1.gcd6f1
