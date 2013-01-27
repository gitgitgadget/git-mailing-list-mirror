From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 03/21] git p4: generate better error message for bad depot path
Date: Sat, 26 Jan 2013 22:11:06 -0500
Message-ID: <1359256284-5660-4-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:12:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIfp-0004bh-9x
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab3A0DM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:12:28 -0500
Received: from honk.padd.com ([74.3.171.149]:58692 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:12:27 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 3C5972F3F;
	Sat, 26 Jan 2013 19:12:27 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3DEDE22838; Sat, 26 Jan 2013 22:12:24 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214653>

Depot paths must start with //.  Exit with a better explanation
when a bad depot path is supplied.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py               | 1 +
 t/t9800-git-p4-basic.sh | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 47d092d..cbf8525 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3163,6 +3163,7 @@ class P4Clone(P4Sync):
         self.cloneExclude = ["/"+p for p in self.cloneExclude]
         for p in depotPaths:
             if not p.startswith("//"):
+                sys.stderr.write('Depot paths must start with "//": %s\n' % p)
                 return False
 
         if not self.cloneDestination:
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 166e752..665607c 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -30,6 +30,11 @@ test_expect_success 'basic git p4 clone' '
 	)
 '
 
+test_expect_success 'depot typo error' '
+	test_must_fail git p4 clone --dest="$git" /depot 2>errs &&
+	grep "Depot paths must start with" errs
+'
+
 test_expect_success 'git p4 clone @all' '
 	git p4 clone --dest="$git" //depot@all &&
 	test_when_finished cleanup_git &&
-- 
1.8.1.1.460.g6fa8886
