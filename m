Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6885F54D
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712488; cv=none; b=uSfqeuvFll0/NPnqnNdC2j5LE2+RZuw4RNyfY2uOzG63LF3x9UDmh0gvWygTKX84Id5Glm1SG582urBrD7Dr/dqF91VtfrMZj/ZQ5WThWJlrc+A/OLeOpYE0k3htUizxnyEMg0+UCAvK2sjIG7sPKSpGK453UvLNHoSAWia/9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712488; c=relaxed/simple;
	bh=+Nw2V2VXV+mHJgY1WYVwFpE5INftEwerpTiJrWYmiZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1YzjxekLP59kkCMiewrZ+slRN1SnoGJOJRYJSNkGVo9REHrzcHyeAMUg+C5/JRiBOBGUMjScdeH4tz2v96YIFnEgtYuI1GRgU+yW5vnQYatJt6hQ9eHBjO+pS7f+7jb4JJ23qx1f+u0TzPR+5tLptQ4ZsbW4lw9srCdwyvtDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26835 invoked by uid 109); 6 Mar 2024 08:08:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Mar 2024 08:08:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 631 invoked by uid 111); 6 Mar 2024 08:08:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Mar 2024 03:08:09 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Mar 2024 03:08:04 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [messy PATCH] multi-byte core.commentChar
Message-ID: <20240306080804.GB4099518@coredump.intra.peff.net>
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g>
 <52d6850914982ffaf15dda937d611ffb@manjaro.org>
 <xmqqmsrc4osm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmsrc4osm.fsf@gitster.g>

On Tue, Mar 05, 2024 at 08:38:17AM -0800, Junio C Hamano wrote:

> It is not my personal itch, so I haven't done anything to make the
> commentChar take more than one byte.  But if it is somebody else's
> itch, I do not see a reason why we should forbid them from
> scratching.  If the setting seeps through across repository
> boundaries, that may create a compatibility issue and that by itself
> might be such a reason.  If it greatly makes the code more complex,
> that may be another reason you can use to argue against adding such
> a "feature".  If it makes the semantics of what "a comment string"
> is and how they are added and stripped at various stages of
> processing commit log messages fuzzy and harder to document and
> understand, that might be another reason.  I however do not think
> any of these to be true.  Maybe I am overly optimistic.  I haven't
> looked deeply into the code around commentChar for quite some time.

Here's a messy version of what it would look like, in case anybody is
interested. It passes the tests (using the string "#" for the most
part), but there may be corner cases lurking. The %c/%s conversions are
noisy but obvious. The trickier parts are matching, which goes from
single-character to a string match. I used starts_with() but had to
introduce a "_mem" variant for buffers that aren't NUL-terminated.
There's a bit of mild refactoring/cleanup to avoid awkwardness in a few
spots, as well.

I also did a few manual tests with "foo>" and "•" as comment chars,
which seemed to work.

I can't imagine using this myself (I don't even set core.commentChar at
all), so it was mostly that I nerd-sniped myself by thinking "how hard
could it be?". Not too bad, but not trivial. But maybe it spurs somebody
interested in working on it. I am on the fence whether supporting UTF-8
like the bullet-point above is maybe something we should just do on
principle.

For a more readable series, I'd guess it would make sense to introduce
comment_line_str as a separate variable (but continue to enforce the
single-char rule), convert the easy cases en masse, the tricky cases one
by one, and then finally drop comment_line_char entirely. At which point
the config rules can be lifted to allow multi-byte strings.

