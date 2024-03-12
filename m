Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29A7A72C
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235058; cv=none; b=l2QwoTfs+a9gByW6elG37CFa6XUggFffwyqrh8b/ufYdtYMc1Ww+xywTz9ezZQHK/zSCUj4RMaeAhByv0Ql3CEE0uzqyMLyaPD/v8VJlGHkve1cR/agVwDTKQ5eJULJNJFKTkAY6faXSc6+sx5Wr3Ih1ZoxR9sVLYBhlZ+27lUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235058; c=relaxed/simple;
	bh=O+BHieVyAXs5r0C0/pxSXWQLUqvOKBXsOr/243eGkwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObaybjKIDjnKpJOCI94TGkgdIXKBvVLuc046ht3qhoGACDFbBSeJ6sYtzQwCVhNBNRGTI0QaB1L7ttxM9Ydu4NmSSciyz8xnvCs3ZwLlGGTSVVqsTvT9crtMP9A07TRIkhgqLkRebVg7+OfNro2riPPYtchVVxlF4ARbEfhnES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17620 invoked by uid 109); 12 Mar 2024 09:17:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28081 invoked by uid 111); 12 Mar 2024 09:17:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:40 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:34 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 10/16] prefer comment_line_str to comment_line_char for
 printing
Message-ID: <20240312091734.GJ95609@coredump.intra.peff.net>
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

As part of our transition to multi-byte comment characters, we should
use the string variable rather than the historical character variable.
All of the sites adjusted here are just swapping out "%c" for "%s" in
format strings, or strbuf_addch() for strbuf_addstr(). The type system
and printf-attribute give the compiler enough information to make sure
our formats and variable changes all match (especially important for
cases where the format string is defined far away from its use, like
prepare_to_commit() in commit.c).

Signed-off-by: Jeff King <peff@peff.net>
---
 add-patch.c      |  4 ++--
 builtin/branch.c |  4 ++--
 builtin/commit.c | 12 ++++++------
 builtin/merge.c  |  4 ++--
 builtin/tag.c    |  8 ++++----
 fmt-merge-msg.c  |  2 +-
 sequencer.c      | 20 ++++++++++----------
 wt-status.c      | 10 +++++-----
 8 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 7390677795..4a10237d50 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1114,10 +1114,10 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 				"To remove '%c' lines, make them ' ' lines "
 				"(context).\n"
 				"To remove '%c' lines, delete them.\n"
-				"Lines starting with %c will be removed.\n"),
+				"Lines starting with %s will be removed.\n"),
 			      s->mode->is_reverse ? '+' : '-',
 			      s->mode->is_reverse ? '-' : '+',
