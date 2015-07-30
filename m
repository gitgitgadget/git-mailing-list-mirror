From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 0/11] port tag.c to use ref-filter APIs
Date: Thu, 30 Jul 2015 21:04:51 +0530
Message-ID: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 17:35:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKprq-0000fs-VC
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbbG3PfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:35:22 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33318 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbbG3PfV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:35:21 -0400
Received: by oixx19 with SMTP id x19so23728410oix.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=xA6ovSt2RGvFN4UrZMHI8uy5lfcKVJG1Pi/W+EBeePA=;
        b=KbZuWtT/1xh7GdWc0fCCC7iR70QM5hk7uGcigj7JRmye4ETLF4NaSL8A2ONzHi04Hm
         kFPunGxzngDv4at6kAV+d400NjPYlhWIvO87k8aOMgc1nClMv1uZ3/hqaZ61Lgj7oU/o
         qZe9h2XRLvtdzVmCQ1eSd1vWKI1N+VLyTtTVnE38BLykJnhmIuN92RH0t5r+mnMAeKIz
         IzVl50uqYrRQQfGXDiGH/wix7CMS9un2f+LFbXMw709lP2JxSGUsZE4fNkq+kyHx61d4
         kZ/CL/y3Br4HLRZgEcXfJgH3JaZrEJnb2rH6aklmJhi/cpXKlu446R0BfOFHHf/MFLiW
         Cp/w==
X-Received: by 10.202.200.151 with SMTP id y145mr44646730oif.111.1438270520668;
 Thu, 30 Jul 2015 08:35:20 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 30 Jul 2015 08:34:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274990>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.  This patch series is continued from: Git (next)
https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61

Version 6 can be found here:
http://article.gmane.org/gmane.comp.version-control.git/274726

Changes in this version:
* ref_formatting_state now works on emit() also, hence succeeding
strings and atoms are affected.
* Make color a modifier_atom like in v5.
* Add test for "padright" when its value is lesser than the value of the atom.
* Other small changes.

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt
b/Documentation/git-for-each-ref.txt
index 2b60aee..bcf319a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -128,10 +128,10 @@ color::
     are described in `color.branch.*`.

 padright::
-    Pad succeeding atom to the right. Followed by `:<value>`,
-    where `value` states the total length of atom including the
-    padding. If the `value` is greater than the atom length, then
-    no padding is performed.
+    Pad succeeding atom or string to the right. Followed by
+    `:<value>`, where `value` states the total length of atom or
+    string including the padding. If the `value` is lesser than
+    the atom or string length, then no padding is performed.

 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
@@ -152,7 +152,7 @@ order (`objectsize`, `authordate`,
`committerdate`, `taggerdate`).
 All other fields are used to sort in their byte-value order.

 There is also an option to sort by versions, this can be done by using
-the fieldname `version:refname` or in short `v:refname`.
+the fieldname `version:refname` or its alias `v:refname`.

 In any case, a field name that refers to a field inapplicable to
 the object referred by the ref does not cause an error.  It
diff --git a/ref-filter.c b/ref-filter.c
index 0a34924..65d168e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -624,7 +624,7 @@ static void populate_value(struct ref_array_item *ref)
         const char *name = used_atom[i];
         struct atom_value *v = &ref->value[i];
         int deref = 0;
-        const char *refname = NULL;
+        const char *refname;
         const char *formatp;
         struct branch *branch = NULL;

@@ -664,6 +664,8 @@ static void populate_value(struct ref_array_item *ref)
             if (color_parse(name + 6, color) < 0)
                 die(_("unable to parse format"));
             v->s = xstrdup(color);
+            v->color = 1;
+            v->modifier_atom = 1;
             continue;
         } else if (!strcmp(name, "flag")) {
             char buf[256], *cp = buf;
@@ -954,12 +956,9 @@ static int match_pattern(const char **patterns,
const char *refname)
      * When no '--format' option is given we need to skip the prefix
      * for matching refs of tags and branches.
      */
-    if (skip_prefix(refname, "refs/tags/", &refname))
-        ;
-    else if (skip_prefix(refname, "refs/heads/", &refname))
-        ;
-    else if (skip_prefix(refname, "refs/remotes/", &refname))
-        ;
+    (void)(skip_prefix(refname, "refs/tags/", &refname) ||
+           skip_prefix(refname, "refs/heads/", &refname) ||
+           skip_prefix(refname, "refs/remotes/", &refname));

     for (; *patterns; patterns++) {
         if (!wildmatch(*patterns, refname, 0, NULL))
@@ -1245,19 +1244,24 @@ void ref_array_sort(struct ref_sorting
*sorting, struct ref_array *array)
 }

 static void apply_formatting_state(struct ref_formatting_state *state,
-                   struct atom_value *v, struct strbuf *value)
+                   const char *buf, struct strbuf *value)
 {
+    if (state->color) {
+        strbuf_addstr(value, state->color);
+        state->color = NULL;
+    }
     if (state->pad_to_right) {
-        if (!is_utf8(v->s))
-            strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
+        if (!is_utf8(buf))
+            strbuf_addf(value, "%-*s", state->pad_to_right, buf);
         else {
-            int utf8_compensation = strlen(v->s) - utf8_strwidth(v->s);
-            strbuf_addf(value, "%-*s", state->pad_to_right +
utf8_compensation, v->s);
+            int utf8_compensation = strlen(buf) - utf8_strwidth(buf);
+            strbuf_addf(value, "%-*s", state->pad_to_right +
utf8_compensation, buf);
         }
+        state->pad_to_right = 0;
         return;
     }

-    strbuf_addstr(value, v->s);
+    strbuf_addstr(value, buf);
 }

 static void print_value(struct atom_value *v, struct
ref_formatting_state *state)
@@ -1265,13 +1269,7 @@ static void print_value(struct atom_value *v,
struct ref_formatting_state *state
     struct strbuf value = STRBUF_INIT;
     struct strbuf formatted = STRBUF_INIT;

-    /*
-     * Some (pesudo) atoms have no immediate side effect, but only
-     * affect the next atom. Store the relevant information from
-     * these atoms in the 'state' variable for use when displaying
-     * the next atom.
-     */
-    apply_formatting_state(state, v, &value);
+    apply_formatting_state(state, v->s, &value);

     switch (state->quote_style) {
     case QUOTE_NONE:
@@ -1314,8 +1312,12 @@ static int hex2(const char *cp)
         return -1;
 }

-static void emit(const char *cp, const char *ep)
+static void emit(const char *cp, const char *ep,
+         struct ref_formatting_state *state)
 {
+    struct strbuf value = STRBUF_INIT;
+    struct strbuf format = STRBUF_INIT;
+
     while (*cp && (!ep || cp < ep)) {
         if (*cp == '%') {
             if (cp[1] == '%')
@@ -1329,25 +1331,24 @@ static void emit(const char *cp, const char *ep)
                 }
             }
         }
-        putchar(*cp);
+        strbuf_addch(&value, *cp);
         cp++;
     }
