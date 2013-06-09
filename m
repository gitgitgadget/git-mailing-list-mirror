From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 23/36] rebase: split the cherry-pick stuff
Date: Sun,  9 Jun 2013 14:24:37 -0500
Message-ID: <1370805890-3453-24-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHi-0003yF-Tn
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab3FIT1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:51 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33053 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab3FIT1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:50 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so8851153obb.8
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xwlDW92VQTZqv0BKTXHw7466nEmf9RcGbinrmWbdqpM=;
        b=Pa3rzd8AJRj7LRLqsjh3tQpgTQGQOJi/FQgESzLUTauISJSeXNoWDZjKpen9boBujw
         bPefWyqSNnbWC3xUisdpbAREEdAXnop/88DC7hUs+7NOgGc85BgfUPTNB8yBMOGDFH4R
         Ao24IMY8L7K1h7UfC3GStcEI5IhMT7tAWFusF87BA7vVPSmTjVGd3xFRxMiyCDZRHCZQ
         stD5raBRssIykUEJXLmKQQLjzeM5huFunJwQcY9DbGJEf9noOsG77Ro73Vtxy0pvDxlD
         M642mnmuvb0DQLyOFQ7BI8NzVrV9iYichop7OSimI7V9qVKMSpZDlTX/nslID6m7PYhg
         gOMQ==
X-Received: by 10.60.80.39 with SMTP id o7mr1348338oex.60.1370806070179;
        Sun, 09 Jun 2013 12:27:50 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id rs4sm8782308obc.10.2013.06.09.12.27.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227131>

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
index 1640c3a..2a3dbae 100644
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
index a167e68..4719979 100644
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
index 34e3102..6460028 100644
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
index d0c11a9..70762f1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -413,6 +413,10 @@ elif test -n "$do_merge"
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
1.8.3.698.g079b096