---
 add-patch.c       |  4 ++--
 builtin/branch.c  |  2 +-
 builtin/commit.c  | 19 ++++++++++------
 builtin/merge.c   |  2 +-
 builtin/tag.c     |  4 ++--
 commit.c          |  3 ++-
 config.c          |  7 +++---
 environment.c     |  2 +-
 environment.h     |  2 +-
 fmt-merge-msg.c   |  2 +-
 sequencer.c       | 28 ++++++++++++-----------
 strbuf.c          | 43 +++++++++++++++++++----------------
 strbuf.h          |  7 +++---
 t/t7508-status.sh |  4 +++-
 trailer.c         |  6 ++---
 wt-status.c       | 23 +++++++------------
 16 files changed, 82 insertions(+), 76 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..4b4db0f253 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1114,7 +1114,7 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 				"To remove '%c' lines, make them ' ' lines "
 				"(context).\n"
 				"To remove '%c' lines, delete them.\n"
-				"Lines starting with %c will be removed.\n"),
+				"Lines starting with %s will be removed.\n"),
 			      s->mode->is_reverse ? '+' : '-',
 			      s->mode->is_reverse ? '-' : '+',
 			      comment_line_char);
@@ -1139,7 +1139,7 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 	for (i = 0; i < s->buf.len; ) {
 		size_t next = find_next_line(&s->buf, i);
 
-		if (s->buf.buf[i] != comment_line_char)
+		if (!starts_with(s->buf.buf + i, comment_line_char))
 			strbuf_add(&s->plain, s->buf.buf + i, next - i);
 		i = next;
 	}
diff --git a/builtin/branch.c b/builtin/branch.c
index cfb63cce5f..0b6e1d1adb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -670,7 +670,7 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_commented_addf(&buf, comment_line_char,
 		    _("Please edit the description for the branch\n"
 		      "  %s\n"
-		      "Lines starting with '%c' will be stripped.\n"),
+		      "Lines starting with '%s' will be stripped.\n"),
 		    branch_name, comment_line_char);
 	write_file_buf(edit_description(), buf.buf, buf.len);
 	strbuf_reset(&buf);
diff --git a/builtin/commit.c b/builtin/commit.c
index 6d1fa71676..898c8aadc7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -678,15 +678,20 @@ static int author_date_is_interesting(void)
 	return author_message || force_date;
 }
 
+/*
+ * This only supports single-byte comment chars, but that's OK;
+ * our candidate list is fixed.
+ */
 static void adjust_comment_line_char(const struct strbuf *sb)
 {
 	char candidates[] = "#;@!$%^&|:";
 	char *candidate;
 	const char *p;
 
-	comment_line_char = candidates[0];
-	if (!memchr(sb->buf, comment_line_char, sb->len))
+	if (!memchr(sb->buf, candidates[0], sb->len)) {
+		comment_line_char = xstrfmt("%c", candidates[0]);
 		return;
+	}
 
 	p = sb->buf;
 	candidate = strchr(candidates, *p);
@@ -705,7 +710,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	if (!*p)
 		die(_("unable to select a comment character that is not used\n"
 		      "in the current commit message"));
-	comment_line_char = *p;
+	comment_line_char = xstrfmt("%c", *p);
 }
 
 static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
@@ -909,18 +914,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
diff --git a/builtin/merge.c b/builtin/merge.c
index 935c8a57dd..81b1cf5b90 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -821,7 +821,7 @@ static const char scissors_editor_comment[] =
 N_("An empty message aborts the commit.\n");
 
 static const char no_scissors_editor_comment[] =
