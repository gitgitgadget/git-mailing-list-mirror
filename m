From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 00/11] port tag.c to use ref-filter APIs
Date: Mon, 27 Jul 2015 12:56:08 +0530
Message-ID: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 09:26:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJco8-0008R6-VY
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 09:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbbG0H0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 03:26:39 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33975 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbbG0H0i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 03:26:38 -0400
Received: by oigd21 with SMTP id d21so47053575oig.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=LnCfK6mUOc5eQ366ks6hJ92ls142skoYzm/Oxv0iDVM=;
        b=awdj7ZjshN+QJoBqO/GN4c23S3LK7TQvnBPXMaBhN/RpN9TlxnE/W2KpRH/B6AqdFL
         mfDmuGYUMUY3Cjgm82jYs1T1k52+LzNki0SNcX+f4bHrgt9vV/LIcUFt2lpVtaICpa38
         6G5zCEgW+BOIn5/rCzuDc+oqu3JBGVvhACAeBmfK+g8EHyT1ZtVuQ5eKUTW7lrdisuGL
         26d6aAPeSw5JdpujOXthC2txWvebVQW/6GdEvQkjbt9ka0G9ov4YPzCJKIf8pYR00zPQ
         1LUSyjjq1BifKwSb7oeOMPGmOTzQX2g1ABR7PMAfXN/zlUNa9mhLk8aj8rFKjL2Xqi4G
         x8Dw==
X-Received: by 10.202.73.198 with SMTP id w189mr25378448oia.102.1437981997594;
 Mon, 27 Jul 2015 00:26:37 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 00:26:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274650>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.  This patch series is continued from: Git (next)
https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61

Version 4 can be found here
http://article.gmane.org/gmane.comp.version-control.git/274579

Changes in this version (interdiff at the end):
* Change the way ref_formatting_state is used and the sequence of its
usage in the
series.
* Separate the introduction of ref_formatting_state from its usage.
* Removed the inefficient removal of path in match_pattern().
* Improve coding style in the implementation of sorting based on version.
* Changed the tests for sorting based on version, to use
'for-each-ref' rather than 'tag.c'
which already has a working sort based on version.
* Other small grammatical changes.
* Change the atom name from 'align' to 'padright'.

[PATCH v5 01/11] ref-filter: introduce 'ref_formatting_state'
[PATCH v5 02/11] ref-filter: make `color` use `ref_formatting_state`
[PATCH v5 03/11] ref-filter: add option to pad atoms to the right
[PATCH v5 04/11] ref-filter: add option to filter only tags
[PATCH v5 05/11] ref-filter: support printing N lines from tag
[PATCH v5 06/11] ref-filter: add support to sort by version
[PATCH v5 07/11] ref-filter: add option to match literal pattern
[PATCH v5 08/11] tag.c: use 'ref-filter' data structures
[PATCH v5 09/11] tag.c: use 'ref-filter' APIs
[PATCH v5 10/11] tag.c: implement '--format' option
[PATCH v5 11/11] tag.c: implement '--merged' and '--no-merged'

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt
b/Documentation/git-for-each-ref.txt
index 224dc8c..2b60aee 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,12 @@ color::
     Change output color.  Followed by `:<colorname>`, where names
     are described in `color.branch.*`.

