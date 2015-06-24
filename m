From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship
 with git-mailinfo
Date: Wed, 24 Jun 2015 15:54:46 +0800
Message-ID: <20150624075446.GA1964@yoshi.chippynet.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
 <1434626743-8552-8-git-send-email-pyokagan@gmail.com>
 <xmqqtwu4d8pg.fsf@gitster.dls.corp.google.com>
 <CACRoPnS9eyBF5NEM7sKvep+A8aKUNLJDaV-1c_oWDBwMcv26Bg@mail.gmail.com>
 <xmqq1th7brsj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 09:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7fWa-0006Ue-LE
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 09:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbbFXHzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 03:55:08 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32860 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbFXHyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 03:54:54 -0400
Received: by padev16 with SMTP id ev16so24151805pad.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cMmff406vibmcQmKedZm20dkyw2EzJjZyOTxE9BBYp0=;
        b=EcVEpTzOGjTadMusYT8/Z+vz1ybffUMpKfGl/a8wPUzmGQgrnKTHW9CE3NuYg0ohFc
         Jj42liMw+LfcDKE7Wy8zGw60JLjtXf6hJHjfmtxur254iik3MFt2nhh4db3QhcNzSN55
         uewH5n49jtSHQQV+ekrl+B/NQMXjFAG0ccHs8F5mMEFRsKtNNJT8e41f8sCKhgQWtpVv
         Stl0TOMGD0jEYyKvJaFgi6K/GwzRUK+0UD0PVbtMtCqmYzEwezAMYL+Ez5K5HXOHYFug
         blp3og6r0yI5/HjjP91YovfIg0EMefWdp7oe0OjtKgswCz01WqZacfwdJHUl/02A24am
         bklg==
X-Received: by 10.68.225.42 with SMTP id rh10mr78313447pbc.158.1435132493959;
        Wed, 24 Jun 2015 00:54:53 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.132.138])
        by mx.google.com with ESMTPSA id bn5sm25654591pbc.82.2015.06.24.00.54.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2015 00:54:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq1th7brsj.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272537>

Okay, let's focus only on the API design issues.

For the record, I'm not completely satisfied with the current code
organization and API, however I don't have really good ideas at hand to
improve it, so any ideas with examples would be appreciated.

On Fri, Jun 19, 2015 at 09:13:00AM -0700, Junio C Hamano wrote:
> Paul Tan <pyokagan@gmail.com> writes:
> With the above fields, it is clear that the above fields are
> per-message thing.  So the loop to process multiple messages is
> conceptually:
> 
> 
> 	set up the entire am_state (for things like cur=1, last=N)
>         for each message {
> 		update per-message fields like cur, author, msg, etc.
> 		process the single message
>                 clean up per-message fileds like cur++, free(msg), etc.
> 	}
> 	tear down the entire am_state
> 
> Reusing the same strbuf and rely on them to clean up after
> themselves is simply a bad taste.

Hmm, reading "reusing the same strbuf" makes me wonder if I'm
misunderstanding something. Do you mean that:

1. We should release the memory in state->msg, state->author_* after
   processing each message? Because that is what am_next() already does.
   Granted, it does strbuf_reset(), but it could just as well be
   strbuf_release().

or

2. The per-message fields (state->msg, state->author_*) should become
   local variables in am_run()?

or

3. I'm over-thinking this and you just want the "struct strbufs" in the
   struct am_state to be switched to "char*"s? If that is so, I've
   attached a sample patch below.

For (2), my idea is that am_state represents the contents of the state
directory at any point in time -- a design feature carried over from
git-am.sh.  This is why parse_patch() modifies the am_state struct
directly -- the "msg" and "author_*" fields would be written to the
"final-commit" and "author-script" files directly after.

I think it would be confusing if we don't update the am_state struct
directly, as we will never know if the "am_state struct" contains the
actual current state of the patch application session.

(On a somewhat related thought, currently we do write_file() all over
the place, which is really ugly. I'm leaning heavily on introducing an
am_save() function, for "I don't care how it is done but just update the
contents of the am state directory so that it matches the contents of
the struct am_state". To save pointless writes, we can compare the
am_state with the last-written/loaded am_state, so we only write the
files that have changed. What do others think?)

