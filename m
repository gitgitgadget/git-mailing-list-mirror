Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9021C1ADC
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174392; cv=none; b=tHo8jgWRJCg5bQAk5ZJfk/ePe3t7jRlZLnpFJjL2C7qHDQpt32gs/9bVT8WvWoXWoMW7Qy1y8R4Pz6etPykEaLMXzE70DnxWJNAQzZvV2QSuL6jwYwFM5UQ+Cd/7EjiIq5Omxw2QFb0KRsulXqglLHlPok8FUYc/DnDh760e/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174392; c=relaxed/simple;
	bh=5aOYPXI5bL1y+HzM9zUTyVudf1M7F/nTN2HQQsa/O8s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBRxRmgoSQsT3qjK5r4wULU6EqOAUkBHc/lgigOkL9UPOs6RS2SL573Iue6xsnM4Ut3QsAuttdnLxWNQSWrPToJs3JKNLv2B2HiIlNjbODJp5OW1SXpdiW0dY9WJU8vFKtBfWQxEqqCle+dD1t7xvGopkKoojXt7Fey+h8QzTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uYq8r1Fq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uYq8r1Fq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACF6630743;
	Thu, 12 Sep 2024 16:53:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=5aOYPXI5bL1y+HzM9zUTyVudf
	1M7F/nTN2HQQsa/O8s=; b=uYq8r1Fqzmadb18CmQ5vGC1qpY8aP9cEQPOOozXIV
	Ln0yRaKQw5GF0nQcJaRTP29XdKmBn4TBe2wSPdlIM20/JN70X12toRe9J+bWYSG6
	AyGvKbXYz1CUSRlPRZkFrISiSa/uISOGdRC1IIJFx6wETCjqk7MTRLxmKuTyHbR1
	2I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A137930742;
	Thu, 12 Sep 2024 16:53:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E71A530741;
	Thu, 12 Sep 2024 16:53:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] strbuf: retire strbuf_commented_lines()
Date: Thu, 12 Sep 2024 13:53:01 -0700
Message-ID: <20240912205301.1809355-3-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-738-g205d0d5e39
In-Reply-To: <20240912205301.1809355-1-gitster@pobox.com>
References: <20240912205301.1809355-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 044037E2-7149-11EF-AB21-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

The API allows the caller to pass any string as the comment prefix,
but in reality, everybody passes the comment_line_str from the
environment.

Replace this overly flexible API with strbuf_comment_lines() that
does not allow customization of the comment_line_str (usually '#'
but can be configured via the core.commentChar).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c      | 10 +++++-----
 builtin/stripspace.c |  2 +-
 fmt-merge-msg.c      | 17 +++++++----------
 rebase-interactive.c |  6 +++---
 sequencer.c          | 12 +++++-------
 strbuf.c             |  7 +++----
 strbuf.h             |  7 ++-----
 wt-status.c          |  4 ++--
 8 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 4cc5bfedc3..8c4d7f6f89 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -178,7 +178,7 @@ static void write_commented_object(int fd, const stru=
ct object_id *object)
=20
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
-	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str);
+	strbuf_add_comment_lines(&cbuf, buf.buf, buf.len);
 	write_or_die(fd, cbuf.buf, cbuf.len);
=20
 	strbuf_release(&cbuf);
@@ -206,10 +206,10 @@ static void prepare_note_data(const struct object_i=
d *object, struct note_data *
 			copy_obj_to_fd(fd, old_note);
=20
 		strbuf_addch(&buf, '\n');
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_str)=
;
-		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_templ=
ate)),
-					   comment_line_str);
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_str)=
;
+		strbuf_add_comment_lines(&buf, "\n", strlen("\n"));
+		strbuf_add_comment_lines(&buf, _(note_template),
+					 strlen(_(note_template)));
+		strbuf_add_comment_lines(&buf, "\n", strlen("\n"));
 		write_or_die(fd, buf.buf, buf.len);
=20
 		write_commented_object(fd, object);
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index e5626e5126..7be99a2ec0 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -13,7 +13,7 @@ static void comment_lines(struct strbuf *buf)
 	size_t len;
=20
 	msg =3D strbuf_detach(buf, &len);
-	strbuf_add_commented_lines(buf, msg, len, comment_line_str);
+	strbuf_add_comment_lines(buf, msg, len);
 	free(msg);
 }
=20
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 6acb37b480..19d7dd10a0 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -511,8 +511,7 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 	strbuf_complete_line(tagbuf);
 	if (sig->len) {
 		strbuf_addch(tagbuf, '\n');
-		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len,
-					   comment_line_str);
+		strbuf_add_comment_lines(tagbuf, sig->buf, sig->len);
 	}
 }
=20
@@ -556,19 +555,17 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			if (tag_number =3D=3D 2) {
 				struct strbuf tagline =3D STRBUF_INIT;
 				strbuf_addch(&tagline, '\n');
-				strbuf_add_commented_lines(&tagline,
-						origins.items[first_tag].string,
-						strlen(origins.items[first_tag].string),
-						comment_line_str);
+				strbuf_add_comment_lines(&tagline,
+							 origins.items[first_tag].string,
+							 strlen(origins.items[first_tag].string));
 				strbuf_insert(&tagbuf, 0, tagline.buf,
 					      tagline.len);
 				strbuf_release(&tagline);
 			}
 			strbuf_addch(&tagbuf, '\n');
-			strbuf_add_commented_lines(&tagbuf,
-					origins.items[i].string,
-					strlen(origins.items[i].string),
-					comment_line_str);
+			strbuf_add_comment_lines(&tagbuf,
+						 origins.items[i].string,
+						 strlen(origins.items[i].string));
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
 		strbuf_release(&payload);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index dd2ec363d8..1670c51fef 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -80,7 +80,7 @@ void append_todo_help(int command_count,
 				      shortrevisions, shortonto, command_count);
 	}