+padright::
+    Pad succeeding atom to the right. Followed by `:<value>`,
+    where `value` states the total length of atom including the
+    padding. If the `value` is greater than the atom length, then
+    no padding is performed.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/tag.c b/builtin/tag.c
index 8a7f684..fc01117 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -41,13 +41,11 @@ static int list_tags(struct ref_filter *filter,
struct ref_sorting *sorting, con
         filter->lines = 0;

     if (filter->lines)
-        format = "%(align:16)%(refname:short)";
+        format = "%(padright:16)%(refname:short)";
     else if (!format)
         format = "%(refname:short)";

     verify_ref_format(format);
-    if (!sorting)
-        sorting = ref_default_sorting();
     filter_refs(&array, filter, FILTER_REFS_TAGS);
     ref_array_sort(sorting, &array);

@@ -134,7 +132,7 @@ static int parse_sorting_string(const char *arg,
struct ref_sorting **sorting_ta
     if (*arg == '-') {
         s->reverse = 1;
         arg++;
-     }
+    }
     if (skip_prefix(arg, "version:", &arg) ||
         skip_prefix(arg, "v:", &arg))
         s->version = 1;
diff --git a/ref-filter.c b/ref-filter.c
index c686c03..597b189 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -56,7 +56,7 @@ static struct {
     { "flag" },
     { "HEAD" },
     { "color" },
-    { "align" },
+    { "padright" },
 };

 /*
@@ -601,8 +601,7 @@ static inline char *copy_advance(char *dst, const char *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct ref_formatting_state *state,
-               struct ref_array_item *ref)
+static void populate_value(struct ref_array_item *ref)
 {
     void *buf;
     struct object *obj;
@@ -664,8 +663,9 @@ static void populate_value(struct
ref_formatting_state *state,

             if (color_parse(name + 6, color) < 0)
                 die(_("unable to parse format"));
-            state->color = xstrdup(color);
+            v->s = xstrdup(color);
             v->pseudo_atom = 1;
+            v->color = 1;
             continue;
         } else if (!strcmp(name, "flag")) {
             char buf[256], *cp = buf;
@@ -693,17 +693,17 @@ static void populate_value(struct
ref_formatting_state *state,
             else
                 v->s = " ";
             continue;
-        } else if (starts_with(name, "align:")) {
+        } else if (starts_with(name, "padright:")) {
             const char *valp = NULL;

-            skip_prefix(name, "align:", &valp);
+            skip_prefix(name, "padright:", &valp);
             if (!valp[0])
-                die(_("no value given with 'align:'"));
-            if (strtoul_ui(valp, 10, &state->pad_to_right))
-                die(_("positive integer expected after ':' in align:%u\n"),
-                    state->pad_to_right);
+                die(_("no value given with 'padright:'"));
+            if (strtoul_ui(valp, 10, (unsigned int *)&v->ul))
+                die(_("positive integer expected after ':' in padright:%u\n"),
+                    (unsigned int)v->ul);
             v->pseudo_atom = 1;
-            v->s = "";
+            v->pad_to_right = 1;
             continue;
         } else
             continue;
@@ -827,15 +827,10 @@ static void populate_value(struct
ref_formatting_state *state,
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_ref_atom_value(struct ref_formatting_state *state,
-                   struct ref_array_item *ref, int atom, struct atom_value **v)
+static void get_ref_atom_value(struct ref_array_item *ref, int atom,
struct atom_value **v)
 {
-    /*
-     * If the atom is a pseudo_atom then we re-populate the value
-     * into the ref_formatting_state stucture.
-     */
-    if (!ref->value || ref->value[atom].pseudo_atom) {
-        populate_value(state, ref);
+    if (!ref->value) {
+        populate_value(ref);
         fill_missing_values(ref->value);
     }
     *v = &ref->value[atom];
@@ -957,17 +952,18 @@ static int commit_contains(struct ref_filter
*filter, struct commit *commit)
  */
 static int match_pattern(const char **patterns, const char *refname)
 {
+    /*
+     * When no '--format' option is given we need to skip the prefix
+     * for matching refs of tags and branches.
+     */
+    if (skip_prefix(refname, "refs/tags/", &refname))
+        ;
+    else if (skip_prefix(refname, "refs/heads/", &refname))
+        ;
+    else if (skip_prefix(refname, "refs/remotes/", &refname))
+        ;
+
     for (; *patterns; patterns++) {
-        /*
-         * When no '--format' option is given we need to skip the prefix
-         * for listing tags and branches.
-         */
-        if (!starts_with(*pattern, "refs/tags/"))
-            skip_prefix(refname, "refs/tags/", &refname);
-        else if (!starts_with(*pattern, "refs/heads/"))
-            skip_prefix(refname, "refs/heads/", &refname);
-        else if (!starts_with(refname, "refs/remotes/"))
-            skip_prefix(refname, "refs/remotes/", &refname);
         if (!wildmatch(*patterns, refname, 0, NULL))
             return 1;
     }
@@ -978,7 +974,7 @@ static int match_pattern(const char **patterns,
const char *refname)
  * Return 1 if the refname matches one of the patterns, otherwise 0.
  * A pattern can be path prefix (e.g. a refname "refs/heads/master"
  * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
- * matches "refs/heads/m*", too).
+ * matches "refs/heads/m*",too).
  */
 static int match_name_as_path(const char **pattern, const char *refname)
 {
@@ -1210,22 +1206,21 @@ static int cmp_ref_sorting(struct ref_sorting
*s, struct ref_array_item *a, stru
     struct atom_value *va, *vb;
     int cmp;
     cmp_type cmp_type = used_atom_type[s->atom];
-    struct ref_formatting_state state;

-    memset(&state, 0, sizeof(state));
-
-    get_ref_atom_value(&state, a, s->atom, &va);
-    get_ref_atom_value(&state, b, s->atom, &vb);
+    get_ref_atom_value(a, s->atom, &va);
+    get_ref_atom_value(b, s->atom, &vb);
     if (s->version)
         cmp = versioncmp(va->s, vb->s);
     else if (cmp_type == FIELD_STR)
         cmp = strcmp(va->s, vb->s);
-    else if (va->ul < vb->ul)
-        cmp = -1;
-    else if (va->ul == vb->ul)
-        cmp = 0;
-    else
-        cmp = 1;
+    else {
+        if (va->ul < vb->ul)
+            cmp = -1;
+        else if (va->ul == vb->ul)
+            cmp = 0;
+        else
+            cmp = 1;
+    }

     return (s->reverse) ? -cmp : cmp;
 }
@@ -1251,20 +1246,20 @@ void ref_array_sort(struct ref_sorting
*sorting, struct ref_array *array)
     qsort(array->items, array->nr, sizeof(struct ref_array_item *),
compare_refs);
 }

-static void ref_formatting(struct ref_formatting_state *state, struct
atom_value *v,
-               struct strbuf *value)
+static void ref_formatting(struct ref_formatting_state *state,
+               struct atom_value *v, struct strbuf *value)
 {
     if (state->color) {
         strbuf_addstr(value, state->color);
-        free((void *)state->color);
+        free(state->color);
         state->color = NULL;
     }
     if (state->pad_to_right) {
         if (!is_utf8(v->s))
             strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
         else {
-            int len = strlen(v->s) - utf8_strwidth(v->s);
-            strbuf_addf(value, "%-*s", state->pad_to_right + len, v->s);
+            int utf8_compensation = strlen(v->s) - utf8_strwidth(v->s);
+            strbuf_addf(value, "%-*s", state->pad_to_right +
utf8_compensation, v->s);
         }
         return;
     }
@@ -1276,8 +1271,6 @@ static void print_value(struct
ref_formatting_state *state, struct atom_value *v
     struct strbuf value = STRBUF_INIT;
     struct strbuf formatted = STRBUF_INIT;

-    if (v->pseudo_atom)
-        return;
     ref_formatting(state, v, &value);

     switch (state->quote_style) {
@@ -1341,6 +1334,15 @@ static void emit(const char *cp, const char *ep)
     }
 }

+static void apply_pseudo_state(struct ref_formatting_state *state,
+                   struct atom_value *v)
+{
+    if (v->color)
+        state->color = (char *)v->s;
+    if (v->pad_to_right)
+        state->pad_to_right = v->ul;
+}
+
 /*
  * If 'lines' is greater than 0, print that many lines from the given
  * object_id 'oid'.
@@ -1399,9 +1401,11 @@ void show_ref_array_item(struct ref_array_item
*info, const char *format,
         ep = strchr(sp, ')');
         if (cp < sp)
             emit(cp, sp);
-        get_ref_atom_value(&state, info,
-                   parse_ref_filter_atom(sp + 2, ep), &atomv);
-        print_value(&state, atomv);
+        get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
+        if (atomv->pseudo_atom)
+            apply_pseudo_state(&state, atomv);
+        else
+            print_value(&state, atomv);
     }
     if (*cp) {
         sp = cp + strlen(cp);
@@ -1413,8 +1417,7 @@ void show_ref_array_item(struct ref_array_item
*info, const char *format,

         if (color_parse("reset", color) < 0)
             die("BUG: couldn't parse 'reset' as a color");
-        resetv.s = "";
-        state.color = xstrdup(color);
+        resetv.s = color;
         print_value(&state, &resetv);
     }
     if (lines > 0) {
diff --git a/ref-filter.h b/ref-filter.h
index f1933e0..a27745f 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -20,7 +20,15 @@
 struct atom_value {
     const char *s;
     unsigned long ul; /* used for sorting when not FIELD_STR */
-    unsigned int pseudo_atom : 1; /*  atoms which aren't placeholders
for ref attributes */
+    unsigned int pseudo_atom : 1, /*  atoms which aren't placeholders
for ref attributes */
+        color : 1,
+        pad_to_right : 1;
+};
+
+struct ref_formatting_state {
+    int quote_style;
+    char *color;
+    unsigned int pad_to_right;
 };

 struct ref_sorting {
@@ -30,12 +38,6 @@ struct ref_sorting {
         version : 1;
 };

-struct ref_formatting_state {
-    unsigned int pad_to_right; /*pad atoms to the right*/
-    int quote_style;
-    const char *color;
-};
-
 struct ref_array_item {
     unsigned char objectname[20];
     int flag;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 5017032..de872db 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,6 +81,22 @@ test_expect_success 'filtering with --contains' '
     test_cmp expect actual
 '

+test_expect_success 'padding to the right using `padright`' '
+    cat >expect <<-\EOF &&
+    refs/heads/master        |
+    refs/heads/side          |
+    refs/odd/spot            |
+    refs/tags/double-tag     |
+    refs/tags/four           |
+    refs/tags/one            |
+    refs/tags/signed-tag     |
+    refs/tags/three          |
+    refs/tags/two            |
+    EOF
+    git for-each-ref --format="%(padright:25)%(refname)|" >actual &&
+    test_cmp expect actual
+'
+
 test_expect_success 'setup for version sort' '
     test_commit foo1.3 &&
     test_commit foo1.6 &&
@@ -88,7 +104,7 @@ test_expect_success 'setup for version sort' '
 '

 test_expect_success 'version sort' '
-    git tag -l --sort=version:refname | grep "foo" >actual &&
+    git for-each-ref --sort=version:refname
--format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
     cat >expect <<-\EOF &&
     foo1.3
     foo1.6
@@ -98,7 +114,7 @@ test_expect_success 'version sort' '
 '

 test_expect_success 'version sort (shortened)' '
-    git tag -l --sort=v:refname | grep "foo" >actual &&
+    git for-each-ref --sort=v:refname --format="%(refname:short)"
refs/tags/ | grep "foo" >actual &&
     cat >expect <<-\EOF &&
     foo1.3
     foo1.6
@@ -108,7 +124,7 @@ test_expect_success 'version sort (shortened)' '
 '

 test_expect_success 'reverse version sort' '
-    git tag -l --sort=-version:refname | grep "foo" >actual &&
+    git for-each-ref --sort=-version:refname
--format="%(refname:short)" refs/tags/ | grep "foo" >actual &&
     cat >expect <<-\EOF &&
     foo1.10
     foo1.6
diff --git a/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
b/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
deleted file mode 100644
index 350acae..0000000
--- a/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
+++ /dev/null
@@ -1,124 +0,0 @@
-From 3a07ca1f56f74ca54b7f3c30e3dfd9fe2fed1cc3 Mon Sep 17 00:00:00 2001
-From: Karthik Nayak <karthik.188@gmail.com>
-Date: Wed, 10 Jun 2015 17:19:55 +0530
-Subject: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
-
-Add a new atom "align" and support %(align:X) where X is a number.
-This will align the preceeding atom value to the left followed by
-spaces for a total length of X characters. If X is less than the item
-size, the entire atom value is printed.
-
-Helped-by: Duy Nguyen <pclouds@gmail.com>
-Mentored-by: Christian Couder <christian.couder@gmail.com>
-Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
-Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
----
- ref-filter.c | 41 +++++++++++++++++++++++++++++++++++++++--
- ref-filter.h |  1 +
- 2 files changed, 40 insertions(+), 2 deletions(-)
-
-diff --git a/ref-filter.c b/ref-filter.c
-index 7561727..93f59aa 100644
---- a/ref-filter.c
-+++ b/ref-filter.c
-@@ -10,6 +10,8 @@
- #include "quote.h"
- #include "ref-filter.h"
- #include "revision.h"
-+#include "utf8.h"
-+#include "git-compat-util.h"
-
- typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
-
-@@ -53,6 +55,7 @@ static struct {
-     { "flag" },
-     { "HEAD" },
-     { "color" },
-+    { "align" },
- };
-
- /*
-@@ -620,7 +623,7 @@ static void populate_value(struct ref_array_item *ref)
-         const char *name = used_atom[i];
-         struct atom_value *v = &ref->value[i];
-         int deref = 0;
--        const char *refname;
-+        const char *refname = NULL;
-         const char *formatp;
-         struct branch *branch = NULL;
-
-@@ -687,6 +690,17 @@ static void populate_value(struct ref_array_item *ref)
-             else
-                 v->s = " ";
-             continue;
-+        } else if (starts_with(name, "align:")) {
-+            const char *valp = NULL;
-+
-+            skip_prefix(name, "align:", &valp);
-+            if (!valp[0])
-+                die(_("no value given with 'align:'"));
-+            strtoul_ui(valp, 10, &ref->align_value);
-+            if (ref->align_value < 1)
-+                die(_("value should be greater than zero:
align:%u"), ref->align_value);
-+            v->s = "";
-+            continue;
-         } else
-             continue;
-
-@@ -1254,17 +1268,40 @@ static void emit(const char *cp, const char *ep)
-     }
- }
-
-+static void assign_formating(struct ref_array_item *ref, int
parsed_atom, struct atom_value *v)
-+{
-+    if (ref->align_value && !starts_with(used_atom[parsed_atom], "align")) {
-+        unsigned int len = 0;
-+
-+        if (*v->s)
-+            len = utf8_strwidth(v->s);
-+        if (ref->align_value > len) {
-+            struct strbuf buf = STRBUF_INIT;
-+            if (*v->s)
-+                strbuf_addstr(&buf, v->s);
-+            if (*v->s && v->s[0] == '\0')
-+                free((char *)v->s);
-+            strbuf_addchars(&buf, ' ', ref->align_value - len);
-+            v->s = strbuf_detach(&buf, NULL);
-+        }
-+        ref->align_value = 0;
-+    }
-+}
-+
- void show_ref_array_item(struct ref_array_item *info, const char
*format, int quote_style)
- {
-     const char *cp, *sp, *ep;
-
-     for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
-         struct atom_value *atomv;
-+        int parsed_atom;
-
-         ep = strchr(sp, ')');
-         if (cp < sp)
-             emit(cp, sp);
--        get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-+        parsed_atom = parse_ref_filter_atom(sp + 2, ep);
-+        get_ref_atom_value(info, parsed_atom, &atomv);
-+        assign_formating(info, parsed_atom, atomv);
-         print_value(atomv, quote_style);
-     }
-     if (*cp) {
-diff --git a/ref-filter.h b/ref-filter.h
-index 6bf27d8..12ffbc5 100644
---- a/ref-filter.h
-+++ b/ref-filter.h
-@@ -30,6 +30,7 @@ struct ref_sorting {
- struct ref_array_item {
-     unsigned char objectname[20];
-     int flag;
-+    unsigned int align_value;
-     const char *symref;
-     struct commit *commit;
-     struct atom_value *value;
---
-2.4.6
-

Thanks to everyone for suggestions on the previous version.

-- 
Regards,
Karthik Nayak
