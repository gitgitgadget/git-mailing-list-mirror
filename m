Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23111BB691
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174389; cv=none; b=tluU2hwVuoImyr8F57qlCwNxuC9BEv2sJUBJss58VPE0YkPHhAqS1KH5AsEUxfyb/6BT+3THzYvx9U4sHCJdKj+T/VdGShS6xS67FB0jUdQDGq2wPwMWckJ0fyy5huxRqk/lKqYaa8I2/A5a40ybXkWjp+n2M/cqYT1MqAOqp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174389; c=relaxed/simple;
	bh=cLID1LkCDLp8l/VnTYkWjIN75vIM2FtQEUWgL1i8x1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fpc7xwy59g1TrzJPsMzfb++2JsQW9qPHy79hkitv4gBOv7yE454trQ1uB684+js/he5Rkn1kRkl5gAQRwCfj1hIPcgZTW/fxCWJBbD24ikBLm5n97uRknQ1a+GThjCyXUhXsYfM6Pg7zXV3tFR1YqsuxNR1r8xWTcD7LZsu7bqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qiefjshj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qiefjshj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3FE03774A;
	Thu, 12 Sep 2024 16:53:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=cLID1LkCDLp8l/VnTYkWjIN75
	vIM2FtQEUWgL1i8x1g=; b=qiefjshjsU62vsUNWKSEVHDvB80H3OqjryzcjTHgo
	DrS3SGhxfXIiyyXlj6+V8/Itr8xFLGRn5TgCH+12MGIENzaT510WXcJart9PeGsX
	cqMeQjm9po7UM3Qq5GyNTOnuSZoqF4+wb2R3KJkA3fRzoGuHKPmt4JHcHi/qdU1R
	Rk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 99A5137749;
	Thu, 12 Sep 2024 16:53:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCF3D37748;
	Thu, 12 Sep 2024 16:53:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] strbuf: retire strbuf_commented_addf()
Date: Thu, 12 Sep 2024 13:53:00 -0700
Message-ID: <20240912205301.1809355-2-gitster@pobox.com>
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
 0265F470-7149-11EF-B433-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The API allows the caller to pass any string as the comment prefix,
but in reality, everybody passes the comment_line_str from the
environment.

Replace this overly flexible API with strbuf_comment_addf() that
does not allow customization of the comment_line_str (usually '#'
but can be configured via the core.commentChar).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 add-patch.c          | 8 ++++----
 builtin/branch.c     | 2 +-
 builtin/merge.c      | 8 ++++----
 builtin/tag.c        | 4 ++--
 rebase-interactive.c | 2 +-
 sequencer.c          | 4 ++--
 strbuf.c             | 6 +++---
 strbuf.h             | 6 +++---
 wt-status.c          | 2 +-
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 46f6bddfe5..32c990cc18 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1114,11 +1114,11 @@ static int edit_hunk_manually(struct add_p_state =
*s, struct hunk *hunk)
 	size_t i;
