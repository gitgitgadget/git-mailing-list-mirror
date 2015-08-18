From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v12 00/13] port tag.c to use ref-filter.c APIs
Date: Wed, 19 Aug 2015 00:07:19 +0530
Message-ID: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 20:37:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRllN-00087f-9w
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 20:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbbHRSh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 14:37:29 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36607 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbHRSh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 14:37:28 -0400
Received: by pdbmi9 with SMTP id mi9so30349428pdb.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6DpbE+AH1BiDolWVKAjYhOh8Z9r/GZ00ZDLBqKNVfzk=;
        b=f4dlgjQ7OrvTVUKdbAy8TIc3Z/aMigauP5HKXod9+XTKJI+2RKnaecroRCExcTfwRF
         l1c6tBWiXV4r6WjGU5wQhBCRg7HMF7EuLychfyv0gdFhShRnWhSzl1FT5fc21g1StBa1
         CTe2Lb298FQnTO2T5yPRlkw9wxjIczgH7aCEnLYBfShatp2mnb+gFENmbdDbtxWeTeLE
         7Y6XcmOxKbrAm5OOFOJkkGYGb0Pc1W1Mn/e1/fxwbRXDQCx5ViDX6boqxhYkdg+zQfEQ
         dCOEGGLTiWt62UxPg+2o9eqNVqbgAwlbXNUzYm57BGPI1n6zaHi3YLTdreYyEfpCpFeE
         sQ6g==
X-Received: by 10.70.22.98 with SMTP id c2mr5357574pdf.115.1439923047329;
        Tue, 18 Aug 2015 11:37:27 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id i9sm18858190pbq.44.2015.08.18.11.37.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 11:37:25 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276133>

This is part of my GSoC project to "unify the code used by branch -l, 
tag -l, and for-each-ref". This series ports over tag.c to use ref-filter
APIs.

Version 11 was posted here:
http://article.gmane.org/gmane.comp.version-control.git/275997

Changes in this version:
* Small style and formatting changes.
* Remove unnecessary variable from push_new_state().
* pop_state doesn't return a value now and attaches the buffer 
  into the previous state.
* use strcmp() rather than starts_with() while checking for 
  alignment position.
* Change attend to at_end

Karthik Nayak (13):
  ref-filter: move `struct atom_value` to ref-filter.c
  ref-filter: introduce ref_formatting_state
  ref-filter: introduce the ref_formatting_state stack machinery
  utf8: add function to align a string into given strbuf
  ref-filter: implement an `align` atom
  ref-filter: add option to filter out tags, branches and remotes
  ref-filter: support printing N lines from tag annotation
  ref-filter: add support to sort by version
  ref-filter: add option to match literal pattern
  tag.c: use 'ref-filter' data structures
  tag.c: use 'ref-filter' APIs
  tag.c: implement '--format' option
  tag.c: implement '--merged' and '--no-merged' options

 Documentation/git-for-each-ref.txt |  11 ++
 Documentation/git-tag.txt          |  34 +++-
 builtin/for-each-ref.c             |   3 +-
 builtin/tag.c                      | 367 +++++++------------------------------
 ref-filter.c                       | 312 +++++++++++++++++++++++++++----
 ref-filter.h                       |  32 +++-
 refs.c                             |   9 +
 refs.h                             |   1 +
 t/t6302-for-each-ref-filter.sh     |  84 +++++++++
 t/t7004-tag.sh                     |  51 +++++-
 utf8.c                             |  21 +++
 utf8.h                             |  15 ++
 12 files changed, 577 insertions(+), 363 deletions(-)


Interdiff:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 3099631..760d719 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -128,8 +128,8 @@ color::
 	are described in `color.branch.*`.
 
 align::
-	left-, middle-, or right-align the content between %(align:..)
-	and %(end). Followed by `:<position>,<width>`, where the
+	Left-, middle-, or right-align the content between %(align:..)
+	and %(end). Followed by `:<width>>,<position>`, where the
 	`<position>` is either left, right or middle and `<width>` is
 	the total length of the content with alignment. If the
 	contents length is more than the width then no alignment is
diff --git a/ref-filter.c b/ref-filter.c
index a6086b2..665221b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -66,9 +66,9 @@ struct align {
 };
 
 struct ref_formatting_state {
-	struct strbuf output;
 	struct ref_formatting_state *prev;
-	void (*attend)(struct ref_formatting_state *state);
+	struct strbuf output;
+	void (*at_end)(struct ref_formatting_state *state);
 	void *cb_data;
 	int quote_style;
 };
@@ -149,24 +149,25 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	return at;
 }
 
-static struct ref_formatting_state *push_new_state(struct ref_formatting_state **state)
+static void push_new_state(struct ref_formatting_state **stack)
 {
-	struct ref_formatting_state *new = xcalloc(1, sizeof(struct ref_formatting_state));
-	struct ref_formatting_state *old = *state;
+	struct ref_formatting_state *s = xcalloc(1, sizeof(struct ref_formatting_state));
 
-	*state = new;
-	new->prev = old;
-	return new;
+	strbuf_init(&s->output, 0);
+	s->prev = *stack;
+	*stack = s;
 }
 
