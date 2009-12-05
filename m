From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] status -s: obey color.status
Date: Sat,  5 Dec 2009 16:04:38 +0100
Message-ID: <2b987524f57a0ac04e219f82e20e806741ce4eca.1260025135.git.git@drmicha.warpmail.net>
References: <cover.1260025135.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 05 16:05:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGwC1-00064w-Qc
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 16:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbZLEPEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 10:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbZLEPEq
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 10:04:46 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52161 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755902AbZLEPEn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Dec 2009 10:04:43 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E6F21C5DBB;
	Sat,  5 Dec 2009 10:04:49 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 05 Dec 2009 10:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=y8CDWfytckWLheRnohxtloZUwYM=; b=cZNFcA+FNsOWP280Y9Tm3JtILmz1ObYMp8QPlQgVapnY5PSV3S6zSApbBIaNsWFUl9JsYTh9nVU2HlZdzW1nOAQaJbYuEMSKDYSZy3yriViSSqNwOH8FUUCOQOPfrRm5OU74u/v+JCeMMm17Yy0TtId/dFABri2nOHtnE1fvEnk=
X-Sasl-enc: ipUgwu71W33uVTo0owJHl+NrVbqaBXyyYAlhulG/1z6s 1260025489
Received: from localhost (p5DCC0D75.dip0.t-ipconnect.de [93.204.13.117])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0340842AE;
	Sat,  5 Dec 2009 10:04:48 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc1.282.ge6667
In-Reply-To: <cover.1260025135.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134606>

Make the short version of status obey the color.status boolean. We color
the status letters only, because they carry the state information and are
potentially colored differently, such as for a file with staged changes
as well as changes in the worktree against the index.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin-commit.c |    4 ++++
 wt-status.c      |   21 ++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 548bbf5..ddcfffb 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1022,6 +1022,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_SHORT:
 		if (s.relative_paths)
 			s.prefix = prefix;
+		if (s.use_color == -1)
+			s.use_color = git_use_color_default;
+		if (diff_use_color_default == -1)
+			diff_use_color_default = git_use_color_default;
 		wt_shortstatus_print(&s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
diff --git a/wt-status.c b/wt-status.c
index 93af994..a8b6d05 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -616,14 +616,14 @@ static void wt_shortstatus_unmerged(int null_termination, struct string_list_ite
 	case 6: how = "AA"; break; /* both added */
 	case 7: how = "UU"; break; /* both modified */
 	}
-	printf("%s ", how);
+	color_fprintf(s->fp, color(WT_STATUS_UNMERGED, s), "%s", how);
 	if (null_termination) {
-		fprintf(stdout, "%s%c", it->string, 0);
+		fprintf(stdout, " %s%c", it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, -1, &onebuf, s->prefix);
-		printf("%s\n", one);
+		printf(" %s\n", one);
 		strbuf_release(&onebuf);
 	}
 }
@@ -633,9 +633,15 @@ static void wt_shortstatus_status(int null_termination, struct string_list_item
 {
 	struct wt_status_change_data *d = it->util;
 
-	printf("%c%c ",
-		!d->index_status ? ' ' : d->index_status,
-		!d->worktree_status ? ' ' : d->worktree_status);
+	if (d->index_status)
+		color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status);
+	else
+		putchar(' ');
+	if (d->worktree_status)
+		color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%c", d->worktree_status);
+	else
+		putchar(' ');
+	putchar(' ');
 	if (null_termination) {
 		fprintf(stdout, "%s%c", it->string, 0);
 		if (d->head_path)
@@ -663,7 +669,8 @@ static void wt_shortstatus_untracked(int null_termination, struct string_list_it
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, -1, &onebuf, s->prefix);
-		printf("?? %s\n", one);
+		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "??");
+		printf(" %s\n", one);
 		strbuf_release(&onebuf);
 	}
 }
-- 
1.6.6.rc1.282.ge6667
