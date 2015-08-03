From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 0/11] Port tag.c over to use ref-filter APIs
Date: Mon, 3 Aug 2015 22:22:30 +0530
Message-ID: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 18:53:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMIz5-0008ED-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 18:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbbHCQxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 12:53:01 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35214 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbbHCQxA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 12:53:00 -0400
Received: by obbop1 with SMTP id op1so103710676obb.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=9uIfYMqZC5EXQQjfb0ZLoy4hWc9yM6qDQprp/N1KjHM=;
        b=x3eWy3bzed0JpoOYeAZb33f6TYjKDeTprzss/QB8L1Qog7+4+hhOtYrlpIaJvKBctZ
         1E7HnNmXTkf1gP1ZvpzRJ8xOh2fVh10jOUqsa5/y7/YKB8fCYG2W9CqZFwYJwz+ND0xX
         B+ldXXvisEOD81+oQaXcpoD3aVZJ7aYl5g5n3ET79crSebpuudioHPO5YjvY0MumEqpU
         LoHBjwG4SPoACXEWluch44Szz50JsZt9nL5JJSWzRKYuBiBTvF9wmIX6rcMjfov7l6iW
         3YGLFcNsbRXyIKkURUC/0CUkNfOKT4ERchpW5bDtsFxfbaIwPf7k81RTxDGzJU+mH2ca
         iYcw==
X-Received: by 10.60.41.138 with SMTP id f10mr17105062oel.84.1438620779638;
 Mon, 03 Aug 2015 09:52:59 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 3 Aug 2015 09:52:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275173>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.  This patch series is continued from: Git (next)
https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61

This series consists of porting tag.c over to using the ref-filter APIs

Version 7 can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/274990

Changes:
* Make padright a general align atom.
* Make print_value() and emit() output to a strbuf rather than stdout directly.

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt
b/Documentation/git-for-each-ref.txt
index bcf319a..e89b9b0 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,11 +127,12 @@ color::
     Change output color.  Followed by `:<colorname>`, where names
     are described in `color.branch.*`.

-padright::
-    Pad succeeding atom or string to the right. Followed by
-    `:<value>`, where `value` states the total length of atom or
-    string including the padding. If the `value` is lesser than
-    the atom or string length, then no padding is performed.
+align::
+    Align succeeding atoms to the right, left or middle. Followed
+    by `:<type>,<paddinglength>`, where the `<type>` is either
+    left, right or middle and `<paddinglength>` is the total
+    length of the padding to be performed. If the atom length is
+    more than the padding length then no padding is performed.

 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/builtin/tag.c b/builtin/tag.c
