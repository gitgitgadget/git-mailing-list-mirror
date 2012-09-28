From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 03/21] git p4: generate better error message for bad depot path
Date: Fri, 28 Sep 2012 08:04:07 -0400
Message-ID: <1348833865-6093-4-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:05:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZK6-0001Kz-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab2I1MF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:05:29 -0400
Received: from honk.padd.com ([74.3.171.149]:34957 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012Ab2I1MF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:05:29 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 92E565AF2;
	Fri, 28 Sep 2012 05:05:28 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2F98B31413; Fri, 28 Sep 2012 08:05:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206560>

Depot paths must start with //.  Exit with a better explanation
when a bad depot path is supplied.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py               | 1 +
 t/t9800-git-p4-basic.sh | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 97699ef..eef5c94 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3035,6 +3035,7 @@ class P4Clone(P4Sync):
         self.cloneExclude = ["/"+p for p in self.cloneExclude]
         for p in depotPaths:
             if not p.startswith("//"):
+                sys.stderr.write('Depot paths must start with "//": %s\n' % p)
                 return False
 
         if not self.cloneDestination:
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index b7ad716..c5f4c88 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -30,6 +30,11 @@ test_expect_success 'basic git p4 clone' '
 	)
 '
 
+test_expect_success 'depot typo error' '
+	test_must_fail git p4 clone --dest="$git" /depot 2>errs &&
+	grep -q "Depot paths must start with" errs
+'
+
 test_expect_success 'git p4 clone @all' '
 	git p4 clone --dest="$git" //depot@all &&
 	test_when_finished cleanup_git &&
-- 
1.7.12.1.403.g28165e1
