Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740B7A136
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235053; cv=none; b=MxSk3SKSyqgSNEHkc5f7C9bnJQmcenRiO/KHX4lRzNVJkcemoY9A1NMZjh7k82s4R35477s558JT2CgOyw5uq2PjhPvScyRruhcocD4WPQwA8MWY04tD0b5MkrprypP0aFF0drOQB/Ly0Hh/MkZS9L3FjngFSJjzIQtA2Nxp3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235053; c=relaxed/simple;
	bh=z+iLir8QHzqA0DiGFu4DAzWjfVXx1lLy93MDzqtVGuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp3NxwJ1S0Kmh5VoNWeTKhxB/Wsm8bUtoG+vxU0InhoOI/WiLoTJ1hLibZnlAyOkVmtW3T//dmX+A7dnmv85Vlwhsr7/Nust6i0KZHj9C9mwHE9JQkmLSPHjIUiZIpZZR1AlBswhLP4iJQnj9kWVdCjrEqciw+kQo3+aOORwYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17576 invoked by uid 109); 12 Mar 2024 09:17:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28063 invoked by uid 111); 12 Mar 2024 09:17:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:29 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 08/16] strbuf: accept a comment string for
 strbuf_commented_addf()
Message-ID: <20240312091729.GH95609@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312091013.GA95442@coredump.intra.peff.net>

As part of our transition to multi-byte comment characters, let's take a
NUL-terminated string pointer for strbuf_commented_addf() rather than a
single character.

All of the callers have to be adjusted, but they can just pass
comment_line_str rather than comment_line_char.

Note that we rely on strbuf_add_commented_lines() under the hood, so
we'll cheat a bit to squeeze our string into a single character (for now
the two are equivalent, and we'll address this TODO in the next patch).

