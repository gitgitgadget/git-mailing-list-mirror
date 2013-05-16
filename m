From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 02:48:52 -0500
Message-ID: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 09:50:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcsxH-0004aV-8O
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 09:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189Ab3EPHuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 03:50:23 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:38428 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab3EPHuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 03:50:22 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so3402110oag.29
        for <git@vger.kernel.org>; Thu, 16 May 2013 00:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=FMQA883YTVshs/Gg1Hw9KMUfacn593+WMlIJrzWpU08=;
        b=MOC1yzJR181VdG76DNQ0FRukM0dF4pnxBL+aVvBItNHvxbV5ax5xkiniW/zxhKK0tQ
         4Ro4AqhKauBN1oyuLviHn0D/8SIXpg688uykjhjLTlbZKCdMA51KvdjvD/3SdIX85Skr
         NUEkynZlGErri1pT6EON6bInsdoY7V4vv3wYp6tzEL5mw81cyd5fVmSkECCwKRuVDhr+
         21hhxVoS9X2KrcAR8AFB7vgoDPDOmluVcs556j8wF19ADpmCJ5kQofd5iBxotab0xil9
         N3D4Y0Sgzrv3anUFZWw+QpJGQNop15xMVFbslgrk/FTq1vWqWLrvhF+8L1f9k015HTu2
         DpDQ==
X-Received: by 10.182.40.202 with SMTP id z10mr19355897obk.74.1368690621814;
        Thu, 16 May 2013 00:50:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id r4sm6870760obg.3.2013.05.16.00.50.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 00:50:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224489>

Showing the tracking information for all the branches takes significant
amount of time. The user might not want that. The --no-show-tracking
option allows that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-branch.txt | 5 ++++-
 builtin/branch.c             | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b7cb625..1db04cd 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
-	[--list] [-v [--abbrev=<length> | --no-abbrev]]
+	[--list] [-v [--abbrev=<length> | --no-abbrev] --show-tracking]
 	[--column[=<options>] | --no-column]
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
@@ -154,6 +154,9 @@ This option is only applicable in non-verbose mode.
 --no-abbrev::
 	Display the full sha1s in the output listing rather than abbreviating them.
 
+--show-tracking::
+	Display the tracking information when using --verbose, or not.
+
 -t::
 --track::
 	When creating a new branch, set up configuration to mark the
diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..2b586ea 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -33,6 +33,7 @@ static const char * const builtin_branch_usage[] = {
 
 static const char *head;
 static unsigned char head_sha1[20];
+static int show_tracking = 1;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -424,7 +425,7 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
 
-	if (!stat_tracking_info(branch, &ours, &theirs)) {
+	if (!(show_tracking && stat_tracking_info(branch, &ours, &theirs))) {
 		if (branch && branch->merge && branch->merge[0]->dst &&
 		    show_upstream_ref) {
 			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
@@ -840,6 +841,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
+		OPT_BOOL(0, "show-tracking", &show_tracking, N_("show tracking information")),
 		OPT_END(),
 	};
 
-- 
1.8.3.rc1.579.g184e698
