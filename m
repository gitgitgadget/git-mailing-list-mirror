From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v3 11/13] add --always-print option
Date: Sun, 11 Jul 2010 14:18:59 +0800
Message-ID: <1278829141-11900-11-git-send-email-struggleyb.nku@gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:21:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXpvC-00025x-Md
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab0GKGVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:21:47 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45345 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab0GKGVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:21:45 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so1400905pxi.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qF7AEv+NZFjrEyc24O4DlIsisVUIXfTTHIHgYaUMyQM=;
        b=OH6QiyPDY9bnX0dgVDgEjG8lEJXqkiwy7v7CDgwet35XXjILsutY3mnpcWbJRn7dry
         snfKp3muQtSWlH+N8aEuCZHXjv1F4b9FNSULeSiYYsL8CbyPz1W1lCv4RmaJQcgyYRRO
         oJMWARkBonetdrIBJaRnmny2V0UoEwajCA0z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GPLCPFsVxaBzEDCtbh5M3OlBjrnF+ofQn+qTJwIrLvlVln06p9F/qguu2xm5CC9QHH
         6qT3dmwg6zFGkePb7ew4U0hZ+KqOYTqx2RIC0onZy0ZlBR8Yjcett3IUAH5rZGLXgixi
         XRGQtUpiDsSotbcB3FlFXn9TBheRIUuEwodyk=
Received: by 10.142.215.6 with SMTP id n6mr3461594wfg.228.1278829304786;
        Sat, 10 Jul 2010 23:21:44 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id c15sm2927911rvi.11.2010.07.10.23.21.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:21:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150754>

Always print the interesting ranges even if the current
commit does not change any line of it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    3 +++
 line.c        |   11 +++++++++--
 revision.h    |    3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 47b386d..3fa31dc 100644
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
index 5c8f77a..c08b510 100644
--- a/line.c
+++ b/line.c
@@ -1080,6 +1080,13 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
 
@@ -1190,7 +1197,7 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 		return flush_nontrivial_merge(rev, nontrivial);
 
 	while (range) {
-		if (range->diff)
+		if (range->diff || (range->nr && rev->always_print))
 			diff_flush_filepair(rev, range);
 		range = range->next;
 	}
@@ -1225,7 +1232,7 @@ int cmd_line_log_walk(struct rev_info *rev)
 			assign_parents_range(rev, commit);
 		}
 
-		if (commit->object.flags & NEED_PRINT) {
+		if (commit->object.flags & NEED_PRINT || rev->always_print) {
 			line_log_flush(rev, commit);
 		}
 
diff --git a/revision.h b/revision.h
index bbc4e2c..433da9a 100644
--- a/revision.h
+++ b/revision.h
@@ -72,7 +72,8 @@ struct rev_info {
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
