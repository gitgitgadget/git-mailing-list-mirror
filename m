From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] pager: config variable pager.program
Date: Sat, 29 Jul 2006 23:28:13 +0200
Message-ID: <E1G6wM1-00040z-Bu@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 29 23:28:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6wMG-0003aq-Uv
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 23:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWG2V2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 17:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWG2V2Q
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 17:28:16 -0400
Received: from moooo.ath.cx ([85.116.203.178]:51921 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932226AbWG2V2Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 17:28:16 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24437>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
I'd like to use another pager (or other options) with git than the
normal pager.  Normally I would not want the -R option with less but
for git less should show colors.
---
 Documentation/config.txt |    5 +++++
 pager.c                  |   16 +++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 465eb13..96429b6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -116,6 +116,11 @@ apply.whitespace::
 	Tells `git-apply` how to handle whitespaces, in the same way
 	as the '--whitespace' option. See gitlink:git-apply[1].
 
+pager.program::
+	Use this program as pager.  git will try this configuration
+	variable first, then the 'PAGER' environment variable and
+	"less" as fallback.
+
 diff.color::
 	When true (or `always`), always use colors in patch.
 	When false (or `never`), never.  When set to `auto`, use
diff --git a/pager.c b/pager.c
index 280f57f..3f753f6 100644
--- a/pager.c
+++ b/pager.c
@@ -5,6 +5,18 @@ #include "cache.h"
  * something different on Windows, for example.
  */
 
+static const char *pager = NULL;
+
+static int git_pager_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "pager.program")) {
+		if (value)
+			pager = strdup(value);
+		return 0;
+	}
+	return 0;
+}
+
 static void run_pager(const char *pager)
 {
 	execlp(pager, pager, NULL);
@@ -15,10 +27,12 @@ void setup_pager(void)
 {
 	pid_t pid;
 	int fd[2];
-	const char *pager = getenv("PAGER");
 
 	if (!isatty(1))
 		return;
+	git_config(git_pager_config);
+	if (!pager)
+		pager = getenv("PAGER");
 	if (!pager)
 		pager = "less";
 	else if (!*pager || !strcmp(pager, "cat"))
-- 
1.4.2.rc2.g688a
