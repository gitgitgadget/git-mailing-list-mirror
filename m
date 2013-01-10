From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] commit: make default of "cleanup" option configurable
Date: Thu, 10 Jan 2013 11:37:43 -0800
Message-ID: <7vk3rk25iw.fsf_-_@alter.siamese.dyndns.org>
References: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
 <20130109072952.GC6503@elie.Belkin>
 <CAN0XMO+t2gu9UKJFVXAxt91-hUUhMqqmMoop88KYp0vo3x6c_g@mail.gmail.com>
 <7vhamq8i44.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 10 20:38:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtNx3-00051r-Rt
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 20:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab3AJTht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 14:37:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35678 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303Ab3AJThs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 14:37:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C957EBF0B;
	Thu, 10 Jan 2013 14:37:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YjmGmI18oOGiU4zRgkYi71d/tag=; b=VcCPpr
	SnKVz0sxzkSf8g0oFLWM5BDK0B8IHoTQvrwIN8nMOunrfDVG/BSwbx6qH+sUr7Au
	UWCx1avlcf5O8qYZLcZ25lUTB6jxmUxyFwhtfnP4YIVSG01s9cMEiZRz/s/1t1ht
	xQs/t3c400uECAuIaUxTlnabIKgEPD9x+CKlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lYeA8OcGx5idshfadyQzEff876dcmgpw
	u1E4Vo7a3ZkXKPwom44vzdealZuEca/oWJRhwvIEqLE8TpVCiNyyvefy57GQtSQK
	sijX/pd+qs5QV7mwjtj+C/TsomSi/LkRkz0U1ODBHZdYhLLn1cK0nhcCckc0jwx3
	zQk6mHxHv40=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F23EBF09;
	Thu, 10 Jan 2013 14:37:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B140BEFF; Thu, 10 Jan 2013
 14:37:45 -0500 (EST)
In-Reply-To: <7vhamq8i44.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 09 Jan 2013 07:56:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35C08E0C-5B5D-11E2-9572-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213149>

Junio C Hamano <gitster@pobox.com> writes:

> I also wonder, as a longer term alternative (which would require a
> lot of code auditing and some refactoring), if it is useful to have
> an option and/or configuration that lets you configure the "comment
> in log message editor" character from the default "#" to something
> else.  "git -c log.commentchar=% commit" may start the log message
> editor with something like this in it:
>
>     % Please enter the commit message for your changes. Lines starting
>     % with '%' will be ignored, and an empty message aborts the commit.
>
> Naturally, setting log.commentchar to "none" would disable stripping
> of any commented lines if such a feature existed, and stop issuing
> these helpful comments altogether, but still strip excess blank
> lines and trailing whitespaces.
>
> I wouldn't seriously suggest it as I am not sure if the usefulness
> of such a feature would outweigh the cost of coding it, though; at
> least not at this point yet.

A beginning of a patch to do would be like this, which does not look
too bad.  There are some low hanging fruits I didn't bother to do in
this illustration (see NEEDSWORK comment in builtin/branch.c if some
of you are interested in pursuing it).

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 10 Jan 2013 11:17:21 -0800
Subject: [PATCH] Allow custom "comment char"

Some users do want to write a line that begin with a pound sign,
#, in their commit log message.  Many tracking system recognise
a token of #<bugid> form, for example.

The support we offer these use cases is not very friendly to the end
users.  They have a choice between

 - Don't do it.  Avoid such a line by rewrapping or indenting; and

 - Use --cleanup=whitespace but remove all the hint lines we add.

Give them a way to set a custom comment char, e.g.

    $ git -c core.commentchar="%" commit

so that they do not have to do either of the two workarounds.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  6 ++++++
 builtin/branch.c         | 16 ++++++++++++----
 builtin/commit.c         | 15 ++++++++-------
 builtin/fmt-merge-msg.c  |  4 +++-
 builtin/merge.c          | 15 +++++++++++----
 builtin/stripspace.c     |  2 +-
 cache.h                  |  6 ++++++
 config.c                 |  8 ++++++++
 environment.c            |  6 ++++++
 wt-status.c              | 10 ++++++----
 10 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5809e0..e99b9f2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -528,6 +528,12 @@ core.editor::
 	variable when it is set, and the environment variable
 	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
 
+core.commentchar::
+	Commands such as `commit` and `tag` that lets you edit
+	messages consider a line that begins with this character
+	commented, and removes them after the editor returns
+	(default '#').
+
 sequence.editor::
 	Text editor used by `git rebase -i` for editing the rebase insn file.
 	The value is meant to be interpreted by the shell when it is used.
diff --git a/builtin/branch.c b/builtin/branch.c
index 873f624..7f8865a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -706,11 +706,19 @@ static int edit_branch_description(const char *branch_name)
 	read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
