Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23E239E9B
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641157; cv=none; b=nwZ8DTQS9WL3l94btKRkmJENCry8vwEcQpLRZR71TP8SnWFJcfGLAQYVkewz0H3zyCyWah5ZAW2oe23+wvIqH7vavjCP18fsEuvnObq/A9X1tZuZ5fUhe3YKdSfEEM0vJAorYPtGuTuPui+pAJgTUPut6YcAI+fPzA2M+3U1Bb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641157; c=relaxed/simple;
	bh=YXcoiD0s2IEQR6FvQhbRoFydF5VT2jBP1I94m1zItLA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFvLj9hMtZpdl21gVdN4I5AvZE2kBS0En/mR45gtN7GfoAK/n+57tJcymORAWTGPR97nDtEdVO8urQJ9w9ik1KcEBHRDx7CqFvHaWGx6ctygJEceKeHnyv0xag6M2IZisgrb07OJW2tt22NWk0xUrAFGIBRzoo+8PsubL0GlEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Ykm7SS2r; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Ykm7SS2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1760641154;
	bh=YXcoiD0s2IEQR6FvQhbRoFydF5VT2jBP1I94m1zItLA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=Ykm7SS2reI1MvlTZTei5LcVUucOC1lNzwGZ7yuAMG15IWn3uTkxNtmCyZvuecheIN
	 ECLtTDonoRmR0HbtqsAIF8alcLOMCEUdcCrjaKX74Fi5s/2euaexME/zCNw1Ckhjdy
	 BwZceSbVkETOr7GA8FIu6979Z/gGKmyBzbspRldY=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 88A4E1C01EF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:59:14 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: git@vger.kernel.org
Subject: [PATCH 2/3] builtin/am.c: add a message-id commit header
Date: Thu, 16 Oct 2025 14:57:57 -0400
Message-ID: <20251016185758.21996-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that mailinfo is updated to collect the message_id all the time,
use this in do_commit to add a "message-id" extra header containing
the message_id if it exists.  This means that git am will always
record the message-id if it can be found in the commit.  It will still
add it to the trailer if -m is specified, keeping the behaviour
backwards compatible.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 builtin/am.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 277c2e7937..ab05701a8d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -119,6 +119,7 @@ struct am_state {
 	char *author_name;
 	char *author_email;
 	char *author_date;
+	char *msg_id;
 	char *msg;
 	size_t msg_len;
 
@@ -187,6 +188,7 @@ static void am_state_release(struct am_state *state)
 	free(state->author_email);
 	free(state->author_date);
 	free(state->msg);
+	free(state->msg_id);
 	strvec_clear(&state->git_apply_opts);
 }
 
@@ -1313,6 +1315,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 	assert(!state->msg);
 	state->msg = strbuf_detach(&msg, &state->msg_len);
 
+	assert(!state->msg_id);
+	state->msg_id = xstrdup_or_null(mi.message_id);
+
 finish:
 	strbuf_release(&msg);
 	strbuf_release(&author_date);
@@ -1668,6 +1673,7 @@ static void do_commit(const struct am_state *state)
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
+	struct commit_extra_header *extra = NULL;
 
 	if (!state->no_verify && run_hooks(the_repository, "pre-applypatch"))
 		exit(1);
@@ -1699,9 +1705,16 @@ static void do_commit(const struct am_state *state)
 							 : state->author_date,
 				      IDENT_STRICT);
 
+	if (state->msg_id) {
+		CALLOC_ARRAY(extra, 1);
+		extra->key = xstrdup("message-id");
+		extra->value = xstrdup(state->msg_id);
+		extra->len = strlen(extra->value);
+	}
+
 	if (commit_tree_extended(state->msg, state->msg_len, &tree, parents,
 				 &commit, author, committer, state->sign_commit,
-				 NULL))
+				 extra))
 		die(_("failed to write commit object"));
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
-- 
2.51.0