index fc01117..529b29f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -41,7 +41,7 @@ static int list_tags(struct ref_filter *filter,
struct ref_sorting *sorting, con
         filter->lines = 0;

     if (filter->lines)
-        format = "%(padright:16)%(refname:short)";
+        format = "%(align:left,16)%(refname:short)";
     else if (!format)
         format = "%(refname:short)";

diff --git a/ref-filter.c b/ref-filter.c
index 65d168e..afeab37 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -56,7 +56,7 @@ static struct {
     { "flag" },
     { "HEAD" },
     { "color" },
-    { "padright" },
+    { "align" },
 };

 /*
@@ -624,7 +624,7 @@ static void populate_value(struct ref_array_item *ref)
         const char *name = used_atom[i];
         struct atom_value *v = &ref->value[i];
         int deref = 0;
-        const char *refname;
+        const char *refname = NULL;
         const char *formatp;
         struct branch *branch = NULL;

@@ -664,8 +664,6 @@ static void populate_value(struct ref_array_item *ref)
             if (color_parse(name + 6, color) < 0)
                 die(_("unable to parse format"));
             v->s = xstrdup(color);
-            v->color = 1;
-            v->modifier_atom = 1;
             continue;
         } else if (!strcmp(name, "flag")) {
             char buf[256], *cp = buf;
@@ -693,17 +691,23 @@ static void populate_value(struct ref_array_item *ref)
             else
                 v->s = " ";
             continue;
-        } else if (starts_with(name, "padright:")) {
+        } else if (starts_with(name, "align:")) {
             const char *valp = NULL;
+            struct align *align = xmalloc(sizeof(struct align));

-            skip_prefix(name, "padright:", &valp);
-            if (!valp[0])
-                die(_("no value given with 'padright:'"));
-            if (strtoul_ui(valp, 10, (unsigned int *)&v->ul))
-                die(_("positive integer expected after ':' in padright:%u\n"),
-                    (unsigned int)v->ul);
-            v->modifier_atom = 1;
-            v->pad_to_right = 1;
+            skip_prefix(name, "align:", &valp);
+
+            if (skip_prefix(valp, "left,", &valp))
+                align->align_type = ALIGN_LEFT;
+            else if (skip_prefix(valp, "right,", &valp))
+                align->align_type = ALIGN_RIGHT;
+            else if (skip_prefix(valp, "middle,", &valp))
+                align->align_type = ALIGN_MIDDLE;
+            else
+                die(_("align: improper format"));
+            if (strtoul_ui(valp, 10, &align->align_value))
+                die(_("align: positive value expected"));
+            v->align = align;
             continue;
         } else
             continue;
@@ -1243,55 +1247,26 @@ void ref_array_sort(struct ref_sorting
*sorting, struct ref_array *array)
     qsort(array->items, array->nr, sizeof(struct ref_array_item *),
compare_refs);
 }

-static void apply_formatting_state(struct ref_formatting_state *state,
-                   const char *buf, struct strbuf *value)
-{
-    if (state->color) {
-        strbuf_addstr(value, state->color);
-        state->color = NULL;
-    }
-    if (state->pad_to_right) {
-        if (!is_utf8(buf))
-            strbuf_addf(value, "%-*s", state->pad_to_right, buf);
-        else {
-            int utf8_compensation = strlen(buf) - utf8_strwidth(buf);
-            strbuf_addf(value, "%-*s", state->pad_to_right +
utf8_compensation, buf);
-        }
-        state->pad_to_right = 0;
-        return;
-    }
-
-    strbuf_addstr(value, buf);
-}
-
-static void print_value(struct atom_value *v, struct
ref_formatting_state *state)
+static void print_value(struct atom_value *v, struct
ref_formatting_state *state,
+            struct strbuf *output)
 {
-    struct strbuf value = STRBUF_INIT;
-    struct strbuf formatted = STRBUF_INIT;
-
-    apply_formatting_state(state, v->s, &value);
-
     switch (state->quote_style) {
     case QUOTE_NONE:
-        fputs(value.buf, stdout);
+        strbuf_addstr(output, v->s);
         break;
     case QUOTE_SHELL:
-        sq_quote_buf(&formatted, value.buf);
+        sq_quote_buf(output, v->s);
         break;
     case QUOTE_PERL:
-        perl_quote_buf(&formatted, value.buf);
+        perl_quote_buf(output, v->s);
         break;
     case QUOTE_PYTHON:
-        python_quote_buf(&formatted, value.buf);
+        python_quote_buf(output, v->s);
         break;
     case QUOTE_TCL:
-        tcl_quote_buf(&formatted, value.buf);
+        tcl_quote_buf(output, v->s);
         break;
     }
-    if (state->quote_style != QUOTE_NONE)
-        fputs(formatted.buf, stdout);
-    strbuf_release(&value);
-    strbuf_release(&formatted);
 }

 static int hex1(char ch)
@@ -1312,12 +1287,8 @@ static int hex2(const char *cp)
         return -1;
 }

-static void emit(const char *cp, const char *ep,
-         struct ref_formatting_state *state)
+static void emit(const char *cp, const char *ep, struct strbuf *output)
 {
-    struct strbuf value = STRBUF_INIT;
-    struct strbuf format = STRBUF_INIT;
-
     while (*cp && (!ep || cp < ep)) {
         if (*cp == '%') {
             if (cp[1] == '%')
@@ -1325,28 +1296,61 @@ static void emit(const char *cp, const char *ep,
             else {
                 int ch = hex2(cp + 1);
                 if (0 <= ch) {
-                    putchar(ch);
+                    strbuf_addch(output, ch);
                     cp += 3;
                     continue;
                 }
             }
         }
-        strbuf_addch(&value, *cp);
+        strbuf_addch(output, *cp);
         cp++;
     }
-    apply_formatting_state(state, value.buf, &format);
-    fputs(format.buf, stdout);
-    strbuf_release(&format);
-    strbuf_release(&value);
 }

-static void store_formatting_state(struct ref_formatting_state *state,
-                   struct atom_value *atomv)
+static void process_formatting_state(struct atom_value *atomv, struct
ref_formatting_state *state)
 {
-    if (atomv->color)
-        state->color = atomv->s;
-    if (atomv->pad_to_right)
-        state->pad_to_right = atomv->ul;
+    if (atomv->align) {
+        state->align = atomv->align;
+        atomv->align = NULL;
+    }
+}
+
+static void apply_formatting_state(struct ref_formatting_state
*state, struct strbuf *value,
+                   struct strbuf *format)
+{
+    if (state->align) {
+        int len = 0, buf_len = value->len;
+        struct align *align = state->align;
+
+        if (!value->buf)
+            return;
+        if (!is_utf8(value->buf)) {
+            len = value->len - utf8_strwidth(value->buf);
+            buf_len -= len;
+        }
+
+        if (align->align_value < buf_len) {
+            state->align = NULL;
+            strbuf_addbuf(format, value);
+            strbuf_release(value);
+            return;
+        }
+
+        if (align->align_type == ALIGN_LEFT)
+            strbuf_addf(format, "%-*s", len + align->align_value, value->buf);
+        else if (align->align_type == ALIGN_MIDDLE) {
+            int right = (align->align_value - buf_len)/2;
+            strbuf_addf(format, "%*s%-*s", align->align_value - right + len,
+                    value->buf, right, "");
+        } else if (align->align_type == ALIGN_RIGHT)
+            strbuf_addf(format, "%*s", align->align_value, value->buf);
+        strbuf_release(value);
+        state->align = NULL;
+        return;
+    }
+    strbuf_addbuf(format, value);
+    strbuf_release(value);
+
 }

 /*
@@ -1396,26 +1400,34 @@ void show_ref_array_item(struct ref_array_item
*info, const char *format,
              int quote_style, unsigned int lines)
 {
     const char *cp, *sp, *ep;
+    struct strbuf value = STRBUF_INIT;
+    struct strbuf final_buf = STRBUF_INIT;
     struct ref_formatting_state state;
+    int i;

     memset(&state, 0, sizeof(state));
     state.quote_style = quote_style;

     for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
-        struct atom_value *atomv;
+        struct atom_value *atomv = NULL;

         ep = strchr(sp, ')');
-        if (cp < sp)
-            emit(cp, sp, &state);
+        if (cp < sp) {
+            emit(cp, sp, &value);
+            apply_formatting_state(&state, &value, &final_buf);
+        }
         get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-        if (atomv->modifier_atom)
-            store_formatting_state(&state, atomv);
-        else
-            print_value(atomv, &state);
+        if (atomv->align)
+            process_formatting_state(atomv, &state);
+        else {
+            print_value(atomv, &state, &value);
+            apply_formatting_state(&state, &value, &final_buf);
+        }
     }
     if (*cp) {
         sp = cp + strlen(cp);
-        emit(cp, sp, &state);
+        emit(cp, sp, &value);
+        apply_formatting_state(&state, &value, &final_buf);
     }
     if (need_color_reset_at_eol) {
         struct atom_value resetv;
@@ -1424,8 +1436,14 @@ void show_ref_array_item(struct ref_array_item
*info, const char *format,
         if (color_parse("reset", color) < 0)
             die("BUG: couldn't parse 'reset' as a color");
         resetv.s = color;
-        print_value(&resetv, &state);
+        print_value(&resetv, &state, &value);
+        apply_formatting_state(&state, &value, &final_buf);
     }
+
+    for (i = 0; i < final_buf.len; i++)
+        printf("%c", final_buf.buf[i]);
+    strbuf_release(&final_buf);
+
     if (lines > 0) {
         struct object_id oid;
         hashcpy(oid.hash, info->objectname);
diff --git a/ref-filter.h b/ref-filter.h
index b50a036..b3b9cd8 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -17,18 +17,25 @@
 #define FILTER_REFS_ALL 0x2
 #define FILTER_REFS_TAGS 0x4

-struct atom_value {
-    const char *s;
-    unsigned long ul; /* used for sorting when not FIELD_STR */
-    unsigned int modifier_atom : 1, /*  atoms which act as modifiers
for the next atom */
-        color : 1,
-        pad_to_right : 1;
-};
+#define ALIGN_LEFT 0x01
+#define ALIGN_RIGHT 0x02
+#define ALIGN_MIDDLE 0x04

 struct ref_formatting_state {
     int quote_style;
-    unsigned int pad_to_right;
-    const char *color;
+    struct align *align;
+    struct strbuf *sb;
+};
+
+struct align {
+    unsigned int align_type,
+        align_value;
+};
+
+struct atom_value {
+    const char *s;
+    struct align *align;
+    unsigned long ul; /* used for sorting when not FIELD_STR */
 };

 struct ref_sorting {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 842efde..7332bea 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,35 +81,83 @@ test_expect_success 'filtering with --contains' '
     test_cmp expect actual
 '

-test_expect_success 'padding to the right using `padright`' '
+test_expect_success 'left alignment' '
     cat >expect <<-\EOF &&
-    master    ||    master
-    side      ||    side
-    odd/spot  ||    odd/spot
-    double-tag||    double-tag
-    four      ||    four
-    one       ||    one
-    signed-tag||    signed-tag
-    three     ||    three
-    two       ||    two
+    refs/heads/master   |refs/heads/master
+    refs/heads/side     |refs/heads/side
+    refs/odd/spot       |refs/odd/spot
+    refs/tags/double-tag|refs/tags/double-tag
+    refs/tags/four      |refs/tags/four
+    refs/tags/one       |refs/tags/one
+    refs/tags/signed-tag|refs/tags/signed-tag
+    refs/tags/three     |refs/tags/three
+    refs/tags/two       |refs/tags/two
     EOF
-    git for-each-ref
--format="%(padright:10)%(refname:short)|%(padright:5)|%(refname:short)"
>actual &&
+    git for-each-ref --format="%(align:left,20)%(refname)|%(refname)"
>actual &&
     test_cmp expect actual
 '

-test_expect_success 'no padding when `padright` length is smaller
than atom length' '
+test_expect_success 'middle alignment' '
     cat >expect <<-\EOF &&
-    refs/heads/master|
-    refs/heads/side|
-    refs/odd/spot|
-    refs/tags/double-tag|
-    refs/tags/four|
-    refs/tags/one|
-    refs/tags/signed-tag|
-    refs/tags/three|
-    refs/tags/two|
+    |  refs/heads/master |refs/heads/master
+    |   refs/heads/side  |refs/heads/side
+    |    refs/odd/spot   |refs/odd/spot
+    |refs/tags/double-tag|refs/tags/double-tag
+    |   refs/tags/four   |refs/tags/four
+    |    refs/tags/one   |refs/tags/one
+    |refs/tags/signed-tag|refs/tags/signed-tag
+    |   refs/tags/three  |refs/tags/three
+    |    refs/tags/two   |refs/tags/two
     EOF
-    git for-each-ref --format="%(padright:5)%(refname)|" >actual &&
+    git for-each-ref
--format="|%(align:middle,20)%(refname)|%(refname)" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'right alignment' '
+    cat >expect <<-\EOF &&
+    |   refs/heads/master|refs/heads/master
+    |     refs/heads/side|refs/heads/side
+    |       refs/odd/spot|refs/odd/spot
+    |refs/tags/double-tag|refs/tags/double-tag
+    |      refs/tags/four|refs/tags/four
+    |       refs/tags/one|refs/tags/one
+    |refs/tags/signed-tag|refs/tags/signed-tag
+    |     refs/tags/three|refs/tags/three
+    |       refs/tags/two|refs/tags/two
+    EOF
+    git for-each-ref
--format="|%(align:right,20)%(refname)|%(refname)" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'alignment value lesser than atom value' '
+    cat >expect <<-\EOF &&
+    |refs/heads/master|
+    |refs/heads/side|
+    |  refs/odd/spot|
+    |refs/tags/double-tag|
+    | refs/tags/four|
+    |  refs/tags/one|
+    |refs/tags/signed-tag|
+    |refs/tags/three|
+    |  refs/tags/two|
+    EOF
+    git for-each-ref --format="|%(align:right,15)%(refname)|" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'non atom alignment' '
+    cat >expect <<-\EOF &&
+    |    |master  |  refs/heads/master|  refs/heads/master
+    |    |side  |  refs/heads/side|  refs/heads/side
+    |    |odd/spot  |  refs/odd/spot|  refs/odd/spot
+    |    |double-tag  |  refs/tags/double-tag|  refs/tags/double-tag
+    |    |four  |  refs/tags/four|  refs/tags/four
+    |    |one  |  refs/tags/one|  refs/tags/one
+    |    |signed-tag  |  refs/tags/signed-tag|  refs/tags/signed-tag
+    |    |three  |  refs/tags/three|  refs/tags/three
+    |    |two  |  refs/tags/two|  refs/tags/two
+    EOF
+    git for-each-ref
--format="|%(align:right,5)|%(refname:short)%(align:middle,5)|%(refname)%(align:left,3)|%(refname)"
>actual &&
     test_cmp expect actual
 '

-- 
Regards,
Karthik Nayak
