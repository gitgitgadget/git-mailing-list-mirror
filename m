Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F583CA6
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803289; cv=none; b=p1wY40+JsPw8z09/onhkRAAMStbBtFqZBq8voIYHMvlbPAj/pmPc0LEF9FZx5a93S8uhkkelgwc8N06y/9fzOkeBQkVMSzBHHRf2edOHkhILJP81/RHeo6qixCVAc+QHpxP9wU41ExknE3jgXre3MM2nRMES+Nzcu7XdGqqKQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803289; c=relaxed/simple;
	bh=Miqnq3yFK7cDbiF+dkXslX4a6cSUIZ9DjQqv6so46Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEaHZ4JcclWb3Ev+i24LLacFR2PcO5yDrZGmqREDXGddJOAXavEHXn78KLLVCPATpYcnRfwOAvWLoCaTlDI+LQaTlWnIzSpxnu4SrDJZG2a32eDik5djUN9bIXU8N95ouJLsWC1LQ4KADvqomI8QAMkFMl8dXKoFusuOqJZQq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6920 invoked by uid 109); 7 Mar 2024 09:21:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:21:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12621 invoked by uid 111); 7 Mar 2024 09:21:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:21:31 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:21:26 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 06/15] strbuf: accept a comment string for strbuf_stripspace()
Message-ID: <20240307092126.GF2080210@coredump.intra.peff.net>
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

As part of our transition to multi-byte comment characters, let's take a
NUL-terminated string pointer for strbuf_stripspace(), rather than a
single character. We can continue to support its feature of ignoring
comments by accepting a NULL pointer (as opposed to the current behavior
of a NUL byte).

All of the callers have to be adjusted, but they can all just pass
comment_line_str (or NULL).

Inside the function we detect comments by comparing the first byte of a
line to the comment character. We'll adjust that to use starts_with(),
which will match multiple bytes (though for now, of course, we still
only allow a single byte, so it's academic).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c     | 2 +-
 builtin/notes.c      | 2 +-
 builtin/rebase.c     | 2 +-
 builtin/stripspace.c | 2 +-
 builtin/tag.c        | 2 +-
 rebase-interactive.c | 2 +-
 sequencer.c          | 6 +++---
 strbuf.c             | 6 +++---
 strbuf.h             | 4 ++--
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index cfb63cce5f..c03c0407d1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -678,7 +678,7 @@ static int edit_branch_description(const char *branch_name)
 		strbuf_release(&buf);
 		return -1;
 	}
-	strbuf_stripspace(&buf, comment_line_char);
+	strbuf_stripspace(&buf, comment_line_str);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 	if (buf.len || exists)
diff --git a/builtin/notes.c b/builtin/notes.c
index caf20fd5bd..5223a3f350 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -223,7 +223,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 			die(_("please supply the note contents using either -m or -F option"));
 		}
 		if (d->stripspace)
-			strbuf_stripspace(&d->buf, comment_line_char);
+			strbuf_stripspace(&d->buf, comment_line_str);
 	}
 }
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6ead9465a4..bf78402129 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -204,7 +204,7 @@ static int edit_todo_file(unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	strbuf_stripspace(&todo_list.buf, comment_line_char);
+	strbuf_stripspace(&todo_list.buf, comment_line_str);
 	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
 	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
 					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 7b700a9fb1..434ac490cb 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -59,7 +59,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 
 	if (mode == STRIP_DEFAULT || mode == STRIP_COMMENTS)
 		strbuf_stripspace(&buf,
-			  mode == STRIP_COMMENTS ? comment_line_char : '\0');
+			  mode == STRIP_COMMENTS ? comment_line_str : NULL);
 	else
 		comment_lines(&buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 19a7e06bf4..07327d3c04 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -310,7 +310,7 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 
 	if (opt->cleanup_mode != CLEANUP_NONE)
 		strbuf_stripspace(buf,
-		  opt->cleanup_mode == CLEANUP_ALL ? comment_line_char : '\0');
+		  opt->cleanup_mode == CLEANUP_ALL ? comment_line_str : NULL);
 
 	if (!opt->message_given && !buf->len)
 		die(_("no tag message?"));
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d9718409b3..6dfc33e4e3 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -130,7 +130,7 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
 		return -2;
 
-	strbuf_stripspace(&new_todo->buf, comment_line_char);
+	strbuf_stripspace(&new_todo->buf, comment_line_str);
 	if (initial && new_todo->buf.len == 0)
 		return -3;
 
diff --git a/sequencer.c b/sequencer.c
index f49a871ac0..6a1b7b200e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1152,7 +1152,7 @@ void cleanup_message(struct strbuf *msgbuf,
 		strbuf_setlen(msgbuf, wt_status_locate_end(msgbuf->buf, msgbuf->len));
 	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
 		strbuf_stripspace(msgbuf,
-		  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
+		  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_str : NULL);
 }
 
 /*
@@ -1184,7 +1184,7 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 		return 0;
 
 	strbuf_stripspace(&tmpl,
-	  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
+	  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_str : NULL);
 	if (!skip_prefix(sb->buf, tmpl.buf, &start))
 		start = sb->buf;
 	strbuf_release(&tmpl);
@@ -1557,7 +1557,7 @@ static int try_to_commit(struct repository *r,
 
 	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
 		strbuf_stripspace(msg,
-		  cleanup == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
+		  cleanup == COMMIT_MSG_CLEANUP_ALL ? comment_line_str : NULL);
 	if ((flags & EDIT_MSG) && message_is_empty(msg, cleanup)) {
 		res = 1; /* run 'git commit' to display error message */
 		goto out;
diff --git a/strbuf.c b/strbuf.c
index a33aed6c07..e9b6127e76 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1001,10 +1001,10 @@ static size_t cleanup(char *line, size_t len)
  *
  * If last line does not have a newline at the end, one is added.
  *
- * Pass a non-NUL comment_prefix to skip every line starting
+ * Pass a non-NULL comment_prefix to skip every line starting
  * with it.
  */
-void strbuf_stripspace(struct strbuf *sb, char comment_prefix)
+void strbuf_stripspace(struct strbuf *sb, const char *comment_prefix)
 {
 	size_t empties = 0;
 	size_t i, j, len, newlen;
@@ -1018,7 +1018,7 @@ void strbuf_stripspace(struct strbuf *sb, char comment_prefix)
 		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
 
 		if (comment_prefix && len &&
-		    sb->buf[i] == comment_prefix) {
+		    starts_with(sb->buf + i, comment_prefix)) {
 			newlen = 0;
 			continue;
 		}
diff --git a/strbuf.h b/strbuf.h
index 860fcec5fb..dc4710adbb 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -513,11 +513,11 @@ int strbuf_getcwd(struct strbuf *sb);
 int strbuf_normalize_path(struct strbuf *sb);
 
 /**
- * Strip whitespace from a buffer. If comment_prefix is non-NUL,
+ * Strip whitespace from a buffer. If comment_prefix is non-NULL,
  * then lines beginning with that character are considered comments,
  * thus removed.
  */
-void strbuf_stripspace(struct strbuf *buf, char comment_prefix);
+void strbuf_stripspace(struct strbuf *buf, const char *comment_prefix);
 
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
-- 
2.44.0.463.g71abcb3a9f