> More importantly, we'd want to make sure that people who will be
> touching the "process the single message" part in the above loop to
> think twice before mucking with read-only fields like author.

Okay, I understand and agree with your reasoning.

However, note that this "process the single message" part consists
solely of run_apply() and do_commit(). Both of them take a
"const struct am_state*", which means that the compiler will warn/fail
if anybody tries to touch any of the fields in the am_state. This
extends to strbufs as well.  Isn't this already safe enough? Or do you
want this safety to extend throughout am_run() as well?

> If they are "char *", they would need to allocate new storage
> themselves, format a new value into there, free the original, and
> replace the field with the new value.  It takes a conscious effort
> and very much visible code and would be clear to reviewers what is
> going on, and gives them a chance to question if it is a good idea
> to update things in-place in the first place.

Okay, although personally I think reviewers may tend to miss out that a
single line like:

    state->msg = strbuf_detach(&sb, NULL);

introduces a memory leak.

> If you left it in strbuf, that invites "let's extend it temporarily
> with strbuf_add() and then return to the original once I am done
> with this single step", which is an entry to a slippery slope to
> "let's extend it with strbuf_add() for my purpose, and I do not even
> bother to clean up because I know I am the last person to touch
> this".
> 
> So, no, please don't leave a field that won't change during the bulk
> of the processing in strbuf, unless you have a compelling reason to
> do so (and "compelling reasons" are pretty much limited to "after
> all, that field we originally thought it won't change is something
> we need to change very often").

Anyway, assuming that you just want the strbufs in the am_state struct
to be switched to "char*"s, here's a quick diff of the result. Can I
confirm that this is the direction that you want to take? (since the
changes are throughout the entire patch series)

Regards,
Paul

--- >8 ---
 builtin/am.c | 202 ++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 131 insertions(+), 71 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f55dd14..944e35a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -98,10 +98,10 @@ struct am_state {
 	int last;
 
 	/* commit message and metadata */
-	struct strbuf author_name;
-	struct strbuf author_email;
-	struct strbuf author_date;
-	struct strbuf msg;
+	char *author_name;
+	char *author_email;
+	char *author_date;
+	char *msg;
 
 	/* number of digits in patch filename */
 	int prec;
@@ -148,10 +148,10 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	state->dir = xstrdup_or_null(dir);
 
-	strbuf_init(&state->author_name, 0);
-	strbuf_init(&state->author_email, 0);
-	strbuf_init(&state->author_date, 0);
-	strbuf_init(&state->msg, 0);
+	state->author_name = NULL;
+	state->author_email = NULL;
+	state->author_date = NULL;
+	state->msg = NULL;
 
 	state->prec = 4;
 
@@ -177,10 +177,17 @@ static void am_state_release(struct am_state *state)
 	if (state->dir)
 		free(state->dir);
 
-	strbuf_release(&state->author_name);
-	strbuf_release(&state->author_email);
-	strbuf_release(&state->author_date);
-	strbuf_release(&state->msg);
+	if (state->author_name)
+		free(state->author_name);
+
+	if (state->author_email)
+		free(state->author_email);
+
+	if (state->author_date)
+		free(state->author_date);
+
+	if (state->msg)
+		free(state->msg);
 
 	argv_array_clear(&state->git_apply_opts);
 }
@@ -250,37 +257,32 @@ static int read_state_file(struct strbuf *sb, const char *file, size_t hint, int
 }
 
 /**
- * Reads a KEY=VALUE shell variable assignment from fp, and returns the VALUE
- * in `value`. VALUE must be a quoted string, and the KEY must match `key`.
- * Returns 0 on success, -1 on failure.
+ * Reads a KEY=VALUE shell variable assignment from fp, returning the VALUE as
+ * a newly-allocated string. VALUE must be a quoted string, and the KEY must
+ * match `key`. Returns NULL on failure.
  *
  * This is used by read_author_script() to read the GIT_AUTHOR_* variables from
  * the author-script.
  */
-static int read_shell_var(struct strbuf *value, FILE *fp, const char *key)
+static char *read_shell_var(FILE *fp, const char *key)
 {
 	struct strbuf sb = STRBUF_INIT;
 	char *str;
 
 	if (strbuf_getline(&sb, fp, '\n'))
-		return -1;
+		return NULL;
 
 	if (!skip_prefix(sb.buf, key, (const char **)&str))
-		return -1;
+		return NULL;
 
 	if (!skip_prefix(str, "=", (const char **)&str))
-		return -1;
+		return NULL;
 
 	str = sq_dequote(str);
 	if (!str)
-		return -1;
-
-	strbuf_reset(value);
-	strbuf_addstr(value, str);
+		return NULL;
 
-	strbuf_release(&sb);
-
-	return 0;
+	return strbuf_detach(&sb, NULL);
 }
 
 /**
@@ -307,13 +309,25 @@ static int read_author_script(struct am_state *state)
 		die_errno(_("could not open '%s' for reading"), filename);
 	}
 
-	if (read_shell_var(&state->author_name, fp, "GIT_AUTHOR_NAME"))
+	if (state->author_name)
+		free(state->author_name);
+
+	state->author_name = read_shell_var(fp, "GIT_AUTHOR_NAME");
+	if (!state->author_name)
 		return -1;
 
-	if (read_shell_var(&state->author_email, fp, "GIT_AUTHOR_EMAIL"))
+	if (state->author_email)
+		free(state->author_email);
+
+	state->author_email = read_shell_var(fp, "GIT_AUTHOR_EMAIL");
+	if (!state->author_email)
 		return -1;
 
-	if (read_shell_var(&state->author_date, fp, "GIT_AUTHOR_DATE"))
+	if (state->author_date)
+		free(state->author_date);
+
+	state->author_date = read_shell_var(fp, "GIT_AUTHOR_DATE");
+	if (!state->author_date)
 		return -1;
 
 	if (fgetc(fp) != EOF)
@@ -336,9 +350,9 @@ static void write_author_script(const struct am_state *state)
 	struct strbuf author_email = STRBUF_INIT;
 	struct strbuf author_date = STRBUF_INIT;
 
-	sq_quote_buf(&author_name, state->author_name.buf);
-	sq_quote_buf(&author_email, state->author_email.buf);
-	sq_quote_buf(&author_date, state->author_date.buf);
+	sq_quote_buf(&author_name, state->author_name);
+	sq_quote_buf(&author_email, state->author_email);
+	sq_quote_buf(&author_date, state->author_date);
 
 	write_file(am_path(state, "author-script"), 1, fmt,
 			author_name.buf, author_email.buf, author_date.buf);
@@ -364,7 +378,10 @@ static void am_load(struct am_state *state)
 	if (read_author_script(state) < 0)
 		die(_("could not parse author script"));
 
-	read_state_file(&state->msg, am_path(state, "final-commit"), 0, 0);
+	read_state_file(&sb, am_path(state, "final-commit"), 0, 0);
+	if (state->msg)
+		free(state->msg);
+	state->msg = strbuf_detach(&sb, NULL);
 
 	read_state_file(&sb, am_path(state, "threeway"), 2, 1);
 	state->threeway = !strcmp(sb.buf, "t");
@@ -670,12 +687,24 @@ static void am_next(struct am_state *state)
 	state->cur++;
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 
-	strbuf_reset(&state->author_name);
-	strbuf_reset(&state->author_email);
-	strbuf_reset(&state->author_date);
+	if (state->author_name)
+		free(state->author_name);
+	state->author_name = NULL;
+
+	if (state->author_email)
+		free(state->author_email);
+	state->author_email = NULL;
+
+	if (state->author_date)
+		free(state->author_date);
+	state->author_date = NULL;
+
 	unlink(am_path(state, "author-script"));
 
-	strbuf_reset(&state->msg);
+	if (state->msg)
+		free(state->msg);
+	state->msg = NULL;
+
 	unlink(am_path(state, "final-commit"));
 
 	if (!get_sha1("HEAD", head))
@@ -762,6 +791,10 @@ static int parse_patch(struct am_state *state, const char *patch)
 	FILE *fp;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf author_name = STRBUF_INIT;
+	struct strbuf author_date = STRBUF_INIT;
+	struct strbuf author_email = STRBUF_INIT;
 
 	cp.git_cmd = 1;
 	cp.in = xopen(patch, O_RDONLY, 0);
@@ -813,20 +846,32 @@ static int parse_patch(struct am_state *state, const char *patch)
 		const char *x;
 
 		if (skip_prefix(sb.buf, "Subject: ", &x)) {
-			if (state->msg.len)
-				strbuf_addch(&state->msg, '\n');
-			strbuf_addstr(&state->msg, x);
+			if (msg.len)
+				strbuf_addch(&msg, '\n');
+			strbuf_addstr(&msg, x);
 		} else if (skip_prefix(sb.buf, "Author: ", &x))
-			strbuf_addstr(&state->author_name, x);
+			strbuf_addstr(&author_name, x);
 		else if (skip_prefix(sb.buf, "Email: ", &x))
-			strbuf_addstr(&state->author_email, x);
+			strbuf_addstr(&author_email, x);
 		else if (skip_prefix(sb.buf, "Date: ", &x))
-			strbuf_addstr(&state->author_date, x);
+			strbuf_addstr(&author_date, x);
 	}
 	fclose(fp);
 
+	if (state->author_name)
+		free(state->author_name);
+	state->author_name = strbuf_detach(&author_name, NULL);
+
+	if (state->author_email)
+		free(state->author_email);
+	state->author_email = strbuf_detach(&author_email, NULL);
+
+	if (state->author_date)
+		free(state->author_date);
+	state->author_date = strbuf_detach(&author_date, NULL);
+
 	/* Skip pine's internal folder data */
-	if (!strcmp(state->author_name.buf, "Mail System Internal Data"))
+	if (!strcmp(state->author_name, "Mail System Internal Data"))
 		return 1;
 
 	if (is_empty_file(am_path(state, "patch")))
@@ -834,13 +879,17 @@ static int parse_patch(struct am_state *state, const char *patch)
 		"If you would prefer to skip this patch, instead run \"git am --skip\".\n"
 		"To restore the original branch and stop patching run \"git am --abort\"."));
 
