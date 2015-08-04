From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 0/11] Port tag.c over to use ref-filter APIs
Date: Tue, 4 Aug 2015 18:09:52 +0530
Message-ID: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 14:40:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbWI-00038G-B8
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 14:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbbHDMkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 08:40:23 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36773 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbbHDMkW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 08:40:22 -0400
Received: by obnw1 with SMTP id w1so5820045obn.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=Rj47yia6uwX4kIjQPg4S99nh1vJyxG/QQzETm++LtNk=;
        b=GczFNXp+gvPaWBaSzDaWbNF3Dmfjio6OpKi8JL3q+xqCHOfU0Bq6vgC0JUh9lhU57w
         g62hPnbv4MeUYHjKwftSC4mlHxmDO1EcFNgwG3u7pCAjm2WiKqdIUn03+pGwjQbcixoH
         AQ8T8oNA6SS1gbhXUnKpAp/T9EJEqS7//lm2vOUiheIszpZv5CI4u1ttDfNtlXv3vIv6
         xQyjnNhL/+mTmMJDbh5ccrFtziSXAUhNSCUME2iU/1fJ6CibWiS7WEdcsUgDA/qlN+ZD
         o3xpB7AyzXHOKvCytDbeQa15QKXPLKsoCVh6vQqcu5jWinH9aeItmKtb2BnR2f4Pb3vW
         QDKA==
X-Received: by 10.60.41.138 with SMTP id f10mr2894360oel.84.1438692022033;
 Tue, 04 Aug 2015 05:40:22 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 4 Aug 2015 05:39:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275252>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.  This patch series is continued from: Git (next)
https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61

This series consists of porting tag.c over to using the ref-filter APIs

Version 8 can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/274990

Changes:
* align now excepts strings till a %(end) is met.
* implement the current strbuf within ref_formatting_change
* change the strbuf name from format to final.

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt
b/Documentation/git-for-each-ref.txt
index e89b9b0..6b6eb93 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -128,11 +128,12 @@ color::
        are described in `color.branch.*`.

 align::