=20
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_str);
+	strbuf_add_comment_lines(buf, msg, strlen(msg));
=20
 	if (get_missing_commit_check_level() =3D=3D MISSING_COMMIT_CHECK_ERROR)
 		msg =3D _("\nDo not remove any line. Use 'drop' "
@@ -89,7 +89,7 @@ void append_todo_help(int command_count,
 		msg =3D _("\nIf you remove a line here "
 			 "THAT COMMIT WILL BE LOST.\n");
=20
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_str);
+	strbuf_add_comment_lines(buf, msg, strlen(msg));
=20
 	if (edit_todo)
 		msg =3D _("\nYou are editing the todo file "
@@ -100,7 +100,7 @@ void append_todo_help(int command_count,
 		msg =3D _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
=20
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_str);
+	strbuf_add_comment_lines(buf, msg, strlen(msg));
 }
=20
 int edit_todo_list(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.c b/sequencer.c
index bf844ce98e..77872d02f4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1911,7 +1911,7 @@ static int is_fixup_flag(enum todo_command command,=
 unsigned flag)
 }
=20
 /*
- * Wrapper around strbuf_add_commented_lines() which avoids double
+ * Wrapper around strbuf_add_comment_lines() which avoids double
  * commenting commit subjects.
  */
 static void add_commented_lines(struct strbuf *buf, const void *str, siz=
e_t len)
@@ -1928,7 +1928,7 @@ static void add_commented_lines(struct strbuf *buf,=
 const void *str, size_t len)
 		s +=3D count;
 		len -=3D count;
 	}
-	strbuf_add_commented_lines(buf, s, len, comment_line_str);
+	strbuf_add_comment_lines(buf, s, len);
 }
=20
 /* Does the current fixup chain contain a squash command? */
@@ -2028,7 +2028,7 @@ static int append_squash_message(struct strbuf *buf=
, const char *body,
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++ctx->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
-	strbuf_add_commented_lines(buf, body, commented_len, comment_line_str);
+	strbuf_add_comment_lines(buf, body, commented_len);
 	/* buf->buf may be reallocated so store an offset into the buffer */
 	fixup_off =3D buf->len;
 	strbuf_addstr(buf, body + commented_len);
@@ -2119,8 +2119,7 @@ static int update_squash_messages(struct repository=
 *r,
 			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		if (is_fixup_flag(command, flag))
-			strbuf_add_commented_lines(&buf, body, strlen(body),
-						   comment_line_str);
+			strbuf_add_comment_lines(&buf, body, strlen(body));
 		else
 			strbuf_addstr(&buf, body);
=20
@@ -2139,8 +2138,7 @@ static int update_squash_messages(struct repository=
 *r,
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++ctx->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
-		strbuf_add_commented_lines(&buf, body, strlen(body),
-					   comment_line_str);
+		strbuf_add_comment_lines(&buf, body, strlen(body));
 	} else
 		return error(_("unknown command: %d"), command);
 	repo_unuse_commit_buffer(r, commit, message);
diff --git a/strbuf.c b/strbuf.c
index 6c525da7a6..3dfd25d94d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -379,10 +379,9 @@ static void add_lines(struct strbuf *out,
 	strbuf_complete_line(out);
 }
=20
-void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
-				size_t size, const char *comment_prefix)
+void strbuf_add_comment_lines(struct strbuf *out, const char *buf, size_=
t size)
 {
-	add_lines(out, comment_prefix, buf, size, 1);
+	add_lines(out, comment_line_str, buf, size, 1);
 }
=20
 void strbuf_comment_addf(struct strbuf *sb, const char *fmt, ...)
@@ -395,7 +394,7 @@ void strbuf_comment_addf(struct strbuf *sb, const cha=
r *fmt, ...)
 	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
=20
-	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_str);
+	strbuf_add_comment_lines(sb, buf.buf, buf.len);
 	if (incomplete_line)
 		sb->buf[--sb->len] =3D '\0';
=20
diff --git a/strbuf.h b/strbuf.h
index aebc8020ae..fcb38c3905 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -284,12 +284,9 @@ void strbuf_splice(struct strbuf *sb, size_t pos, si=
ze_t len,
=20
 /**
  * Add a NUL-terminated string to the buffer. Each line will be prepende=
d
- * by a comment character and a blank.
+ * by the comment character and a blank.
  */
-void strbuf_add_commented_lines(struct strbuf *out,
-				const char *buf, size_t size,
-				const char *comment_prefix);
-
+void strbuf_add_comment_lines(struct strbuf *out, const char *buf, size_=
t size);
=20
 /**
  * Add data of given length to the buffer.
diff --git a/wt-status.c b/wt-status.c
index 44d29b721f..b94ee1f727 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1033,7 +1033,7 @@ static void wt_longstatus_print_submodule_summary(s=
truct wt_status *s, int uncom
 	if (s->display_comment_prefix) {
 		size_t len;
 		summary_content =3D strbuf_detach(&summary, &len);
-		strbuf_add_commented_lines(&summary, summary_content, len, comment_lin=
e_str);
+		strbuf_add_comment_lines(&summary, summary_content, len);
 		free(summary_content);
 	}
=20
@@ -1112,7 +1112,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 	const char *explanation =3D _("Do not modify or remove the line above.\=
nEverything below it will be ignored.");
=20
 	strbuf_comment_addf(buf,  "%s", cut_line);
-	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comme=
nt_line_str);
+	strbuf_add_comment_lines(buf, explanation, strlen(explanation));
 }
=20
 void wt_status_add_cut_line(struct wt_status *s)
--=20
2.46.0-717-g3841ff3f09

