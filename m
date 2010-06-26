From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 10/12] add --always-print option
Date: Sat, 26 Jun 2010 06:27:35 -0700
Message-ID: <1277558857-23103-11-git-send-email-struggleyb.nku@gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVR2-0007yz-JD
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026Ab0FZN2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:28:25 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58519 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107Ab0FZN2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:28:21 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1277102pvg.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lWEu3z0W3fTYE66JZmjo76viJhS69WKtLaJFwZQbQk8=;
        b=pUDFGfL+j//1tO39t6XbaDJQW0sRcMgRZEhZZkhX1rRHRdyhIhUaxHLZAMrSEF+NZf
         6yABvykQ+IoaKpi+K1LRgEu3qqSyCtF8zVsipz/gqSjxDqKvwB5NmqtJ/JdZLoSUmWRI
         AjNa0eEx8cTFk7wAywc0Ka1WaQ6avoGlX+e00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IR1TnACqR8YpnURLp5QG7uaQlCohp8h/YRvfDkbbTCCNL3fTsgS2pg4I21ES/dB7S2
         1x8RV8CIJW5FOXRTrNL2e4F1DZ0kdRiz9cfcsDXHj+ZnFMq1iwnQo/Xx3LJdu/Lf/I4Y
         adnGp0rq/NfRhR6vPFGAIPbKpQAW16el1PuNU=
Received: by 10.142.134.13 with SMTP id h13mr49763wfd.232.1277558900855;
        Sat, 26 Jun 2010 06:28:20 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.28.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:28:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
In-Reply-To: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149752>

Always print the interesting ranges even if the current
commit does not change any line of it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    3 +++
 line.c        |   11 +++++++++--
 revision.h    |    3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 87d6b2f..a0918ef 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -85,6 +85,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 {
 	int i;
 	int decoration_given = 0;
+	static int always_print = 0;
 	struct userformat_want w;
 	const char *path = NULL, *pathspec = NULL;
 	static struct diff_line_range *range = NULL;
@@ -92,6 +93,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	static struct line_opt_callback_data line_cb = {&range, &ctx, NULL};
 	static const struct option options[] = {
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m", "Process only line range n,m, counting from 1", log_line_range_callback),
+		OPT_BOOLEAN(0, "always-print", &always_print, "Always print the interesting range even if the current commit does not change any line of it"),
 		OPT_END()
 	};
 	static const struct option null_options[] = {
@@ -244,6 +246,7 @@ parse_done2:
 	/* Test whether line level history is asked for */
 	if (range && range->nr > 0) {
 		setup_line(rev, range);
+		rev->always_print = always_print;
 	}
 }
 
diff --git a/line.c b/line.c
index 46d0937..655fa71 100644
--- a/line.c
+++ b/line.c
@@ -1067,6 +1067,13 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
 	 * no sensible rang->pair since there is no diff run.
 	 */
 	if (one == NULL) {
+		if (rev->always_print) {
+			chunk.two = two->data;
+			chunk.two_end = two->data + two->size;
+			chunk.ltwo = 1;
+			chunk.range = range;
+			diff_flush_chunks(&rev->diffopt, &chunk);
+		}
 		return;
 	}
 
@@ -1177,7 +1184,7 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 		return flush_nontrivial_merge(rev, nontrivial);
 
 	while (range) {
-		if (range->diff)
+		if (range->diff || (range->nr && rev->always_print))
 			diff_flush_filepair(rev, range);
 		range = range->next;
 	}
@@ -1211,7 +1218,7 @@ int cmd_line_log_walk(struct rev_info *rev)
 			assign_parents_range(rev, commit);
 		}
 
-		if (commit->object.flags & NEED_PRINT) {
+		if (commit->object.flags & NEED_PRINT || rev->always_print) {
 			line_log_flush(rev, commit);
 		}
 
diff --git a/revision.h b/revision.h
index 2bc3750..02ab14c 100644
--- a/revision.h
+++ b/revision.h
@@ -71,7 +71,8 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
-			line:1;
+			line:1,
+			always_print:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
-- 
1.7.1.577.g36cf0.dirty
