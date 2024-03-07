Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE482D7C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803395; cv=none; b=g5n02dNmyOZgaRIhh3Th/ov/WTVeQ4o6DvMbG3iG95bPPodx0Sc9WK0ZF6HQlsAKsp+AA03ohqeSX9eXS9d66uQs5DcOZElnbr1eNP7fiua+XUwejxs5iSZc0DtJTmPSvHKKyQAlAut3iv12B4HtvZhkxDsBpi6CseTQIMiLka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803395; c=relaxed/simple;
	bh=8bVLZk8lmn2ZVTwFtX+ylsp+7f2Vy4mssttsK5o05IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEYGubchhOQNiVxq7fapcqy/FB+5+zF2Bg1ExFTnlraoJWBU3oqE/Q8HTFq2HuOZD+puvcPzTB/8sXZcBPqG9MMRyeh21F441w/TqwUb46bC2DqJt3yuw3v7gv1Otepj9T9HRL382cith+qaKyWQpFzKOuUY/jKGe9jLjMqtiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6956 invoked by uid 109); 7 Mar 2024 09:23:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:23:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12636 invoked by uid 111); 7 Mar 2024 09:23:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:23:17 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:23:12 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 08/15] strbuf: accept a comment string for
 strbuf_add_commented_lines()
Message-ID: <20240307092312.GH2080210@coredump.intra.peff.net>
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
NUL-terminated string pointer for strbuf_add_commented_lines() rather
than a single character.

All of the callers have to be adjusted; most can just pass
comment_line_str rather than comment_line_char.

And now our "cheat" in strbuf_commented_addf() can go away, as we can
take the full string from it.

Signed-off-by: Jeff King <peff@peff.net>
---
This could also be squashed into the previous patch. I wasn't sure if it
would be more overwhelming to have so many changes intermingled, or if
the "cheat" / "uncheat" back-and-forth would be too confusing. Pick your
poison.

 builtin/notes.c      |  8 ++++----
 builtin/stripspace.c |  2 +-
 fmt-merge-msg.c      |  6 +++---
 rebase-interactive.c |  6 +++---
 sequencer.c          |  8 ++++----
 strbuf.c             | 16 +++-------------
 strbuf.h             |  2 +-
 wt-status.c          |  4 ++--
 8 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 5223a3f350..1a67f01d00 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -179,7 +179,7 @@ static void write_commented_object(int fd, const struct object_id *object)
 
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
-	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_char);
+	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str);
 	write_or_die(fd, cbuf.buf, cbuf.len);
 
 	strbuf_release(&cbuf);
@@ -207,10 +207,10 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 			copy_obj_to_fd(fd, old_note);
 
 		strbuf_addch(&buf, '\n');
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_str);
 		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)),
-					   comment_line_char);
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
+					   comment_line_str);
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_str);
 		write_or_die(fd, buf.buf, buf.len);
 
 		write_commented_object(fd, object);
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 434ac490cb..e5626e5126 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -13,7 +13,7 @@ static void comment_lines(struct strbuf *buf)
 	size_t len;
 
 	msg = strbuf_detach(buf, &len);
-	strbuf_add_commented_lines(buf, msg, len, comment_line_char);
+	strbuf_add_commented_lines(buf, msg, len, comment_line_str);
 	free(msg);
 }
 
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 66e47449a0..79e8aad086 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -510,7 +510,7 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 	if (sig->len) {
 		strbuf_addch(tagbuf, '\n');
 		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len,
-					   comment_line_char);
+					   comment_line_str);
 	}
 }
 
@@ -557,7 +557,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 				strbuf_add_commented_lines(&tagline,
 						origins.items[first_tag].string,
 						strlen(origins.items[first_tag].string),
-						comment_line_char);
+						comment_line_str);
 				strbuf_insert(&tagbuf, 0, tagline.buf,
 					      tagline.len);
 				strbuf_release(&tagline);
