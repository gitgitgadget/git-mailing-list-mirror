Received: from mx1.ddevault.org (mx1.ddevault.org [172.233.46.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7322E54DC
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.46.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542536; cv=none; b=YNaFV+FrsuAcH5dzvOhRCyeiz9LC7rN+PVxyHhWSE+hGFLes8C54bzaz/PtGQZuIHIr1u5YyVYYKpAW1sW/KcKTotEw1wiJjZmCpHYvHlHx0rTz5+ba8Nm+NIdCfstE3LNCzoJ3JoAfw9of7rTI+RJsPk5F31GS5mk8SFjp2SUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542536; c=relaxed/simple;
	bh=JPWc5lgC6iZq1kVBg1Rq74pbUIBBy20EPzvw5VoSjFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVw+43jOh7FM7ld+O0KZ2Cr1VDOTHfquVNgy8aZb9wngC160tTbCe0oAnvBYpPiOJWoK6PpSpeqiD/5+eb+UcjBKSHUQuL7JokxQfc3uhyej22QYJIyoMkwgxY9ciHay/EZDZMoMcMLuSDubNOFk8X57eiJH8sYEPtApzycBCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=Tx4Z8E2g; arc=none smtp.client-ip=172.233.46.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="Tx4Z8E2g"
DKIM-Signature: a=rsa-sha256; bh=GdSfhMzZvlyA34exM4FA2ZIJNLG41ad8LZoZeQOlpRE=;
 c=relaxed/relaxed; d=ddevault.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@ddevault.org; s=default; t=1751542524; v=1; x=1751974524;
 b=Tx4Z8E2gc0WcggJRvCzmxCGDcwxZDjRRbbwOUEFqjxkFsMcg+RXOpHjVATPJfiLJqEjvwtjt
 kpHmS29gZiTzc+MR4gGBo5F8m9WzyHKPsgR/SEoeZvRxWYMHLCkio30qFi36HjH35Pa45NpkBJl
 qz9+7hx4Yjkpm0jSEg2fCoLWvxmF3VgfEjnrjeF4fAKdpcesD3LR/qG7iC8rIveXOzoQQu90FH5
 omEqpc7LuuexYCUjrJ1v659hxT90alB4VK1aUajAMkJz/4DQkZTwUQScweUMfBGlnkq5+tiFN5H
 LZi2nfNxCyBeO5htq1W75sTMqooGwuWRkbrPvx+xtVRbA==
Received: by mx1.ddevault.org (envelope-sender <drew@ddevault.org>) with
 ESMTPS id 66a70bab; Thu, 03 Jul 2025 11:35:24 +0000
Received: by taiga (Postfix, from userid 1000)
	id BDE4570206F2; Thu, 03 Jul 2025 13:35:24 +0200 (CEST)
From: Drew DeVault <drew@ddevault.org>
To: git@vger.kernel.org
Cc: Drew DeVault <drew@ddevault.org>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Patrick Steinhardt <ps@pks.im>,
	Andy Koppe <andy.koppe@gmail.com>,
	"Remo Senekowitsch" <remo@buenzli.dev>
Subject: [PATCH v2 2/2] am: import X-Change-ID from email headers
Date: Thu,  3 Jul 2025 13:29:53 +0200
Message-ID: <20250703113505.11889-3-drew@ddevault.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703113505.11889-1-drew@ddevault.org>
References: <20250703113505.11889-1-drew@ddevault.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing emails formatted by git-send-email which include a
change-id commit header, the change-id is written as X-Change-ID to the
mail headers. This change causes git-am to grab the X-Change-ID email
header and write it to the commit header as change-id.

This completes the loop to ensure that sending and receiving patches via
email preserves the change-id header, if present.

Signed-off-by: Drew DeVault <drew@ddevault.org>
---
I'm pretty sure I got all of the lifecycle details including --resume
correct, but I would appreciate a second set of eyes.

Also not sure how to test this one, though this time it's less because
of any fundamental limitations and has more to do with me not really
understanding the test suite design. Perfectly acceptable for reviewers
to insist on a v3 which adds the necessary tests but I will wait to
endure that headache until some more discussion lands on this proposal
in general.

 builtin/am.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 mailinfo.c   |  4 +++-
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a800003340..04cc9ef581 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -119,6 +119,7 @@ struct am_state {
 	char *author_name;
 	char *author_email;
 	char *author_date;
+	char *change_id;
 	char *msg;
 	size_t msg_len;
 
@@ -186,6 +187,7 @@ static void am_state_release(struct am_state *state)
 	free(state->author_name);
 	free(state->author_email);
 	free(state->author_date);
+	free(state->change_id);
 	free(state->msg);
 	strvec_clear(&state->git_apply_opts);
 }
@@ -408,6 +410,11 @@ static void am_load(struct am_state *state)
 
 	read_commit_msg(state);
 
+	if (read_state_file(&sb, state, "change-id", 1) != -1) {
+		assert(!state->change_id);
+		state->change_id = strbuf_detach(&sb, NULL);
+	}
+
 	if (read_state_file(&sb, state, "original-commit", 1) < 0)
 		oidclr(&state->orig_commit, the_repository->hash_algo);
 	else if (get_oid_hex(sb.buf, &state->orig_commit) < 0)
@@ -1119,11 +1126,13 @@ static void am_next(struct am_state *state)
 	FREE_AND_NULL(state->author_name);
 	FREE_AND_NULL(state->author_email);
 	FREE_AND_NULL(state->author_date);
+	FREE_AND_NULL(state->change_id);
 	FREE_AND_NULL(state->msg);
 	state->msg_len = 0;
 
 	unlink(am_path(state, "author-script"));
 	unlink(am_path(state, "final-commit"));
+	unlink(am_path(state, "change-id"));
 
 	oidclr(&state->orig_commit, the_repository->hash_algo);
 	unlink(am_path(state, "original-commit"));
@@ -1210,6 +1219,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	struct strbuf author_name = STRBUF_INIT;
 	struct strbuf author_date = STRBUF_INIT;
 	struct strbuf author_email = STRBUF_INIT;
+	struct strbuf change_id = STRBUF_INIT;
 	int ret = 0;
 	struct mailinfo mi;
 
@@ -1288,6 +1298,8 @@ static int parse_mail(struct am_state *state, const char *mail)
 			strbuf_addstr(&author_email, x);
 		else if (skip_prefix(sb.buf, "Date: ", &x))
 			strbuf_addstr(&author_date, x);
+		else if (skip_prefix(sb.buf, "X-Change-ID: ", &x))
+			strbuf_addstr(&change_id, x);
 	}
 	fclose(fp);
 
@@ -1310,6 +1322,11 @@ static int parse_mail(struct am_state *state, const char *mail)
 	assert(!state->author_date);
 	state->author_date = strbuf_detach(&author_date, NULL);
 
+	if (change_id.len) {
+		assert(!state->change_id);
+		state->change_id = strbuf_detach(&change_id, NULL);
+	}
+
 	assert(!state->msg);
 	state->msg = strbuf_detach(&msg, &state->msg_len);
 
@@ -1318,6 +1335,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	strbuf_release(&author_date);
 	strbuf_release(&author_email);
 	strbuf_release(&author_name);
+	strbuf_release(&change_id);
 	strbuf_release(&sb);
 	clear_mailinfo(&mi);
 	return ret;
@@ -1345,13 +1363,14 @@ static int get_mail_commit_oid(struct object_id *commit_id, const char *mail)
 }
 
 /**
- * Sets state->msg, state->author_name, state->author_email, state->author_date
- * to the commit's respective info.
+ * Sets state->msg, state->author_name, state->author_email, state->author_date,
+ * and state->change_id to the commit's respective info.
  */
 static void get_commit_info(struct am_state *state, struct commit *commit)
 {
-	const char *buffer, *ident_line, *msg;
+	const char *buffer, *ident_line, *change_id, *msg;
 	size_t ident_len;
+	size_t change_id_len;
 	struct ident_split id;
 
 	buffer = repo_logmsg_reencode(the_repository, commit, NULL,
@@ -1381,6 +1400,12 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	assert(!state->author_date);
 	state->author_date = xstrdup(show_ident_date(&id, DATE_MODE(NORMAL)));
 
+	change_id = find_commit_header(buffer, "change-id", &change_id_len);
+	if (change_id && change_id_len) {
+		assert(!state->change_id);
+		state->change_id = xmemdupz(change_id, change_id_len);
+	}
+
 	assert(!state->msg);
 	msg = strstr(buffer, "\n\n");
 	if (!msg)
@@ -1668,6 +1693,8 @@ static void do_commit(const struct am_state *state)
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
+	struct commit_extra_header change_id_hdr = {0};
+	struct commit_extra_header *extra = NULL;
 
 	if (!state->no_verify && run_hooks(the_repository, "pre-applypatch"))
 		exit(1);
@@ -1699,9 +1726,16 @@ static void do_commit(const struct am_state *state)
 							 : state->author_date,
 				      IDENT_STRICT);
 
+	if (state->change_id && strlen(state->change_id) != 0) {
+		change_id_hdr.key = "change-id";
+		change_id_hdr.value = state->change_id;
+		change_id_hdr.len = strlen(state->change_id);
+		extra = &change_id_hdr;
+	}
+
 	if (commit_tree_extended(state->msg, state->msg_len, &tree, parents,
 				 &commit, author, committer, state->sign_commit,
-				 NULL))
+				 extra))
 		die(_("failed to write commit object"));
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
@@ -1853,6 +1887,10 @@ static void am_run(struct am_state *state, int resume)
 
 			write_author_script(state);
 			write_commit_msg(state);
+
+			if (state->change_id)
+				write_state_text(state, "change-id",
+						 state->change_id);
 		}
 
 		if (state->interactive && do_interactive(state))
diff --git a/mailinfo.c b/mailinfo.c
index b4e815b2d8..46d68a03d6 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -351,7 +351,7 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
 }
 
 static const char * const header[] = {
-	"From", "Subject", "Date",
+	"From", "Subject", "Date", "X-Change-ID",
 };
 
 static inline int skip_header(const struct strbuf *line, const char *hdr,
@@ -1183,6 +1183,8 @@ static void handle_info(struct mailinfo *mi)
 			handle_from(mi, hdr);
 			fprintf(mi->output, "Author: %s\n", mi->name.buf);
 			fprintf(mi->output, "Email: %s\n", mi->email.buf);
+		} else if (!strcmp(header[i], "X-Change-ID")) {
+			output_header_lines(mi->output, "X-Change-ID", hdr);
 		} else {
 			cleanup_space(hdr);
 			fprintf(mi->output, "%s: %s\n", header[i], hdr->buf);
-- 
2.50.0

