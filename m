From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix core.sharedRepository = 2
Date: Wed, 11 Jul 2007 15:18:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707111517050.4516@racer.site>
References: <Pine.LNX.4.64.0707111338360.4516@racer.site>
 <20070711135656.GA28593@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 16:26:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8d8s-0003Uw-3w
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 16:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763057AbXGKO0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 10:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762700AbXGKO0E
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 10:26:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:43892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759978AbXGKO0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 10:26:03 -0400
Received: (qmail invoked by alias); 11 Jul 2007 14:26:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 11 Jul 2007 16:26:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+c37oQt6Sca2m7MCqfzDqchKpiKvB0yuVHcxBHp8
	cU9Q4woUDze1hD
X-X-Sender: gene099@racer.site
In-Reply-To: <20070711135656.GA28593@piper.oerlikon.madduck.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52162>


For compatibility reasons, "git init --shared=all" does not write
"all" into the config, but a number.  In the shared setup, you
really have to support even older clients on the _same_ repository.

But git_config_perm() did not pick up on it.

Also, "git update-server-info" failed to pick up on the shared
permissions.

This patch fixes both issues, and adds a test to prove it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 11 Jul 2007, martin f krafft wrote:

	> also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de>
	> > Earlier, update-server-info used the umask, even if
	> > core.sharedRepository = 1.
	> > 
	> > Noticed by madduck on IRC.
	> > 	Does this work for you?
	>	 
	> Yes, it does, but only if I put = all/group into the config. 
	> init-db --shared=all however sets core.sharedRepository=2, and 
	> then update-server-info produces a 0660 file.

	Should be fixed now.

 server-info.c          |    2 ++
 setup.c                |    4 ++++
 t/t1301-shared-repo.sh |   27 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100755 t/t1301-shared-repo.sh

diff --git a/server-info.c b/server-info.c
index f9be5a7..0d1312c 100644
--- a/server-info.c
+++ b/server-info.c
@@ -38,6 +38,7 @@ static int update_info_refs(int force)
 		return error("unable to update %s", path0);
 	for_each_ref(add_info_ref, NULL);
 	fclose(info_ref_fp);
+	adjust_shared_perm(path1);
 	rename(path1, path0);
 	free(path0);
 	free(path1);
@@ -227,6 +228,7 @@ static int update_info_packs(int force)
 		return error("cannot open %s", name);
 	write_pack_info_file(fp);
 	fclose(fp);
+	adjust_shared_perm(name);
 	rename(name, infofile);
 	return 0;
 }
diff --git a/setup.c b/setup.c
index bb26f3a..7b07144 100644
--- a/setup.c
+++ b/setup.c
@@ -364,6 +364,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 int git_config_perm(const char *var, const char *value)
 {
 	if (value) {
+		int i;
 		if (!strcmp(value, "umask"))
 			return PERM_UMASK;
 		if (!strcmp(value, "group"))
@@ -372,6 +373,9 @@ int git_config_perm(const char *var, const char *value)
 		    !strcmp(value, "world") ||
 		    !strcmp(value, "everybody"))
 			return PERM_EVERYBODY;
+		i = atoi(value);
+		if (i > 1)
+			return i;
 	}
 	return git_config_bool(var, value);
 }
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
new file mode 100755
index 0000000..bb5f302
--- /dev/null
+++ b/t/t1301-shared-repo.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes Schindelin
+#
+
+test_description='Test shared repository initialization'
+
+. ./test-lib.sh
+
+test_expect_success 'shared=all' '
+	mkdir sub &&
+	cd sub &&
+	git init --shared=all &&
+	test 2 = $(git config core.sharedrepository)
+'
+
+test_expect_success 'update-server-info honors core.sharedRepository' '
+	: > a1 &&
+	git add a1 &&
+	test_tick &&
+	git commit -m a1 &&
+	umask 0277 &&
+	git update-server-info &&
+	test 444 = $(stat -c %a .git/info/refs)
+'
+
+test_done
-- 
1.5.3.rc0.2783.gf3f7