-N_("Lines starting with '%c' will be ignored, and an empty message aborts\n"
+N_("Lines starting with '%s' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
 static void write_merge_heads(struct commit_list *);
diff --git a/builtin/tag.c b/builtin/tag.c
index 19a7e06bf4..8b17705cf6 100644
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
diff --git a/commit.c b/commit.c
index ef679a0b93..ff9d49a141 100644
--- a/commit.c
+++ b/commit.c
@@ -1796,7 +1796,8 @@ size_t ignored_log_message_bytes(const char *buf, size_t len)
 		else
 			next_line++;
 
-		if (buf[bol] == comment_line_char || buf[bol] == '\n') {
+		if (starts_with_mem(buf + bol, cutoff - bol, comment_line_char) ||
+		    buf[bol] == '\n') {
 			/* is this the first of the run of comments? */
 			if (!boc)
 				boc = bol;
diff --git a/config.c b/config.c
index 3cfeb3d8bd..9280dc9844 100644
--- a/config.c
+++ b/config.c
@@ -1565,11 +1565,10 @@ static int git_default_core_config(const char *var, const char *value,
 			return config_error_nonbool(var);
 		else if (!strcasecmp(value, "auto"))
 			auto_comment_line_char = 1;
-		else if (value[0] && !value[1]) {
-			comment_line_char = value[0];
+		else {
+			comment_line_char = xstrdup(value);
 			auto_comment_line_char = 0;
-		} else
-			return error(_("core.commentChar should only be one ASCII character"));
+		}
 		return 0;
 	}
 
diff --git a/environment.c b/environment.c
index 90632a39bc..4435866d4e 100644
--- a/environment.c
+++ b/environment.c
@@ -110,7 +110,7 @@ int protect_ntfs = PROTECT_NTFS_DEFAULT;
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
  */
-char comment_line_char = '#';
+char *comment_line_char = "#";
 int auto_comment_line_char;
 
 /* Parallel index stat data preload? */
diff --git a/environment.h b/environment.h
index e5351c9dd9..821c6079af 100644
--- a/environment.h
+++ b/environment.h
@@ -8,7 +8,7 @@ struct strvec;
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
  */
-extern char comment_line_char;
+extern char *comment_line_char;
 extern int auto_comment_line_char;
 
 /*
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 66e47449a0..daf57917fa 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -321,7 +321,7 @@ static void credit_people(struct strbuf *out,
 	     skip_prefix(me, them->items->string, &me) &&
 	     starts_with(me, " <")))
 		return;
-	strbuf_addf(out, "\n%c %s ", comment_line_char, label);
+	strbuf_addf(out, "\n%s %s ", comment_line_char, label);
 	add_people_count(out, them);
 }
 
diff --git a/sequencer.c b/sequencer.c
index f49a871ac0..2370abc379 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -663,7 +663,7 @@ void append_conflicts_hint(struct index_state *istate,
 	if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 		strbuf_addch(msgbuf, '\n');
 		wt_status_append_cut_line(msgbuf);
-		strbuf_addch(msgbuf, comment_line_char);
+		strbuf_addstr(msgbuf, comment_line_char);
 	}
 
 	strbuf_addch(msgbuf, '\n');
@@ -1779,14 +1779,16 @@ static const char *command_to_string(const enum todo_command command)
 {
 	if (command < TODO_COMMENT)
 		return todo_command_info[command].str;
+	if (command == TODO_COMMENT)
+		return comment_line_char;
 	die(_("unknown command: %d"), command);
 }
 
 static char command_to_char(const enum todo_command command)
 {
 	if (command < TODO_COMMENT)
 		return todo_command_info[command].c;
-	return comment_line_char;
+	return 0;
 }
 
 static int is_noop(const enum todo_command command)
@@ -1840,7 +1842,7 @@ static int is_fixup_flag(enum todo_command command, unsigned flag)
 static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
 {
 	const char *s = str;
-	while (len > 0 && s[0] == comment_line_char) {
+	while (len > 0 && starts_with_mem(s, len, comment_line_char)) {
 		size_t count;
 		const char *n = memchr(s, '\n', len);
 		if (!n)
@@ -1946,7 +1948,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	     (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
 		commented_len = commit_subject_length(body);
 
-	strbuf_addf(buf, "\n%c ", comment_line_char);
+	strbuf_addf(buf, "\n%s ", comment_line_char);
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
@@ -2003,10 +2005,10 @@ static int update_squash_messages(struct repository *r,
 			return error(_("could not read '%s'"),
 				rebase_path_squash_msg());
 
-		eol = buf.buf[0] != comment_line_char ?
+		eol = !starts_with(buf.buf, comment_line_char) ?
 			buf.buf : strchrnul(buf.buf, '\n');
 
-		strbuf_addf(&header, "%c ", comment_line_char);
+		strbuf_addf(&header, "%s ", comment_line_char);
 		strbuf_addf(&header, _(combined_commit_msg_fmt),
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
@@ -2032,9 +2034,9 @@ static int update_squash_messages(struct repository *r,
 			repo_unuse_commit_buffer(r, head_commit, head_message);
 			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
-		strbuf_addf(&buf, "%c ", comment_line_char);
+		strbuf_addf(&buf, "%s ", comment_line_char);
 		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
-		strbuf_addf(&buf, "\n%c ", comment_line_char);
+		strbuf_addf(&buf, "\n%s ", comment_line_char);
 		strbuf_addstr(&buf, is_fixup_flag(command, flag) ?
 			      _(skip_first_commit_msg_str) :
 			      _(first_commit_msg_str));
@@ -2056,7 +2058,7 @@ static int update_squash_messages(struct repository *r,
 	if (command == TODO_SQUASH || is_fixup_flag(command, flag)) {
 		res = append_squash_message(&buf, body, command, opts, flag);
 	} else if (command == TODO_FIXUP) {
-		strbuf_addf(&buf, "\n%c ", comment_line_char);
+		strbuf_addf(&buf, "\n%s ", comment_line_char);
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
@@ -2562,7 +2564,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	/* left-trim */
 	bol += strspn(bol, " \t");
 
-	if (bol == eol || *bol == '\r' || *bol == comment_line_char) {
+	if (bol == eol || *bol == '\r' || starts_with_mem(bol, eol - bol, comment_line_char)) {
 		item->command = TODO_COMMENT;
 		item->commit = NULL;
 		item->arg_offset = bol - buf;
@@ -5659,7 +5661,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				    oid_to_hex(&commit->object.oid),
 				    oneline.buf);
 			if (is_empty)
-				strbuf_addf(&buf, " %c empty",
+				strbuf_addf(&buf, " %s empty",
 					    comment_line_char);
 
 			FLEX_ALLOC_STR(entry, string, buf.buf);
@@ -5750,7 +5752,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
+			strbuf_addf(out, "\n%s Branch %s\n", comment_line_char, entry->string);
 		else
 			strbuf_addch(out, '\n');
 
@@ -5887,7 +5889,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, out);
 		if (is_empty)
-			strbuf_addf(out, " %c empty", comment_line_char);
+			strbuf_addf(out, " %s empty", comment_line_char);
 		strbuf_addch(out, '\n');
 	}
 	if (skipped_commit)
diff --git a/strbuf.c b/strbuf.c
index 7827178d8e..5d2a32d8f0 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -24,6 +24,17 @@ int istarts_with(const char *str, const char *prefix)
 			return 0;
 }
 
+int starts_with_mem(const char *str, size_t len, const char *prefix)
+{
+	const char *end = str + len;
+	for (; ; str++, prefix++) {
+		if (!*prefix)
+			return 1;
+		else if (str == end || *str != *prefix)
+			return 0;
+	}
+}
+
 int skip_to_optional_arg_default(const char *str, const char *prefix,
 				 const char **arg, const char *def)
 {
@@ -340,18 +351,17 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 }
 
 static void add_lines(struct strbuf *out,
-			const char *prefix1,
-			const char *prefix2,
-			const char *buf, size_t size)
+			const char *prefix,
+			const char *buf, size_t size,
+			int space_after_prefix)
 {
 	while (size) {
-		const char *prefix;
 		const char *next = memchr(buf, '\n', size);
 		next = next ? (next + 1) : (buf + size);
 
-		prefix = ((prefix2 && (buf[0] == '\n' || buf[0] == '\t'))
-			  ? prefix2 : prefix1);
 		strbuf_addstr(out, prefix);
+		if (space_after_prefix && buf[0] != '\n' && buf[0] != '\t')
+			strbuf_addch(out, ' ');
 		strbuf_add(out, buf, next - buf);
 		size -= next - buf;
 		buf = next;
@@ -360,19 +370,12 @@ static void add_lines(struct strbuf *out,
 }
 
 void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
-				size_t size, char comment_line_char)
+				size_t size, const char *comment_line_char)
 {
-	static char prefix1[3];
-	static char prefix2[2];
-
-	if (prefix1[0] != comment_line_char) {
-		xsnprintf(prefix1, sizeof(prefix1), "%c ", comment_line_char);
-		xsnprintf(prefix2, sizeof(prefix2), "%c", comment_line_char);
-	}
-	add_lines(out, prefix1, prefix2, buf, size);
+	add_lines(out, comment_line_char, buf, size, 1);
 }
 
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char,
+void strbuf_commented_addf(struct strbuf *sb, const char *comment_line_char,
 			   const char *fmt, ...)
 {
 	va_list params;
@@ -750,7 +753,7 @@ ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 void strbuf_add_lines(struct strbuf *out, const char *prefix,
 		      const char *buf, size_t size)
 {
-	add_lines(out, prefix, NULL, buf, size);
+	add_lines(out, prefix, buf, size, 0);
 }
 
 void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
@@ -1005,10 +1008,10 @@ static size_t cleanup(char *line, size_t len)
  *
  * If last line does not have a newline at the end, one is added.
  *
- * Pass a non-NUL comment_line_char to skip every line starting
+ * Pass a non-NULL comment_line_char to skip every line starting
  * with it.
  */
-void strbuf_stripspace(struct strbuf *sb, char comment_line_char)
+void strbuf_stripspace(struct strbuf *sb, const char *comment_line_char)
 {
 	size_t empties = 0;
 	size_t i, j, len, newlen;
@@ -1022,7 +1025,7 @@ void strbuf_stripspace(struct strbuf *sb, char comment_line_char)
 		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
 
 		if (comment_line_char && len &&
-		    sb->buf[i] == comment_line_char) {
+		    starts_with(sb->buf + i, comment_line_char)) {
 			newlen = 0;
 			continue;
 		}
diff --git a/strbuf.h b/strbuf.h
index e959caca87..b310a55095 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -288,7 +288,7 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
  */
 void strbuf_add_commented_lines(struct strbuf *out,
 				const char *buf, size_t size,
-				char comment_line_char);
+				const char *comment_line_char);
 
 
 /**
@@ -379,7 +379,7 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
  * blank to the buffer.
  */
 __attribute__((format (printf, 3, 4)))
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char, const char *fmt, ...);
+void strbuf_commented_addf(struct strbuf *sb, const char *comment_line_char, const char *fmt, ...);
 
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
@@ -517,7 +517,7 @@ int strbuf_normalize_path(struct strbuf *sb);
  * then lines beginning with that character are considered comments,
  * thus removed.
  */
-void strbuf_stripspace(struct strbuf *buf, char comment_line_char);
+void strbuf_stripspace(struct strbuf *buf, const char *comment_line_char);
 
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
@@ -673,6 +673,7 @@ char *xstrfmt(const char *fmt, ...);
 
 int starts_with(const char *str, const char *prefix);
 int istarts_with(const char *str, const char *prefix);
+int starts_with_mem(const char *str, size_t len, const char *prefix);
 
 /*
  * If the string "str" is the same as the string in "prefix", then the "arg"
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a3c18a4fc2..10ed8b32bc 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1403,7 +1403,9 @@ test_expect_success "status (core.commentchar with submodule summary)" '
 
 test_expect_success "status (core.commentchar with two chars with submodule summary)" '
 	test_config core.commentchar ";;" &&
-	test_must_fail git -c status.displayCommentPrefix=true status
+	sed "s/^/;/" <expect >expect.double &&
+	git -c status.displayCommentPrefix=true status >output &&
+	test_cmp expect.double output
 '
 
 test_expect_success "--ignore-submodules=all suppresses submodule summary" '
diff --git a/trailer.c b/trailer.c
index ef9df4af55..b3edcfe695 100644
--- a/trailer.c
+++ b/trailer.c
@@ -882,7 +882,7 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
 
 	/* The first paragraph is the title and cannot be trailers */
 	for (s = buf; s < buf + len; s = next_line(s)) {
-		if (s[0] == comment_line_char)
+		if (starts_with_mem(s, buf + len - s, comment_line_char))
 			continue;
 		if (is_blank_line(s))
 			break;
@@ -902,7 +902,7 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
 		const char **p;
 		ssize_t separator_pos;
 
-		if (bol[0] == comment_line_char) {
+		if (starts_with_mem(bol, buf + end_of_title - bol, comment_line_char)) {
 			non_trailer_lines += possible_continuation_lines;
 			possible_continuation_lines = 0;
 			continue;
@@ -1013,7 +1013,7 @@ static void parse_trailers(struct trailer_info *info,
 	for (i = 0; i < info->trailer_nr; i++) {
 		int separator_pos;
 		char *trailer = info->trailers[i];
-		if (trailer[0] == comment_line_char)
+		if (starts_with(trailer, comment_line_char))
 			continue;
 		separator_pos = find_separator(trailer, separators);
 		if (separator_pos >= 1) {
diff --git a/wt-status.c b/wt-status.c
index b5a29083df..dfe120a559 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -70,7 +70,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 	strbuf_vaddf(&sb, fmt, ap);
 	if (!sb.len) {
 		if (s->display_comment_prefix) {
-			strbuf_addch(&sb, comment_line_char);
+			strbuf_addstr(&sb, comment_line_char);
 			if (!trail)
 				strbuf_addch(&sb, ' ');
 		}
@@ -85,7 +85,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 
 		strbuf_reset(&linebuf);
 		if (at_bol && s->display_comment_prefix) {
-			strbuf_addch(&linebuf, comment_line_char);
+			strbuf_addstr(&linebuf, comment_line_char);
 			if (*line != '\n' && *line != '\t')
 				strbuf_addch(&linebuf, ' ');
 		}
@@ -1090,7 +1090,7 @@ size_t wt_status_locate_end(const char *s, size_t len)
 	const char *p;
 	struct strbuf pattern = STRBUF_INIT;
 
-	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
+	strbuf_addf(&pattern, "\n%s %s", comment_line_char, cut_line);
 	if (starts_with(s, pattern.buf + 1))
 		len = 0;
 	else if ((p = strstr(s, pattern.buf)))
@@ -1176,8 +1176,6 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep, *branch_name;
 	struct branch *branch;
-	char comment_line_string[3];
-	int i;
 	uint64_t t_begin = 0;
 
 	assert(s->branch && !s->is_initial);
@@ -1202,19 +1200,14 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 		}
 	}
 
-	i = 0;
-	if (s->display_comment_prefix) {
-		comment_line_string[i++] = comment_line_char;
-		comment_line_string[i++] = ' ';
-	}
-	comment_line_string[i] = '\0';
-
 	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s),
-				 "%s%.*s", comment_line_string,
+				 "%s%s%.*s",
+				 s->display_comment_prefix ? comment_line_char : "",
+				 s->display_comment_prefix ? " " : "",
 				 (int)(ep - cp), cp);
 	if (s->display_comment_prefix)
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%s",
 				 comment_line_char);
 	else
 		fputs("\n", s->fp);
@@ -1382,7 +1375,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 			  git_path("%s", fname));
 	}
 	while (!strbuf_getline_lf(&line, f)) {
-		if (line.len && line.buf[0] == comment_line_char)
+		if (starts_with(line.buf, comment_line_char))
 			continue;
 		strbuf_trim(&line);
 		if (!line.len)
