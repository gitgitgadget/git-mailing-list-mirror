From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] fmt-merge-msg: Make the number of log entries in commit message configurable
Date: Fri, 20 Aug 2010 17:53:58 +0530
Message-ID: <1282307041-19681-2-git-send-email-artagnon@gmail.com>
References: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 14:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmQfl-0001b3-Dg
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab0HTM0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:26:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50662 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0HTM0C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:26:02 -0400
Received: by pzk26 with SMTP id 26so1199710pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zvbP6gqkmSebvIeuCkc6115zd/xZE82k1Rdv6qEFUcs=;
        b=bju3KrcdDaQEf9ekc4NN+JRSjw/f+vxz2FKCGqTgg4YWnI/nfSviUzOPo9/cid+4mJ
         hijv4kRX0MAaYiu5XtqgsZNwBffkvMQ4nGXAsz6Z88zlsoMCwsHpuN/U6yP5CDwSGLDH
         F+4OxMVfZnnYpzx+StVQifNDFKL15PuNLvDN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tA4lWYgZqevJhyjcDehr8GDv0bX31WnKXJcH19uPs8HJXqHBlB4oH3aZHlQb5BBRMJ
         AUaLL2/hKHYE9AOz4Rk0dLuJw3w10QY84s3CiXGahkBGYBOg8qNVz4I89e0USGcYtJgU
         UQ4aTvgdRTLo7GDEMy7hqyru2EL9CSUdAafGE=
Received: by 10.114.89.11 with SMTP id m11mr1409743wab.150.1282307162068;
        Fri, 20 Aug 2010 05:26:02 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm4770439waa.21.2010.08.20.05.25.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 05:26:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154017>

Make the `merge.log` option either an integer or boolean instead of
just a boolean. The integer can be used to specify how many merged
commits to summarize (at maximum) in the merge message. Let true mean
20. Default to false.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Reported-by: Yaroslav Halchenko <debian@onerussian.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>
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
1.7.1
