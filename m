From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] test suite: add a check that all test numbers are unique
Date: Fri, 21 Aug 2009 11:28:15 +0200
Message-ID: <4A8E68AF.8040001@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 11:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeQQD-0001S0-NF
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 11:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbZHUJ2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 05:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755179AbZHUJ2Y
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 05:28:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47516 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbZHUJ2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 05:28:23 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MeQPv-0006e1-SF; Fri, 21 Aug 2009 11:28:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8755C9F88; Fri, 21 Aug 2009 11:28:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126701>

From: Johannes Sixt <j6t@kdbg.org>

The test runs only if 'make all' is used. Its purpose is to alert our
valued integrator if different branches are merged that happen to
introduce the same test number.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/Makefile                |    1 +
 t/check_unique_numbers.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100755 t/check_unique_numbers.sh

diff --git a/t/Makefile b/t/Makefile
index bd09390..2a451b7 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -17,6 +17,7 @@ T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)

 all: pre-clean
+	'$(SHELL_PATH_SQ)' ./check_unique_numbers.sh
 	$(MAKE) aggregate-results-and-cleanup

 $(T):
diff --git a/t/check_unique_numbers.sh b/t/check_unique_numbers.sh
new file mode 100755
index 0000000..e767275
--- /dev/null
+++ b/t/check_unique_numbers.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+# checks whether test case numbers are unique;
+# returns non-zero if any duplicates were found
+
+check_numbers () {
+	last= dup=
+	while read name
+	do
+		case $name in
+		t[0-9][0-9][0-9][0-9]-*.sh)
+			number=${name%%-*}
+			if test "$number" = "$last"; then
+				dup="$dup $number"
+			fi
+			last=$number
+			;;
+		esac
+	done
+	test -z "$dup" || {
+		echo >&2 "error: duplicate test numbers:" $dup
+		return 1
+	}
+}
+
+ls -1 |	# no wildcard to avoid overflow of command line
+check_numbers
-- 
1.6.4.204.g6aad7