+    apply_formatting_state(state, value.buf, &format);
+    fputs(format.buf, stdout);
+    strbuf_release(&format);
+    strbuf_release(&value);
 }

 static void store_formatting_state(struct ref_formatting_state *state,
                    struct atom_value *atomv)
 {
+    if (atomv->color)
+        state->color = atomv->s;
     if (atomv->pad_to_right)
         state->pad_to_right = atomv->ul;
 }

-static void reset_formatting_state(struct ref_formatting_state *state)
-{
-    int quote_style = state->quote_style;
-    memset(state, 0, sizeof(*state));
-    state->quote_style = quote_style;
-}
-
 /*
  * If 'lines' is greater than 0, print that many lines from the given
  * object_id 'oid'.
@@ -1405,18 +1406,16 @@ void show_ref_array_item(struct ref_array_item
*info, const char *format,

         ep = strchr(sp, ')');
         if (cp < sp)
-            emit(cp, sp);
+            emit(cp, sp, &state);
         get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
         if (atomv->modifier_atom)
             store_formatting_state(&state, atomv);
-        else {
+        else
             print_value(atomv, &state);
-            reset_formatting_state(&state);
-        }
     }
     if (*cp) {
         sp = cp + strlen(cp);
-        emit(cp, sp);
+        emit(cp, sp, &state);
     }
     if (need_color_reset_at_eol) {
         struct atom_value resetv;
diff --git a/ref-filter.h b/ref-filter.h
index fcf469e..b50a036 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -21,12 +21,14 @@ struct atom_value {
     const char *s;
     unsigned long ul; /* used for sorting when not FIELD_STR */
     unsigned int modifier_atom : 1, /*  atoms which act as modifiers
for the next atom */
+        color : 1,
         pad_to_right : 1;
 };

 struct ref_formatting_state {
     int quote_style;
     unsigned int pad_to_right;
+    const char *color;
 };

 struct ref_sorting {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 68688a9..b9ebb3d 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -83,17 +83,33 @@ test_expect_success 'filtering with --contains' '

 test_expect_success 'padding to the right using `padright`' '
     cat >expect <<-\EOF &&
-    refs/heads/master|refs/heads/master        |refs/heads/master|
-    refs/heads/side|refs/heads/side          |refs/heads/side|
-    refs/odd/spot|refs/odd/spot            |refs/odd/spot|
-    refs/tags/double-tag|refs/tags/double-tag     |refs/tags/double-tag|
-    refs/tags/four|refs/tags/four           |refs/tags/four|
-    refs/tags/one|refs/tags/one            |refs/tags/one|
-    refs/tags/signed-tag|refs/tags/signed-tag     |refs/tags/signed-tag|
-    refs/tags/three|refs/tags/three          |refs/tags/three|
-    refs/tags/two|refs/tags/two            |refs/tags/two|
+    master|    master    |
+    side|    side      |
+    odd/spot|    odd/spot  |
+    double-tag|    double-tag|
+    four|    four      |
+    one|    one       |
+    signed-tag|    signed-tag|
+    three|    three     |
+    two|    two       |
     EOF
-    git for-each-ref
--format="%(refname)%(padright:25)|%(refname)|%(refname)|" >actual &&
+    git for-each-ref
--format="%(refname:short)%(padright:5)|%(padright:10)%(refname:short)|"
>actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'no padding when `padright` length is smaller
than atom length' '
+    cat >expect <<-\EOF &&
+    refs/heads/master|
+    refs/heads/side|
+    refs/odd/spot|
+    refs/tags/double-tag|
+    refs/tags/four|
+    refs/tags/one|
+    refs/tags/signed-tag|
+    refs/tags/three|
+    refs/tags/two|
+    EOF
+    git for-each-ref --format="%(padright:5)%(refname)|" >actual &&
     test_cmp expect actual
 '

Thanks to Everyone for suggestions and tips :)

-- 
Regards,
Karthik Nayak