Signed-off-by: Jeff King <peff@peff.net>
---
 add-patch.c          |  8 ++++----
 builtin/branch.c     |  2 +-
 builtin/merge.c      |  8 ++++----
 builtin/tag.c        |  4 ++--
 rebase-interactive.c |  2 +-
 sequencer.c          |  4 ++--
 strbuf.c             | 10 ++++++++--
 strbuf.h             |  2 +-
 wt-status.c          |  2 +-
 9 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..7390677795 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1105,11 +1105,11 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 	size_t i;
 
 	strbuf_reset(&s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf, comment_line_str,
 			      _("Manual hunk edit mode -- see bottom for "
 				"a quick guide.\n"));
 	render_hunk(s, hunk, 0, 0, &s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf, comment_line_str,
 			      _("---\n"
 				"To remove '%c' lines, make them ' ' lines "
 				"(context).\n"
@@ -1118,13 +1118,13 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 			      s->mode->is_reverse ? '+' : '-',
 			      s->mode->is_reverse ? '-' : '+',
 			      comment_line_char);
-	strbuf_commented_addf(&s->buf, comment_line_char, "%s",
+	strbuf_commented_addf(&s->buf, comment_line_str, "%s",
 			      _(s->mode->edit_hunk_hint));
 	/*
 	 * TRANSLATORS: 'it' refers to the patch mentioned in the previous
 	 * messages.
 	 */
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf, comment_line_str,
 			      _("If it does not apply cleanly, you will be "
 				"given an opportunity to\n"
 				"edit again.  If all lines of the hunk are "
diff --git a/builtin/branch.c b/builtin/branch.c
index f6091f3438..2d8c89e9ac 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -673,7 +673,7 @@ static int edit_branch_description(const char *branch_name)
 	exists = !read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
-	strbuf_commented_addf(&buf, comment_line_char,
+	strbuf_commented_addf(&buf, comment_line_str,
 		    _("Please edit the description for the branch\n"
 		      "  %s\n"
 		      "Lines starting with '%c' will be stripped.\n"),
diff --git a/builtin/merge.c b/builtin/merge.c
index a0ba1f9815..4e47434708 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -852,15 +852,15 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		strbuf_addch(&msg, '\n');
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			wt_status_append_cut_line(&msg);
-			strbuf_commented_addf(&msg, comment_line_char, "\n");
+			strbuf_commented_addf(&msg, comment_line_str, "\n");
 		}
-		strbuf_commented_addf(&msg, comment_line_char,
+		strbuf_commented_addf(&msg, comment_line_str,
 				      _(merge_editor_comment));
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
-			strbuf_commented_addf(&msg, comment_line_char,
+			strbuf_commented_addf(&msg, comment_line_str,
 					      _(scissors_editor_comment));
 		else
-			strbuf_commented_addf(&msg, comment_line_char,
+			strbuf_commented_addf(&msg, comment_line_str,
 				_(no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
diff --git a/builtin/tag.c b/builtin/tag.c
index 07327d3c04..1c708785bf 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -291,10 +291,10 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addch(&buf, '\n');
 			if (opt->cleanup_mode == CLEANUP_ALL)
-				strbuf_commented_addf(&buf, comment_line_char,
+				strbuf_commented_addf(&buf, comment_line_str,
 				      _(tag_template), tag, comment_line_char);
 			else
-				strbuf_commented_addf(&buf, comment_line_char,
+				strbuf_commented_addf(&buf, comment_line_str,
 				      _(tag_template_nocleanup), tag, comment_line_char);
 			write_or_die(fd, buf.buf, buf.len);
 			strbuf_release(&buf);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 6dfc33e4e3..affc93a8e4 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -71,7 +71,7 @@ void append_todo_help(int command_count,
 
 	if (!edit_todo) {
 		strbuf_addch(buf, '\n');
-		strbuf_commented_addf(buf, comment_line_char,
+		strbuf_commented_addf(buf, comment_line_str,
 				      Q_("Rebase %s onto %s (%d command)",
 					 "Rebase %s onto %s (%d commands)",
 					 command_count),
diff --git a/sequencer.c b/sequencer.c
index 4819265bf1..051929c9f1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -667,11 +667,11 @@ void append_conflicts_hint(struct index_state *istate,
 	}
 
 	strbuf_addch(msgbuf, '\n');
-	strbuf_commented_addf(msgbuf, comment_line_char, "Conflicts:\n");
+	strbuf_commented_addf(msgbuf, comment_line_str, "Conflicts:\n");
 	for (i = 0; i < istate->cache_nr;) {
 		const struct cache_entry *ce = istate->cache[i++];
 		if (ce_stage(ce)) {
-			strbuf_commented_addf(msgbuf, comment_line_char,
+			strbuf_commented_addf(msgbuf, comment_line_str,
 					      "\t%s\n", ce->name);
 			while (i < istate->cache_nr &&
 			       !strcmp(ce->name, istate->cache[i]->name))
diff --git a/strbuf.c b/strbuf.c
index e9b6127e76..76d02e0920 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -368,7 +368,7 @@ void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
 	add_lines(out, prefix, buf, size, 1);
 }
 
-void strbuf_commented_addf(struct strbuf *sb, char comment_prefix,
+void strbuf_commented_addf(struct strbuf *sb, const char *comment_prefix,
 			   const char *fmt, ...)
 {
 	va_list params;
@@ -379,7 +379,13 @@ void strbuf_commented_addf(struct strbuf *sb, char comment_prefix,
 	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
 
-	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_prefix);
+	/*
+	 * TODO Our commented_lines helper does not yet understand
+	 * comment strings. But since we know that the strings are
+	 * always single-char, we can cheat for the moment, and
+	 * fix this later.
+	 */
+	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_prefix[0]);
 	if (incomplete_line)
 		sb->buf[--sb->len] = '\0';
 
diff --git a/strbuf.h b/strbuf.h
index dc4710adbb..b128ca539a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -379,7 +379,7 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
  * blank to the buffer.
  */
 __attribute__((format (printf, 3, 4)))
-void strbuf_commented_addf(struct strbuf *sb, char comment_prefix, const char *fmt, ...);
+void strbuf_commented_addf(struct strbuf *sb, const char *comment_prefix, const char *fmt, ...);
 
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
diff --git a/wt-status.c b/wt-status.c
index 7108a92b52..3845e1d383 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1103,7 +1103,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
-	strbuf_commented_addf(buf, comment_line_char, "%s", cut_line);
+	strbuf_commented_addf(buf, comment_line_str, "%s", cut_line);
 	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
 }
 
-- 
2.44.0.481.gf1a6d20963

