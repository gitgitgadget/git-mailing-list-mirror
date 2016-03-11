From: Jim Klimov <jim@jimklimov.com>
Subject: [PATCH 6/6] gitweb.perl : the optional DEBUG functionality is now
 unit-tested
Date: Fri, 11 Mar 2016 14:24:49 +0100
Message-ID: <1457702689-9084-6-git-send-email-jim@jimklimov.com>
References: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
Content-Transfer-Encoding: 7BIT
Cc: Jim Klimov <jim@jimklimov.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 14:30:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeN9J-0000qY-V3
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 14:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbcCKNac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 08:30:32 -0500
Received: from relay-mta.cos.ru ([93.175.31.8]:43370 "EHLO relay-mta.cos.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbcCKNaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 08:30:30 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Mar 2016 08:30:25 EST
Received: from sunmail.cos.ru (mail.cos.ru [81.5.113.73])
	by relay-mta.cos.ru (8.14.3+Sun/8.14.3) with ESMTP id u2BDOxJt025365
	for <git@vger.kernel.org>; Fri, 11 Mar 2016 16:25:08 +0300 (MSK)
Received: from debian8.roz.lab.etn.com. ([31.7.243.238])
 by sunmail.cos.ru (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26
 2008; 64bit)) with ESMTPA id <0O3V0013IMPRKC00@sunmail.cos.ru> for
 git@vger.kernel.org; Fri, 11 Mar 2016 16:27:36 +0300 (MSK)
X-Mailer: git-send-email 2.8.0.rc1.4.ge2bf47e.dirty
In-reply-to: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
X-Greylist-Inspected: inspected by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:08 +0300 (MSK) for IP:'81.5.113.73' DOMAIN:'mail.cos.ru' HELO:'sunmail.cos.ru' FROM:'jim@jimklimov.com'
X-Greylist: Sender IP whitelisted, ACL 386 matched, not delayed by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:08 +0300 (MSK)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288681>

---
 t/t9502-gitweb-standalone-parse-output.sh | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index a2ae5c4..4f1ddbf 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -253,6 +253,41 @@ test_expect_success 'snapshot certain objects: have expected content in xx/test
 test_debug 'cat gitweb.headers && cat file_list'
 
 # ----------------------------------------------------------------------
+# optional debugging in log, if allowed on server and requested by user
+
+test_expect_success 'snapshot: debugging logged as forbidden when not defined in server environment' '
+	rm -f gitweb.body gitweb.log gitweb.headers gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=master;sf=tar;debug=yes" &&
+	grep "GITWEB_MAY_DEBUG=yes is not set" < gitweb.log >/dev/null
+'
+test_debug 'cat gitweb.headers gitweb.log'
+
+test_expect_success 'snapshot: debugging logged as forbidden when not allowed in server environment' '
+	rm -f gitweb.body gitweb.log gitweb.headers gitweb.output &&
+	GITWEB_MAY_DEBUG=xxx && export GITWEB_MAY_DEBUG &&
+	gitweb_run "p=.git;a=snapshot;h=master;sf=tar;debug=yes" &&
+	grep "GITWEB_MAY_DEBUG=yes is not set" < gitweb.log >/dev/null
+'
+test_debug 'cat gitweb.headers gitweb.log'
+
+test_expect_success 'snapshot: debugging present when allowed in server environment' '
+	rm -f gitweb.body gitweb.log gitweb.headers gitweb.output &&
+	GITWEB_MAY_DEBUG=yes && export GITWEB_MAY_DEBUG &&
+	gitweb_run "p=.git;a=snapshot;h=master;sf=tar;debug=yes" &&
+	! grep "GITWEB_MAY_DEBUG=yes is not set" < gitweb.log >/dev/null &&
+	grep "git-archive" < gitweb.log >/dev/null
+'
+test_debug 'cat gitweb.headers gitweb.log'
+
+test_expect_success 'snapshot: debugging absent when not allowed in server environment' '
+	rm -f gitweb.body gitweb.log gitweb.headers gitweb.output &&
+	GITWEB_MAY_DEBUG=xxx && export GITWEB_MAY_DEBUG &&
+	gitweb_run "p=.git;a=snapshot;h=master;sf=tar;debug=yes" &&
+	! grep "git-archive" < gitweb.log >/dev/null
+'
+test_debug 'cat gitweb.headers gitweb.log'
+
+# ----------------------------------------------------------------------
 # forks of projects
 
 test_expect_success 'forks: setup' '
-- 
2.1.4
