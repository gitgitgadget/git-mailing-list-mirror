Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C363D1FAE2
	for <e@80x24.org>; Tue, 13 Mar 2018 10:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932637AbeCMKQo (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 06:16:44 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:39922
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752411AbeCMKQi (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Mar 2018 06:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1520936196;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=FvjZ8K6MQ8YDGydxWr6diYqGYGitVRUl+MJjDGz3zTs=;
        b=RhYAW9fSRK4tO+SWfzkwUCXde03TE/ve/EUm5kjWXPR6GZlrZAlBwPZYKgLdeQYJ
        +zViqa880C5Yxyo4QxrfOa37Kk/+l5/qGGbnkMicjXDPUeDze2B/LBoJZ+mcDvCwMFs
        4n3GkNejenVkU2TLHA3z3W3SZOSfm3AvfVPYjWww=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201621edc9811-4197d53b-2ebd-4543-b316-22b58804c6b4-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
References: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
Subject: [RFC 2/4] ref-filter: add return value && strbuf to handlers
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Mar 2018 10:16:36 +0000
X-SES-Outgoing: 2018.03.13-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue removing any printing from ref-filter formatting logic,
so that it could be more general.

Change the signature of handlers by adding return value
and strbuf parameter for errors.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 71 ++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 54fae00bdd410..07bedc636398c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -387,7 +387,8 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
-	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
+	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
+		       struct strbuf *err);
 	uintmax_t value; /* used for sorting when not FIELD_STR */
 	struct used_atom *atom;
 };
@@ -481,7 +482,8 @@ static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
 	}
 }
 
-static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
+static int append_atom(struct atom_value *v, struct ref_formatting_state *state,
+		       struct strbuf *err)
 {
 	/*
 	 * Quote formatting is only done when the stack has a single
@@ -493,6 +495,7 @@ static void append_atom(struct atom_value *v, struct ref_formatting_state *state
 		quote_formatting(&state->stack->output, v->s, state->quote_style);
 	else
 		strbuf_addstr(&state->stack->output, v->s);
+	return 0;
 }
 
 static void push_stack_element(struct ref_formatting_stack **stack)
@@ -527,7 +530,8 @@ static void end_align_handler(struct ref_formatting_stack **stack)
 	strbuf_release(&s);
 }
 
-static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+static int align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
+			      struct strbuf *err)
 {
 	struct ref_formatting_stack *new_stack;
 
@@ -535,6 +539,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	new_stack = state->stack;
 	new_stack->at_end = end_align_handler;
 	new_stack->at_end_data = &atomv->atom->u.align;
+	return 0;
 }
 
 static void if_then_else_handler(struct ref_formatting_stack **stack)
@@ -572,7 +577,8 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 	free(if_then_else);
 }
 
-static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
+			   struct strbuf *err)
 {
 	struct ref_formatting_stack *new_stack;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
@@ -584,6 +590,7 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	new_stack = state->stack;
 	new_stack->at_end = if_then_else_handler;
 	new_stack->at_end_data = if_then_else;
+	return 0;
 }
 
 static int is_empty(const char *s)
@@ -596,19 +603,24 @@ static int is_empty(const char *s)
 	return 1;
 }
 
-static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
+			     struct strbuf *err)
 {
 	struct ref_formatting_stack *cur = state->stack;
 	struct if_then_else *if_then_else = NULL;
 
 	if (cur->at_end == if_then_else_handler)
 		if_then_else = (struct if_then_else *)cur->at_end_data;
-	if (!if_then_else)
-		die(_("format: %%(then) atom used without an %%(if) atom"));
-	if (if_then_else->then_atom_seen)
-		die(_("format: %%(then) atom used more than once"));
-	if (if_then_else->else_atom_seen)
-		die(_("format: %%(then) atom used after %%(else)"));
+	if (!if_then_else) {
+		strbuf_addstr(err, _("format: %(then) atom used without an %(if) atom"));
+		return -1;
+	} else if (if_then_else->then_atom_seen) {
+		strbuf_addstr(err, _("format: %(then) atom used more than once"));
+		return -1;
+	} else if (if_then_else->else_atom_seen) {
+		strbuf_addstr(err, _("format: %(then) atom used after %(else)"));
+		return -1;
+	}
 	if_then_else->then_atom_seen = 1;
 	/*
 	 * If the 'equals' or 'notequals' attribute is used then
@@ -624,34 +636,44 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
 	} else if (cur->output.len && !is_empty(cur->output.buf))
 		if_then_else->condition_satisfied = 1;
 	strbuf_reset(&cur->output);
+	return 0;
 }
 
-static void else_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+static int else_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
+			     struct strbuf *err)
 {
 	struct ref_formatting_stack *prev = state->stack;
 	struct if_then_else *if_then_else = NULL;
 
 	if (prev->at_end == if_then_else_handler)
 		if_then_else = (struct if_then_else *)prev->at_end_data;
-	if (!if_then_else)
-		die(_("format: %%(else) atom used without an %%(if) atom"));
-	if (!if_then_else->then_atom_seen)
-		die(_("format: %%(else) atom used without a %%(then) atom"));
-	if (if_then_else->else_atom_seen)
-		die(_("format: %%(else) atom used more than once"));
+	if (!if_then_else) {
+		strbuf_addstr(err, _("format: %(else) atom used without an %(if) atom"));
+		return -1;
+	} else if (!if_then_else->then_atom_seen) {
+		strbuf_addstr(err, _("format: %(else) atom used without a %(then) atom"));
+		return -1;
+	} else if (if_then_else->else_atom_seen) {
+		strbuf_addstr(err, _("format: %(else) atom used more than once"));
+		return -1;
+	}
 	if_then_else->else_atom_seen = 1;
 	push_stack_element(&state->stack);
 	state->stack->at_end_data = prev->at_end_data;
 	state->stack->at_end = prev->at_end;
+	return 0;
 }
 
-static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+static int end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
+			    struct strbuf *err)
 {
 	struct ref_formatting_stack *current = state->stack;
 	struct strbuf s = STRBUF_INIT;
 
-	if (!current->at_end)
-		die(_("format: %%(end) atom used without corresponding atom"));
+	if (!current->at_end) {
+		strbuf_addstr(err, _("format: %(end) atom used without corresponding atom"));
+		return -1;
+	}
 	current->at_end(&state->stack);
 
 	/*  Stack may have been popped within at_end(), hence reset the current pointer */
@@ -668,6 +690,7 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	}
 	strbuf_release(&s);
 	pop_stack_element(&state->stack);
+	return 0;
 }
 
 /*
@@ -2138,7 +2161,8 @@ int format_ref_array_item(struct ref_array_item *info,
 		get_ref_atom_value(info,
 				   parse_ref_filter_atom(format, sp + 2, ep),
 				   &atomv);
-		atomv->handler(atomv, &state);
+		if (atomv->handler(atomv, &state, error_buf))
+			return -1;
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -2147,7 +2171,8 @@ int format_ref_array_item(struct ref_array_item *info,
 	if (format->need_color_reset_at_eol) {
 		struct atom_value resetv;
 		resetv.s = GIT_COLOR_RESET;
-		append_atom(&resetv, &state);
+		if (append_atom(&resetv, &state, error_buf))
+			return -1;
 	}
 	if (state.stack->prev) {
 		strbuf_addstr(error_buf, _("format: %(end) atom missing"));

--
https://github.com/git/git/pull/466
