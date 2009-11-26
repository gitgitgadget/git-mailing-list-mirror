From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 2/2] status -s: obey color.status
Date: Thu, 26 Nov 2009 16:24:39 +0100
Message-ID: <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net>
References: <cover.1259248243.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 16:26:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDgEV-0007vN-6W
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 16:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbZKZPZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 10:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbZKZPZt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 10:25:49 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:55433 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755310AbZKZPZr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 10:25:47 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A33B8C27A3;
	Thu, 26 Nov 2009 10:25:53 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 26 Nov 2009 10:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=WQ3jDQH1YWPUu+Mrt+w7FkRmVvU=; b=d/pl6wLYluxYJL8iyW1yD0TllY2Tg/Ut6DGaVEo0fTtLfNkFkdefLYzm87TiaU4eZkb9ZDPikFilGAjEtGECA8yoUsMCKLD2o+8AwW2FMBqBOQoazvVHBpTfuladQprk440u81NbQLDqfrunKuSOMVZRV7wMJWtt7DnjG8/toew=
X-Sasl-enc: 7hBM3gQwEziWmY0frh46mMR73MO3yfNnV68Bbjd6ynO8 1259249153
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E60F52E72C;
	Thu, 26 Nov 2009 10:25:52 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc0.274.g71380
In-Reply-To: <cover.1259248243.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133801>

Make the short version of status obey the color.status boolean. We color
the status letters only, because they carry the state information and are
potentially colored differently, such as for a file with staged changes
as well as changes in the worktree against the index.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is RFC for several reasons:

* Should I rename wt-status.c's color() into something more unique when
  I export it?
* Is there any policy regarding use of putchar/puts vs. printf?
* The way it is done now I "color" a space, otherwise one would need to
  break down the print statements even more. Since we always color the
  foreground only it is no problem, is it?
* Even if I were to write tests for status -s: How do I test colors?

 builtin-commit.c |   20 +++++++++++++++-----
 wt-status.c      |    2 +-
 wt-status.h      |    1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index c103beb..c38fc96 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -999,7 +999,7 @@ static void short_unmerged(int null_termination, struct string_list_item *it,
 	case 6: how = "AA"; break; /* both added */
 	case 7: how = "UU"; break; /* both modified */
 	}
-	printf("%s ", how);
+	color_fprintf(s->fp, color(WT_STATUS_UNMERGED, s), "%s ", how);
 	if (null_termination) {
 		fprintf(stdout, "%s%c", it->string, 0);
 	} else {
@@ -1016,9 +1016,14 @@ static void short_status(int null_termination, struct string_list_item *it,
 {
 	struct wt_status_change_data *d = it->util;
 
-	printf("%c%c ",
-	       !d->index_status ? ' ' : d->index_status,
-	       !d->worktree_status ? ' ' : d->worktree_status);
+	if (d->index_status)
+		color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status);
+	else
+		putchar(' ');
+	if (d->worktree_status)
+		color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%c ", d->worktree_status);
+	else
+		printf("  ");
 	if (null_termination) {
 		fprintf(stdout, "%s%c", it->string, 0);
 		if (d->head_path)
@@ -1046,7 +1051,8 @@ static void short_untracked(int null_termination, struct string_list_item *it,
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, -1, &onebuf, s->prefix);
-		printf("?? %s\n", one);
+		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "?? ");
+		puts(one);
 		strbuf_release(&onebuf);
 	}
 }
@@ -1115,6 +1121,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_SHORT:
 		if (s.relative_paths)
 			s.prefix = prefix;
+		if (s.use_color == -1)
+			s.use_color = git_use_color_default;
+		if (diff_use_color_default == -1)
+			diff_use_color_default = git_use_color_default;
 		short_print(&s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
diff --git a/wt-status.c b/wt-status.c
index 3c2f580..c779b7c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -19,7 +19,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,    /* WT_STATUS_UNMERGED */
 };
 
-static const char *color(int slot, struct wt_status *s)
+const char *color(int slot, struct wt_status *s)
 {
 	return s->use_color > 0 ? s->color_palette[slot] : "";
 }
diff --git a/wt-status.h b/wt-status.h
index 09fd9f1..22b15b0 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -55,5 +55,6 @@ struct wt_status {
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+const char *color(int slot, struct wt_status *s);
 
 #endif /* STATUS_H */
-- 
1.6.6.rc0.274.g71380