-	strbuf_addstr(&state->msg, "\n\n");
-	if (strbuf_read_file(&state->msg, am_path(state, "msg"), 0) < 0)
+	strbuf_addstr(&msg, "\n\n");
+	if (strbuf_read_file(&msg, am_path(state, "msg"), 0) < 0)
 		die_errno(_("could not read '%s'"), am_path(state, "msg"));
-	stripspace(&state->msg, 0);
+	stripspace(&msg, 0);
 
 	if (state->sign)
-		append_signoff(&state->msg, 0, 0);
+		append_signoff(&msg, 0, 0);
+
+	if (state->msg)
+		free(state->msg);
+	state->msg = strbuf_detach(&msg, NULL);
 
 	return 0;
 }
@@ -876,6 +925,9 @@ static int get_patch_commit_sha1(unsigned char *commit_id, const char *patch)
 static void get_commit_info(struct am_state *state, struct commit *commit)
 {
 	const char *buf, *begin, *end;
+	struct strbuf author_name = STRBUF_INIT;
+	struct strbuf author_email = STRBUF_INIT;
+	struct strbuf author_date = STRBUF_INIT;
 
 	buf = logmsg_reencode(commit, NULL, get_commit_output_encoding());
 	begin = end = buf;
@@ -895,24 +947,36 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 			}
 
 			if (split.name_begin)
