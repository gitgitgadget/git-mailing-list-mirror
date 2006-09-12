From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach runstatus about --untracked
Date: Tue, 12 Sep 2006 22:45:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609122243360.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Sep 12 22:45:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNF8E-0002cU-1q
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 22:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWILUpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 16:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWILUpR
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 16:45:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:11927 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030429AbWILUpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Sep 2006 16:45:16 -0400
Received: (qmail invoked by alias); 12 Sep 2006 20:45:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp007) with SMTP; 12 Sep 2006 22:45:14 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net, Jeff King <peff@peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26892>


Actually, teach runstatus what to do if it is not passed; it should not list
the contents of completely untracked directories, but only the name of that
directory (plus a trailing '/').

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-runstatus.c |    2 ++
 git-commit.sh       |    3 ++-
 wt-status.c         |    3 +++
 wt-status.h         |    1 +
 4 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 7979d61..303c556 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -25,6 +25,8 @@ int cmd_runstatus(int argc, const char *
 		}
 		else if (!strcmp(argv[i], "--verbose"))
 			s.verbose = 1;
+		else if (!strcmp(argv[i], "--untracked"))
+			s.untracked = 1;
 		else
 			usage(runstatus_usage);
 	}
diff --git a/git-commit.sh b/git-commit.sh
index 10c269a..5a4c659 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -82,7 +82,8 @@ run_status () {
   esac
   git-runstatus ${color} \
                 ${verbose:+--verbose} \
-                ${amend:+--amend}
+                ${amend:+--amend} \
+		${untracked_files:+--untracked}
 }
 
 trap '
diff --git a/wt-status.c b/wt-status.c
index ec2c728..4398f9b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -50,6 +50,7 @@ void wt_status_prepare(struct wt_status 
 	s->amend = 0;
 	s->verbose = 0;
 	s->commitable = 0;
+	s->untracked = 0;
 }
 
 static void wt_status_print_header(const char *main, const char *sub)
@@ -188,6 +189,8 @@ static void wt_status_print_untracked(co
 	memset(&dir, 0, sizeof(dir));
 
 	dir.exclude_per_dir = ".gitignore";
+	if (!s->untracked)
+		dir.show_other_directories = 1;
 	x = git_path("info/exclude");
 	if (file_exists(x))
 		add_excludes_from_file(&dir, x);
diff --git a/wt-status.h b/wt-status.h
index 75d3cfe..0a5a5b7 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -15,6 +15,7 @@ struct wt_status {
 	int commitable;
 	int verbose;
 	int amend;
+	int untracked;
 };
 
 int git_status_config(const char *var, const char *value);
-- 
1.4.2.g1734-dirty
