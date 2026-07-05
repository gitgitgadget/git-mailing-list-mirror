Received: from mail-108-mta32.mxroute.com (mail-108-mta32.mxroute.com [136.175.108.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4993596E1
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260929; cv=none; b=O7vsj1Udkvt++HBoTstOZv7QdxjMgYRlgAZX1MFFi3o1tNk0cgepDEcgdMsSNRhuR5q+MfssQUfRKL93pkM0BkInxOJTzUYlDQ8n7v/P9jexRSB0dc/6/M4/KpnxM6Sb5SJx7ynJ+Pfqiq6FAa5p1B6DDmlocsEmTP0nRLv+dVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260929; c=relaxed/simple;
	bh=2B7wAaI+ab03ekj9cnCO43x17p84/29VV6u8w1fN528=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ltswaPzVjpujp93tm1x7+iCOrYwZV+48mFMUOF67nDZx7MfeU42dJ0jo8vz4/zJOoLHDCYWcvPnNcYR0X7EYfgoxKHxDozF3JUnAMADSISmX25AV56mIamjLwKY/gogN3bFE/jMNtfuGq562WOPpj4rQDfhMSAlt7pIXBrkFuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trevorgross.com; spf=pass smtp.mailfrom=trevorgross.com; dkim=pass (2048-bit key) header.d=trevorgross.com header.i=@trevorgross.com header.b=rZzzg5fB; arc=none smtp.client-ip=136.175.108.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trevorgross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trevorgross.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trevorgross.com header.i=@trevorgross.com header.b="rZzzg5fB"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta32.mxroute.com (ZoneMTA) with ESMTPSA id 19f329d937700067f7.006
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 05 Jul 2026 14:10:15 +0000
X-Zone-Loop: e3be293e1aa4c1d5cad183394f27b7f6f240b96e59e8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=trevorgross.com; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7Y1NVMKx2NF/GfWLGkOjJBv2FJc0woOEk0NQHJ02J1U=; b=rZzzg5fBxi4VwkG2hykJOQVALr
	7OfW4UsBaDRWH9khousawevXJOPzxV8yt5eJEiNwTjbYVybuIF5wj7XkWBckUk03fA/kcZMgSxl1S
	WLepRbxVtPV+LKgFwZ9hOnOAN5EaTpeyzlW/bY9KQqwftppjfgU5K/avyfjXuTIY4r55YGuzBd4vD
	ue+5b0gC01J+PXi2pw8V9+x7nRMOrD7C/aZ3aFE30L2UR38cV5xn/sOqM6ES/2Idr8kK4ZTG56Rg1
	uODeCaQUVs98Z9SKwcoCFzy7G24FQnj1IJnOICDmu91WNGVLL6uK4k099oakI8ehFZds4VNJJP9it
	+f60NQ4g==;
From: Trevor Gross <tg@trevorgross.com>
To: git@vger.kernel.org
Cc: Trevor Gross <tg@trevorgross.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Haller <lists@haller-berlin.de>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] rebase -i: introduce `pick -x` to add "cherry picked from commit ..."
Date: Sun,  5 Jul 2026 14:09:06 +0000
Message-ID: <20260705140931.98262-2-tg@trevorgross.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: tg@trevorgross.com

It is sometimes useful to do cherry picks via rebases when there is a
sequence of picks or other git operations to combine. However, there is
no interactive rebase equivalent to the cherry-pick `-x` flag, which
adds a line to the commit body indicating the original commit.

Using `exec git cherry-pick ... -x` does work, but is not as nice
because it interrupts rebase flow; after resolving a conflict, both `git
cherry-pick --continue` and `git rebase --continue` must be run.

To improve this, introduce `-x` to the pick, reword, and edit todo
rebase commands.  This uses the same logic as cherry-pick to add a
"(cherry picked from commit ...)" note to the commit body.

Of note is that rebase will fastforward wherever possible, meaning the
check for TODO_RECORD_ORIGIN doesn't get hit and the message will not
get amended. This differs from the cherry-pick logic, which will add
"cherry picked from ..." even if a rewrite isn't otherwise necessary.

Signed-off-by: Trevor Gross <tg@trevorgross.com>
---

Link to PR with the CI runs: https://github.com/git/git/pull/2194

 Documentation/git-rebase.adoc | 16 +++++++++++++
 rebase-interactive.c          |  9 +++++---
 sequencer.c                   | 19 ++++++++++++++--
 t/t3404-rebase-interactive.sh | 42 +++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..d8a8e2c2d6 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -978,6 +978,22 @@ pick f4593f9 four
 exec make test
 --------------------

+Similar to `git cherry-pick`, `-x` can be specified to append a "(cherry
+picked from commit …​)" line to the commit body if the the commit base
+changes. That is, the following todo list:
+
+--------------
+pick 123456 -x
+edit 654321 -x
+--------------
+
+acts the same as:
+
+---------------------------
+$ git cherry-pick -x 123456
+$ git cherry-pick -xe 654321
+---------------------------
+
 SPLITTING COMMITS
 -----------------

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 809f76a87b..6a86ab5a94 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -47,9 +47,9 @@ void append_todo_help(int command_count,
 		      struct strbuf *buf)
 {
 	const char *msg = _("\nCommands:\n"
-"p, pick <commit> = use commit\n"
-"r, reword <commit> = use commit, but edit the commit message\n"
-"e, edit <commit> = use commit, but stop for amending\n"
+"p, pick   [ -x ] <commit> = use commit\n"
+"r, reword [ -x ] <commit> = use commit, but edit the commit message\n"
+"e, edit   [ -x ] <commit> = use commit, but stop for amending\n"
 "s, squash <commit> = use commit, but meld into previous commit\n"
 "f, fixup [-C | -c] <commit> = like \"squash\" but keep only the previous\n"
 "                   commit's log message, unless -C is used, in which case\n"
@@ -68,6 +68,9 @@ void append_todo_help(int command_count,
 "                      to this position in the new commits. The <ref> is\n"
 "                      updated at the end of the rebase\n"
 "\n"
+"With pick, reword, or edit, -x will append a line that says \"(cherry\n"
+"picked from commit <sha>)\", similar to git-cherry-pick."
+"\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);

diff --git a/sequencer.c b/sequencer.c
index 57855b0066..fde09dd77d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1884,6 +1884,7 @@ enum todo_item_flags {
 	TODO_EDIT_MERGE_MSG    = (1 << 0),
 	TODO_REPLACE_FIXUP_MSG = (1 << 1),
 	TODO_EDIT_FIXUP_MSG    = (1 << 2),
+	TODO_RECORD_ORIGIN     = (1 << 3),
 };

 static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
@@ -2390,7 +2391,7 @@ static int do_pick_commit(struct repository *r,
 		if (find_commit_subject(msg.message, &p))
 			strbuf_addstr(&ctx->message, p);

-		if (opts->record_origin) {
+		if (opts->record_origin || (item->flags & TODO_RECORD_ORIGIN)) {
 			strbuf_complete_line(&ctx->message);
 			if (!has_conforming_footer(&ctx->message, NULL, 0))
 				strbuf_addch(&ctx->message, '\n');
@@ -2758,6 +2759,14 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts,
 		return error(_("missing arguments for %s"),
 			     command_to_string(item->command));

+	if (item->command == TODO_PICK || item->command == TODO_REWORD ||
+	    item->command == TODO_EDIT) {
+		if (skip_prefix(bol, "-x", &bol)) {
+			bol += strspn(bol, " \t");
+			item->flags |= TODO_RECORD_ORIGIN;
+		}
+	}
+
 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
 	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
 		int ret = 0;
@@ -5524,7 +5533,7 @@ static int single_pick(struct repository *r,
 		       struct replay_opts *opts)
 {
 	int check_todo;
-	struct todo_item item;
+	struct todo_item item = { 0 };

 	item.command = opts->action == REPLAY_PICK ?
 			TODO_PICK : TODO_REVERT;
@@ -6340,6 +6349,12 @@ static void todo_list_to_strbuf(struct repository *r,
 					  short_commit_name(r, item->commit) :
 					  oid_to_hex(&item->commit->object.oid);

+			if (item->command == TODO_PICK || item->command == TODO_EDIT ||
+			    item->command == TODO_REWORD) {
+				if (item->flags & TODO_RECORD_ORIGIN)
+					strbuf_addstr(buf, " -x");
+			}
+
 			if (item->command == TODO_FIXUP) {
 				if (item->flags & TODO_EDIT_FIXUP_MSG)
 					strbuf_addstr(buf, " -c");
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 58b3bb0c27..3ff86ebaae 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2337,6 +2337,48 @@ test_expect_success 'non-merge commands reject merge commits' '
 	test_cmp expect actual
 '

+
+test_expect_success 'rebase -i with pick -x' '
+	git checkout A &&
+	orig_j="$(git rev-parse J)" &&
+	orig_k="$(git rev-parse K)" &&
+	orig_l="$(git rev-parse L)" &&
+	cat >fake-todo <<-EOF &&
+	# No message since this is a fastforward
+	pick -x F
+	# The rest should get the "cherry picked from " message
+	pick -x J
+	reword -x K
+	edit -x L
+	EOF
+	(
+		set_replace_editor fake-todo &&
+		git rebase -i HEAD
+	) &&
+	git log --format="---%n%s%n%b" >actual &&
+	cat >expect <<-EOF &&
+	---
+	L
+	(cherry picked from commit $orig_l)
+
+	---
+	K
+	(cherry picked from commit $orig_k)
+
+	---
+	J
+	(cherry picked from commit $orig_j)
+
+	---
+	F
+
+	---
+	A
+
+	EOF
+	test_cmp expect actual
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
--
2.50.1 (Apple Git-155)
