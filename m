Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6FE7A14C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803410; cv=none; b=qS2uJfE24Qb+QKpwStvob3RGzc6c8/vNEOGVmi3aLwhknK+LhrH2bOd98RiFkNE4lln1hKHUNV7gmMYF11EIByBtWOt/9Ne9ToTu5AJPXZninQyc0Y12Kh6+3OP37BGPFV8cWiBfvZVAMIuSdXFY3T1Ud2tH5kfNPQX7KucxPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803410; c=relaxed/simple;
	bh=7K1sSiwpT4U0ZFyiKyXkKaj14z+Z52BPTCBLiHz7WEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpBmSGqY30+j4dqwNnDA97YZ1tISRHvAjSufIA284Rvq6mlEBfat+hEEtQB79klSdKzZ0pQjdeQQzBUEMmPxSoS57p4L8V089D5y21xyyA3q2XeX3f+24TPsrFJqtJylE610NO/Z9JnNR4AgVlA2n4Uo8Nyi2S0WdgEjiscpj74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6971 invoked by uid 109); 7 Mar 2024 09:23:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:23:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12643 invoked by uid 111); 7 Mar 2024 09:23:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:23:31 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:23:26 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 09/15] prefer comment_line_str to comment_line_char for
 printing
Message-ID: <20240307092326.GI2080210@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307091407.GA2072522@coredump.intra.peff.net>

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
index 8904a1e5d9..1cdcae8454 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -670,8 +670,8 @@ static int edit_branch_description(const char *branch_name)
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
index d8abbe48b1..8519a004d0 100644
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
@@ -945,12 +945,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 		fprintf(s->fp, "\n");
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL)
-			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_all, comment_line_char);
+			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_all, comment_line_str);
 		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			if (whence == FROM_COMMIT && !merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
-			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_space, comment_line_char);
+			status_printf(s, GIT_COLOR_NORMAL, hint_cleanup_space, comment_line_str);
 
 		/*
 		 * These should never fail because they come from our own
diff --git a/builtin/merge.c b/builtin/merge.c
index 6d048fb628..ba4308883f 100644
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
index 032e213a3f..241e185f87 100644
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
@@ -1946,7 +1946,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	     (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
 		commented_len = commit_subject_length(body);
 
-	strbuf_addf(buf, "\n%c ", comment_line_char);
+	strbuf_addf(buf, "\n%s ", comment_line_str);
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
@@ -2006,7 +2006,7 @@ static int update_squash_messages(struct repository *r,
 		eol = buf.buf[0] != comment_line_char ?
 			buf.buf : strchrnul(buf.buf, '\n');
 
-		strbuf_addf(&header, "%c ", comment_line_char);
+		strbuf_addf(&header, "%s ", comment_line_str);
 		strbuf_addf(&header, _(combined_commit_msg_fmt),
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
@@ -2032,9 +2032,9 @@ static int update_squash_messages(struct repository *r,
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
@@ -2056,7 +2056,7 @@ static int update_squash_messages(struct repository *r,
 	if (command == TODO_SQUASH || is_fixup_flag(command, flag)) {
 		res = append_squash_message(&buf, body, command, opts, flag);
 	} else if (command == TODO_FIXUP) {
-		strbuf_addf(&buf, "\n%c ", comment_line_char);
+		strbuf_addf(&buf, "\n%s ", comment_line_str);
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
@@ -5659,8 +5659,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				    oid_to_hex(&commit->object.oid),
 				    oneline.buf);
 			if (is_empty)
-				strbuf_addf(&buf, " %c empty",
-					    comment_line_char);
+				strbuf_addf(&buf, " %s empty",
+					    comment_line_str);
 
 			FLEX_ALLOC_STR(entry, string, buf.buf);
 			oidcpy(&entry->entry.oid, &commit->object.oid);
@@ -5750,7 +5750,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
+			strbuf_addf(out, "\n%s Branch %s\n", comment_line_str, entry->string);
 		else
 			strbuf_addch(out, '\n');
 
@@ -5887,7 +5887,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, out);
 		if (is_empty)
-			strbuf_addf(out, " %c empty", comment_line_char);
+			strbuf_addf(out, " %s empty", comment_line_str);
 		strbuf_addch(out, '\n');
 	}
 	if (skipped_commit)
diff --git a/wt-status.c b/wt-status.c
index 6b81f5349c..b66c30775b 100644
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
@@ -1214,8 +1214,8 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
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
2.44.0.463.g71abcb3a9f