-       Align succeeding atoms to the right, left or middle. Followed
-       by `:<type>,<paddinglength>`, where the `<type>` is either
-       left, right or middle and `<paddinglength>` is the total
-       length of the padding to be performed. If the atom length is
-       more than the padding length then no padding is performed.
+       Align any string with or without %(atom) before the %(end)
+       atom to the right, left or middle. Followed by
+       `:<type>,<paddinglength>`, where the `<type>` is either left,
+       right or middle and `<paddinglength>` is the total length of
+       the padding to be performed. If the string length is more than
+       the padding length then no padding is performed.

 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index afeab37..de84dd4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -57,6 +57,7 @@ static struct {
        { "HEAD" },
        { "color" },
        { "align" },
+       { "end" },
 };

 /*
@@ -708,6 +709,11 @@ static void populate_value(struct ref_array_item *ref)
                        if (strtoul_ui(valp, 10, &align->align_value))
                                die(_("align: positive value expected"));
                        v->align = align;
+                       v->modifier_atom = 1;
+                       continue;
+               } else if (starts_with(name, "end")) {
+                       v->end = 1;
+                       v->modifier_atom = 1;
                        continue;
                } else
                        continue;
@@ -1247,24 +1253,23 @@ void ref_array_sort(struct ref_sorting
*sorting, struct ref_array *array)
        qsort(array->items, array->nr, sizeof(struct ref_array_item
*), compare_refs);
 }

-static void print_value(struct atom_value *v, struct
ref_formatting_state *state,
-                       struct strbuf *output)
+static void print_value(struct atom_value *v, struct
ref_formatting_state *state)
 {
        switch (state->quote_style) {
        case QUOTE_NONE:
-               strbuf_addstr(output, v->s);
+               strbuf_addstr(state->output, v->s);
                break;
        case QUOTE_SHELL:
-               sq_quote_buf(output, v->s);
+               sq_quote_buf(state->output, v->s);
                break;
        case QUOTE_PERL:
-               perl_quote_buf(output, v->s);
+               perl_quote_buf(state->output, v->s);
                break;
        case QUOTE_PYTHON:
-               python_quote_buf(output, v->s);
+               python_quote_buf(state->output, v->s);
                break;
        case QUOTE_TCL:
-               tcl_quote_buf(output, v->s);
+               tcl_quote_buf(state->output, v->s);
                break;
        }
 }
@@ -1287,7 +1292,7 @@ static int hex2(const char *cp)
                return -1;
 }

-static void emit(const char *cp, const char *ep, struct strbuf *output)
+static void emit(const char *cp, const char *ep, struct
ref_formatting_state *state)
 {
        while (*cp && (!ep || cp < ep)) {
                if (*cp == '%') {
@@ -1296,13 +1301,13 @@ static void emit(const char *cp, const char
*ep, struct strbuf *output)
                        else {
                                int ch = hex2(cp + 1);
                                if (0 <= ch) {
-                                       strbuf_addch(output, ch);
+                                       strbuf_addch(state->output, ch);
                                        cp += 3;
                                        continue;
                                }
                        }
                }
-               strbuf_addch(output, *cp);
+               strbuf_addch(state->output, *cp);
                cp++;
        }
 }
@@ -1313,12 +1318,14 @@ static void process_formatting_state(struct
atom_value *atomv, struct ref_format
                state->align = atomv->align;
                atomv->align = NULL;
        }
+       if (atomv->end)
+               state->end = 1;
 }

-static void apply_formatting_state(struct ref_formatting_state
*state, struct strbuf *value,
-                                  struct strbuf *format)
+static void apply_formatting_state(struct ref_formatting_state
*state, struct strbuf *final)
 {
-       if (state->align) {
+       if (state->align && state->end) {
+               struct strbuf *value = state->output;
                int len = 0, buf_len = value->len;
                struct align *align = state->align;

@@ -1331,26 +1338,26 @@ static void apply_formatting_state(struct
ref_formatting_state *state, struct st

                if (align->align_value < buf_len) {
                        state->align = NULL;
-                       strbuf_addbuf(format, value);
+                       strbuf_addbuf(final, value);
                        strbuf_release(value);
                        return;
                }

                if (align->align_type == ALIGN_LEFT)
-                       strbuf_addf(format, "%-*s", len +
align->align_value, value->buf);
+                       strbuf_addf(final, "%-*s", len +
align->align_value, value->buf);
                else if (align->align_type == ALIGN_MIDDLE) {
                        int right = (align->align_value - buf_len)/2;
-                       strbuf_addf(format, "%*s%-*s",
align->align_value - right + len,
+                       strbuf_addf(final, "%*s%-*s",
align->align_value - right + len,
                                    value->buf, right, "");
                } else if (align->align_type == ALIGN_RIGHT)
-                       strbuf_addf(format, "%*s", align->align_value,
value->buf);
+                       strbuf_addf(final, "%*s", align->align_value,
value->buf);
                strbuf_release(value);
                state->align = NULL;
                return;
-       }
-       strbuf_addbuf(format, value);
-       strbuf_release(value);
-
+       } else if (state->align)
+               return;
+       strbuf_addbuf(final, state->output);
+       strbuf_release(state->output);
 }

 /*
@@ -1407,27 +1414,34 @@ void show_ref_array_item(struct ref_array_item
*info, const char *format,

        memset(&state, 0, sizeof(state));
        state.quote_style = quote_style;
+       state.output = &value;

        for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
                struct atom_value *atomv = NULL;

                ep = strchr(sp, ')');
                if (cp < sp) {
-                       emit(cp, sp, &value);
-                       apply_formatting_state(&state, &value, &final_buf);
+                       emit(cp, sp, &state);
+                       apply_formatting_state(&state, &final_buf);
                }
                get_ref_atom_value(info, parse_ref_filter_atom(sp + 2,
ep), &atomv);
-               if (atomv->align)
+               if (atomv->modifier_atom)
                        process_formatting_state(atomv, &state);
                else {
-                       print_value(atomv, &state, &value);
-                       apply_formatting_state(&state, &value, &final_buf);
+                       print_value(atomv, &state);
+                       apply_formatting_state(&state, &final_buf);
+               }
+               if (atomv->end) {
+                       print_value(atomv, &state);
+                       apply_formatting_state(&state, &final_buf);
                }
        }
+       if (state.align)
+               die(_("format: align used without an `end` atom"));
        if (*cp) {
                sp = cp + strlen(cp);
-               emit(cp, sp, &value);
-               apply_formatting_state(&state, &value, &final_buf);
+               emit(cp, sp, &state);
+               apply_formatting_state(&state, &final_buf);
        }
        if (need_color_reset_at_eol) {
                struct atom_value resetv;
@@ -1436,8 +1450,8 @@ void show_ref_array_item(struct ref_array_item
*info, const char *format,
                if (color_parse("reset", color) < 0)
                        die("BUG: couldn't parse 'reset' as a color");
                resetv.s = color;
-               print_value(&resetv, &state, &value);
-               apply_formatting_state(&state, &value, &final_buf);
+               print_value(&resetv, &state);
+               apply_formatting_state(&state, &final_buf);
        }

        for (i = 0; i < final_buf.len; i++)
diff --git a/ref-filter.h b/ref-filter.h
index b3b9cd8..5be3e35 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -23,8 +23,9 @@

 struct ref_formatting_state {
        int quote_style;
+       struct strbuf *output;
        struct align *align;
-       struct strbuf *sb;
+       unsigned int end : 1;
 };
struct align {
@@ -36,6 +37,8 @@ struct atom_value {
        const char *s;
        struct align *align;
        unsigned long ul; /* used for sorting when not FIELD_STR */
