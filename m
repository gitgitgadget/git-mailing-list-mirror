From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: [PATCH] [GSoC][MICRO] Forbid "log --graph --no-walk"
Date: Fri,  6 Mar 2015 16:55:10 +0800
Message-ID: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
Cc: Dongcan Jiang <dongcan.jiang@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 10:28:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YToYc-0004yb-TL
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 10:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbbCFJ2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 04:28:30 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37272 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbbCFJ20 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 04:28:26 -0500
Received: by paceu11 with SMTP id eu11so36221744pac.4
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 01:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wysa9zFTGoaUGANBPUdB9gFe/hbAMcVr661T3zgSuN4=;
        b=hiJE3f8VC23UKzNNx9NPtFDXHNJ7HE5uEMc53A4sOYS6wqn55jBw6CNZU/fr7dxjv1
         RuQ09t3tZDzbt6czI4yVJx/fOJjIGdo24JiowFo8OW26iHtDtdN9MKO/Ji72L7nJm85h
         qVA3MgHNkOfxEJclSR5/AcX+tzEP+8slkmXigXUplWZDoDrKz5use13oNqPJzddb/02H
         +htJ5q2iV+J3K/l9Vu/o5drgNWymE9d1dJtalIJZQ4Io2uqLvQ1LiU7TVD9B9D7RuZUx
         hvBW4O1FBoZRfSj5Kgc+GDRxVMme7F/Hdk/2C9JBLz05h7TYeuaGwxTBir6yNMH+Kl7g
         DG/g==
X-Received: by 10.70.40.167 with SMTP id y7mr24016889pdk.164.1425634106245;
        Fri, 06 Mar 2015 01:28:26 -0800 (PST)
Received: from localhost.localdomain ([162.105.205.253])
        by mx.google.com with ESMTPSA id ey1sm5088979pdb.30.2015.03.06.01.28.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Mar 2015 01:28:25 -0800 (PST)
X-Mailer: git-send-email 2.3.1.251.g83036f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264899>

Because --graph is about connected history while --no-walk is about discrete points.

revision.c: Judge whether --graph and --no-walk come together when running git-log.
buildin/log.c: Set git-log cmd flag.
Documentation/rev-list-options.txt: Add specification on the forbidden usage.

Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
---
 Documentation/rev-list-options.txt | 2 ++
 builtin/log.c                      | 1 +
 revision.c                         | 4 ++++
 revision.h                         | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4ed8587..eea2c0a 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -679,6 +679,7 @@ endif::git-rev-list[]
 	given on the command line. Otherwise (if `sorted` or no argument
 	was given), the commits are shown in reverse chronological order
 	by commit time.
+	Cannot be combined with `--graph` when running git-log.
 
 --do-walk::
 	Overrides a previous `--no-walk`.
@@ -781,6 +782,7 @@ you would get an output like this:
 	on the left hand side of the output.  This may cause extra lines
 	to be printed in between commits, in order for the graph history
 	to be drawn properly.
+	Cannot be combined with `--no-walk` when running git-log.
 +
 This enables parent rewriting, see 'History Simplification' below.
 +
diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..7bf5adb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -627,6 +627,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	git_config(git_log_config, NULL);
 
 	init_revisions(&rev, prefix);
+	rev.cmd_is_log = 1;
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
diff --git a/revision.c b/revision.c
index 66520c6..5f62c89 100644
--- a/revision.c
+++ b/revision.c
@@ -1399,6 +1399,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
+	revs->cmd_is_log = 0;
+
 	init_grep_defaults();
 	grep_init(&revs->grep_filter, prefix);
 	revs->grep_filter.status_only = 1;
@@ -2339,6 +2341,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
+	if (revs->no_walk && revs->graph && revs->cmd_is_log)
+		die("cannot combine --no-walk with --graph when running git-log");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
 
diff --git a/revision.h b/revision.h
index 0ea8b4e..255982a 100644
--- a/revision.h
+++ b/revision.h
@@ -146,6 +146,9 @@ struct rev_info {
 			track_first_time:1,
 			linear:1;
 
+	/* cmd type */
+	unsigned int  cmd_is_log:1;
+
 	enum date_mode date_mode;
 
 	unsigned int	abbrev;
-- 
2.3.1.251.g83036f8
