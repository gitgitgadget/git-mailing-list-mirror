From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/18] revert: Eliminate global "commit" variable
Date: Mon,  1 Aug 2011 23:36:53 +0530
Message-ID: <1312222025-28453-7-git-send-email-artagnon@gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:11:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwxj-0003sI-Cq
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab1HASLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:11:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42801 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab1HASL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:11:29 -0400
Received: by ywn13 with SMTP id 13so873232ywn.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Hx0ZpUNsZ/+LxpiowbMjHsER2uQ4c9nEcBwzYZYAKvg=;
        b=RL6y++mwW6SpqNz9F2DguZRtlKEgr+uU3dPdn0dcmPaKNG/dMUBFEc0/k+4IwUJHzS
         jS68lbh8QTMF/vXvK98+QV/cf6Lx3pS1H8EH0XBtrujFUM4NxKpXl1c8uoqK+g3N4ZFg
         ZMR2sne6tHzH69fGrIZox7z44e6+VSXki/dR8=
Received: by 10.142.74.16 with SMTP id w16mr412342wfa.225.1312222288533;
        Mon, 01 Aug 2011 11:11:28 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.11.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:11:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178378>

Functions which act on commits currently rely on a file-scope static
variable to be set before they're called.  Consequently, the API and
corresponding callsites are ugly and unclear.  Remove this variable
and change their API to accept the commit to act on as additional
argument so that the callsites change from looking like

  commit = prepare_a_commit();
  act_on_commit();

to looking like

  commit = prepare_a_commit();
  act_on_commit(commit);

This change is also in line with our long-term goal of exposing some
of these functions through a public API.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 794c050..d6c9f1d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -37,7 +37,6 @@ static const char * const cherry_pick_usage[] = {
 
 static int edit, record_origin, no_commit, mainline, signoff, allow_ff;
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
@@ -182,7 +181,7 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static void write_cherry_pick_head(void)
+static void write_cherry_pick_head(struct commit *commit)
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
@@ -355,7 +354,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(void)
+static int do_pick_commit(struct commit *commit)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -417,7 +416,7 @@ static int do_pick_commit(void)
 		die(_("%s: cannot parse parent commit %s"),
 		    me, sha1_to_hex(parent->object.sha1));
 
-	if (get_message(commit->buffer, &msg) != 0)
+	if (get_message(commit, &msg) != 0)
 		die(_("Cannot get commit message for %s"),
 				sha1_to_hex(commit->object.sha1));
 
@@ -470,7 +469,7 @@ static int do_pick_commit(void)
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 		if (!no_commit)
-			write_cherry_pick_head();
+			write_cherry_pick_head(commit);
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
@@ -548,6 +547,7 @@ static void read_and_refresh_cache(const char *me)
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	struct rev_info revs;
+	struct commit *commit;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -570,7 +570,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	prepare_revs(&revs);
 
 	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit();
+		int res = do_pick_commit(commit);
 		if (res)
 			return res;
 	}
-- 
1.7.4.rc1.7.g2cf08.dirty
