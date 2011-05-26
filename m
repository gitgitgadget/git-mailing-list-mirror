From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/10] revert: Eliminate global "commit" variable
Date: Thu, 26 May 2011 15:53:46 +0000
Message-ID: <1306425233-504-4-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 17:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPctQ-0001ZT-V2
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810Ab1EZPyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:54:06 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62865 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757113Ab1EZPyC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:54:02 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so441172qwk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=0xXgi/Pz/K66uvwbpu1q10U0AlrWUMe/vcmilPnCzMw=;
        b=LetcWBy3rOGzxbXQcsmSat+bG+/hVy94LtBQ2Vo6RVBIHDwr6LtzjGyrA2pcvHiImS
         3+wHdzkz8/0LduY/8/pqGOZwbqogWTegXhARz+4MTzKC8QreN41Mj3WHY9+7zmhJgilF
         yXuiPZCeHbHv04t2YozzEMC+1qaKGDyGEhFMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vs0ZvhzqJ+j0FXVs9hp2nAH70Sop23UdBsDeP42ykyNxeBswvfGpklACgwe1X5W1L2
         vM29dB3pvRISCzm2u6gjkDncX/yMRJuUoQa46t95Isas07ZxuSkT/G3fSiWFm6ueGEnk
         iC1WftRR5sWZO/Y9BawL8NXPeHBhCdEotcYbw=
Received: by 10.224.31.80 with SMTP id x16mr752010qac.73.1306425242114;
        Thu, 26 May 2011 08:54:02 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id j18sm513435qck.27.2011.05.26.08.54.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 08:54:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306425233-504-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174534>

Since we want to develop the functionality to either pick or revert
individual commits atomically later in the series, make "commit" a
local variable.  Modify the get_message API to take "commit" as an
argument, factor out add_message_to_msg, and don't check the sole
argument in get_encoding.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   47 ++++++++++++++++++-----------------------------
 1 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ff26856..745295d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -37,7 +37,6 @@ static const char * const cherry_pick_usage[] = {
 
 static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
-static struct commit *commit;
 static int commit_argc;
 static const char **commit_argv;
 static int allow_rerere_auto;
@@ -116,25 +115,25 @@ struct commit_message {
 	const char *message;
 };
 
-static int get_message(const char *raw_message, struct commit_message *out)
+static int get_message(struct commit *commit, struct commit_message *out)
 {
 	const char *encoding;
 	const char *abbrev, *subject;
 	int abbrev_len, subject_len;
 	char *q;
 
-	if (!raw_message)
+	if (!commit->buffer)
 		return -1;
-	encoding = get_encoding(raw_message);
+	encoding = get_encoding(commit->buffer);
 	if (!encoding)
 		encoding = "UTF-8";
 	if (!git_commit_encoding)
 		git_commit_encoding = "UTF-8";
 
 	out->reencoded_message = NULL;
-	out->message = raw_message;
+	out->message = commit->buffer;
 	if (strcmp(encoding, git_commit_encoding))
-		out->reencoded_message = reencode_string(raw_message,
+		out->reencoded_message = reencode_string(commit->buffer,
 					git_commit_encoding, encoding);
 	if (out->reencoded_message)
 		out->message = out->reencoded_message;
@@ -167,9 +166,6 @@ static char *get_encoding(const char *message)
 {
 	const char *p = message, *eol;
 
-	if (!p)
-		die (_("Could not read commit message of %s"),
-				sha1_to_hex(commit->object.sha1));
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
@@ -185,25 +181,12 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
-{
-	const char *p = message;
-	while (*p && (*p != '\n' || p[1] != '\n'))
-		p++;
-
-	if (!*p)
-		strbuf_addstr(msgbuf, sha1_to_hex(commit->object.sha1));
-
-	p += 2;
-	strbuf_addstr(msgbuf, p);
-}
-
-static void write_cherry_pick_head(void)
+static void write_cherry_pick_head(const char *commit_sha1_hex)
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
+	strbuf_addf(&buf, "%s\n", commit_sha1_hex);
 
 	fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
@@ -370,7 +353,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(void)
+static int do_pick_commit(struct commit *commit)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -434,7 +417,7 @@ static int do_pick_commit(void)
 		return error(_("%s: cannot parse parent commit %s"),
 			me, sha1_to_hex(parent->object.sha1));
 
-	if (get_message(commit->buffer, &msg) != 0)
+	if (get_message(commit, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
 			sha1_to_hex(commit->object.sha1));
 
@@ -467,14 +450,19 @@ static int do_pick_commit(void)
 		base_label = msg.parent_label;
 		next = commit;
 		next_label = msg.label;
-		add_message_to_msg(&msgbuf, msg.message);
+
+		/* Add msg.message to msgbuf */
+		const char *p = strstr(msg.message, "\n\n");
+		p = p ? p + 2 : sha1_to_hex(commit->object.sha1);
+		strbuf_addstr(&msgbuf, p);
+
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 		if (!no_commit)
-			write_cherry_pick_head();
+			write_cherry_pick_head(sha1_to_hex(commit->object.sha1));
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
@@ -552,6 +540,7 @@ static void read_and_refresh_cache(const char *me)
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	struct rev_info revs;
+	struct commit *commit;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -574,7 +563,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	prepare_revs(&revs);
 
 	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit();
+		int res = do_pick_commit(commit);
 		if (res)
 			return res;
 	}
-- 
1.7.5.GIT
