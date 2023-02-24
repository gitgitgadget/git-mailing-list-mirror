Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F240C6FA99
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBXGjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBXGjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B320460D7D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:07 -0800 (PST)
Received: (qmail 3675 invoked by uid 109); 24 Feb 2023 06:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31101 invoked by uid 111); 24 Feb 2023 06:39:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:06 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/21] ref-filter: mark unused callback parameters
Message-ID: <Y/hbimqTTSmZ8k2w@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref-filter code uses virtual functions to handle specific atoms, but
many of the functions ignore some parameters:

  - most atom parsers do not need the ref_format itself, unless they are
    looking at centralized options like use_color, quote_style, etc.

  - meta-atom handlers like append_atom(), align_atom_handler(), etc,
    can't generate errors, so ignore their "err" parameter

  - likewise, the handlers for then/else/end do not even need to look at
    their atom_value, as the "if" handler put everything they need into
    the ref_formatting_state stack

Since these functions all have to conform to virtual function
interfaces, we can't just drop the unused parameters, but must mark them
as UNUSED (to appease -Wunused-parameter).

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 62 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 434a28c830..acdee7fe3d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -282,7 +282,8 @@ static int refname_atom_parser_internal(struct refname_atom *atom, const char *a
 	return 0;
 }
 
-static int remote_ref_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int remote_ref_atom_parser(struct ref_format *format UNUSED,
+				  struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
@@ -329,7 +330,8 @@ static int remote_ref_atom_parser(struct ref_format *format, struct used_atom *a
 	return 0;
 }
 
-static int objecttype_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int objecttype_atom_parser(struct ref_format *format UNUSED,
+				  struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
 	if (arg)
@@ -341,7 +343,8 @@ static int objecttype_atom_parser(struct ref_format *format, struct used_atom *a
 	return 0;
 }
 
-static int objectsize_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int objectsize_atom_parser(struct ref_format *format UNUSED,
+				  struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
 	if (!arg) {
@@ -361,7 +364,8 @@ static int objectsize_atom_parser(struct ref_format *format, struct used_atom *a
 	return 0;
 }
 
-static int deltabase_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int deltabase_atom_parser(struct ref_format *format UNUSED,
+				 struct used_atom *atom,
 				 const char *arg, struct strbuf *err)
 {
 	if (arg)
@@ -373,7 +377,8 @@ static int deltabase_atom_parser(struct ref_format *format, struct used_atom *at
 	return 0;
 }
 
-static int body_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int body_atom_parser(struct ref_format *format UNUSED,
+			    struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
@@ -382,7 +387,8 @@ static int body_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
-static int subject_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int subject_atom_parser(struct ref_format *format UNUSED,
+			       struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
 	if (!arg)
@@ -394,7 +400,8 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
 	return 0;
 }
 
-static int trailers_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int trailers_atom_parser(struct ref_format *format UNUSED,
+				struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
 	atom->u.contents.trailer_opts.no_divider = 1;
@@ -448,8 +455,9 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 	return 0;
 }
 
-static int raw_atom_parser(struct ref_format *format, struct used_atom *atom,
-				const char *arg, struct strbuf *err)
+static int raw_atom_parser(struct ref_format *format UNUSED,
+			   struct used_atom *atom,
+			   const char *arg, struct strbuf *err)
 {
 	if (!arg)
 		atom->u.raw_data.option = RAW_BARE;
@@ -460,7 +468,8 @@ static int raw_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
-static int oid_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int oid_atom_parser(struct ref_format *format UNUSED,
+			   struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
 {
 	if (!arg)
@@ -479,7 +488,8 @@ static int oid_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
-static int person_email_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int person_email_atom_parser(struct ref_format *format UNUSED,
+				    struct used_atom *atom,
 				    const char *arg, struct strbuf *err)
 {
 	if (!arg)
@@ -493,7 +503,8 @@ static int person_email_atom_parser(struct ref_format *format, struct used_atom
 	return 0;
 }
 
-static int refname_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int refname_atom_parser(struct ref_format *format UNUSED,
+			       struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
 	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name, err);
@@ -510,7 +521,8 @@ static align_type parse_align_position(const char *s)
 	return -1;
 }
 
-static int align_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int align_atom_parser(struct ref_format *format UNUSED,
+			     struct used_atom *atom,
 			     const char *arg, struct strbuf *err)
 {
 	struct align *align = &atom->u.align;
@@ -562,7 +574,8 @@ static int align_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
-static int if_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int if_atom_parser(struct ref_format *format UNUSED,
+			  struct used_atom *atom,
 			  const char *arg, struct strbuf *err)
 {
 	if (!arg) {
@@ -577,7 +590,8 @@ static int if_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
-static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int rest_atom_parser(struct ref_format *format,
+			    struct used_atom *atom UNUSED,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
@@ -586,7 +600,8 @@ static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
-static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int head_atom_parser(struct ref_format *format UNUSED,
+			    struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
@@ -791,7 +806,7 @@ static void quote_formatting(struct strbuf *s, const char *str, ssize_t len, int
 }
 
 static int append_atom(struct atom_value *v, struct ref_formatting_state *state,
-		       struct strbuf *unused_err)
+		       struct strbuf *err UNUSED)
 {
 	/*
 	 * Quote formatting is only done when the stack has a single
@@ -841,7 +856,7 @@ static void end_align_handler(struct ref_formatting_stack **stack)
 }
 
 static int align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
-			      struct strbuf *unused_err)
+			      struct strbuf *err UNUSED)
 {
 	struct ref_formatting_stack *new_stack;
 
@@ -888,7 +903,7 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 }
 
 static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
-			   struct strbuf *unused_err)
+			   struct strbuf *err UNUSED)
 {
 	struct ref_formatting_stack *new_stack;
 	struct if_then_else *if_then_else = xcalloc(1,
@@ -915,7 +930,8 @@ static int is_empty(struct strbuf *buf)
 	return cur == end;
  }
 
-static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
+static int then_atom_handler(struct atom_value *atomv UNUSED,
+			     struct ref_formatting_state *state,
 			     struct strbuf *err)
 {
 	struct ref_formatting_stack *cur = state->stack;
@@ -952,7 +968,8 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	return 0;
 }
 
-static int else_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
+static int else_atom_handler(struct atom_value *atomv UNUSED,
+			     struct ref_formatting_state *state,
 			     struct strbuf *err)
 {
 	struct ref_formatting_stack *prev = state->stack;
@@ -973,7 +990,8 @@ static int else_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	return 0;
 }
 
-static int end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
+static int end_atom_handler(struct atom_value *atomv UNUSED,
+			    struct ref_formatting_state *state,
 			    struct strbuf *err)
 {
 	struct ref_formatting_stack *current = state->stack;
-- 
2.39.2.981.g6157336f25

