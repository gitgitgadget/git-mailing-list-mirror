Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085B1C11
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DWucWofH"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD0BA7
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 22:10:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CA6982E950;
	Mon, 30 Oct 2023 01:10:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=TfELOjsyNDV9cY96o4RtuWvdY
	0ABLfGFZtnYFC3n7us=; b=DWucWofHo5mKPfsAoeg8Eq4vH3zUx3uYuiCrrc3vj
	4WI3JBpYV2mldybtd7Q1c8FKi6yGzIQyjl7sUfZt+/kWQSPEfHw3bfTYETGTx1Bq
	0aLZrlHy7MgXhbGG8X1ttFMm5oFa2DO9xmuwZu3wsu7Edg4UcFnPbyShMWe7L1pa
	uk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B36382E94F;
	Mon, 30 Oct 2023 01:10:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A98B2E94A;
	Mon, 30 Oct 2023 01:10:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] strbuf_add_commented_lines(): drop the comment_line_char parameter
Date: Mon, 30 Oct 2023 14:10:34 +0900
Message-ID: <20231030051034.2295242-3-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-526-g3130c155df
In-Reply-To: <20231030051034.2295242-1-gitster@pobox.com>
References: <20231030051034.2295242-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 AAD4C3E6-76E2-11EE-B0BA-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

All the callers of this function supply the global variable
comment_line_char as an argument to its last parameter.  Remove the
parameter to allow us in the future to change the reference to the
global variable with something else, like a function call.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c      |  9 ++++-----
 builtin/stripspace.c |  2 +-
 fmt-merge-msg.c      |  9 +++------
 rebase-interactive.c |  6 +++---
 sequencer.c          | 10 ++++------
 strbuf.c             |  6 +++---
 strbuf.h             |  3 +--
 wt-status.c          |  4 ++--
 8 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9f38863dd5..355ecce07a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -181,7 +181,7 @@ static void write_commented_object(int fd, const stru=
ct object_id *object)
=20
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
-	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_char);
+	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len);
 	write_or_die(fd, cbuf.buf, cbuf.len);
=20
 	strbuf_release(&cbuf);
@@ -209,10 +209,9 @@ static void prepare_note_data(const struct object_id=
 *object, struct note_data *
 			copy_obj_to_fd(fd, old_note);
=20
 		strbuf_addch(&buf, '\n');
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char=
);
-		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_templ=
ate)),
-					   comment_line_char);
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char=
);
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
+		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_templ=
ate)));
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
 		write_or_die(fd, buf.buf, buf.len);
=20
 		write_commented_object(fd, object);
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 7b700a9fb1..11e475760c 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -13,7 +13,7 @@ static void comment_lines(struct strbuf *buf)
 	size_t len;
=20
 	msg =3D strbuf_detach(buf, &len);
-	strbuf_add_commented_lines(buf, msg, len, comment_line_char);
+	strbuf_add_commented_lines(buf, msg, len);
 	free(msg);
 }
=20
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 66e47449a0..adc85d2a72 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -509,8 +509,7 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 	strbuf_complete_line(tagbuf);
 	if (sig->len) {
 		strbuf_addch(tagbuf, '\n');
-		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len,
-					   comment_line_char);
+		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len);
 	}
 }
=20
@@ -556,8 +555,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 				strbuf_addch(&tagline, '\n');
 				strbuf_add_commented_lines(&tagline,
 						origins.items[first_tag].string,
-						strlen(origins.items[first_tag].string),
-						comment_line_char);
+						strlen(origins.items[first_tag].string));
 				strbuf_insert(&tagbuf, 0, tagline.buf,
 					      tagline.len);
 				strbuf_release(&tagline);
@@ -565,8 +563,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			strbuf_addch(&tagbuf, '\n');
 			strbuf_add_commented_lines(&tagbuf,
 					origins.items[i].string,
-					strlen(origins.items[i].string),
-					comment_line_char);
+					strlen(origins.items[i].string));
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
 		strbuf_release(&payload);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 3f33da7f03..1138bd37ba 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -78,7 +78,7 @@ void append_todo_help(int command_count,
 				      shortrevisions, shortonto, command_count);
 	}