-				strbuf_add(&state->author_name,
-					split.name_begin,
+				strbuf_add(&author_name, split.name_begin,
 					split.name_end - split.name_begin);
 
 			if (split.mail_begin)
-				strbuf_add(&state->author_email,
-					split.mail_begin,
+				strbuf_add(&author_email, split.mail_begin,
 					split.mail_end - split.mail_begin);
 
 			date = show_ident_date(&split, DATE_NORMAL);
-			strbuf_addstr(&state->author_date, date);
+			strbuf_addstr(&author_date, date);
 		} else if (begin == end) {
 			end++;
 			break;
 		}
 	}
 
-	strbuf_addstr(&state->msg, end);
+	if (state->author_name)
+		free(state->author_name);
+	state->author_name = strbuf_detach(&author_name, NULL);
+
+	if (state->author_email)
+		free(state->author_email);
+	state->author_email = strbuf_detach(&author_email, NULL);
+
+	if (state->author_date)
+		free(state->author_date);
+	state->author_date = strbuf_detach(&author_date, NULL);
+
+	if (state->msg)
+		free(state->msg);
+	state->msg = xstrdup(end);
 }
 
 /**
@@ -1107,7 +1171,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	init_merge_options(&o);
 
 	o.branch1 = "HEAD";
-	his_tree_name = xstrfmt("%.*s", linelen(state->msg.buf), state->msg.buf);
+	his_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 	o.branch2 = his_tree_name;
 
 	if (state->quiet)
@@ -1147,15 +1211,15 @@ static void do_commit(const struct am_state *state)
 		say(state, stderr, _("applying to an empty history"));
 	}
 
-	author = fmt_ident(state->author_name.buf, state->author_email.buf,
-			state->ignore_date ? NULL : state->author_date.buf,
+	author = fmt_ident(state->author_name, state->author_email,
+			state->ignore_date ? NULL : state->author_date,
 			IDENT_STRICT);
 
 	if (state->committer_date_is_author_date)
 		setenv("GIT_COMMITTER_DATE",
-			state->ignore_date ? "" : state->author_date.buf, 1);
+			state->ignore_date ? "" : state->author_date, 1);
 
-	if (commit_tree(state->msg.buf, state->msg.len, tree, parents, commit,
+	if (commit_tree(state->msg, strlen(state->msg), tree, parents, commit,
 				author, state->sign_commit))
 		die(_("failed to write commit object"));
 
@@ -1163,8 +1227,8 @@ static void do_commit(const struct am_state *state)
 	if (!reflog_msg)
 		reflog_msg = "am";
 
-	strbuf_addf(&sb, "%s: %.*s", reflog_msg, linelen(state->msg.buf),
-			state->msg.buf);
+	strbuf_addf(&sb, "%s: %.*s", reflog_msg, linelen(state->msg),
+			state->msg);
 
 	update_ref(sb.buf, "HEAD", commit, ptr, 0, UPDATE_REFS_DIE_ON_ERR);
 
@@ -1191,7 +1255,7 @@ static void am_run(struct am_state *state)
 	strbuf_release(&sb);
 
 	while (state->cur <= state->last) {
-		const char *patch, *msg;
+		const char *patch;
 		int apply_status, skip;
 
 		patch = am_path(state, msgnum(state));
@@ -1208,10 +1272,10 @@ static void am_run(struct am_state *state)
 			goto next; /* patch should be skipped */
 
 		write_author_script(state);
-		write_file(am_path(state, "final-commit"), 1, "%s", state->msg.buf);
+		write_file(am_path(state, "final-commit"), 1, "%s", state->msg);
 
-		msg = state->msg.buf;
-		say(state, stdout, _("Applying: %.*s"), linelen(msg), msg);
+		say(state, stdout, _("Applying: %.*s"), linelen(state->msg),
+			state->msg);
 
 		apply_status = run_apply(state, NULL);
 
@@ -1235,9 +1299,8 @@ static void am_run(struct am_state *state)
 		if (apply_status) {
 			int advice_amworkdir = 1;
 
-			msg = state->msg.buf;
 			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
-					linelen(msg), msg);
+				linelen(state->msg), state->msg);
 
 			git_config_get_bool("advice.amworkdir", &advice_amworkdir);
 
@@ -1267,10 +1330,7 @@ next:
  */
 static void am_resolve(struct am_state *state)
 {
-	const char *msg;
-
-	msg = state->msg.buf;
-	say(state, stdout, _("Applying: %.*s"), linelen(msg), msg);
+	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 	if (!index_has_changes(NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
