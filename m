From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/10] port tag.c to use ref-filter APIs
Date: Tue, 28 Jul 2015 12:02:00 +0530
Message-ID: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 08:32:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyRH-0004nF-OP
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbbG1Gcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:32:31 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33492 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbbG1Gca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:32:30 -0400
Received: by obdeg2 with SMTP id eg2so77199926obd.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=QrflsddN8v4Wr+lsBQ8H44cA6zv1dknQ0SjtNk0lagY=;
        b=qJq1aRjR836EXWz8oRFJGLsHE7UX7Y6T1e5iLxumswMg17L2K3+ZArZx7TSDF7Xqx2
         YWB5I29SZOUJib1YXsBhq19B+hIZrG3BFMQXEoCR476/FfY9RdBK3hJrxC+fy7MfKnVU
         rGwTYnp7AmmyGSMId2i5Rduug7e+nDydvfUAo2A8C0c3rRK5Ilx+PE91uEJb/EJhRl4F
         nJkL8OIhWP7nCUR2TmqR0oRycvvJQ6zAsyC3v9M2dYPEtCKVAIB1+ZszFVf/Zz98ftJS
         AY4E87c7/pgqMx6Bk44tUcKsa4a+p0RH7M5kiH0ozSBtb9gSdW6AqVnrcm4W7CtEzLfO
         +Ozw==
X-Received: by 10.182.29.68 with SMTP id i4mr31203910obh.57.1438065149936;
 Mon, 27 Jul 2015 23:32:29 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 23:32:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274726>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.  This patch series is continued from: Git (next)
https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61

Version 5 can be found here:
http://article.gmane.org/gmane.comp.version-control.git/274650

Changes in v6:
* Change the flow of commits, introduce rest_formatting_state.
* Rename
ref_formatting -> apply_formatting_state
apply_pseudo_state -> store_formatting_state
* Remove the patch for making color a pseudo atom, and rename
pseudo_atom to modifier_atom.
* Small grammatical changes.

Side Note: --format="%(padright:X)" applies to the next available atom
and not to the next span. I find this more accurate as I don't see why
we'd want to pad something of known length. But its up for discussion
:D

Interdiff:
diff --git a/ref-filter.c b/ref-filter.c
index 597b189..0a34924 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -664,8 +664,6 @@ static void populate_value(struct ref_array_item *ref)
             if (color_parse(name + 6, color) < 0)
                 die(_("unable to parse format"));
             v->s = xstrdup(color);
-            v->pseudo_atom = 1;
-            v->color = 1;
             continue;
         } else if (!strcmp(name, "flag")) {
             char buf[256], *cp = buf;
@@ -702,7 +700,7 @@ static void populate_value(struct ref_array_item *ref)
             if (strtoul_ui(valp, 10, (unsigned int *)&v->ul))
                 die(_("positive integer expected after ':' in padright:%u\n"),
                     (unsigned int)v->ul);
-            v->pseudo_atom = 1;
+            v->modifier_atom = 1;
             v->pad_to_right = 1;
             continue;
         } else
@@ -973,8 +971,8 @@ static int match_pattern(const char **patterns,
const char *refname)
 /*
  * Return 1 if the refname matches one of the patterns, otherwise 0.
  * A pattern can be path prefix (e.g. a refname "refs/heads/master"
- * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
- * matches "refs/heads/m*",too).
+ * matches a pattern "refs/heads/" but not "refs/heads/m") or a
+ * wildcard (e.g. the same ref matches "refs/heads/m*", too).
  */
 static int match_name_as_path(const char **pattern, const char *refname)
 {
@@ -1246,14 +1244,9 @@ void ref_array_sort(struct ref_sorting
*sorting, struct ref_array *array)
     qsort(array->items, array->nr, sizeof(struct ref_array_item *),
compare_refs);
 }

-static void ref_formatting(struct ref_formatting_state *state,
-               struct atom_value *v, struct strbuf *value)
+static void apply_formatting_state(struct ref_formatting_state *state,
+                   struct atom_value *v, struct strbuf *value)
 {
-    if (state->color) {
-        strbuf_addstr(value, state->color);
-        free(state->color);
-        state->color = NULL;
-    }
     if (state->pad_to_right) {
         if (!is_utf8(v->s))
             strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
@@ -1263,15 +1256,22 @@ static void ref_formatting(struct
ref_formatting_state *state,
         }
         return;
     }
-    strbuf_addf(value, "%s", v->s);
+
+    strbuf_addstr(value, v->s);
 }

