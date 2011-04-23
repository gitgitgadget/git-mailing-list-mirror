From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 02/23] Introduce --unstaged.
Date: Sat, 23 Apr 2011 17:22:31 +1000
Message-ID: <1303543372-77843-3-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCQ-0004jf-8F
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab1DWHX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:23:59 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34280 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab1DWHXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:23:50 -0400
Received: by pxi2 with SMTP id 2so862616pxi.10
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=IDli/3L1oFeF0Pl27Hdnib4ID9ZywVUp/fgxF8YH388=;
        b=MDavR7opfyWO+cHYMrrSEx7kl8D7QEJElgGo57mGoPDN00IEOJY+4hQYjzja8Wa2oW
         Zf7lWHKrdeoHJ7+KkZchG5BfaCX3P1jQ5tlObp85S0tu8sLB/3W/qGhYTIV7ydAVu4NT
         0YyMVdef7Pxxjc1hjtfbNhuz/QBQXJw77e7yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b32gbb/yECrrWYvkxprpBriCHtNFAKcWsG2gIMDeJVLDsrc/kcun8ODcBVundIOEYd
         vvnhPnp6dtpHu9830bQLM5lQa3Iq2tBPcJHnpX3oU4rU1dgpP7IQ+PYdwCyxu7L7Ch3W
         4a11QJTGtkAXi4YlP+smHDbPATneJb7eZ7I4c=
Received: by 10.68.10.98 with SMTP id h2mr2767055pbb.372.1303543430408;
        Sat, 23 Apr 2011 00:23:50 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.23.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:23:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171956>

test_must_fail: unstaged
---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   11 +++++++++++
 t/t1520-test.sh            |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 1792c4e..4b2c129 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -64,6 +64,8 @@ OPTIONS
 
 CONDITIONS
 ----------
+'--unstaged'|'--not-unstaged'::
+	Tests if there are (not) any unstaged changes in the working tree.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index f462e22..f9ff0b9 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -8,5 +8,16 @@ __GIT_CONDITIONS_LIB_INCLUDED=t
 #
 # Provides a function that enables the evaluation of assertions.
 #
+check_unstaged_0()
+{
+	if test $(git diff-files --name-only | wc -l) -ne 0
+	then
+		echo "There are unstaged files."
+	else
+		echo "There are no unstaged files."
+		false
+	fi
+}
+
 
 fi
diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index 9e3abe6..8543943 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -181,5 +181,40 @@ test_expect_success 'git test --not-always-fails-0' \
 '
 	git test --not-always-fails-0
 '
+
+test_expect_success 'git test --unstaged # should fail' \
+'
+	test_must_fail git test --unstaged
+'
+
+test_expect_success 'git test --not-unstaged' \
+'
+	git test --not-unstaged
+'
+
+test_expect_success 'git test --unstaged # when there are unstaged files' \
+'
+	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	git checkout -f M^0 &&
+	git stash apply --index STASH_UNSTAGED &&
+	git test --unstaged
+'
+
+test_expect_success 'git test --not-unstaged # when there are unstaged files - should fail' \
+'
+	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	git checkout -f M^0 &&
+	git stash apply --index STASH_UNSTAGED &&
+	test_must_fail git test --not-unstaged
+'
+
+test_expect_success 'git test --unstaged # when there are only staged files' \
+'
+	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	git checkout -f M^0 &&
+	git stash apply --index STASH_STAGED &&
+	git test --not-unstaged
+'
+
 '
 test_done
-- 
1.7.5.rc1.23.g7f622
