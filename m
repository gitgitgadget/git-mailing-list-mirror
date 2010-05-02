From: Knittl <knittl89@googlemail.com>
Subject: [PATCH] Show branch information in short output of git status
Date: Sun, 2 May 2010 12:10:21 +0200
Message-ID: <AANLkTim335DkD5nq8njM3jfEDcWLH-4cdEHKRdavdDLG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 12:12:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8W9a-0003RD-F7
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 12:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab0EBKKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 06:10:43 -0400
Received: from mail-ew0-f222.google.com ([209.85.219.222]:46404 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab0EBKKm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 06:10:42 -0400
Received: by ewy22 with SMTP id 22so422030ewy.37
        for <git@vger.kernel.org>; Sun, 02 May 2010 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=KFvT0xzPtdA7AveP/vy76/bDLV2Et1uMxU6OQRvqgCM=;
        b=tis/brzKlAIT4KYmhJ25quSecwCoADW/wO4y5nh/aCfcM4fA87kzLJ5k/FaRpdR/gc
         0SM5FLKL+ONxnXDfZ9VidBXpvnDj9RZ16MoJDImXRMNRqr8DeuLFFena3AYb/tonh+ho
         xWjGXvj3EyKPViF0w5/r2oZ7wkhc/HxPVAFCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=yBfW4C0X3/1oWmJ2FrSkN7/Ffl++hMduJ/3/j7cMIHfRijAPhMcuQke/qxfY3feEAw
         /1YAA4sqsFzZu6OPKscY/9UZkW+Ku/wIwdi8LV9KGe58tMporbvaoJfWgPsklFWXNGa+
         iug7RJaWQGL9TSLkjlfZKNuHCMqKRR7REx96M=
Received: by 10.213.57.193 with SMTP id d1mr5225175ebh.51.1272795041110; Sun, 
	02 May 2010 03:10:41 -0700 (PDT)
Received: by 10.213.2.200 with HTTP; Sun, 2 May 2010 03:10:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146156>

>From 6a82c5486163a058cf2bdbe5089527084a563b80 Mon Sep 17 00:00:00 2001
From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Tue, 20 Apr 2010 22:40:54 +0200
Subject: [PATCH] Show branch information in short output of git status

This patch adds a first line in the output of `git status -s`, showing
which branch the user is currently on, and in case of tracking branches
the number of commits on each branch.

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
 wt-status.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..2e6c56e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "run-command.h"
 #include "remote.h"
+#include "refs.h"

 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -721,9 +722,53 @@ static void wt_shortstatus_untracked(int
null_termination, struct string_list_it
 	}
 }

+static void wt_shortstatus_print_tracking(struct wt_status *s)
+{
+	struct branch *branch;
+	const char *branch_color = color(WT_STATUS_HEADER, s);
+
+	const char *base;
+	const char *branch_name;
+	int num_ours, num_theirs;
+
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
+
+	if(!s->branch) return;
+	branch_name = s->branch;
+
+	if (!prefixcmp(branch_name, "refs/heads/"))
+		branch_name += 11;
+	else if (!strcmp(branch_name, "HEAD")) {
+		branch_color = color(WT_STATUS_NOBRANCH, s);
+	}
+
+	branch = branch_get(s->branch + 11);
+	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
+
+		if(s->is_initial) {
+			color_fprintf(s->fp,
+				color(WT_STATUS_HEADER, s),
+				"Initial commit ... ");
+		}
+		color_fprintf_ln(s->fp, branch_color,
+			"%s", branch_name);
+		return;
+	}
+
+	base = branch->merge[0]->dst;
+	base = shorten_unambiguous_ref(base, 0);
+	color_fprintf_ln(s->fp, branch_color,
+			"%s (%d) ... %s (%d)",
+			branch_name, num_ours,
+			base, num_theirs);
+}
+
 void wt_shortstatus_print(struct wt_status *s, int null_termination)
 {
 	int i;
+
+	wt_shortstatus_print_tracking(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
-- 
1.7.1.rc2.6.g1015.dirty

-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