-			      comment_line_char);
+			      comment_line_str);
 	strbuf_commented_addf(&s->buf, comment_line_str, "%s",
 			      _(s->mode->edit_hunk_hint));
 	/*
diff --git a/builtin/branch.c b/builtin/branch.c
index 2d8c89e9ac..faf6ea1b7b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -676,8 +676,8 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_commented_addf(&buf, comment_line_str,
 		    _("Please edit the description for the branch\n"
 		      "  %s\n"
-		      "Lines starting with '%c' will be stripped.\n"),
-		    branch_name, comment_line_char);
+		      "Lines starting with '%s' will be stripped.\n"),
+		    branch_name, comment_line_str);
 	write_file_buf(edit_description(), buf.buf, buf.len);
 	strbuf_reset(&buf);
 	if (launch_editor(edit_description(), &buf, NULL)) {
diff --git a/builtin/commit.c b/builtin/commit.c
index 9b139fc795..066dc42a3d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -910,18 +910,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 		const char *hint_cleanup_all = allow_empty_message ?
 			_("Please enter the commit message for your changes."
-			  " Lines starting\nwith '%c' will be ignored.\n") :
+			  " Lines starting\nwith '%s' will be ignored.\n") :
 			_("Please enter the commit message for your changes."
-			  " Lines starting\nwith '%c' will be ignored, and an empty"
+			  " Lines starting\nwith '%s' will be ignored, and an empty"
 			  " message aborts the commit.\n");
 		const char *hint_cleanup_space = allow_empty_message ?
 			_("Please enter the commit message for your changes."
 			  " Lines starting\n"
-			  "with '%c' will be kept; you may remove them"
+			  "with '%s' will be kept; you may remove them"
 			  " yourself if you want to.\n") :
 			_("Please enter the commit message for your changes."
 			  " Lines starting\n"
-			  "with '%c' will be kept; you may remove them"
+			  "with '%s' will be kept; you may remove them"
 			  " yourself if you want to.\n"
 			  "An empty message aborts the commit.\n");
 		if (whence != FROM_COMMIT) {
@@ -944,12 +944,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 		fprintf(s->fp, "\n");
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL)
-			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_all, comment_line_char);
+			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_all, comment_line_str);
 		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			if (whence == FROM_COMMIT)
 				wt_status_add_cut_line(s);
 		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
-			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_space, comment_line_char);
+			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_space, comment_line_str);
 
 		/*
 		 * These should never fail because they come from our own
diff --git a/builtin/merge.c b/builtin/merge.c
index 4e47434708..1e33aa49a0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -821,7 +821,7 @@ static const char scissors_editor_comment[] =
 N_("An empty message aborts the commit.\n");
 
 static const char no_scissors_editor_comment[] =
-N_("Lines starting with '%c' will be ignored, and an empty message aborts\n"
+N_("Lines starting with '%s' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
 static void write_merge_heads(struct commit_list *);
@@ -861,7 +861,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 					      _(scissors_editor_comment));
 		else
 			strbuf_commented_addf(&msg, comment_line_str,
-				_(no_scissors_editor_comment), comment_line_char);
+				_(no_scissors_editor_comment), comment_line_str);
 	}
 	if (signoff)
 		append_signoff(&msg, ignored_log_message_bytes(msg.buf, msg.len), 0);
diff --git a/builtin/tag.c b/builtin/tag.c
index 1c708785bf..721d07a589 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -158,11 +158,11 @@ static int do_sign(struct strbuf *buffer)
 
 static const char tag_template[] =
 	N_("\nWrite a message for tag:\n  %s\n"
-	"Lines starting with '%c' will be ignored.\n");
+	"Lines starting with '%s' will be ignored.\n");
 
 static const char tag_template_nocleanup[] =
 	N_("\nWrite a message for tag:\n  %s\n"
-	"Lines starting with '%c' will be kept; you may remove them"
+	"Lines starting with '%s' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
 static int git_tag_config(const char *var, const char *value,
@@ -292,10 +292,10 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 			strbuf_addch(&buf, '\n');
 			if (opt->cleanup_mode == CLEANUP_ALL)
 				strbuf_commented_addf(&buf, comment_line_str,
-				      _(tag_template), tag, comment_line_char);
+				      _(tag_template), tag, comment_line_str);
 			else
 				strbuf_commented_addf(&buf, comment_line_str,
-				      _(tag_template_nocleanup), tag, comment_line_char);
+				      _(tag_template_nocleanup), tag, comment_line_str);
 			write_or_die(fd, buf.buf, buf.len);
 			strbuf_release(&buf);
 		}
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 79e8aad086..ae201e21db 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -321,7 +321,7 @@ static void credit_people(struct strbuf *out,
 	     skip_prefix(me, them->items->string, &me) &&
 	     starts_with(me, " <")))
 		return;
-	strbuf_addf(out, "\n%c %s ", comment_line_char, label);
+	strbuf_addf(out, "\n%s %s ", comment_line_str, label);
 	add_people_count(out, them);
 }
 
diff --git a/sequencer.c b/sequencer.c
index d12c5a8a03..b75d0c098d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -663,7 +663,7 @@ void append_conflicts_hint(struct index_state *istate,
 	if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 		strbuf_addch(msgbuf, '\n');
 		wt_status_append_cut_line(msgbuf);
-		strbuf_addch(msgbuf, comment_line_char);
+		strbuf_addstr(msgbuf, comment_line_str);
 	}
 
 	strbuf_addch(msgbuf, '\n');
@@ -1948,7 +1948,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	     (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
 		commented_len = commit_subject_length(body);
 
-	strbuf_addf(buf, "\n%c ", comment_line_char);
+	strbuf_addf(buf, "\n%s ", comment_line_str);
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
@@ -2008,7 +2008,7 @@ static int update_squash_messages(struct repository *r,
 		eol = buf.buf[0] != comment_line_char ?
 			buf.buf : strchrnul(buf.buf, '\n');
 
-		strbuf_addf(&header, "%c ", comment_line_char);
+		strbuf_addf(&header, "%s ", comment_line_str);
 		strbuf_addf(&header, _(combined_commit_msg_fmt),
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
@@ -2034,9 +2034,9 @@ static int update_squash_messages(struct repository *r,
 			repo_unuse_commit_buffer(r, head_commit, head_message);
 			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
-		strbuf_addf(&buf, "%c ", comment_line_char);
+		strbuf_addf(&buf, "%s ", comment_line_str);
 		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
-		strbuf_addf(&buf, "\n%c ", comment_line_char);
+		strbuf_addf(&buf, "\n%s ", comment_line_str);
 		strbuf_addstr(&buf, is_fixup_flag(command, flag) ?
 			      _(skip_first_commit_msg_str) :
 			      _(first_commit_msg_str));
@@ -2058,7 +2058,7 @@ static int update_squash_messages(struct repository *r,
 	if (command == TODO_SQUASH || is_fixup_flag(command, flag)) {
 		res = append_squash_message(&buf, body, command, opts, flag);
 	} else if (command == TODO_FIXUP) {
-		strbuf_addf(&buf, "\n%c ", comment_line_char);
+		strbuf_addf(&buf, "\n%s ", comment_line_str);
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
@@ -5667,8 +5667,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				    oid_to_hex(&commit->object.oid),
 				    oneline.buf);
 			if (is_empty)
-				strbuf_addf(&buf, " %c empty",
-					    comment_line_char);
+				strbuf_addf(&buf, " %s empty",
+					    comment_line_str);
 
 			FLEX_ALLOC_STR(entry, string, buf.buf);
 			oidcpy(&entry->entry.oid, &commit->object.oid);
@@ -5758,7 +5758,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
+			strbuf_addf(out, "\n%s Branch %s\n", comment_line_str, entry->string);
 		else
 			strbuf_addch(out, '\n');
 
@@ -5895,7 +5895,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, out);
 		if (is_empty)
-			strbuf_addf(out, " %c empty", comment_line_char);
+			strbuf_addf(out, " %s empty", comment_line_str);
 		strbuf_addch(out, '\n');
 	}
 	if (skipped_commit)
diff --git a/wt-status.c b/wt-status.c
index ae623e760e..6201a97de0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -70,7 +70,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 	strbuf_vaddf(&sb, fmt, ap);
 	if (!sb.len) {
 		if (s->display_comment_prefix) {
-			strbuf_addch(&sb, comment_line_char);
+			strbuf_addstr(&sb, comment_line_str);
 			if (!trail)
 				strbuf_addch(&sb, ' ');
 		}
@@ -85,7 +85,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 
 		strbuf_reset(&linebuf);
 		if (at_bol && s->display_comment_prefix) {
-			strbuf_addch(&linebuf, comment_line_char);
+			strbuf_addstr(&linebuf, comment_line_str);
 			if (*line != '\n' && *line != '\t')
 				strbuf_addch(&linebuf, ' ');
 		}
@@ -1090,7 +1090,7 @@ size_t wt_status_locate_end(const char *s, size_t len)
 	const char *p;
 	struct strbuf pattern = STRBUF_INIT;
 
-	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
+	strbuf_addf(&pattern, "\n%s %s", comment_line_str, cut_line);
 	if (starts_with(s, pattern.buf + 1))
 		len = 0;
 	else if ((p = strstr(s, pattern.buf)))
@@ -1218,8 +1218,8 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 				 "%s%.*s", comment_line_string,
 				 (int)(ep - cp), cp);
 	if (s->display_comment_prefix)
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
-				 comment_line_char);
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%s",
+				 comment_line_str);
 	else
 		fputs("\n", s->fp);
 	strbuf_release(&sb);
-- 
2.44.0.481.gf1a6d20963

