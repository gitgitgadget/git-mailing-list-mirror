From: skimo@liacs.nl
Subject: [PATCH 01/15] Add dump-config
Date: Sun, 20 May 2007 20:04:34 +0200
Message-ID: <11796842882228-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmp-0007La-2a
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873AbXETSFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756970AbXETSFC
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:02 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37198 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756881AbXETSE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:04:57 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4mph007797;
	Sun, 20 May 2007 20:04:53 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 9562C7DDA0; Sun, 20 May 2007 20:04:48 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47865>

From: Sven Verdoolaege <skimo@kotnet.org>

This command dumps the config of a repository and will be used
to read config options from a remote site.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 .gitignore                        |    1 +
 Documentation/cmd-list.perl       |    1 +
 Documentation/git-dump-config.txt |   37 +++++++++++++++++++++++++++++++++++++
 Makefile                          |    1 +
 daemon.c                          |    7 +++++++
 dump-config.c                     |   29 +++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-dump-config.txt
 create mode 100644 dump-config.c

diff --git a/.gitignore b/.gitignore
index 4dc0c39..d4e5492 100644
--- a/.gitignore
+++ b/.gitignore
@@ -38,6 +38,7 @@ git-diff-files
 git-diff-index
 git-diff-tree
 git-describe
+git-dump-config
 git-fast-import
 git-fetch
 git-fetch--tool
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 443802a..fa04615 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -103,6 +103,7 @@ git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff                                mainporcelain
 git-diff-tree                           plumbinginterrogators
+git-dump-config                         synchelpers
 git-fast-import				ancillarymanipulators
 git-fetch                               mainporcelain
 git-fetch-pack                          synchingrepositories
diff --git a/Documentation/git-dump-config.txt b/Documentation/git-dump-config.txt
new file mode 100644
index 0000000..370781c
--- /dev/null
+++ b/Documentation/git-dump-config.txt
@@ -0,0 +1,37 @@
+git-dump-config(1)
+====================
+
+NAME
+----
+git-dump-config - Dump config options
+
+
+SYNOPSIS
+--------
+'git-dump-config' <directory>
+
+DESCRIPTION
+-----------
+Invoked by 'git-config --remote' and dumps the config file to the
+other end over the git protocol.
+
+This command is usually not invoked directly by the end user.  The UI
+for the protocol is on the 'git-config' side, where it is used to get
+options from a remote repository.
+
+OPTIONS
+-------
+<directory>::
+	The repository to get the config options from.
+
+Author
+------
+Written by Sven Verdoolaege.
+
+Documentation
+--------------
+Documentation by Sven Verdoolaege.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 29243c6..37eb861 100644
--- a/Makefile
+++ b/Makefile
@@ -240,6 +240,7 @@ PROGRAMS = \
 	git-fast-import$X \
 	git-merge-base$X \
 	git-daemon$X \
+	git-dump-config$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-patch-id$X \
 	git-peek-remote$X git-receive-pack$X \
 	git-send-pack$X git-shell$X \
diff --git a/daemon.c b/daemon.c
index e74ecac..3e5ebf3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -378,10 +378,17 @@ static int receive_pack(void)
 	return -1;
 }
 
+static int dump_config(void)
+{
+	execl_git_cmd("dump-config", ".", NULL);
+	return -1;
+}
+
 static struct daemon_service daemon_service[] = {
 	{ "upload-archive", "uploadarch", upload_archive, 0, 1 },
 	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
 	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
+	{ "dump-config", "dumpconfig", dump_config, 0, 1 },
 };
 
 static void enable_service(const char *name, int ena) {
diff --git a/dump-config.c b/dump-config.c
new file mode 100644
index 0000000..355920d
--- /dev/null
+++ b/dump-config.c
@@ -0,0 +1,29 @@
+#include "git-compat-util.h"
+#include "cache.h"
+#include "pkt-line.h"
+
+static const char dump_config_usage[] = "git-dump-config <dir>";
+
+static int dump_config(const char *var, const char *value)
+{
+	packet_write(1, "%s", var);
+	packet_write(1, "%s", value);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	char *dir;
+
+	if (argc != 2)
+		usage(dump_config_usage);
+
+	dir = argv[1];
+	if (!enter_repo(dir, 0))
+		die("'%s': unable to chdir or not a git archive", dir);
+
+	git_config(dump_config);
+	packet_flush(1);
+
+	return 0;
+}
-- 
1.5.2.rc3.815.g8fc2