-static void print_value(struct ref_formatting_state *state, struct
atom_value *v)
+static void print_value(struct atom_value *v, struct
ref_formatting_state *state)
 {
     struct strbuf value = STRBUF_INIT;
     struct strbuf formatted = STRBUF_INIT;

-    ref_formatting(state, v, &value);
+    /*
+     * Some (pesudo) atoms have no immediate side effect, but only
+     * affect the next atom. Store the relevant information from
+     * these atoms in the 'state' variable for use when displaying
+     * the next atom.
+     */
+    apply_formatting_state(state, v, &value);

     switch (state->quote_style) {
     case QUOTE_NONE:
@@ -1292,8 +1292,8 @@ static void print_value(struct
ref_formatting_state *state, struct atom_value *v
     }
     if (state->quote_style != QUOTE_NONE)
         fputs(formatted.buf, stdout);
-    strbuf_release(&formatted);
     strbuf_release(&value);
+    strbuf_release(&formatted);
 }

 static int hex1(char ch)
@@ -1334,13 +1334,18 @@ static void emit(const char *cp, const char *ep)
     }
 }

-static void apply_pseudo_state(struct ref_formatting_state *state,
-                   struct atom_value *v)
+static void store_formatting_state(struct ref_formatting_state *state,
+                   struct atom_value *atomv)
 {
-    if (v->color)
-        state->color = (char *)v->s;
-    if (v->pad_to_right)
-        state->pad_to_right = v->ul;
+    if (atomv->pad_to_right)
+        state->pad_to_right = atomv->ul;
+}
+
+static void reset_formatting_state(struct ref_formatting_state *state)
+{
+    int quote_style = state->quote_style;
+    memset(state, 0, sizeof(*state));
+    state->quote_style = quote_style;
 }

 /*
@@ -1402,10 +1407,12 @@ void show_ref_array_item(struct ref_array_item
*info, const char *format,
         if (cp < sp)
             emit(cp, sp);
         get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-        if (atomv->pseudo_atom)
-            apply_pseudo_state(&state, atomv);
-        else
-            print_value(&state, atomv);
+        if (atomv->modifier_atom)
+            store_formatting_state(&state, atomv);
+        else {
+            print_value(atomv, &state);
+            reset_formatting_state(&state);
+        }
     }
     if (*cp) {
         sp = cp + strlen(cp);
@@ -1418,7 +1425,7 @@ void show_ref_array_item(struct ref_array_item
*info, const char *format,
         if (color_parse("reset", color) < 0)
             die("BUG: couldn't parse 'reset' as a color");
         resetv.s = color;
-        print_value(&state, &resetv);
+        print_value(&resetv, &state);
     }
     if (lines > 0) {
         struct object_id oid;
diff --git a/ref-filter.h b/ref-filter.h
index a27745f..fcf469e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -20,14 +20,12 @@
 struct atom_value {
     const char *s;
     unsigned long ul; /* used for sorting when not FIELD_STR */
-    unsigned int pseudo_atom : 1, /*  atoms which aren't placeholders
for ref attributes */
-        color : 1,
+    unsigned int modifier_atom : 1, /*  atoms which act as modifiers
for the next atom */
         pad_to_right : 1;
 };

 struct ref_formatting_state {
     int quote_style;
-    char *color;
     unsigned int pad_to_right;
 };

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index de872db..68688a9 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -83,17 +83,17 @@ test_expect_success 'filtering with --contains' '

 test_expect_success 'padding to the right using `padright`' '
     cat >expect <<-\EOF &&
-    refs/heads/master        |
-    refs/heads/side          |
-    refs/odd/spot            |
-    refs/tags/double-tag     |
-    refs/tags/four           |
-    refs/tags/one            |
-    refs/tags/signed-tag     |
-    refs/tags/three          |
-    refs/tags/two            |
+    refs/heads/master|refs/heads/master        |refs/heads/master|
+    refs/heads/side|refs/heads/side          |refs/heads/side|
+    refs/odd/spot|refs/odd/spot            |refs/odd/spot|
+    refs/tags/double-tag|refs/tags/double-tag     |refs/tags/double-tag|
+    refs/tags/four|refs/tags/four           |refs/tags/four|
+    refs/tags/one|refs/tags/one            |refs/tags/one|
+    refs/tags/signed-tag|refs/tags/signed-tag     |refs/tags/signed-tag|
+    refs/tags/three|refs/tags/three          |refs/tags/three|
+    refs/tags/two|refs/tags/two            |refs/tags/two|
     EOF
-    git for-each-ref --format="%(padright:25)%(refname)|" >actual &&
+    git for-each-ref
--format="%(refname)%(padright:25)|%(refname)|%(refname)|" >actual &&
     test_cmp expect actual
 '

-- 
Regards,
Karthik Nayak