=20
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
=20
 	if (get_missing_commit_check_level() =3D=3D MISSING_COMMIT_CHECK_ERROR)
 		msg =3D _("\nDo not remove any line. Use 'drop' "
@@ -87,7 +87,7 @@ void append_todo_help(int command_count,
 		msg =3D _("\nIf you remove a line here "
 			 "THAT COMMIT WILL BE LOST.\n");
=20
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
=20
 	if (edit_todo)
 		msg =3D _("\nYou are editing the todo file "
@@ -98,7 +98,7 @@ void append_todo_help(int command_count,
 		msg =3D _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
=20
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 }
=20
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
diff --git a/sequencer.c b/sequencer.c
index 5d348a3f12..29c8b5e32b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1859,7 +1859,7 @@ static void add_commented_lines(struct strbuf *buf,=
 const void *str, size_t len)
 		s +=3D count;
 		len -=3D count;
 	}
-	strbuf_add_commented_lines(buf, s, len, comment_line_char);
+	strbuf_add_commented_lines(buf, s, len);
 }
=20
 /* Does the current fixup chain contain a squash command? */
@@ -1958,7 +1958,7 @@ static int append_squash_message(struct strbuf *buf=
, const char *body,
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
-	strbuf_add_commented_lines(buf, body, commented_len, comment_line_char)=
;
+	strbuf_add_commented_lines(buf, body, commented_len);
 	/* buf->buf may be reallocated so store an offset into the buffer */
 	fixup_off =3D buf->len;
 	strbuf_addstr(buf, body + commented_len);
@@ -2048,8 +2048,7 @@ static int update_squash_messages(struct repository=
 *r,
 			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		if (is_fixup_flag(command, flag))
-			strbuf_add_commented_lines(&buf, body, strlen(body),
-						   comment_line_char);
+			strbuf_add_commented_lines(&buf, body, strlen(body));
 		else
 			strbuf_addstr(&buf, body);
=20
@@ -2068,8 +2067,7 @@ static int update_squash_messages(struct repository=
 *r,
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
-		strbuf_add_commented_lines(&buf, body, strlen(body),
-					   comment_line_char);
+		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
 		return error(_("unknown command: %d"), command);
 	repo_unuse_commit_buffer(r, commit, message);
diff --git a/strbuf.c b/strbuf.c
index 15550b2619..2088f7800a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -360,8 +360,8 @@ static void add_lines(struct strbuf *out,
 	strbuf_complete_line(out);
 }
=20
-void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
-				size_t size, char comment_line_char)
+void strbuf_add_commented_lines(struct strbuf *out,
+				const char *buf, size_t size)
 {
 	static char prefix1[3];
 	static char prefix2[2];
@@ -384,7 +384,7 @@ void strbuf_commented_addf(struct strbuf *sb,
 	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
=20
-	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_char);
+	strbuf_add_commented_lines(sb, buf.buf, buf.len);
 	if (incomplete_line)
 		sb->buf[--sb->len] =3D '\0';
=20
diff --git a/strbuf.h b/strbuf.h
index 981617dc77..4547efa62e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -287,8 +287,7 @@ void strbuf_splice(struct strbuf *sb, size_t pos, siz=
e_t len,
  * by a comment character and a blank.
  */
 void strbuf_add_commented_lines(struct strbuf *out,
-				const char *buf, size_t size,
-				char comment_line_char);
+				const char *buf, size_t size);
=20
=20
 /**
diff --git a/wt-status.c b/wt-status.c
index 54b2775730..b390c77334 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1027,7 +1027,7 @@ static void wt_longstatus_print_submodule_summary(s=
truct wt_status *s, int uncom
 	if (s->display_comment_prefix) {
 		size_t len;
 		summary_content =3D strbuf_detach(&summary, &len);
-		strbuf_add_commented_lines(&summary, summary_content, len, comment_lin=
e_char);
+		strbuf_add_commented_lines(&summary, summary_content, len);
 		free(summary_content);
 	}
=20
@@ -1103,7 +1103,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 	const char *explanation =3D _("Do not modify or remove the line above.\=
nEverything below it will be ignored.");
=20
 	strbuf_commented_addf(buf, "%s", cut_line);
-	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comme=
nt_line_char);
+	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
 }
=20
 void wt_status_add_cut_line(FILE *fp)
--=20
2.42.0-526-g3130c155df

