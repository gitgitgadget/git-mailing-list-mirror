From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 14/23] Introduce --tree-same.
Date: Sat, 23 Apr 2011 17:22:43 +1000
Message-ID: <1303543372-77843-15-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCt-00054D-Fa
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568Ab1DWHYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39715 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab1DWHY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:28 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so584380pzk.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=GF0iw/rl2uF8WV9sj0hve/0EBwBENuBjjszIw3eG0jU=;
        b=qK2A17NG138eeKmc27IH94PMzm0B5b3++Vi58yInn7ax2ODuI/YC1hOdKMbtbvpjbm
         O0gSrYfIL6dF8G2InJC/9GCWG3O1gQ+Oh2RmKBoVmfwE28HZ1PZE7emTHeIkUJbFgo1a
         ATS5RVw1pmbC/jcMXa2ofFnXQFxj5BjsZ3em0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O63+JX/MQ/kf9Xpc+3dyLTlVSqchzKVoI6PBwWT8NhrK75LVcrYryT1eE0rq8b1XKa
         ScllOfb1gxinPrdy0STedgfDSmCuxFDvXw9DPQ11yapSFRjT4vuEypjf2FG3CjoUD70W
         ss/JetGORw4VTJKuxsr/Fua+gCt8xInI8s8/4=
Received: by 10.68.25.166 with SMTP id d6mr2898404pbg.136.1303543468561;
        Sat, 23 Apr 2011 00:24:28 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171971>

---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   12 ++++++++++++
 t/t1520-test.sh            |    9 +++++++++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index e28ed88..6709fdd 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -88,6 +88,8 @@ CONDITIONS
         Tests if the specified branch is (not) checked out.
 '--reachable'|'--not-reachable' first second::
 	Tests if the first commit is (not) reachable from the second.
+'--tree-same'|'--not-tree-same' first second::
+        Tests if the first commit is (not) tree-same to the second commit.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 0223fcd..2b7a5d1 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -150,5 +150,17 @@ check_reachable_2()
 	fi     
 }
 
+check_tree_same_2()
+{
+	if git diff-tree --quiet "$1" "$2"
+	then
+		echo "'$1' has the same tree as '$2'."
+	else
+		echo "'$1' does not have the same tree as '$2'."
+		false
+	fi
+
+}
+
 
 fi
diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index 3e33f8a..1fd5122 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -399,4 +399,13 @@ test_expect_success 'git test --not-reachable F C' \
        git test --not-reachable F C
 '
 
+test_expect_success 'tree-same' \
+'
+   git test \
+     --tree-same master HEAD \
+     --tree-same D D1 \
+     --not-tree-same C D
+
+'
+
 test_done
-- 
1.7.5.rc1.23.g7f622