+	/*
+	 * NEEDSWORK: introduce a strbuf_commented_addf(), possibly
+	 * sharing code with status_vprintf(), that makes each line
+	 * commented with comment_line_char, and use it here and from
+	 * other places (e.g. write_commented_object() and create_note()
+	 * in builtin/notes.c and create_tag() in builtin/tag.c).
+	 */
 	strbuf_addf(&buf,
-		    "# Please edit the description for the branch\n"
-		    "#   %s\n"
-		    "# Lines starting with '#' will be stripped.\n",
-		    branch_name);
+		    "%c Please edit the description for the branch\n"
+		    "%c   %s\n"
+		    "%c Lines starting with '%c' will be stripped.\n",
+		    comment_line_char, comment_line_char,
+		    branch_name, comment_line_char, comment_line_char);
 	fp = fopen(git_path(edit_description), "w");
 	if ((fwrite(buf.buf, 1, buf.len, fp) < buf.len) || fclose(fp)) {
 		strbuf_release(&buf);
diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..a946a13 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -733,15 +733,16 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (cleanup_mode == CLEANUP_ALL)
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
-				" Lines starting\nwith '#' will be ignored, and an empty"
-				" message aborts the commit.\n"));
+				  " Lines starting\nwith '%c' will be ignored, and an empty"
+				  " message aborts the commit.\n"), comment_line_char);
 		else /* CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
-				_("Please enter the commit message for your changes."
-				" Lines starting\n"
-				"with '#' will be kept; you may remove them"
-				" yourself if you want to.\n"
-				"An empty message aborts the commit.\n"));
+				      _("Please enter the commit message for your changes."
+					" Lines starting\n"
+					"with '%c' will be kept; you may remove them"
+					" yourself if you want to.\n"
+					"An empty message aborts the commit.\n"),
+				      comment_line_char);
 		if (only_include_assumed)
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					"%s", only_include_assumed);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e2e27b2..2261e1f 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -463,8 +463,10 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 	}
 	strbuf_complete_line(tagbuf);
 	if (sig->len) {
+		char comment_head[3];
+		sprintf(comment_head, "%c ", comment_line_char);
 		strbuf_addch(tagbuf, '\n');
-		strbuf_add_lines(tagbuf, "# ", sig->buf, sig->len);
+		strbuf_add_lines(tagbuf, comment_head, sig->buf, sig->len);
 	}
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 3a31c4b..632d860 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -788,17 +788,24 @@ static const char merge_editor_comment[] =
 N_("Please enter a commit message to explain why this merge is necessary,\n"
    "especially if it merges an updated upstream into a topic branch.\n"
    "\n"
-   "Lines starting with '#' will be ignored, and an empty message aborts\n"
+   "Lines starting with '%c' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
-	const char *comment = _(merge_editor_comment);
+	const char *commentf = _(merge_editor_comment);
 	strbuf_addbuf(&msg, &merge_msg);
 	strbuf_addch(&msg, '\n');
-	if (0 < option_edit)
-		strbuf_add_lines(&msg, "# ", comment, strlen(comment));
+	if (0 < option_edit) {
+		struct strbuf hint = STRBUF_INIT;
+		char comment_head[3];
+
+		sprintf(comment_head, "%c ", comment_line_char);
+		strbuf_addf(&hint, commentf, comment_line_char);
+		strbuf_add_lines(&msg, comment_head, hint.buf, hint.len);
+		strbuf_release(&hint);
+	}
 	write_merge_msg(&msg);
 	if (run_hook(get_index_file(), "prepare-commit-msg",
 		     git_path("MERGE_MSG"), "merge", NULL, NULL))
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index f16986c..600ca66 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -45,7 +45,7 @@ void stripspace(struct strbuf *sb, int skip_comments)
 		eol = memchr(sb->buf + i, '\n', sb->len - i);
 		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
 
-		if (skip_comments && len && sb->buf[i] == '#') {
+		if (skip_comments && len && sb->buf[i] == comment_line_char) {
 			newlen = 0;
 			continue;
 		}
diff --git a/cache.h b/cache.h
index c257953..0b435a4 100644
--- a/cache.h
+++ b/cache.h
@@ -562,6 +562,12 @@ extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 
+/*
+ * The character that begins a commented line in user-editable file
+ * that is subject to stripspace.
+ */
+extern char comment_line_char;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/config.c b/config.c
index 7b444b6..d873c59 100644
--- a/config.c
+++ b/config.c
@@ -717,6 +717,14 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
+	if (!strcmp(var, "core.commentchar")) {
+		const char *comment;
+		int ret = git_config_string(&comment, var, value);
+		if (!ret)
+			comment_line_char = comment[0];
+		return ret;
+	}
+
 	if (!strcmp(var, "core.askpass"))
 		return git_config_string(&askpass_program, var, value);
 
diff --git a/environment.c b/environment.c
index 85edd7f..a40c38b 100644
--- a/environment.c
+++ b/environment.c
@@ -62,6 +62,12 @@ int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
 
+/*
+ * The character that begins a commented line in user-editable file
+ * that is subject to stripspace.
+ */
+char comment_line_char = '#';
+
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
 
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..f6f197e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -45,7 +45,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 
 	strbuf_vaddf(&sb, fmt, ap);
 	if (!sb.len) {
-		strbuf_addch(&sb, '#');
+		strbuf_addch(&sb, comment_line_char);
 		if (!trail)
 			strbuf_addch(&sb, ' ');
 		color_print_strbuf(s->fp, color, &sb);
@@ -59,7 +59,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 
 		strbuf_reset(&linebuf);
 		if (at_bol) {
-			strbuf_addch(&linebuf, '#');
+			strbuf_addch(&linebuf, comment_line_char);
 			if (*line != '\n' && *line != '\t')
 				strbuf_addch(&linebuf, ' ');
 		}
@@ -760,8 +760,10 @@ static void wt_status_print_tracking(struct wt_status *s)
 
 	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s),
-				 "# %.*s", (int)(ep - cp), cp);
-	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
+				 "%c %.*s", comment_line_char,
+				 (int)(ep - cp), cp);
+	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
+			 comment_line_char);
 }
 
 static int has_unmerged(struct wt_status *s)
-- 
1.8.1.351.g191b7b1
