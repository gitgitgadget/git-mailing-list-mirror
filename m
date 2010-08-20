From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/4] fmt-merge-msg: Make the number of log entries in commit message configurable
Date: Fri, 20 Aug 2010 22:24:49 +0530
Message-ID: <1282323292-11412-2-git-send-email-artagnon@gmail.com>
References: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 18:57:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmUuN-0004cf-2J
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 18:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab0HTQ5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 12:57:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53675 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0HTQ5J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 12:57:09 -0400
Received: by gyd8 with SMTP id 8so1331630gyd.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=x3HzhDXvPE5WU69HzW0NhJl6gUHlc/jHmnghFITFOZ0=;
        b=ptwhRqSRtN7TrWfwC7AAeUVc5NaD52BEYZAUviofr6Fs1nzsQ/68NMLcGC0DehcRL6
         Eu//wut9fvGfzsHAeVuOp5ekLWTPPVpTw6E/1RcVq8Q6lbMT6jfb25Bg2k2eSymezM8C
         2Hp7hXrn5FL6eVn29YF+CX4GdBYpwitBowDs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Fa4hoSeCFynSKC6hQ37heZCZ8Q/ATz8N4rwLVU//G82d89aKGrDCDc5cFPborPugdv
         GfdZ1KvCt6weIwI6tuIziP4v+6o5Aci5pYJXBNoYUmoVDN/rSllnVCiR9o3voG/FHlCK
         V3RyZ61/Gui7A2fmR+/WTbM9hwjW/whv+uWWw=
Received: by 10.151.143.17 with SMTP id v17mr2295814ybn.179.1282323428508;
        Fri, 20 Aug 2010 09:57:08 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e8sm2761091ibb.20.2010.08.20.09.57.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 09:57:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.408.g7357
In-Reply-To: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154057>

Make the `merge.log` option either an integer or boolean instead of
just a boolean. The integer can be used to specify how many merged
commits to summarize (at maximum) in the merge message. Let true mean
20. Default to false.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Reported-by: Yaroslav Halchenko <debian@onerussian.com>
Thanks-to: Johannes Sixt <j.sixt@viscovery.net>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fmt-merge-msg.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e7e12ee..e967a05 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -12,16 +12,23 @@ static const char * const fmt_merge_msg_usage[] = {
 };
 
 static int merge_summary;
+static int log_limit = 0;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
 	static int found_merge_log = 0;
+	int is_bool = 0;
 	if (!strcmp("merge.log", key)) {
 		found_merge_log = 1;
-		merge_summary = git_config_bool(key, value);
+		log_limit = git_config_bool_or_int(key, value, &is_bool);
 	}
 	if (!found_merge_log && !strcmp("merge.summary", key))
-		merge_summary = git_config_bool(key, value);
+		log_limit = git_config_bool_or_int(key, value, &is_bool);
+
+	if (is_bool && log_limit)
+		log_limit = 20;
+	merge_summary = log_limit ? 1 : 0;
+
 	return 0;
 }
 
@@ -140,7 +147,7 @@ static void print_joined(const char *singular, const char *plural,
 }
 
 static void shortlog(const char *name, unsigned char *sha1,
-		struct commit *head, struct rev_info *rev, int limit,
+		struct commit *head, struct rev_info *rev,
 		struct strbuf *out)
 {
 	int i, count = 0;
@@ -169,7 +176,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 			continue;
 
 		count++;
-		if (subjects.nr > limit)
+		if (subjects.nr > log_limit)
 			continue;
 
 		format_commit_message(commit, "%s", &sb, &ctx);
@@ -182,13 +189,13 @@ static void shortlog(const char *name, unsigned char *sha1,
 			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
 
-	if (count > limit)
+	if (count > log_limit)
 		strbuf_addf(out, "\n* %s: (%d commits)\n", name, count);
 	else
 		strbuf_addf(out, "\n* %s:\n", name);
 
 	for (i = 0; i < subjects.nr; i++)
-		if (i >= limit)
+		if (i >= log_limit)
 			strbuf_addf(out, "  ...\n");
 		else
 			strbuf_addf(out, "  %s\n", subjects.items[i].string);
@@ -257,7 +264,7 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 
 static int do_fmt_merge_msg(int merge_title, int merge_summary,
 	struct strbuf *in, struct strbuf *out) {
-	int limit = 20, i = 0, pos = 0;
+	int i = 0, pos = 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
 
@@ -303,7 +310,7 @@ static int do_fmt_merge_msg(int merge_title, int merge_summary,
 
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.items[i].string, origins.items[i].util,
-					head, &rev, limit, out);
+					head, &rev, out);
 	}
 	return 0;
 }
-- 
1.7.2.2.408.g7357
