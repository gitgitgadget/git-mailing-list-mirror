From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 13/28] rebase: split the cherry-pick stuff
Date: Fri, 30 Aug 2013 00:56:07 -0500
Message-ID: <1377842182-18724-14-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmI-0007TR-24
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab3H3GBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:35 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:44708 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab3H3GBd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:33 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so1757038oah.39
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wG5a+pNBXCt/iOSpGucdtmQ50qya5lJ8OwO8fYTG+W8=;
        b=LDWBr1q7fLA6GR/V0pFDkH7o46J10gJ/Wu7DLWM0jNIwLCUwJ9UOcuLm+jQHIQp8Ok
         Z4gxYMcjD81Ud/KJmPGSdAcSHCwFC5yI1GbSNIyGlA8YHLKrO6GOiGnII/yX9P7Z0dvX
         W02xXo86o9Hv0MT1YAKxGlcLXQ8M1C9NG9O4OCgms9pedpJhZIwtZckPgi5acxqs4ksb
         7ZlqSGVcscrTZj6fwJ7hqJrMUi8zlQC6IoYQ+DT1fA4weCcDwTdK/vP1LCRmf8GHt5S/
         W0uF4yastcMB/BUBk+Gs7IzC6ufpy6bafloUGYejzndvyOEaIbqXaBks9rLkjtMUOf/z
         DJ9A==
X-Received: by 10.182.92.231 with SMTP id cp7mr5320006obb.82.1377842493419;
        Thu, 29 Aug 2013 23:01:33 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm35755624obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233407>

They do something completely different from 'git am', it belongs in a
different file.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore                |  1 +
 Makefile                  |  1 +
 git-rebase--am.sh         | 11 +----------
 git-rebase--cherrypick.sh | 30 ++++++++++++++++++++++++++++++
 git-rebase.sh             |  4 ++++
 5 files changed, 37 insertions(+), 10 deletions(-)
 create mode 100644 git-rebase--cherrypick.sh

diff --git a/.gitignore b/.gitignore
index 6b1fd1b..3514737 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,6 +114,7 @@
 /git-read-tree
 /git-rebase
 /git-rebase--am
+/git-rebase--cherrypick
 /git-rebase--interactive
 /git-rebase--merge
 /git-receive-pack
diff --git a/Makefile b/Makefile
index 9396d57..2d6521e 100644
--- a/Makefile
+++ b/Makefile
@@ -473,6 +473,7 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
+SCRIPT_LIB += git-rebase--cherrypick
 SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 34e3102..aae6a85 100644
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
index 0000000..2c16995
--- /dev/null
+++ b/git-rebase--cherrypick.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Junio C Hamano.
+#
+
+case "$action" in
+continue)
+	git am --resolved --resolvemsg="$resolvemsg" &&
+	move_to_original_branch
+	return
+	;;
+skip)
+	git am --skip --resolvemsg="$resolvemsg" &&
+	move_to_original_branch
+	return
+	;;
+esac
+
+test -n "$rebase_root" && root_flag=--root
+
+git cherry-pick --allow-empty "$revisions"
+ret=$?
+
+if test 0 != $ret
+then
+	test -d "$state_dir" && write_basic_state
+	return $ret
+fi
+
+move_to_original_branch
diff --git a/git-rebase.sh b/git-rebase.sh
index 8d7659a..2310638 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -412,6 +412,10 @@ elif test -n "$do_merge"
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
1.8.4-fc
