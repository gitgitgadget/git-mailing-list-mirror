From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 2/5] fmt-merge-msg: Make the number of log entries in commit message configurable
Date: Sat, 21 Aug 2010 00:44:59 +0530
Message-ID: <1282331702-5115-3-git-send-email-artagnon@gmail.com>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:17:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmX5n-0006w7-Li
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab0HTTR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:17:29 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64833 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0HTTR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:17:27 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1329950pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+LH7atTx3qCDRkebN5LwVeO3eOKQ1F6hcq32bAuCzNI=;
        b=SXFHb67MwzYKfDsxdcCtcGXSU15b/Lt6+6myRgu1JhNrgpT9L2bu7CKB9OzRRMHINx
         iw34YwegrHPHqKXMTtawJFIssSzOdjoQjwO7Mr/eThXUmwyJf8IoswOF2iTQmql4PVpX
         aeDRd/9bISZEo2o4Vq/PnbfE47ORFII4v6CX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mtQIs7AOjBC0MFVLexMqXGykBp+KzcvcA9gu1MwzU+DlDABlHSeNE1/RdcffKPQG7H
         oDsuPfwnxoA9lssdDobqvplFY/ImBEf1JEQlUkym5mYfFMUM9WJY954d7c5R+nBoVv04
         I1JUxSsflF4aRPoC4QJGAoUMzux2TtaQJtmb8=
Received: by 10.143.155.1 with SMTP id h1mr1476473wfo.41.1282331846740;
        Fri, 20 Aug 2010 12:17:26 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm3610572wff.7.2010.08.20.12.17.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 12:17:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154071>

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
1.7.2.2.409.gdbb11.dirty
