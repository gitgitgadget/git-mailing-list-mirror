From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 1/8] rebase: split the cherry-pick stuff
Date: Tue, 28 May 2013 23:16:33 -0500
Message-ID: <1369801000-3705-2-git-send-email-felipe.contreras@gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 06:18:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXqK-0002DH-MJ
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab3E2ESZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:18:25 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33826 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3E2ESY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:18:24 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so424255obc.38
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=51v36r6e3E4rn81gzYFVi1lytZS6EOe5k6qGeEojNSA=;
        b=ZaRUeKcw0ofa4CfSoorULpQ0Dqbr58mLTUOzUJ2skbrDTohlclDRqg7VOHpWrkPprm
         rg5BCkUtajoSGQ3UrnMF9uJyQ48KNyQVMq5QLhfyhuEmx33LiwdVF8gNa0LlpfNDBm+Y
         ZUqHsLtlG9z/5Hi7lJEjPa3dMmiBRzgs9STzhXviu/TBKcPT3FcLECE5B80GYFm1xGLV
         pPKDn5HPY0qhp2ptOTOcs0eVidl44e6G84hkK33RYM6FJ6plWoNehszT2DRF32ECAjhR
         tsz2ka5y12loIi9TRryVbXWmzgvYBdX5AwvfDi6x1UaI8sYVaXWo5uWQwycOxdIBw5IL
         VQWg==
X-Received: by 10.60.103.76 with SMTP id fu12mr545295oeb.71.1369801104094;
        Tue, 28 May 2013 21:18:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zn5sm38339996obc.10.2013.05.28.21.18.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 21:18:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225724>

They do something completely different from 'git am', it belongs in a
different file.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore                |  1 +
 Makefile                  |  1 +
 git-rebase--am.sh         | 11 +----------
 git-rebase--cherrypick.sh | 34 ++++++++++++++++++++++++++++++++++
 git-rebase.sh             |  4 ++++
 5 files changed, 41 insertions(+), 10 deletions(-)
 create mode 100644 git-rebase--cherrypick.sh

diff --git a/.gitignore b/.gitignore
index 6669bf0..a171533 100644
--- a/.gitignore
+++ b/.gitignore
@@ -113,6 +113,7 @@
 /git-read-tree
 /git-rebase
 /git-rebase--am
+/git-rebase--cherrypick
 /git-rebase--interactive
 /git-rebase--merge
 /git-receive-pack
diff --git a/Makefile b/Makefile
index 0f931a2..800e42d 100644
--- a/Makefile
+++ b/Makefile
@@ -469,6 +469,7 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
+SCRIPT_LIB += git-rebase--cherrypick
 SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index f84854f..ee1b1b9 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -19,15 +19,7 @@ esac
 test -n "$rebase_root" && root_flag=--root
 
 ret=0
-if test -n "$keep_empty"
-then
-	# we have to do this the hard way.  git format-patch completely squashes
-	# empty commits and even if it didn't the format doesn't really lend
-	# itself well to recording empty patches.  fortunately, cherry-pick
-	# makes this easy
-	git cherry-pick --allow-empty "$revisions"
-	ret=$?
-else
+
 rm -f "$GIT_DIR/rebased-patches"
 
 git format-patch -k --stdout --full-index --ignore-if-in-upstream \
@@ -63,7 +55,6 @@ else
 ret=$?
 
 rm -f "$GIT_DIR/rebased-patches"
-fi
 
 if test 0 != $ret
 then
diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
new file mode 100644
index 0000000..cbf80f9
--- /dev/null
+++ b/git-rebase--cherrypick.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Junio C Hamano.
+#
+
+case "$action" in
+continue)
+	git am --resolved --resolvemsg="$resolvemsg" &&
+	move_to_original_branch
+	exit
+	;;
+skip)
+	git am --skip --resolvemsg="$resolvemsg" &&
+	move_to_original_branch
+	exit
+	;;
+esac
+
+test -n "$rebase_root" && root_flag=--root
+
+# we have to do this the hard way.  git format-patch completely squashes
+# empty commits and even if it didn't the format doesn't really lend
+# itself well to recording empty patches.  fortunately, cherry-pick
+# makes this easy
+git cherry-pick --allow-empty "$revisions"
+ret=$?
+
+if test 0 != $ret
+then
+	test -d "$state_dir" && write_basic_state
+	exit $ret
+fi
+
+move_to_original_branch
diff --git a/git-rebase.sh b/git-rebase.sh
index 2c692c3..f929ca3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -379,6 +379,10 @@ elif test -n "$do_merge"
 then
 	type=merge
 	state_dir="$merge_dir"
+elif test -n "$keep_empty"
+then
+	type=cherrypick
+	state_dir="$apply_dir"
 else
 	type=am
 	state_dir="$apply_dir"
-- 
1.8.3.rc3.312.g47657de