@@ -566,7 +566,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			strbuf_add_commented_lines(&tagbuf,
 					origins.items[i].string,
 					strlen(origins.items[i].string),
-					comment_line_char);
+					comment_line_str);
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
 		strbuf_release(&payload);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index affc93a8e4..c343e16fcd 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -78,7 +78,7 @@ void append_todo_help(int command_count,
 				      shortrevisions, shortonto, command_count);
 	}
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_str);
 
 	if (get_missing_commit_check_level() == MISSING_COMMIT_CHECK_ERROR)
 		msg = _("\nDo not remove any line. Use 'drop' "
@@ -87,7 +87,7 @@ void append_todo_help(int command_count,
 		msg = _("\nIf you remove a line here "
 			 "THAT COMMIT WILL BE LOST.\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_str);
 
 	if (edit_todo)
 		msg = _("\nYou are editing the todo file "
@@ -98,7 +98,7 @@ void append_todo_help(int command_count,
 		msg = _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_str);
 }
 
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
diff --git a/sequencer.c b/sequencer.c
index 852c3f9f4e..032e213a3f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1851,7 +1851,7 @@ static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
 		s += count;
 		len -= count;
 	}
-	strbuf_add_commented_lines(buf, s, len, comment_line_char);
+	strbuf_add_commented_lines(buf, s, len, comment_line_str);
 }
 
 /* Does the current fixup chain contain a squash command? */
@@ -1950,7 +1950,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
-	strbuf_add_commented_lines(buf, body, commented_len, comment_line_char);
+	strbuf_add_commented_lines(buf, body, commented_len, comment_line_str);
 	/* buf->buf may be reallocated so store an offset into the buffer */
 	fixup_off = buf->len;
 	strbuf_addstr(buf, body + commented_len);
@@ -2041,7 +2041,7 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addstr(&buf, "\n\n");
 		if (is_fixup_flag(command, flag))
 			strbuf_add_commented_lines(&buf, body, strlen(body),
-						   comment_line_char);
+						   comment_line_str);
 		else
 			strbuf_addstr(&buf, body);
 
@@ -2061,7 +2061,7 @@ static int update_squash_messages(struct repository *r,
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body),
-					   comment_line_char);
+					   comment_line_str);
 	} else
 		return error(_("unknown command: %d"), command);
 	repo_unuse_commit_buffer(r, commit, message);
diff --git a/strbuf.c b/strbuf.c
index 76d02e0920..7c8f582127 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -359,13 +359,9 @@ static void add_lines(struct strbuf *out,
 }
 
 void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
-				size_t size, char comment_prefix)
+				size_t size, const char *comment_prefix)
 {
-	char prefix[2];
-
-	prefix[0] = comment_prefix;
-	prefix[1] = '\0';
-	add_lines(out, prefix, buf, size, 1);
+	add_lines(out, comment_prefix, buf, size, 1);
 }
 
 void strbuf_commented_addf(struct strbuf *sb, const char *comment_prefix,
@@ -379,13 +375,7 @@ void strbuf_commented_addf(struct strbuf *sb, const char *comment_prefix,
 	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
 
-	/*
-	 * TODO Our commented_lines helper does not yet understand
-	 * comment strings. But since we know that the strings are
-	 * always single-char, we can cheat for the moment, and
-	 * fix this later.
-	 */
-	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_prefix[0]);
+	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_prefix);
 	if (incomplete_line)
 		sb->buf[--sb->len] = '\0';
 
diff --git a/strbuf.h b/strbuf.h
index b128ca539a..58dddf2777 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -288,7 +288,7 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
  */
 void strbuf_add_commented_lines(struct strbuf *out,
 				const char *buf, size_t size,
-				char comment_prefix);
+				const char *comment_prefix);
 
 
 /**
diff --git a/wt-status.c b/wt-status.c
index 2be2eb094c..6b81f5349c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1028,7 +1028,7 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	if (s->display_comment_prefix) {
 		size_t len;
 		summary_content = strbuf_detach(&summary, &len);
-		strbuf_add_commented_lines(&summary, summary_content, len, comment_line_char);
+		strbuf_add_commented_lines(&summary, summary_content, len, comment_line_str);
 		free(summary_content);
 	}
 
@@ -1104,7 +1104,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
 	strbuf_commented_addf(buf, comment_line_str, "%s", cut_line);
-	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
+	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_str);
 }
 
 void wt_status_add_cut_line(FILE *fp)
-- 
2.44.0.463.g71abcb3a9f

