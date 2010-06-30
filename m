From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 11/13] add --always-print option
Date: Wed, 30 Jun 2010 23:25:24 +0800
Message-ID: <1277911526-12105-11-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:31:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzG8-00026z-85
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139Ab0F3PbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:31:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59471 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0F3PbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:31:20 -0400
Received: by pzk7 with SMTP id 7so138879pzk.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xv/bQSEBFZIaat2GK6uL420GPlza3EaL0tbb4Unuh9w=;
        b=WXdzF35YZLjHV5BAWpBwd7wSr0vrDdx+7VXvnhCO8Ur8S+ErdMQ9izFtkhrHpZqkv6
         sR5in/opN7Ct5l4gbeGC0MZsgAaW09wgqR3CKRI6UMOQKxgRtf22VjfV4495GR++t5m0
         s5Jr2whoVTjFwMe+XDAz7CjKaaSHlKu1RysVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uXSnzCW3fOOoFka0MKxblL5H2/IhCF8SQ+Yu6DJ93iIHFZbp2D2l80VNafgDilDReR
         rsZ6O5WfZo+Nxl9MRXR5JIk+L8IgL0AwJI1XvBPMPhC4V/n2QaGlPfdIBlTi53ywnrwj
         YVcIkMcLNo2Pp2FKSo/9E4Fc++dfLnl82jtjg=
Received: by 10.115.66.30 with SMTP id t30mr10020111wak.161.1277911880533;
        Wed, 30 Jun 2010 08:31:20 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.31.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:31:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149974>

Always print the interesting ranges even if the current
commit does not change any line of it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    3 +++
 line.c        |   11 +++++++++--
 revision.h    |    3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f14d54a..a856f3c 100644
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
 
@@ -224,6 +226,7 @@ parse_done:
 	/* Test whether line level history is asked for */
 	if (range && range->nr > 0) {
 		setup_line(rev, range);
+		rev->always_print = always_print;
 	}
 }
 
diff --git a/line.c b/line.c
index faaa25a..eb7375d 100644
--- a/line.c
+++ b/line.c
@@ -1074,6 +1074,13 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
 
@@ -1184,7 +1191,7 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 		return flush_nontrivial_merge(rev, nontrivial);
 
 	while (range) {
-		if (range->diff)
+		if (range->diff || (range->nr && rev->always_print))
 			diff_flush_filepair(rev, range);
 		range = range->next;
 	}
@@ -1218,7 +1225,7 @@ int cmd_line_log_walk(struct rev_info *rev)
 			assign_parents_range(rev, commit);
 		}
 
-		if (commit->object.flags & NEED_PRINT) {
+		if (commit->object.flags & NEED_PRINT || rev->always_print) {
 			line_log_flush(rev, commit);
 		}
 
diff --git a/revision.h b/revision.h
index 32bde08..3d25fd0 100644
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
1.7.0.2.273.gc2413.dirty