-static void pop_state(struct ref_formatting_state **state)
+static void pop_state(struct ref_formatting_state **stack)
 {
-	struct ref_formatting_state *current = *state;
+	struct ref_formatting_state *current = *stack;
 	struct ref_formatting_state *prev = current->prev;
 
+	if (prev)
+		strbuf_addbuf(&prev->output, &current->output);
 	strbuf_release(&current->output);
 	free(current);
-	*state = prev;
+	*stack = prev;
 }
 
 /*
@@ -641,29 +642,31 @@ static inline char *copy_advance(char *dst, const char *src)
 
 static void align_handler(struct ref_formatting_state *state)
 {
-	struct strbuf aligned = STRBUF_INIT;
-	struct ref_formatting_state *return_to = state->prev;
 	struct align *align = (struct align *)state->cb_data;
+	struct strbuf s = STRBUF_INIT;
 
-	strbuf_utf8_align(&aligned, align->position, align->width, state->output.buf);
-	strbuf_addbuf(&return_to->output, &aligned);
-	strbuf_release(&aligned);
+	strbuf_utf8_align(&s, align->position, align->width, state->output.buf);
+	strbuf_reset(&state->output);
+	strbuf_addbuf(&state->output, &s);
+	free(align);
 }
 
 static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
 {
-	struct ref_formatting_state *new = push_new_state(state);
-	strbuf_init(&new->output, 0);
-	new->attend = align_handler;
+	struct ref_formatting_state *new;
+
+	push_new_state(state);
+	new = *state;
+	new->at_end = align_handler;
 	new->cb_data = atomv->align;
 }
 
 static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
 {
 	struct ref_formatting_state *current = *state;
-	if (!current->attend)
+	if (!current->at_end)
 		die(_("format: `end` atom used without a supporting atom"));
-	current->attend(current);
+	current->at_end(current);
 	pop_state(state);
 }
 
@@ -771,11 +774,11 @@ static void populate_value(struct ref_array_item *ref)
 			if (strtoul_ui(valp, 10, &align->width))
 				die(_("positive width expected align:%s"), valp);
 
-			if (!ep || starts_with(ep + 1, "left"))
+			if (!ep || !strcmp(ep + 1, "left"))
 				align->position = ALIGN_LEFT;
-			else if (starts_with(ep + 1, "right"))
+			else if (!strcmp(ep + 1, "right"))
 				align->position = ALIGN_RIGHT;
-			else if (starts_with(ep + 1, "middle"))
+			else if (!strcmp(ep + 1, "middle"))
 				align->position = ALIGN_MIDDLE;
 			else
 				die(_("improper format entered align:%s"), ep + 1);
@@ -1305,7 +1308,7 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 
 	/*  Simple per-ref filtering */
 	if (type & FILTER_REFS_INCLUDE_BROKEN) {
-		type -= FILTER_REFS_INCLUDE_BROKEN;
+		type &= ~FILTER_REFS_INCLUDE_BROKEN;
 		broken = 1;
 	}
 
@@ -1484,7 +1487,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
 	struct strbuf *final_buf;
 	struct ref_formatting_state *state = NULL;
 
-	state = push_new_state(&state);
+	push_new_state(&state);
 	state->quote_style = quote_style;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
diff --git a/ref-filter.h b/ref-filter.h
index 72fdf9e..8241066 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -5,7 +5,6 @@
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
-#include "utf8.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
diff --git a/refs.c b/refs.c
index 0f18c34..a92bba1 100644
--- a/refs.c
+++ b/refs.c
@@ -2147,9 +2147,11 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
 {
+	unsigned int flag = 0;
+
 	if (broken)
-		broken = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(&ref_cache, type, fn, 0, broken, cb_data);
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(&ref_cache, type, fn, 0, flag, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 5b73539..335396e 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1462,7 +1462,7 @@ test_expect_success 'invalid sort parameter on command line' '
 
 test_expect_success 'invalid sort parameter in configuratoin' '
 	git config tag.sort "v:notvalid" &&
-	test_must_fail git tag -l "foo*" >actual
+	test_must_fail git tag -l "foo*"
 '
 
 test_expect_success 'version sort with prerelease reordering' '
diff --git a/utf8.c b/utf8.c
index 0fb8e9d..00e10c8 100644
--- a/utf8.c
+++ b/utf8.c
@@ -660,7 +660,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
 	if (position == ALIGN_LEFT)
 		strbuf_addf(buf, "%-*s", width + utf8_compensation, s);
 	else if (position == ALIGN_MIDDLE) {
-		int left = (width - display_len)/2;
+		int left = (width - display_len) / 2;
 		strbuf_addf(buf, "%*s%-*s", left, "", width - left + utf8_compensation, s);
 	} else if (position == ALIGN_RIGHT)
 		strbuf_addf(buf, "%*s", width + utf8_compensation, s);


-- 
2.5.0
