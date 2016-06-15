From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v5 08/10] ref-filter: move code from 'for-each-ref'
Date: Sat,  6 Jun 2015 12:39:39 +0530
Message-ID: <1433574581-23980-8-git-send-email-karthik.188@gmail.com>
References: <55729B78.1070207@gmail.com>
 <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 09:11:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z18Fk-0003HA-J4
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 09:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbbFFHKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 03:10:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33880 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbbFFHKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 03:10:16 -0400
Received: by payr10 with SMTP id r10so63444404pay.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JMljIwuQTZ4eFLQS3BsWAsxkZbmw/me7EwLmA+9Frxc=;
        b=DHt2Ngae2ReFgInCaI4LotxDmDPqcHxNfH26VPFDR6Ia9qzGuSdQ7NfByj3/eEfNHe
         vc7+5iEG2PgDKemQEXkJz5gU4Agl/8hLqP4WXl3G8gYQ6JO8DHDENCFcmnR/JpLR1UkV
         7E4/GEk/lx7v4umhf6XI+Jsoj7bdmbogFwxdztsUTA84mjtD6zsfKtiBKlIZPoErNMWi
         /IOE8parHft2DGBLjMTbfqk5BVZN9AVKMJhHX36xqOuqXaTp24PosHNYTM9m8Mb2Lvie
         oceVbgDHP4kUAOXZ0YzUnyeSJ7IgMjTKBc62ZEinUDn3Zt8VsKp7CunBEFEQKkuNZNGE
         1W+w==
X-Received: by 10.70.33.67 with SMTP id p3mr11987062pdi.126.1433574615263;
        Sat, 06 Jun 2015 00:10:15 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ve1sm8572230pbc.52.2015.06.06.00.10.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 00:10:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270910>

Move most of the code from 'for-each-ref' to 'ref-filter' to make
it publicly available to other commands, this is to unify the code
of 'tag -l', 'branch -l' and 'for-each-ref' so that they can share
their implementations with each other.

Add 'ref-filter' to the Makefile, this completes the movement of code
from 'for-each-ref' to 'ref-filter'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Makefile               |    1 +
 builtin/for-each-ref.c | 1059 -----------------------------------------------
 ref-filter.c           | 1062 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1063 insertions(+), 1059 deletions(-)
 create mode 100644 ref-filter.c

diff --git a/Makefile b/Makefile
index 54ec511..d715b66 100644
--- a/Makefile
+++ b/Makefile
@@ -762,6 +762,7 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
+LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 39f7c9a..e237194 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -2,1068 +2,9 @@
 #include "cache.h"
 #include "refs.h"
 #include "object.h"
-#include "tag.h"
-#include "commit.h"
-#include "tree.h"
-#include "blob.h"
-#include "quote.h"
 #include "parse-options.h"
-#include "remote.h"
-#include "color.h"
 #include "ref-filter.h"
 
-typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
-
-static struct {
-	const char *name;
-	cmp_type cmp_type;
-} valid_atom[] = {
-	{ "refname" },
-	{ "objecttype" },
-	{ "objectsize", FIELD_ULONG },
-	{ "objectname" },
-	{ "tree" },
-	{ "parent" },
-	{ "numparent", FIELD_ULONG },
-	{ "object" },
-	{ "type" },
-	{ "tag" },
-	{ "author" },
-	{ "authorname" },
-	{ "authoremail" },
-	{ "authordate", FIELD_TIME },
-	{ "committer" },
-	{ "committername" },
-	{ "committeremail" },
-	{ "committerdate", FIELD_TIME },
-	{ "tagger" },
-	{ "taggername" },
-	{ "taggeremail" },
-	{ "taggerdate", FIELD_TIME },
-	{ "creator" },
-	{ "creatordate", FIELD_TIME },
-	{ "subject" },
-	{ "body" },
-	{ "contents" },
-	{ "contents:subject" },
-	{ "contents:body" },
-	{ "contents:signature" },
-	{ "upstream" },
-	{ "symref" },
-	{ "flag" },
-	{ "HEAD" },
-	{ "color" },
-};
-
-/*
- * An atom is a valid field atom listed above, possibly prefixed with
- * a "*" to denote deref_tag().
- *
- * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  ref_array_item
- * structure will hold an array of values extracted that can be
- * indexed with the "atom number", which is an index into this
- * array.
- */
-static const char **used_atom;
-static cmp_type *used_atom_type;
-static int used_atom_cnt, need_tagged, need_symref;
-static int need_color_reset_at_eol;
-
-/*
- * Used to parse format string and sort specifiers
- */
-int parse_ref_filter_atom(const char *atom, const char *ep)
-{
-	const char *sp;
-	int i, at;
-
-	sp = atom;
-	if (*sp == '*' && sp < ep)
-		sp++; /* deref */
-	if (ep <= sp)
-		die("malformed field name: %.*s", (int)(ep-atom), atom);
-
-	/* Do we have the atom already used elsewhere? */
-	for (i = 0; i < used_atom_cnt; i++) {
-		int len = strlen(used_atom[i]);
-		if (len == ep - atom && !memcmp(used_atom[i], atom, len))
-			return i;
-	}
-
-	/* Is the atom a valid one? */
-	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
-		int len = strlen(valid_atom[i].name);
-		/*
-		 * If the atom name has a colon, strip it and everything after
-		 * it off - it specifies the format for this entry, and
-		 * shouldn't be used for checking against the valid_atom
-		 * table.
-		 */
-		const char *formatp = strchr(sp, ':');
-		if (!formatp || ep < formatp)
-			formatp = ep;
-		if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
-			break;
-	}
-
-	if (ARRAY_SIZE(valid_atom) <= i)
-		die("unknown field name: %.*s", (int)(ep-atom), atom);
-
-	/* Add it in, including the deref prefix */
-	at = used_atom_cnt;
-	used_atom_cnt++;
-	REALLOC_ARRAY(used_atom, used_atom_cnt);
-	REALLOC_ARRAY(used_atom_type, used_atom_cnt);
-	used_atom[at] = xmemdupz(atom, ep - atom);
-	used_atom_type[at] = valid_atom[i].cmp_type;
-	if (*atom == '*')
-		need_tagged = 1;
-	if (!strcmp(used_atom[at], "symref"))
-		need_symref = 1;
-	return at;
-}
-
-/*
- * In a format string, find the next occurrence of %(atom).
- */
-static const char *find_next(const char *cp)
-{
-	while (*cp) {
-		if (*cp == '%') {
-			/*
-			 * %( is the start of an atom;
-			 * %% is a quoted per-cent.
-			 */
-			if (cp[1] == '(')
-				return cp;
-			else if (cp[1] == '%')
-				cp++; /* skip over two % */
-			/* otherwise this is a singleton, literal % */
-		}
-		cp++;
-	}
-	return NULL;
-}
-
-/*
- * Make sure the format string is well formed, and parse out
- * the used atoms.
- */
-int verify_ref_format(const char *format)
-{
-	const char *cp, *sp;
-
-	need_color_reset_at_eol = 0;
-	for (cp = format; *cp && (sp = find_next(cp)); ) {
-		const char *color, *ep = strchr(sp, ')');
-		int at;
-
-		if (!ep)
-			return error("malformed format string %s", sp);
-		/* sp points at "%(" and ep points at the closing ")" */
-		at = parse_ref_filter_atom(sp + 2, ep);
-		cp = ep + 1;
-
-		if (skip_prefix(used_atom[at], "color:", &color))
-			need_color_reset_at_eol = !!strcmp(color, "reset");
-	}
-	return 0;
-}
-
-/*
- * Given an object name, read the object data and size, and return a
- * "struct object".  If the object data we are returning is also borrowed
- * by the "struct object" representation, set *eaten as well---it is a
- * signal from parse_object_buffer to us not to free the buffer.
- */
-static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned long *sz, int *eaten)
-{
-	enum object_type type;
-	void *buf = read_sha1_file(sha1, &type, sz);
-
-	if (buf)
-		*obj = parse_object_buffer(sha1, type, *sz, buf, eaten);
-	else
-		*obj = NULL;
-	return buf;
-}
-
-static int grab_objectname(const char *name, const unsigned char *sha1,
-			    struct atom_value *v)
-{
-	if (!strcmp(name, "objectname")) {
-		char *s = xmalloc(41);
-		strcpy(s, sha1_to_hex(sha1));
-		v->s = s;
-		return 1;
-	}
-	if (!strcmp(name, "objectname:short")) {
-		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
-		return 1;
-	}
-	return 0;
-}
-
-/* See grab_values */
-static void grab_common_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
-{
-	int i;
-
-	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
-		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
-			continue;
-		if (deref)
-			name++;
-		if (!strcmp(name, "objecttype"))
-			v->s = typename(obj->type);
-		else if (!strcmp(name, "objectsize")) {
-			char *s = xmalloc(40);
-			sprintf(s, "%lu", sz);
-			v->ul = sz;
-			v->s = s;
-		}
-		else if (deref)
-			grab_objectname(name, obj->sha1, v);
-	}
-}
-
-/* See grab_values */
-static void grab_tag_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
-{
-	int i;
-	struct tag *tag = (struct tag *) obj;
-
-	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
-		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
-			continue;
-		if (deref)
-			name++;
-		if (!strcmp(name, "tag"))
-			v->s = tag->tag;
-		else if (!strcmp(name, "type") && tag->tagged)
-			v->s = typename(tag->tagged->type);
-		else if (!strcmp(name, "object") && tag->tagged) {
-			char *s = xmalloc(41);
-			strcpy(s, sha1_to_hex(tag->tagged->sha1));
-			v->s = s;
-		}
-	}
-}
-
-/* See grab_values */
-static void grab_commit_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
-{
-	int i;
-	struct commit *commit = (struct commit *) obj;
-
-	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
-		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
-			continue;
-		if (deref)
-			name++;
-		if (!strcmp(name, "tree")) {
-			char *s = xmalloc(41);
-			strcpy(s, sha1_to_hex(commit->tree->object.sha1));
-			v->s = s;
-		}
-		if (!strcmp(name, "numparent")) {
-			char *s = xmalloc(40);
-			v->ul = commit_list_count(commit->parents);
-			sprintf(s, "%lu", v->ul);
-			v->s = s;
-		}
-		else if (!strcmp(name, "parent")) {
-			int num = commit_list_count(commit->parents);
-			int i;
-			struct commit_list *parents;
-			char *s = xmalloc(41 * num + 1);
-			v->s = s;
-			for (i = 0, parents = commit->parents;
-			     parents;
-			     parents = parents->next, i = i + 41) {
-				struct commit *parent = parents->item;
-				strcpy(s+i, sha1_to_hex(parent->object.sha1));
-				if (parents->next)
-					s[i+40] = ' ';
-			}
-			if (!i)
-				*s = '\0';
-		}
-	}
-}
-
-static const char *find_wholine(const char *who, int wholen, const char *buf, unsigned long sz)
-{
-	const char *eol;
-	while (*buf) {
-		if (!strncmp(buf, who, wholen) &&
-		    buf[wholen] == ' ')
-			return buf + wholen + 1;
-		eol = strchr(buf, '\n');
-		if (!eol)
-			return "";
-		eol++;
-		if (*eol == '\n')
-			return ""; /* end of header */
-		buf = eol;
-	}
-	return "";
-}
-
-static const char *copy_line(const char *buf)
-{
-	const char *eol = strchrnul(buf, '\n');
-	return xmemdupz(buf, eol - buf);
-}
-
-static const char *copy_name(const char *buf)
-{
-	const char *cp;
-	for (cp = buf; *cp && *cp != '\n'; cp++) {
-		if (!strncmp(cp, " <", 2))
-			return xmemdupz(buf, cp - buf);
-	}
-	return "";
-}
-
-static const char *copy_email(const char *buf)
-{
-	const char *email = strchr(buf, '<');
-	const char *eoemail;
-	if (!email)
-		return "";
-	eoemail = strchr(email, '>');
-	if (!eoemail)
-		return "";
-	return xmemdupz(email, eoemail + 1 - email);
-}
-
-static char *copy_subject(const char *buf, unsigned long len)
-{
-	char *r = xmemdupz(buf, len);
-	int i;
-
-	for (i = 0; i < len; i++)
-		if (r[i] == '\n')
-			r[i] = ' ';
-
-	return r;
-}
-
-static void grab_date(const char *buf, struct atom_value *v, const char *atomname)
-{
-	const char *eoemail = strstr(buf, "> ");
-	char *zone;
-	unsigned long timestamp;
-	long tz;
-	enum date_mode date_mode = DATE_NORMAL;
-	const char *formatp;
-
-	/*
-	 * We got here because atomname ends in "date" or "date<something>";
-	 * it's not possible that <something> is not ":<format>" because
-	 * parse_ref_filter_atom() wouldn't have allowed it, so we can assume that no
-	 * ":" means no format is specified, and use the default.
-	 */
-	formatp = strchr(atomname, ':');
-	if (formatp != NULL) {
-		formatp++;
-		date_mode = parse_date_format(formatp);
-	}
-
-	if (!eoemail)
-		goto bad;
-	timestamp = strtoul(eoemail + 2, &zone, 10);
-	if (timestamp == ULONG_MAX)
-		goto bad;
-	tz = strtol(zone, NULL, 10);
-	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
-		goto bad;
-	v->s = xstrdup(show_date(timestamp, tz, date_mode));
-	v->ul = timestamp;
-	return;
- bad:
-	v->s = "";
-	v->ul = 0;
-}
-
-/* See grab_values */
-static void grab_person(const char *who, struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
-{
-	int i;
-	int wholen = strlen(who);
-	const char *wholine = NULL;
-
-	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
-		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
-			continue;
-		if (deref)
-			name++;
-		if (strncmp(who, name, wholen))
-			continue;
-		if (name[wholen] != 0 &&
-		    strcmp(name + wholen, "name") &&
-		    strcmp(name + wholen, "email") &&
-		    !starts_with(name + wholen, "date"))
-			continue;
-		if (!wholine)
-			wholine = find_wholine(who, wholen, buf, sz);
-		if (!wholine)
-			return; /* no point looking for it */
-		if (name[wholen] == 0)
-			v->s = copy_line(wholine);
-		else if (!strcmp(name + wholen, "name"))
-			v->s = copy_name(wholine);
-		else if (!strcmp(name + wholen, "email"))
-			v->s = copy_email(wholine);
-		else if (starts_with(name + wholen, "date"))
-			grab_date(wholine, v, name);
-	}
-
-	/*
-	 * For a tag or a commit object, if "creator" or "creatordate" is
-	 * requested, do something special.
-	 */
-	if (strcmp(who, "tagger") && strcmp(who, "committer"))
-		return; /* "author" for commit object is not wanted */
-	if (!wholine)
-		wholine = find_wholine(who, wholen, buf, sz);
-	if (!wholine)
-		return;
-	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
-		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
-			continue;
-		if (deref)
-			name++;
-
-		if (starts_with(name, "creatordate"))
-			grab_date(wholine, v, name);
-		else if (!strcmp(name, "creator"))
-			v->s = copy_line(wholine);
-	}
-}
-
-static void find_subpos(const char *buf, unsigned long sz,
-			const char **sub, unsigned long *sublen,
-			const char **body, unsigned long *bodylen,
-			unsigned long *nonsiglen,
-			const char **sig, unsigned long *siglen)
-{
-	const char *eol;
-	/* skip past header until we hit empty line */
-	while (*buf && *buf != '\n') {
-		eol = strchrnul(buf, '\n');
-		if (*eol)
-			eol++;
-		buf = eol;
-	}
-	/* skip any empty lines */
-	while (*buf == '\n')
-		buf++;
-
-	/* parse signature first; we might not even have a subject line */
-	*sig = buf + parse_signature(buf, strlen(buf));
-	*siglen = strlen(*sig);
-
-	/* subject is first non-empty line */
-	*sub = buf;
-	/* subject goes to first empty line */
-	while (buf < *sig && *buf && *buf != '\n') {
-		eol = strchrnul(buf, '\n');
-		if (*eol)
-			eol++;
-		buf = eol;
-	}
-	*sublen = buf - *sub;
-	/* drop trailing newline, if present */
-	if (*sublen && (*sub)[*sublen - 1] == '\n')
-		*sublen -= 1;
-
-	/* skip any empty lines */
-	while (*buf == '\n')
-		buf++;
-	*body = buf;
-	*bodylen = strlen(buf);
-	*nonsiglen = *sig - buf;
-}
-
-/* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
-{
-	int i;
-	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
-	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
-
-	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
-		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
-			continue;
-		if (deref)
-			name++;
-		if (strcmp(name, "subject") &&
-		    strcmp(name, "body") &&
-		    strcmp(name, "contents") &&
-		    strcmp(name, "contents:subject") &&
-		    strcmp(name, "contents:body") &&
-		    strcmp(name, "contents:signature"))
-			continue;
-		if (!subpos)
-			find_subpos(buf, sz,
-				    &subpos, &sublen,
-				    &bodypos, &bodylen, &nonsiglen,
-				    &sigpos, &siglen);
-
-		if (!strcmp(name, "subject"))
-			v->s = copy_subject(subpos, sublen);
-		else if (!strcmp(name, "contents:subject"))
-			v->s = copy_subject(subpos, sublen);
-		else if (!strcmp(name, "body"))
-			v->s = xmemdupz(bodypos, bodylen);
-		else if (!strcmp(name, "contents:body"))
-			v->s = xmemdupz(bodypos, nonsiglen);
-		else if (!strcmp(name, "contents:signature"))
-			v->s = xmemdupz(sigpos, siglen);
-		else if (!strcmp(name, "contents"))
-			v->s = xstrdup(subpos);
-	}
-}
-
-/*
- * We want to have empty print-string for field requests
- * that do not apply (e.g. "authordate" for a tag object)
- */
-static void fill_missing_values(struct atom_value *val)
-{
-	int i;
-	for (i = 0; i < used_atom_cnt; i++) {
-		struct atom_value *v = &val[i];
-		if (v->s == NULL)
-			v->s = "";
-	}
-}
-
-/*
- * val is a list of atom_value to hold returned values.  Extract
- * the values for atoms in used_atom array out of (obj, buf, sz).
- * when deref is false, (obj, buf, sz) is the object that is
- * pointed at by the ref itself; otherwise it is the object the
- * ref (which is a tag) refers to.
- */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
-{
-	grab_common_values(val, deref, obj, buf, sz);
-	switch (obj->type) {
-	case OBJ_TAG:
-		grab_tag_values(val, deref, obj, buf, sz);
-		grab_sub_body_contents(val, deref, obj, buf, sz);
-		grab_person("tagger", val, deref, obj, buf, sz);
-		break;
-	case OBJ_COMMIT:
-		grab_commit_values(val, deref, obj, buf, sz);
-		grab_sub_body_contents(val, deref, obj, buf, sz);
-		grab_person("author", val, deref, obj, buf, sz);
-		grab_person("committer", val, deref, obj, buf, sz);
-		break;
-	case OBJ_TREE:
-		/* grab_tree_values(val, deref, obj, buf, sz); */
-		break;
-	case OBJ_BLOB:
-		/* grab_blob_values(val, deref, obj, buf, sz); */
-		break;
-	default:
-		die("Eh?  Object of type %d?", obj->type);
-	}
-}
-
-static inline char *copy_advance(char *dst, const char *src)
-{
-	while (*src)
-		*dst++ = *src++;
-	return dst;
-}
-
-/*
- * Parse the object referred by ref, and grab needed value.
- */
-static void populate_value(struct ref_array_item *ref)
-{
-	void *buf;
-	struct object *obj;
-	int eaten, i;
-	unsigned long size;
-	const unsigned char *tagged;
-
-	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
-
-	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
-		unsigned char unused1[20];
-		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
-					     unused1, NULL);
-		if (!ref->symref)
-			ref->symref = "";
-	}
-
-	/* Fill in specials first */
-	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
-		struct atom_value *v = &ref->value[i];
-		int deref = 0;
-		const char *refname;
-		const char *formatp;
-		struct branch *branch = NULL;
-
-		if (*name == '*') {
-			deref = 1;
-			name++;
-		}
-
-		if (starts_with(name, "refname"))
-			refname = ref->refname;
-		else if (starts_with(name, "symref"))
-			refname = ref->symref ? ref->symref : "";
-		else if (starts_with(name, "upstream")) {
-			/* only local branches may have an upstream */
-			if (!starts_with(ref->refname, "refs/heads/"))
-				continue;
-			branch = branch_get(ref->refname + 11);
-
-			if (!branch || !branch->merge || !branch->merge[0] ||
-			    !branch->merge[0]->dst)
-				continue;
-			refname = branch->merge[0]->dst;
-		} else if (starts_with(name, "color:")) {
-			char color[COLOR_MAXLEN] = "";
-
-			if (color_parse(name + 6, color) < 0)
-				die(_("unable to parse format"));
-			v->s = xstrdup(color);
-			continue;
-		} else if (!strcmp(name, "flag")) {
-			char buf[256], *cp = buf;
-			if (ref->flag & REF_ISSYMREF)
-				cp = copy_advance(cp, ",symref");
-			if (ref->flag & REF_ISPACKED)
-				cp = copy_advance(cp, ",packed");
-			if (cp == buf)
-				v->s = "";
-			else {
-				*cp = '\0';
-				v->s = xstrdup(buf + 1);
-			}
-			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname, v)) {
-			continue;
-		} else if (!strcmp(name, "HEAD")) {
-			const char *head;
-			unsigned char sha1[20];
-
-			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-						  sha1, NULL);
-			if (!strcmp(ref->refname, head))
-				v->s = "*";
-			else
-				v->s = " ";
-			continue;
-		} else
-			continue;
-
-		formatp = strchr(name, ':');
-		if (formatp) {
-			int num_ours, num_theirs;
-
-			formatp++;
-			if (!strcmp(formatp, "short"))
-				refname = shorten_unambiguous_ref(refname,
-						      warn_ambiguous_refs);
-			else if (!strcmp(formatp, "track") &&
-				 starts_with(name, "upstream")) {
-				char buf[40];
-
-				if (stat_tracking_info(branch, &num_ours,
-						       &num_theirs) != 1)
-					continue;
-
-				if (!num_ours && !num_theirs)
-					v->s = "";
-				else if (!num_ours) {
-					sprintf(buf, "[behind %d]", num_theirs);
-					v->s = xstrdup(buf);
-				} else if (!num_theirs) {
-					sprintf(buf, "[ahead %d]", num_ours);
-					v->s = xstrdup(buf);
-				} else {
-					sprintf(buf, "[ahead %d, behind %d]",
-						num_ours, num_theirs);
-					v->s = xstrdup(buf);
-				}
-				continue;
-			} else if (!strcmp(formatp, "trackshort") &&
-				   starts_with(name, "upstream")) {
-				assert(branch);
-
-				if (stat_tracking_info(branch, &num_ours,
-							&num_theirs) != 1)
-					continue;
-
-				if (!num_ours && !num_theirs)
-					v->s = "=";
-				else if (!num_ours)
-					v->s = "<";
-				else if (!num_theirs)
-					v->s = ">";
-				else
-					v->s = "<>";
-				continue;
-			} else
-				die("unknown %.*s format %s",
-				    (int)(formatp - name), name, formatp);
-		}
-
-		if (!deref)
-			v->s = refname;
-		else {
-			int len = strlen(refname);
-			char *s = xmalloc(len + 4);
-			sprintf(s, "%s^{}", refname);
-			v->s = s;
-		}
-	}
-
-	for (i = 0; i < used_atom_cnt; i++) {
-		struct atom_value *v = &ref->value[i];
-		if (v->s == NULL)
-			goto need_obj;
-	}
-	return;
-
- need_obj:
-	buf = get_obj(ref->objectname, &obj, &size, &eaten);
-	if (!buf)
-		die("missing object %s for %s",
-		    sha1_to_hex(ref->objectname), ref->refname);
-	if (!obj)
-		die("parse_object_buffer failed on %s for %s",
-		    sha1_to_hex(ref->objectname), ref->refname);
-
-	grab_values(ref->value, 0, obj, buf, size);
-	if (!eaten)
-		free(buf);
-
-	/*
-	 * If there is no atom that wants to know about tagged
-	 * object, we are done.
-	 */
-	if (!need_tagged || (obj->type != OBJ_TAG))
-		return;
-
-	/*
-	 * If it is a tag object, see if we use a value that derefs
-	 * the object, and if we do grab the object it refers to.
-	 */
-	tagged = ((struct tag *)obj)->tagged->sha1;
-
-	/*
-	 * NEEDSWORK: This derefs tag only once, which
-	 * is good to deal with chains of trust, but
-	 * is not consistent with what deref_tag() does
-	 * which peels the onion to the core.
-	 */
-	buf = get_obj(tagged, &obj, &size, &eaten);
-	if (!buf)
-		die("missing object %s for %s",
-		    sha1_to_hex(tagged), ref->refname);
-	if (!obj)
-		die("parse_object_buffer failed on %s for %s",
-		    sha1_to_hex(tagged), ref->refname);
-	grab_values(ref->value, 1, obj, buf, size);
-	if (!eaten)
-		free(buf);
-}
-
-/*
- * Given a ref, return the value for the atom.  This lazily gets value
- * out of the object by calling populate value.
- */
-static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
-{
-	if (!ref->value) {
-		populate_value(ref);
-		fill_missing_values(ref->value);
-	}
-	*v = &ref->value[atom];
-}
-
-/*
- * Given a refname, return 1 if the refname matches with one of the patterns
- * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
- * and so on, else return 0. Supports use of wild characters.
- */
-static int match_name_as_path(const char **pattern, const char *refname)
-{
-	int namelen = strlen(refname);
-	for (; *pattern; pattern++) {
-		const char *p = *pattern;
-		int plen = strlen(p);
-
-		if ((plen <= namelen) &&
-		    !strncmp(refname, p, plen) &&
-		    (refname[plen] == '\0' ||
-		     refname[plen] == '/' ||
-		     p[plen-1] == '/'))
-			return 1;
-		if (!wildmatch(p, refname, WM_PATHNAME, NULL))
-			return 1;
-	}
-	return 0;
-}
-
-/* Allocate space for a new ref_array_item and copy the objectname and flag to it */
-static struct ref_array_item *new_ref_array_item(const char *refname,
-						 const unsigned char *objectname,
-						 int flag)
-{
-	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item));
-	ref->refname = xstrdup(refname);
-	hashcpy(ref->objectname, objectname);
-	ref->flag = flag;
-
-	return ref;
-}
-
-/*
- * A call-back given to for_each_ref().  Filter refs and keep them for
- * later object processing.
- */
-int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct ref_filter_cbdata *ref_cbdata = cb_data;
-	struct ref_filter *filter = &ref_cbdata->filter;
-	struct ref_array_item *ref;
-
-	if (flag & REF_BAD_NAME) {
-		  warning("ignoring ref with broken name %s", refname);
-		  return 0;
-	}
-
-	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
-		return 0;
-
-	/*
-	 * We do not open the object yet; sort may only need refname
-	 * to do its job and the resulting list may yet to be pruned
-	 * by maxcount logic.
-	 */
-	ref = new_ref_array_item(refname, sha1, flag);
-
-	REALLOC_ARRAY(ref_cbdata->array.items, ref_cbdata->array.nr + 1);
-	ref_cbdata->array.items[ref_cbdata->array.nr++] = ref;
-	return 0;
-}
-
-/*  Free memory allocated for a ref_array_item */
-static void free_array_item(struct ref_array_item *item)
-{
-	free(item->symref);
-	free(item->refname);
-	free(item);
-}
-
-/* Free all memory allocated for ref_array */
-void ref_array_clear(struct ref_array *array)
-{
-	int i;
-
-	for (i = 0; i < array->nr; i++)
-		free_array_item(array->items[i]);
-	free(array->items);
-	array->items = NULL;
-	array->nr = array->alloc = 0;
-}
-
-static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
-{
-	struct atom_value *va, *vb;
-	int cmp;
-	cmp_type cmp_type = used_atom_type[s->atom];
-
-	get_ref_atom_value(a, s->atom, &va);
-	get_ref_atom_value(b, s->atom, &vb);
-	switch (cmp_type) {
-	case FIELD_STR:
-		cmp = strcmp(va->s, vb->s);
-		break;
-	default:
-		if (va->ul < vb->ul)
-			cmp = -1;
-		else if (va->ul == vb->ul)
-			cmp = 0;
-		else
-			cmp = 1;
-		break;
-	}
-	return (s->reverse) ? -cmp : cmp;
-}
-
-static struct ref_sorting *ref_sorting;
-static int compare_refs(const void *a_, const void *b_)
-{
-	struct ref_array_item *a = *((struct ref_array_item **)a_);
-	struct ref_array_item *b = *((struct ref_array_item **)b_);
-	struct ref_sorting *s;
-
-	for (s = ref_sorting; s; s = s->next) {
-		int cmp = cmp_ref_sorting(s, a, b);
-		if (cmp)
-			return cmp;
-	}
-	return 0;
-}
-
-void ref_array_sort(struct ref_sorting *sort, struct ref_array *array)
-{
-	ref_sorting = sort;
-	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
-}
-
-static void print_value(struct atom_value *v, int quote_style)
-{
-	struct strbuf sb = STRBUF_INIT;
-	switch (quote_style) {
-	case QUOTE_NONE:
-		fputs(v->s, stdout);
-		break;
-	case QUOTE_SHELL:
-		sq_quote_buf(&sb, v->s);
-		break;
-	case QUOTE_PERL:
-		perl_quote_buf(&sb, v->s);
-		break;
-	case QUOTE_PYTHON:
-		python_quote_buf(&sb, v->s);
-		break;
-	case QUOTE_TCL:
-		tcl_quote_buf(&sb, v->s);
-		break;
-	}
-	if (quote_style != QUOTE_NONE) {
-		fputs(sb.buf, stdout);
-		strbuf_release(&sb);
-	}
-}
-
-static int hex1(char ch)
-{
-	if ('0' <= ch && ch <= '9')
-		return ch - '0';
-	else if ('a' <= ch && ch <= 'f')
-		return ch - 'a' + 10;
-	else if ('A' <= ch && ch <= 'F')
-		return ch - 'A' + 10;
-	return -1;
-}
-static int hex2(const char *cp)
-{
-	if (cp[0] && cp[1])
-		return (hex1(cp[0]) << 4) | hex1(cp[1]);
-	else
-		return -1;
-}
-
-static void emit(const char *cp, const char *ep)
-{
-	while (*cp && (!ep || cp < ep)) {
-		if (*cp == '%') {
-			if (cp[1] == '%')
-				cp++;
-			else {
-				int ch = hex2(cp + 1);
-				if (0 <= ch) {
-					putchar(ch);
-					cp += 3;
-					continue;
-				}
-			}
-		}
-		putchar(*cp);
-		cp++;
-	}
-}
-
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
-{
-	const char *cp, *sp, *ep;
-
-	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
-		struct atom_value *atomv;
-
-		ep = strchr(sp, ')');
-		if (cp < sp)
-			emit(cp, sp);
-		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style);
-	}
-	if (*cp) {
-		sp = cp + strlen(cp);
-		emit(cp, sp);
-	}
-	if (need_color_reset_at_eol) {
-		struct atom_value resetv;
-		char color[COLOR_MAXLEN] = "";
-
-		if (color_parse("reset", color) < 0)
-			die("BUG: couldn't parse 'reset' as a color");
-		resetv.s = color;
-		print_value(&resetv, quote_style);
-	}
-	putchar('\n');
-}
-
-/*  If no sorting option is given, use refname to sort as default */
-struct ref_sorting *ref_default_sorting(void)
-{
-	static const char cstr_name[] = "refname";
-
-	struct ref_sorting *sort = xcalloc(1, sizeof(*sort));
-
-	sort->next = NULL;
-	sort->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
-	return sort;
-}
-
-int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
-{
-	struct ref_sorting **sort_tail = opt->value;
-	struct ref_sorting *s;
-	int len;
-
-	if (!arg) /* should --no-sort void the list ? */
-		return -1;
-
-	s = xcalloc(1, sizeof(*s));
-	s->next = *sort_tail;
-	*sort_tail = s;
-
-	if (*arg == '-') {
-		s->reverse = 1;
-		arg++;
-	}
-	len = strlen(arg);
-	s->atom = parse_ref_filter_atom(arg, arg+len);
-	return 0;
-}
-
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	NULL
diff --git a/ref-filter.c b/ref-filter.c
new file mode 100644
index 0000000..95e72f6
--- /dev/null
+++ b/ref-filter.c
@@ -0,0 +1,1062 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "refs.h"
+#include "wildmatch.h"
+#include "commit.h"
+#include "remote.h"
+#include "color.h"
+#include "tag.h"
+#include "quote.h"
+
+typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
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
+	{ "parent" },
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
+	{ "creator" },
+	{ "creatordate", FIELD_TIME },
+	{ "subject" },
+	{ "body" },
+	{ "contents" },
+	{ "contents:subject" },
+	{ "contents:body" },
+	{ "contents:signature" },
+	{ "upstream" },
+	{ "symref" },
+	{ "flag" },
+	{ "HEAD" },
+	{ "color" },
+};
+
+/*
+ * An atom is a valid field atom listed above, possibly prefixed with
+ * a "*" to denote deref_tag().
+ *
+ * We parse given format string and sort specifiers, and make a list
+ * of properties that we need to extract out of objects.  ref_array_item
+ * structure will hold an array of values extracted that can be
+ * indexed with the "atom number", which is an index into this
+ * array.
+ */
+static const char **used_atom;
+static cmp_type *used_atom_type;
+static int used_atom_cnt, need_tagged, need_symref;
+static int need_color_reset_at_eol;
+
+/*
+ * Used to parse format string and sort specifiers
+ */
+int parse_ref_filter_atom(const char *atom, const char *ep)
+{
+	const char *sp;
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
+		/*
+		 * If the atom name has a colon, strip it and everything after
+		 * it off - it specifies the format for this entry, and
+		 * shouldn't be used for checking against the valid_atom
+		 * table.
+		 */
+		const char *formatp = strchr(sp, ':');
+		if (!formatp || ep < formatp)
+			formatp = ep;
+		if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
+			break;
+	}
+
+	if (ARRAY_SIZE(valid_atom) <= i)
+		die("unknown field name: %.*s", (int)(ep-atom), atom);
+
+	/* Add it in, including the deref prefix */
+	at = used_atom_cnt;
+	used_atom_cnt++;
+	REALLOC_ARRAY(used_atom, used_atom_cnt);
+	REALLOC_ARRAY(used_atom_type, used_atom_cnt);
+	used_atom[at] = xmemdupz(atom, ep - atom);
+	used_atom_type[at] = valid_atom[i].cmp_type;
+	if (*atom == '*')
+		need_tagged = 1;
+	if (!strcmp(used_atom[at], "symref"))
+		need_symref = 1;
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
+			/*
+			 * %( is the start of an atom;
+			 * %% is a quoted per-cent.
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
+int verify_ref_format(const char *format)
+{
+	const char *cp, *sp;
+
+	need_color_reset_at_eol = 0;
+	for (cp = format; *cp && (sp = find_next(cp)); ) {
+		const char *color, *ep = strchr(sp, ')');
+		int at;
+
+		if (!ep)
+			return error("malformed format string %s", sp);
+		/* sp points at "%(" and ep points at the closing ")" */
+		at = parse_ref_filter_atom(sp + 2, ep);
+		cp = ep + 1;
+
+		if (skip_prefix(used_atom[at], "color:", &color))
+			need_color_reset_at_eol = !!strcmp(color, "reset");
+	}
+	return 0;
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
+	enum object_type type;
+	void *buf = read_sha1_file(sha1, &type, sz);
+
+	if (buf)
+		*obj = parse_object_buffer(sha1, type, *sz, buf, eaten);
+	else
+		*obj = NULL;
+	return buf;
+}
+
+static int grab_objectname(const char *name, const unsigned char *sha1,
+			    struct atom_value *v)
+{
+	if (!strcmp(name, "objectname")) {
+		char *s = xmalloc(41);
+		strcpy(s, sha1_to_hex(sha1));
+		v->s = s;
+		return 1;
+	}
+	if (!strcmp(name, "objectname:short")) {
+		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
+		return 1;
+	}
+	return 0;
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
+			v->s = typename(obj->type);
+		else if (!strcmp(name, "objectsize")) {
+			char *s = xmalloc(40);
+			sprintf(s, "%lu", sz);
+			v->ul = sz;
+			v->s = s;
+		}
+		else if (deref)
+			grab_objectname(name, obj->sha1, v);
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
+		else if (!strcmp(name, "type") && tag->tagged)
+			v->s = typename(tag->tagged->type);
+		else if (!strcmp(name, "object") && tag->tagged) {
+			char *s = xmalloc(41);
+			strcpy(s, sha1_to_hex(tag->tagged->sha1));
+			v->s = s;
+		}
+	}
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
+			v->ul = commit_list_count(commit->parents);
+			sprintf(s, "%lu", v->ul);
+			v->s = s;
+		}
+		else if (!strcmp(name, "parent")) {
+			int num = commit_list_count(commit->parents);
+			int i;
+			struct commit_list *parents;
+			char *s = xmalloc(41 * num + 1);
+			v->s = s;
+			for (i = 0, parents = commit->parents;
+			     parents;
+			     parents = parents->next, i = i + 41) {
+				struct commit *parent = parents->item;
+				strcpy(s+i, sha1_to_hex(parent->object.sha1));
+				if (parents->next)
+					s[i+40] = ' ';
+			}
+			if (!i)
+				*s = '\0';
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
+		if (*eol == '\n')
+			return ""; /* end of header */
+		buf = eol;
+	}
+	return "";
+}
+
+static const char *copy_line(const char *buf)
+{
+	const char *eol = strchrnul(buf, '\n');
+	return xmemdupz(buf, eol - buf);
+}
+
+static const char *copy_name(const char *buf)
+{
+	const char *cp;
+	for (cp = buf; *cp && *cp != '\n'; cp++) {
+		if (!strncmp(cp, " <", 2))
+			return xmemdupz(buf, cp - buf);
+	}
+	return "";
+}
+
+static const char *copy_email(const char *buf)
+{
+	const char *email = strchr(buf, '<');
+	const char *eoemail;
+	if (!email)
+		return "";
+	eoemail = strchr(email, '>');
+	if (!eoemail)
+		return "";
+	return xmemdupz(email, eoemail + 1 - email);
+}
+
+static char *copy_subject(const char *buf, unsigned long len)
+{
+	char *r = xmemdupz(buf, len);
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (r[i] == '\n')
+			r[i] = ' ';
+
+	return r;
+}
+
+static void grab_date(const char *buf, struct atom_value *v, const char *atomname)
+{
+	const char *eoemail = strstr(buf, "> ");
+	char *zone;
+	unsigned long timestamp;
+	long tz;
+	enum date_mode date_mode = DATE_NORMAL;
+	const char *formatp;
+
+	/*
+	 * We got here because atomname ends in "date" or "date<something>";
+	 * it's not possible that <something> is not ":<format>" because
+	 * parse_ref_filter_atom() wouldn't have allowed it, so we can assume that no
+	 * ":" means no format is specified, and use the default.
+	 */
+	formatp = strchr(atomname, ':');
+	if (formatp != NULL) {
+		formatp++;
+		date_mode = parse_date_format(formatp);
+	}
+
+	if (!eoemail)
+		goto bad;
+	timestamp = strtoul(eoemail + 2, &zone, 10);
+	if (timestamp == ULONG_MAX)
+		goto bad;
+	tz = strtol(zone, NULL, 10);
+	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
+		goto bad;
+	v->s = xstrdup(show_date(timestamp, tz, date_mode));
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
+		    !starts_with(name + wholen, "date"))
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
+		else if (starts_with(name + wholen, "date"))
+			grab_date(wholine, v, name);
+	}
+
+	/*
+	 * For a tag or a commit object, if "creator" or "creatordate" is
+	 * requested, do something special.
+	 */
+	if (strcmp(who, "tagger") && strcmp(who, "committer"))
+		return; /* "author" for commit object is not wanted */
+	if (!wholine)
+		wholine = find_wholine(who, wholen, buf, sz);
+	if (!wholine)
+		return;
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &val[i];
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+
+		if (starts_with(name, "creatordate"))
+			grab_date(wholine, v, name);
+		else if (!strcmp(name, "creator"))
+			v->s = copy_line(wholine);
+	}
+}
+
+static void find_subpos(const char *buf, unsigned long sz,
+			const char **sub, unsigned long *sublen,
+			const char **body, unsigned long *bodylen,
+			unsigned long *nonsiglen,
+			const char **sig, unsigned long *siglen)
+{
+	const char *eol;
+	/* skip past header until we hit empty line */
+	while (*buf && *buf != '\n') {
+		eol = strchrnul(buf, '\n');
+		if (*eol)
+			eol++;
+		buf = eol;
+	}
+	/* skip any empty lines */
+	while (*buf == '\n')
+		buf++;
+
+	/* parse signature first; we might not even have a subject line */
+	*sig = buf + parse_signature(buf, strlen(buf));
+	*siglen = strlen(*sig);
+
+	/* subject is first non-empty line */
+	*sub = buf;
+	/* subject goes to first empty line */
+	while (buf < *sig && *buf && *buf != '\n') {
+		eol = strchrnul(buf, '\n');
+		if (*eol)
+			eol++;
+		buf = eol;
+	}
+	*sublen = buf - *sub;
+	/* drop trailing newline, if present */
+	if (*sublen && (*sub)[*sublen - 1] == '\n')
+		*sublen -= 1;
+
+	/* skip any empty lines */
+	while (*buf == '\n')
+		buf++;
+	*body = buf;
+	*bodylen = strlen(buf);
+	*nonsiglen = *sig - buf;
+}
+
+/* See grab_values */
+static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+{
+	int i;
+	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
+	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
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
+		    strcmp(name, "contents") &&
+		    strcmp(name, "contents:subject") &&
+		    strcmp(name, "contents:body") &&
+		    strcmp(name, "contents:signature"))
+			continue;
+		if (!subpos)
+			find_subpos(buf, sz,
+				    &subpos, &sublen,
+				    &bodypos, &bodylen, &nonsiglen,
+				    &sigpos, &siglen);
+
+		if (!strcmp(name, "subject"))
+			v->s = copy_subject(subpos, sublen);
+		else if (!strcmp(name, "contents:subject"))
+			v->s = copy_subject(subpos, sublen);
+		else if (!strcmp(name, "body"))
+			v->s = xmemdupz(bodypos, bodylen);
+		else if (!strcmp(name, "contents:body"))
+			v->s = xmemdupz(bodypos, nonsiglen);
+		else if (!strcmp(name, "contents:signature"))
+			v->s = xmemdupz(sigpos, siglen);
+		else if (!strcmp(name, "contents"))
+			v->s = xstrdup(subpos);
+	}
+}
+
+/*
+ * We want to have empty print-string for field requests
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
+		/* grab_tree_values(val, deref, obj, buf, sz); */
+		break;
+	case OBJ_BLOB:
+		/* grab_blob_values(val, deref, obj, buf, sz); */
+		break;
+	default:
+		die("Eh?  Object of type %d?", obj->type);
+	}
+}
+
+static inline char *copy_advance(char *dst, const char *src)
+{
+	while (*src)
+		*dst++ = *src++;
+	return dst;
+}
+
+/*
+ * Parse the object referred by ref, and grab needed value.
+ */
+static void populate_value(struct ref_array_item *ref)
+{
+	void *buf;
+	struct object *obj;
+	int eaten, i;
+	unsigned long size;
+	const unsigned char *tagged;
+
+	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
+
+	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
+		unsigned char unused1[20];
+		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
+					     unused1, NULL);
+		if (!ref->symref)
+			ref->symref = "";
+	}
+
+	/* Fill in specials first */
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &ref->value[i];
+		int deref = 0;
+		const char *refname;
+		const char *formatp;
+		struct branch *branch = NULL;
+
+		if (*name == '*') {
+			deref = 1;
+			name++;
+		}
+
+		if (starts_with(name, "refname"))
+			refname = ref->refname;
+		else if (starts_with(name, "symref"))
+			refname = ref->symref ? ref->symref : "";
+		else if (starts_with(name, "upstream")) {
+			/* only local branches may have an upstream */
+			if (!starts_with(ref->refname, "refs/heads/"))
+				continue;
+			branch = branch_get(ref->refname + 11);
+
+			if (!branch || !branch->merge || !branch->merge[0] ||
+			    !branch->merge[0]->dst)
+				continue;
+			refname = branch->merge[0]->dst;
+		} else if (starts_with(name, "color:")) {
+			char color[COLOR_MAXLEN] = "";
+
+			if (color_parse(name + 6, color) < 0)
+				die(_("unable to parse format"));
+			v->s = xstrdup(color);
+			continue;
+		} else if (!strcmp(name, "flag")) {
+			char buf[256], *cp = buf;
+			if (ref->flag & REF_ISSYMREF)
+				cp = copy_advance(cp, ",symref");
+			if (ref->flag & REF_ISPACKED)
+				cp = copy_advance(cp, ",packed");
+			if (cp == buf)
+				v->s = "";
+			else {
+				*cp = '\0';
+				v->s = xstrdup(buf + 1);
+			}
+			continue;
+		} else if (!deref && grab_objectname(name, ref->objectname, v)) {
+			continue;
+		} else if (!strcmp(name, "HEAD")) {
+			const char *head;
+			unsigned char sha1[20];
+
+			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+						  sha1, NULL);
+			if (!strcmp(ref->refname, head))
+				v->s = "*";
+			else
+				v->s = " ";
+			continue;
+		} else
+			continue;
+
+		formatp = strchr(name, ':');
+		if (formatp) {
+			int num_ours, num_theirs;
+
+			formatp++;
+			if (!strcmp(formatp, "short"))
+				refname = shorten_unambiguous_ref(refname,
+						      warn_ambiguous_refs);
+			else if (!strcmp(formatp, "track") &&
+				 starts_with(name, "upstream")) {
+				char buf[40];
+
+				if (stat_tracking_info(branch, &num_ours,
+						       &num_theirs) != 1)
+					continue;
+
+				if (!num_ours && !num_theirs)
+					v->s = "";
+				else if (!num_ours) {
+					sprintf(buf, "[behind %d]", num_theirs);
+					v->s = xstrdup(buf);
+				} else if (!num_theirs) {
+					sprintf(buf, "[ahead %d]", num_ours);
+					v->s = xstrdup(buf);
+				} else {
+					sprintf(buf, "[ahead %d, behind %d]",
+						num_ours, num_theirs);
+					v->s = xstrdup(buf);
+				}
+				continue;
+			} else if (!strcmp(formatp, "trackshort") &&
+				   starts_with(name, "upstream")) {
+				assert(branch);
+
+				if (stat_tracking_info(branch, &num_ours,
+							&num_theirs) != 1)
+					continue;
+
+				if (!num_ours && !num_theirs)
+					v->s = "=";
+				else if (!num_ours)
+					v->s = "<";
+				else if (!num_theirs)
+					v->s = ">";
+				else
+					v->s = "<>";
+				continue;
+			} else
+				die("unknown %.*s format %s",
+				    (int)(formatp - name), name, formatp);
+		}
+
+		if (!deref)
+			v->s = refname;
+		else {
+			int len = strlen(refname);
+			char *s = xmalloc(len + 4);
+			sprintf(s, "%s^{}", refname);
+			v->s = s;
+		}
+	}
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		struct atom_value *v = &ref->value[i];
+		if (v->s == NULL)
+			goto need_obj;
+	}
+	return;
+
+ need_obj:
+	buf = get_obj(ref->objectname, &obj, &size, &eaten);
+	if (!buf)
+		die("missing object %s for %s",
+		    sha1_to_hex(ref->objectname), ref->refname);
+	if (!obj)
+		die("parse_object_buffer failed on %s for %s",
+		    sha1_to_hex(ref->objectname), ref->refname);
+
+	grab_values(ref->value, 0, obj, buf, size);
+	if (!eaten)
+		free(buf);
+
+	/*
+	 * If there is no atom that wants to know about tagged
+	 * object, we are done.
+	 */
+	if (!need_tagged || (obj->type != OBJ_TAG))
+		return;
+
+	/*
+	 * If it is a tag object, see if we use a value that derefs
+	 * the object, and if we do grab the object it refers to.
+	 */
+	tagged = ((struct tag *)obj)->tagged->sha1;
+
+	/*
+	 * NEEDSWORK: This derefs tag only once, which
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
+static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
+{
+	if (!ref->value) {
+		populate_value(ref);
+		fill_missing_values(ref->value);
+	}
+	*v = &ref->value[atom];
+}
+
+/*
+ * Given a refname, return 1 if the refname matches with one of the patterns
+ * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
+ * and so on, else return 0. Supports use of wild characters.
+ */
+static int match_name_as_path(const char **pattern, const char *refname)
+{
+	int namelen = strlen(refname);
+	for (; *pattern; pattern++) {
+		const char *p = *pattern;
+		int plen = strlen(p);
+
+		if ((plen <= namelen) &&
+		    !strncmp(refname, p, plen) &&
+		    (refname[plen] == '\0' ||
+		     refname[plen] == '/' ||
+		     p[plen-1] == '/'))
+			return 1;
+		if (!wildmatch(p, refname, WM_PATHNAME, NULL))
+			return 1;
+	}
+	return 0;
+}
+
+/* Allocate space for a new ref_array_item and copy the objectname and flag to it */
+static struct ref_array_item *new_ref_array_item(const char *refname,
+						 const unsigned char *objectname,
+						 int flag)
+{
+	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item));
+	ref->refname = xstrdup(refname);
+	hashcpy(ref->objectname, objectname);
+	ref->flag = flag;
+
+	return ref;
+}
+
+/*
+ * A call-back given to for_each_ref().  Filter refs and keep them for
+ * later object processing.
+ */
+int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct ref_filter_cbdata *ref_cbdata = cb_data;
+	struct ref_filter *filter = &ref_cbdata->filter;
+	struct ref_array_item *ref;
+
+	if (flag & REF_BAD_NAME) {
+		  warning("ignoring ref with broken name %s", refname);
+		  return 0;
+	}
+
+	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
+		return 0;
+
+	/*
+	 * We do not open the object yet; sort may only need refname
+	 * to do its job and the resulting list may yet to be pruned
+	 * by maxcount logic.
+	 */
+	ref = new_ref_array_item(refname, sha1, flag);
+
+	REALLOC_ARRAY(ref_cbdata->array.items, ref_cbdata->array.nr + 1);
+	ref_cbdata->array.items[ref_cbdata->array.nr++] = ref;
+	return 0;
+}
+
+/*  Free memory allocated for a ref_array_item */
+static void free_array_item(struct ref_array_item *item)
+{
+	free(item->symref);
+	free(item->refname);
+	free(item);
+}
+
+/* Free all memory allocated for ref_array */
+void ref_array_clear(struct ref_array *array)
+{
+	int i;
+
+	for (i = 0; i < array->nr; i++)
+		free_array_item(array->items[i]);
+	free(array->items);
+	array->items = NULL;
+	array->nr = array->alloc = 0;
+}
+
+static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
+{
+	struct atom_value *va, *vb;
+	int cmp;
+	cmp_type cmp_type = used_atom_type[s->atom];
+
+	get_ref_atom_value(a, s->atom, &va);
+	get_ref_atom_value(b, s->atom, &vb);
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
+static struct ref_sorting *ref_sorting;
+static int compare_refs(const void *a_, const void *b_)
+{
+	struct ref_array_item *a = *((struct ref_array_item **)a_);
+	struct ref_array_item *b = *((struct ref_array_item **)b_);
+	struct ref_sorting *s;
+
+	for (s = ref_sorting; s; s = s->next) {
+		int cmp = cmp_ref_sorting(s, a, b);
+		if (cmp)
+			return cmp;
+	}
+	return 0;
+}
+
+void ref_array_sort(struct ref_sorting *sort, struct ref_array *array)
+{
+	ref_sorting = sort;
+	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
+}
+
+static void print_value(struct atom_value *v, int quote_style)
+{
+	struct strbuf sb = STRBUF_INIT;
+	switch (quote_style) {
+	case QUOTE_NONE:
+		fputs(v->s, stdout);
+		break;
+	case QUOTE_SHELL:
+		sq_quote_buf(&sb, v->s);
+		break;
+	case QUOTE_PERL:
+		perl_quote_buf(&sb, v->s);
+		break;
+	case QUOTE_PYTHON:
+		python_quote_buf(&sb, v->s);
+		break;
+	case QUOTE_TCL:
+		tcl_quote_buf(&sb, v->s);
+		break;
+	}
+	if (quote_style != QUOTE_NONE) {
+		fputs(sb.buf, stdout);
+		strbuf_release(&sb);
+	}
+}
+
+static int hex1(char ch)
+{
+	if ('0' <= ch && ch <= '9')
+		return ch - '0';
+	else if ('a' <= ch && ch <= 'f')
+		return ch - 'a' + 10;
+	else if ('A' <= ch && ch <= 'F')
+		return ch - 'A' + 10;
+	return -1;
+}
+static int hex2(const char *cp)
+{
+	if (cp[0] && cp[1])
+		return (hex1(cp[0]) << 4) | hex1(cp[1]);
+	else
+		return -1;
+}
+
+static void emit(const char *cp, const char *ep)
+{
+	while (*cp && (!ep || cp < ep)) {
+		if (*cp == '%') {
+			if (cp[1] == '%')
+				cp++;
+			else {
+				int ch = hex2(cp + 1);
+				if (0 <= ch) {
+					putchar(ch);
+					cp += 3;
+					continue;
+				}
+			}
+		}
+		putchar(*cp);
+		cp++;
+	}
+}
+
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+{
+	const char *cp, *sp, *ep;
+
+	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
+		struct atom_value *atomv;
+
+		ep = strchr(sp, ')');
+		if (cp < sp)
+			emit(cp, sp);
+		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
+		print_value(atomv, quote_style);
+	}
+	if (*cp) {
+		sp = cp + strlen(cp);
+		emit(cp, sp);
+	}
+	if (need_color_reset_at_eol) {
+		struct atom_value resetv;
+		char color[COLOR_MAXLEN] = "";
+
+		if (color_parse("reset", color) < 0)
+			die("BUG: couldn't parse 'reset' as a color");
+		resetv.s = color;
+		print_value(&resetv, quote_style);
+	}
+	putchar('\n');
+}
+
+/*  If no sorting option is given, use refname to sort as default */
+struct ref_sorting *ref_default_sorting(void)
+{
+	static const char cstr_name[] = "refname";
+
+	struct ref_sorting *sort = xcalloc(1, sizeof(*sort));
+
+	sort->next = NULL;
+	sort->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
+	return sort;
+}
+
+int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
+{
+	struct ref_sorting **sort_tail = opt->value;
+	struct ref_sorting *s;
+	int len;
+
+	if (!arg) /* should --no-sort void the list ? */
+		return -1;
+
+	s = xcalloc(1, sizeof(*s));
+	s->next = *sort_tail;
+	*sort_tail = s;
+
+	if (*arg == '-') {
+		s->reverse = 1;
+		arg++;
+	}
+	len = strlen(arg);
+	s->atom = parse_ref_filter_atom(arg, arg+len);
+	return 0;
+}
-- 
2.4.2
