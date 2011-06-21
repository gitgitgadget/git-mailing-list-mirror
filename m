From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/13] revert: Eliminate global "commit" variable
Date: Tue, 21 Jun 2011 13:04:41 +0000
Message-ID: <1308661489-20080-6-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0e6-00065X-Cj
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab1FUNFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:05:07 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51876 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab1FUNFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:05:03 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so1679724vxb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=m+YAR2mMx6ZBwgtTK0EzPWZVUmNtcjxkZbAViRjOcPU=;
        b=vEM4OuMBPDo5OEGJ55GirxiLoTtYy5Og9FN/nWbs5Vl7qpQ6xSCjmt+1e2FL6R/Ml0
         BHmk2xPcKhepN3a+oS+LYBAIzoA7vcVx28Z+o9hWcrxeDjyth+EiYQbQur4q9X3AjQjB
         eOvlC9iLkw99YoJjSJXUqKvMcZYY+8MfRiUeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O3pZ9WvOKaoq9F5lFQFRhor2UU/cfopufYzFQ3jBFHNOtF7FWyT0wh2DuWYHFb3yHc
         BDSdzn60e5bK4bfX4l4Yxz0dO5OaVli6W+tnAGZi7GbcRT0i3/puSnIs+a3E33IQTOpF
         rspE5kk7altohC4JxiGk4+Re0+RHPhrUOSNhU=
Received: by 10.52.100.6 with SMTP id eu6mr1982887vdb.30.1308661502235;
        Tue, 21 Jun 2011 06:05:02 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.05.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:05:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176143>

Since we want to develop the functionality to either pick or revert
individual commits atomically later in the series, make "commit" a
local variable.  Doing this involves changing several functions to
take an additional argument, but no other functional changes.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 26f39d1..1b04b3c 100644
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
@@ -182,12 +181,12 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static void write_cherry_pick_head(void)
+static void write_cherry_pick_head(const char *commit_sha1_hex)
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
+	strbuf_addf(&buf, "%s\n", commit_sha1_hex);
 
 	fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
@@ -354,7 +353,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(void)
+static int do_pick_commit(struct commit *commit)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -416,7 +415,7 @@ static int do_pick_commit(void)
 		return error(_("%s: cannot parse parent commit %s"),
 			me, sha1_to_hex(parent->object.sha1));
 
-	if (get_message(commit->buffer, &msg) != 0)
+	if (get_message(commit, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
 			sha1_to_hex(commit->object.sha1));
 
@@ -462,7 +461,7 @@ static int do_pick_commit(void)
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 		if (!no_commit)
-			write_cherry_pick_head();
+			write_cherry_pick_head(sha1_to_hex(commit->object.sha1));
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
@@ -540,6 +539,7 @@ static void read_and_refresh_cache(const char *me)
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	struct rev_info revs;
+	struct commit *commit;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -562,7 +562,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	prepare_revs(&revs);
 
 	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit();
+		int res = do_pick_commit(commit);
 		if (res)
 			return res;
 	}
-- 
1.7.5.GIT