+       unsigned int modifier_atom : 1,
+               end : 1;
 };

 struct ref_sorting {

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7332bea..272a7e4 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -83,81 +83,49 @@ test_expect_success 'filtering with --contains' '

 test_expect_success 'left alignment' '
        cat >expect <<-\EOF &&
-       refs/heads/master   |refs/heads/master
-       refs/heads/side     |refs/heads/side
-       refs/odd/spot       |refs/odd/spot
-       refs/tags/double-tag|refs/tags/double-tag
-       refs/tags/four      |refs/tags/four
-       refs/tags/one       |refs/tags/one
-       refs/tags/signed-tag|refs/tags/signed-tag
-       refs/tags/three     |refs/tags/three
-       refs/tags/two       |refs/tags/two
+       refname is refs/heads/master  |refs/heads/master
+       refname is refs/heads/side    |refs/heads/side
+       refname is refs/odd/spot      |refs/odd/spot
+       refname is refs/tags/double-tag|refs/tags/double-tag
+       refname is refs/tags/four     |refs/tags/four
+       refname is refs/tags/one      |refs/tags/one
+       refname is refs/tags/signed-tag|refs/tags/signed-tag
+       refname is refs/tags/three    |refs/tags/three
+       refname is refs/tags/two      |refs/tags/two
        EOF
-       git for-each-ref
--format="%(align:left,20)%(refname)|%(refname)" >actual &&
+       git for-each-ref --format="%(align:left,30)refname is
%(refname)%(end)|%(refname)" >actual &&
        test_cmp expect actual
 '

 test_expect_success 'middle alignment' '

        cat >expect <<-\EOF &&
-       |  refs/heads/master |refs/heads/master
-       |   refs/heads/side  |refs/heads/side
-       |    refs/odd/spot   |refs/odd/spot
-       |refs/tags/double-tag|refs/tags/double-tag
-       |   refs/tags/four   |refs/tags/four
-       |    refs/tags/one   |refs/tags/one
-       |refs/tags/signed-tag|refs/tags/signed-tag
-       |   refs/tags/three  |refs/tags/three
-       |    refs/tags/two   |refs/tags/two
+       | refname is refs/heads/master |refs/heads/master
+       |  refname is refs/heads/side  |refs/heads/side
+       |   refname is refs/odd/spot   |refs/odd/spot
+       |refname is refs/tags/double-tag|refs/tags/double-tag
+       |   refname is refs/tags/four  |refs/tags/four
+       |   refname is refs/tags/one   |refs/tags/one
+       |refname is refs/tags/signed-tag|refs/tags/signed-tag
+       |  refname is refs/tags/three  |refs/tags/three
+       |   refname is refs/tags/two   |refs/tags/two
        EOF
-       git for-each-ref
--format="|%(align:middle,20)%(refname)|%(refname)" >actual &&
+       git for-each-ref --format="|%(align:middle,30)refname is
%(refname)%(end)|%(refname)" >actual &&
        test_cmp expect actual
 '

 test_expect_success 'right alignment' '
        cat >expect <<-\EOF &&
-       |   refs/heads/master|refs/heads/master
-       |     refs/heads/side|refs/heads/side
-       |       refs/odd/spot|refs/odd/spot
-       |refs/tags/double-tag|refs/tags/double-tag
-       |      refs/tags/four|refs/tags/four
-       |       refs/tags/one|refs/tags/one
-       |refs/tags/signed-tag|refs/tags/signed-tag
-       |     refs/tags/three|refs/tags/three
-       |       refs/tags/two|refs/tags/two
+       |  refname is refs/heads/master|refs/heads/master
+       |    refname is refs/heads/side|refs/heads/side
+       |      refname is refs/odd/spot|refs/odd/spot
+       |refname is refs/tags/double-tag|refs/tags/double-tag
+       |     refname is refs/tags/four|refs/tags/four
+       |      refname is refs/tags/one|refs/tags/one
+       |refname is refs/tags/signed-tag|refs/tags/signed-tag
+       |    refname is refs/tags/three|refs/tags/three
+       |      refname is refs/tags/two|refs/tags/two
        EOF
-       git for-each-ref
--format="|%(align:right,20)%(refname)|%(refname)" >actual &&
-       test_cmp expect actual
-'
-
-test_expect_success 'alignment value lesser than atom value' '
-       cat >expect <<-\EOF &&
-       |refs/heads/master|
-       |refs/heads/side|
-       |  refs/odd/spot|
-       |refs/tags/double-tag|
-       | refs/tags/four|
-       |  refs/tags/one|
-       |refs/tags/signed-tag|
-       |refs/tags/three|
-       |  refs/tags/two|
-       EOF
-       git for-each-ref --format="|%(align:right,15)%(refname)|" >actual &&
-       test_cmp expect actual
-'
-
-test_expect_success 'non atom alignment' '
-       cat >expect <<-\EOF &&
-       |    |master  |  refs/heads/master|  refs/heads/master
-       |    |side  |  refs/heads/side|  refs/heads/side
-       |    |odd/spot  |  refs/odd/spot|  refs/odd/spot
-       |    |double-tag  |  refs/tags/double-tag|  refs/tags/double-tag
-       |    |four  |  refs/tags/four|  refs/tags/four
-       |    |one  |  refs/tags/one|  refs/tags/one
-       |    |signed-tag  |  refs/tags/signed-tag|  refs/tags/signed-tag
-       |    |three  |  refs/tags/three|  refs/tags/three
-       |    |two  |  refs/tags/two|  refs/tags/two
-       EOF
-       git for-each-ref
--format="|%(align:right,5)|%(refname:short)%(align:middle,5)|%(refname)%(align:left,3)|%(refname)"
>actual &&
+       git for-each-ref --format="|%(align:right,30)refname is
%(refname)%(end)|%(refname)" >actual &&
        test_cmp expect actual
 '


-- 
Regards,
Karthik Nayak