=20
 	strbuf_reset(&s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_str,
+	strbuf_comment_addf(&s->buf,
 			      _("Manual hunk edit mode -- see bottom for "
 				"a quick guide.\n"));
 	render_hunk(s, hunk, 0, 0, &s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_str,
+	strbuf_comment_addf(&s->buf,
 			      _("---\n"
 				"To remove '%c' lines, make them ' ' lines "
 				"(context).\n"
@@ -1127,13 +1127,13 @@ static int edit_hunk_manually(struct add_p_state =
*s, struct hunk *hunk)
 			      s->mode->is_reverse ? '+' : '-',
 			      s->mode->is_reverse ? '-' : '+',
 			      comment_line_str);
-	strbuf_commented_addf(&s->buf, comment_line_str, "%s",
+	strbuf_comment_addf(&s->buf,  "%s",
 			      _(s->mode->edit_hunk_hint));
 	/*
 	 * TRANSLATORS: 'it' refers to the patch mentioned in the previous
 	 * messages.
 	 */
-	strbuf_commented_addf(&s->buf, comment_line_str,
+	strbuf_comment_addf(&s->buf,
 			      _("If it does not apply cleanly, you will be "
 				"given an opportunity to\n"
 				"edit again.  If all lines of the hunk are "
diff --git a/builtin/branch.c b/builtin/branch.c
index 48cac74f97..b2a4206e1b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -681,7 +681,7 @@ static int edit_branch_description(const char *branch=
_name)
 	exists =3D !read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] !=3D '\n')
 		strbuf_addch(&buf, '\n');
-	strbuf_commented_addf(&buf, comment_line_str,
+	strbuf_comment_addf(&buf,
 		    _("Please edit the description for the branch\n"
 		      "  %s\n"
 		      "Lines starting with '%s' will be stripped.\n"),
diff --git a/builtin/merge.c b/builtin/merge.c
index 9fba27d85d..8794fea28f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -863,15 +863,15 @@ static void prepare_to_commit(struct commit_list *r=
emoteheads)
 		strbuf_addch(&msg, '\n');
 		if (cleanup_mode =3D=3D COMMIT_MSG_CLEANUP_SCISSORS) {
 			wt_status_append_cut_line(&msg);
-			strbuf_commented_addf(&msg, comment_line_str, "\n");
+			strbuf_comment_addf(&msg,  "\n");
 		}
-		strbuf_commented_addf(&msg, comment_line_str,
+		strbuf_comment_addf(&msg,
 				      _(merge_editor_comment));
 		if (cleanup_mode =3D=3D COMMIT_MSG_CLEANUP_SCISSORS)
-			strbuf_commented_addf(&msg, comment_line_str,
+			strbuf_comment_addf(&msg,
 					      _(scissors_editor_comment));
 		else
-			strbuf_commented_addf(&msg, comment_line_str,
+			strbuf_comment_addf(&msg,
 				_(no_scissors_editor_comment), comment_line_str);
 	}
 	if (signoff)
diff --git a/builtin/tag.c b/builtin/tag.c
index a1fb218512..0929cfc158 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -334,10 +334,10 @@ static void create_tag(const struct object_id *obje=
ct, const char *object_ref,
 			struct strbuf buf =3D STRBUF_INIT;
 			strbuf_addch(&buf, '\n');
 			if (opt->cleanup_mode =3D=3D CLEANUP_ALL)
-				strbuf_commented_addf(&buf, comment_line_str,
+				strbuf_comment_addf(&buf,
 				      _(tag_template), tag, comment_line_str);
 			else
-				strbuf_commented_addf(&buf, comment_line_str,
+				strbuf_comment_addf(&buf,
 				      _(tag_template_nocleanup), tag, comment_line_str);
 			write_or_die(fd, buf.buf, buf.len);
 			strbuf_release(&buf);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index cbeb864147..dd2ec363d8 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -73,7 +73,7 @@ void append_todo_help(int command_count,
=20
 	if (!edit_todo) {
 		strbuf_addch(buf, '\n');
-		strbuf_commented_addf(buf, comment_line_str,
+		strbuf_comment_addf(buf,
 				      Q_("Rebase %s onto %s (%d command)",
 					 "Rebase %s onto %s (%d commands)",
 					 command_count),
diff --git a/sequencer.c b/sequencer.c
index a2284ac9e9..bf844ce98e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -731,11 +731,11 @@ void append_conflicts_hint(struct index_state *ista=
te,
 	}
=20
 	strbuf_addch(msgbuf, '\n');
-	strbuf_commented_addf(msgbuf, comment_line_str, "Conflicts:\n");
+	strbuf_comment_addf(msgbuf,  "Conflicts:\n");
 	for (i =3D 0; i < istate->cache_nr;) {
 		const struct cache_entry *ce =3D istate->cache[i++];
 		if (ce_stage(ce)) {
-			strbuf_commented_addf(msgbuf, comment_line_str,
+			strbuf_comment_addf(msgbuf,
 					      "\t%s\n", ce->name);
 			while (i < istate->cache_nr &&
 			       !strcmp(ce->name, istate->cache[i]->name))
diff --git a/strbuf.c b/strbuf.c
index 3d2189a7f6..6c525da7a6 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex-ll.h"
 #include "strbuf.h"
@@ -384,8 +385,7 @@ void strbuf_add_commented_lines(struct strbuf *out, c=
onst char *buf,
 	add_lines(out, comment_prefix, buf, size, 1);
 }
=20
-void strbuf_commented_addf(struct strbuf *sb, const char *comment_prefix=
,
-			   const char *fmt, ...)
+void strbuf_comment_addf(struct strbuf *sb, const char *fmt, ...)
 {
 	va_list params;
 	struct strbuf buf =3D STRBUF_INIT;
@@ -395,7 +395,7 @@ void strbuf_commented_addf(struct strbuf *sb, const c=
har *comment_prefix,
 	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
=20
-	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_prefix);
+	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_str);
 	if (incomplete_line)
 		sb->buf[--sb->len] =3D '\0';
=20
diff --git a/strbuf.h b/strbuf.h
index 003f880ff7..aebc8020ae 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -385,11 +385,11 @@ __attribute__((format (printf,2,3)))
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
=20
 /**
- * Add a formatted string prepended by a comment character and a
+ * Add a formatted string prepended by the comment character and a
  * blank to the buffer.
  */
-__attribute__((format (printf, 3, 4)))
-void strbuf_commented_addf(struct strbuf *sb, const char *comment_prefix=
, const char *fmt, ...);
+__attribute__((format (printf,2,3)))
+void strbuf_comment_addf(struct strbuf *sb, const char *fmt, ...);
=20
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
diff --git a/wt-status.c b/wt-status.c
index b778eef989..44d29b721f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1111,7 +1111,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation =3D _("Do not modify or remove the line above.\=
nEverything below it will be ignored.");
=20
-	strbuf_commented_addf(buf, comment_line_str, "%s", cut_line);
+	strbuf_comment_addf(buf,  "%s", cut_line);
 	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comme=
nt_line_str);
 }
=20
--=20
2.46.0-717-g3841ff3f09

