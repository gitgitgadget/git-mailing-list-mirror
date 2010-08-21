From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 1/5] fmt-merge-msg: Make the number of log entries in commit message configurable
Date: Sat, 21 Aug 2010 15:28:15 +0530
Message-ID: <1282384699-16477-2-git-send-email-artagnon@gmail.com>
References: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 12:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omksb-0004zP-Qo
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab0HUKA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:00:27 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62273 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0HUKAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:00:25 -0400
Received: by pvg2 with SMTP id 2so1564348pvg.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Sk5Qz4yE1h4BNnzsaOCrZaujud31hlwqOeEi4l9ci5I=;
        b=sHSAhJbegJOB57bBWpE4o9GsJ3ZE8b4QM6ArOtUVQYsOCoZiZuC9seFD1Bos28yr62
         /DNp0jBJ9fKRNutWbb+drrO9dV8KM8VCeSXhTyg/3RmD68Pw94g3tfuYLNhhLDDDImy8
         RlUyAZwF8gBLBRnFWYtskHHk2CYSGLX6BedIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XUGXQoBWMa9tpXLP2jQHSyG2vWVZijC8IXI6C9PKsPG4W8j1oDLUqll94Jt7Id8HPQ
         lGSbMlAgflLydMRj2u8QnjeugY3cFwn4D+ySbWfhFOVmzcCe1gU52Gc5CLuoJx3TSo7u
         UByQ3UljBXDfRO9mrq43C3QVraj3q2gMdC2hQ=
Received: by 10.142.132.18 with SMTP id f18mr2165855wfd.28.1282384825253;
        Sat, 21 Aug 2010 03:00:25 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm4641270wff.7.2010.08.21.03.00.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 03:00:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154130>

Make the `merge.log` option either an integer or boolean instead of
just a boolean. The integer can be used to specify how many merged
commits to summarize (at maximum) in the merge message. Let true mean
20. Default to false.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Reported-by: Yaroslav Halchenko <debian <at> onerussian.com>
Thanks-to: Johannes Sixt <j.sixt <at> viscovery.net>
Thanks-to: Jonathan Nieder <jrnieder <at> gmail.com>
---
 builtin/fmt-merge-msg.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e7e12ee..66b1cbd 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -12,16 +12,23 @@ static const char * const fmt_merge_msg_usage[] = {
 };
 
 static int merge_summary;
+static int log_limit = 0;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
 	static int found_merge_log = 0;
+	int is_bool;
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
1.7.2.2.409.gdbb11.dirty
