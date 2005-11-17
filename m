From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Add git-config-set, a simple helper for scripts to set config
 variables
Date: Thu, 17 Nov 2005 22:44:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511172244230.18285@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Nov 17 22:47:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcrYx-0000zi-FX
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVKQVo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVKQVo5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:44:57 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50361 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751355AbVKQVo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 16:44:56 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6445013FCDA; Thu, 17 Nov 2005 22:44:55 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 41547B5231; Thu, 17 Nov 2005 22:44:55 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 24209B5215; Thu, 17 Nov 2005 22:44:55 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 16AC913FCD6; Thu, 17 Nov 2005 22:44:55 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12156>


This is meant for the end user, who cannot be expected to edit
.git/config by hand.

Example:

	git-config-set core.filemode true

will set filemode in the section [core] to true,

	git-config-set --unset core.filemode

will remove the entry (failing if it is not there), and

	git-config-set --unset diff.twohead ^recar

will remove the unique entry whose value matches the regex "^recar"
(failing if there is no unique such entry).

It is just a light wrapper around git_config_set() and
git_config_set_multivar().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

 .gitignore   |    1 +
 Makefile     |    3 ++-
 config-set.c |   26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletions(-)
 create mode 100644 config-set.c

applies-to: 8ff699dffc817e92fb2101f538f84c38d5ed0a0f
acf7869a158171bf4552d0b0da64b20d48e4bf27
diff --git a/.gitignore b/.gitignore
index 0dd7b9c..d17a8b5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,6 +17,7 @@ git-clone
 git-clone-pack
 git-commit
 git-commit-tree
+git-config-set
 git-convert-objects
 git-count-objects
 git-cvsexportcommit
diff --git a/Makefile b/Makefile
index ebff990..8e84e28 100644
--- a/Makefile
+++ b/Makefile
@@ -125,7 +125,8 @@ PROGRAMS = \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
-	git-name-rev$X git-pack-redundant$X git-var$X $(SIMPLE_PROGRAMS)
+	git-name-rev$X git-pack-redundant$X git-config-set$X git-var$X \
+	$(SIMPLE_PROGRAMS)
 
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
diff --git a/config-set.c b/config-set.c
new file mode 100644
index 0000000..1b1547b
--- /dev/null
+++ b/config-set.c
@@ -0,0 +1,26 @@
+#include "cache.h"
+
+static const char git_config_set_usage[] =
+"git-config-set name [value [value_regex]] | --unset name [value_regex]";
+
+int main(int argc, const char **argv)
+{
+	setup_git_directory();
+	switch (argc) {
+	case 2:
+		return git_config_set(argv[1], NULL);
+	case 3:
+		if (!strcmp(argv[1], "--unset"))
+			return git_config_set(argv[2], NULL);
+		else
+			return git_config_set(argv[1], argv[2]);
+	case 4:
+		if (!strcmp(argv[1], "--unset"))
+			return git_config_set_multivar(argv[2], NULL, argv[3]);
+		else
+			return git_config_set_multivar(argv[1], argv[2], argv[3]);
+	default:
+		usage(git_config_set_usage);
+	}
+	return 0;
+}
---
0.99.9.GIT
