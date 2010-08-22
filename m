From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5 1/5] fmt_merge_msg: Change fmt_merge_msg API to accept shortlog_len
Date: Sun, 22 Aug 2010 21:56:34 +0530
Message-ID: <1282494398-20542-2-git-send-email-artagnon@gmail.com>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 22 18:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnDR6-00047i-IK
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 18:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab0HVQ3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 12:29:20 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48844 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0HVQ26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 12:28:58 -0400
Received: by pxi10 with SMTP id 10so1976160pxi.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NCuTwY77LfU5BnC4B7dnBAKkBv0yc3+n+PHVl6Tfih4=;
        b=SKXgXjt2XEQmecA+sN118r26ZLNYOxVSQW7Z+LB4bhTnD01L3curfd7mlbgRYoGQX6
         wW9toKiTOr2zpjE3o4F4nSClahNf9Q1B+Rp1/MO8cATK9+8cJLs6cKjshb1E7Z3Qc8GC
         5px+hd0usATI48P+BypQYkxJsdErtQV8rcDZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=idpvIu9ILco/55s1OUvJo1u0NLjqaXI6woPu8hEzchmleAAByab5AQIsiSI4oeur3U
         SQshoku2OmTX43jStByL856uXi6BD8L6j70Tix+5Rt7y+grKFHgowiRHQrXcm8oA+aOL
         Xslh/PfDw/APUSLCfrMrmIqAG7g55cTm6fXnQ=
Received: by 10.143.42.14 with SMTP id u14mr3333494wfj.280.1282494537750;
        Sun, 22 Aug 2010 09:28:57 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id y16sm7089065wff.14.2010.08.22.09.28.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 09:28:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154187>

Update the API of the fmt_merge_msg function to replace the the
merge_summary argument with a new shortlog_len argument. Update the
callers track this change: when translating from merge_summary to
shortlog_len, note that 0 means no shortlog and 20 is the default
"enabled" value.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin.h               |    5 ++---
 builtin/fmt-merge-msg.c |   24 +++++++++++-------------
 builtin/merge.c         |    5 +++--
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin.h b/builtin.h
index 9c3d50b..1993166 100644
--- a/builtin.h
+++ b/builtin.h
@@ -14,9 +14,8 @@ extern const char git_more_info_string[];
 extern void list_common_cmds_help(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
-extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
-	struct strbuf *out);
-extern int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out);
+extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
+			 int merge_title, int shortlog_len);
 extern int commit_notes(struct notes_tree *t, const char *msg);
 
 struct notes_rewrite_cfg {
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e7e12ee..4ed728a 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -255,9 +255,9 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 		strbuf_addf(out, " into %s\n", current_branch);
 }
 
-static int do_fmt_merge_msg(int merge_title, int merge_summary,
-	struct strbuf *in, struct strbuf *out) {
-	int limit = 20, i = 0, pos = 0;
+static int do_fmt_merge_msg(int merge_title, struct strbuf *in,
+	struct strbuf *out, int shortlog_len) {
+	int i = 0, pos = 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
 
@@ -288,7 +288,7 @@ static int do_fmt_merge_msg(int merge_title, int merge_summary,
 	if (merge_title)
 		do_fmt_merge_msg_title(out, current_branch);
 
-	if (merge_summary) {
+	if (shortlog_len) {
 		struct commit *head;
 		struct rev_info rev;
 
@@ -303,17 +303,14 @@ static int do_fmt_merge_msg(int merge_title, int merge_summary,
 
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.items[i].string, origins.items[i].util,
-					head, &rev, limit, out);
+					head, &rev, shortlog_len, out);
 	}
 	return 0;
 }
 
-int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
-	return do_fmt_merge_msg(1, merge_summary, in, out);
-}
-
-int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out) {
-	return do_fmt_merge_msg(0, 1, in, out);
+int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
+		  int merge_title, int shortlog_len) {
+	return do_fmt_merge_msg(merge_title, in, out, shortlog_len);
 }
 
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
@@ -357,9 +354,10 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		die_errno("could not read input file");
 	if (message) {
 		strbuf_addstr(&output, message);
-		ret = fmt_merge_msg_shortlog(&input, &output);
+		ret = fmt_merge_msg(&input, &output, 0, 20);
 	} else {
-		ret = fmt_merge_msg(merge_summary, &input, &output);
+		ret = fmt_merge_msg(&input, &output, 1,
+				    merge_summary ? 20 : 0);
 	}
 	if (ret)
 		return ret;
diff --git a/builtin/merge.c b/builtin/merge.c
index 4e4ec89..d47f48f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1014,9 +1014,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			merge_name(argv[i], &merge_names);
 
 		if (have_message && option_log)
-			fmt_merge_msg_shortlog(&merge_names, &merge_msg);
+			fmt_merge_msg(&merge_names, &merge_msg, 0, 20);
 		else if (!have_message)
-			fmt_merge_msg(option_log, &merge_names, &merge_msg);
+			fmt_merge_msg(&merge_names, &merge_msg, 1,
+				      option_log ? 20: 0);
 
 
 		if (!(have_message && !option_log) && merge_msg.len)
-- 
1.7.2.2.409.gdbb11.dirty
