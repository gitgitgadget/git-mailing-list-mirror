From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 13/23] Introduce --reachable
Date: Sat, 23 Apr 2011 17:22:42 +1000
Message-ID: <1303543372-77843-14-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCs-00054D-Pk
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab1DWHYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:30 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34280 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab1DWHYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:25 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so862616pxi.10
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=H31r6/KRDF8yN/SNNtca/d6+syoyU6DF0M864JnYrUI=;
        b=dSsJOLkRCRtB+Y+7+uYy9pGbWgyXE3Ry9as3Y6D4yxP+Zes1XJvra/K+qk0762LQmU
         tC18G7uI6bkHEFAG9xnoqcjN+JvzVNGOsE0PAZpl2kiYIR1bwN+lcNBEUskfxTpPTvPl
         5ue+Zm9oP+NTMZL5V0e3RhxMZEWNfknsTZ89o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EfHOViZ8whA9H4cGe+/hG1Qd/fT4DqywlDt4BzIIuaoSv6iccz6Feil2TtECyE2PlK
         nqIEMkBgtFQgchjBlGK2C6ccDgz5hyX+U0aZgVKLiZfdEME7G8DZgnokvY3NNQ8htbtr
         RA355GdHTZHsfOFSfxY05538zc0h+Fzuh/gYw=
Received: by 10.68.56.106 with SMTP id z10mr635762pbp.292.1303543465427;
        Sat, 23 Apr 2011 00:24:25 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171966>

reachable
---
 Documentation/git-test.txt |    2 +
 git-conditions-lib.sh      |   14 ++++++
 t/t1520-test.sh            |  101 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index f76aa38..e28ed88 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -86,6 +86,8 @@ CONDITIONS
 	Tests if the specified commit does (not) exist.
 '--checked-out'|'--not-checked-out branch'::
         Tests if the specified branch is (not) checked out.
+'--reachable'|'--not-reachable' first second::
+	Tests if the first commit is (not) reachable from the second.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 3eccc19..0223fcd 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -136,5 +136,19 @@ check_checked_out_1()
 
 }
 
+check_reachable_2()
+{
+	first=$(git rev-parse --quiet --verify "$1" 2>/dev/null) || die "'$1' is not a commit"
+	second=$(git rev-parse --quiet --verify "$2" 2>/dev/null) || die "'$2' is not a commit"
+	if test "$first" = "$second" \
+                -o -z "$(git rev-list -n1 "$first" ^"$second")" 
+	then
+		echo "'$1' is reachable from '$2'."
+	else
+		echo "'$1' is not reachable from '$2'."
+		false
+	fi     
+}
+
 
 fi
diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index bb39050..3e33f8a 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -298,4 +298,105 @@ test_expect_success 'git test --detached # when detached' \
 	git test --detached
 '
 
+
+test_expect_success 'git test --reachable #should fail' \
+'
+	test_must_fail git test --reachable
+'
+
+test_expect_success 'git test --not-reachable #should fail' \
+'
+	test_must_fail git test --reachable
+'
+
+test_expect_success 'git test --reachable A #should fail' \
+'
+	test_must_fail git test --reachable A
+'
+
+test_expect_success 'git test --not-reachable A #should fail' \
+'
+	test_must_fail git test --not-reachable A
+'
+
+test_expect_success 'git test --reachable does-not-exist-1 does-not-exist-2 #should fail' \
+'
+	test_must_fail git test --reachable does-not-exist-1 does-not-exist-2
+'
+
+test_expect_success 'git test --not-reachable does-not-exist-1 does-not-exist-2 #should fail' \
+'
+	test_must_fail git test --not-reachable does-not-exist-1 does-not-exist-2
+'
+
+test_expect_success 'git test --reachable does-not-exist-1 A #should fail' \
+'
+	test_must_fail git test --reachable does-not-exist-1 A
+'
+
+test_expect_success 'git test --not-reachable does-not-exist-1 A #should fail' \
+'
+	test_must_fail git test --not-reachable does-not-exist-1 A
+'
+
+test_expect_success 'git test --reachable A does-not-exist-2 #should fail' \
+'
+	test_must_fail git test --reachable A does-not-exist-2
+'
+
+test_expect_success 'git test --not-reachable A does-not-exist-2 #should fail' \
+'
+	test_must_fail git test --not-reachable A does-not-exist-2
+'
+
+test_expect_success 'git test --reachable A C' \
+'
+       git test --reachable A C
+'
+
+test_expect_success 'git test --not-reachable A C # should fail' \
+'
+       test_must_fail git test --not-reachable A C
+'
+
+test_expect_success 'git test --reachable C A # should fail' \
+'
+       test_must_fail git test --reachable C A
+'
+
+test_expect_success 'git test --not-reachable C A # should fail' \
+'
+       git test --not-reachable C A
+'
+
+test_expect_success 'git test --reachable C C' \
+'
+       git test --reachable C C
+'
+
+test_expect_success 'git test --not-reachable C C' \
+'
+       test_must_fail git test --not-reachable C C
+'
+
+test_expect_success 'git test --reachable C F' \
+'
+       test_must_fail git test --reachable C F
+'
+
+test_expect_success 'git test --not-reachable C F' \
+'
+       git test --not-reachable C F
+'
+
+test_expect_success 'git test --reachable F C' \
+'
+       test_must_fail git test --reachable F C
+'
+
+test_expect_success 'git test --not-reachable F C' \
+'
+       git test --not-reachable F C
+'
+
 test_done
-- 
1.7.5.rc1.23.g7f622
