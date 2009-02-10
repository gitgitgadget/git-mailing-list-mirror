From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH v2] Support "\" in non-wildcard exclusion entries
Date: Tue, 10 Feb 2009 15:20:17 +0100
Message-ID: <20090210142017.GA16478@pvv.org>
References: <20090210121149.GA1226@pvv.org> <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de> <20090210125800.GA14800@pvv.org> <alpine.DEB.1.00.0902101402230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 10 15:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWtUl-0006ki-5Z
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 15:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbZBJOUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 09:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754383AbZBJOUY
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 09:20:24 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:38596 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbZBJOUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 09:20:23 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LWtTG-00008D-08; Tue, 10 Feb 2009 15:20:18 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902101402230.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109244>

"\" was treated differently in exclude rules depending on whether a
wildcard match was done. For wildcard rules, "\" was de-escaped in
fnmatch, but this was not done for other rules since they used strcmp
instead.  A file named "#foo" would not be excluded by "\#foo", but would
be excluded by "\#foo*".

We now treat all rules with "\" as wildcard rules.

Another solution could be to de-escape all non-wildcard rules as we
read them, but we would have to do the de-escaping exactly as fnmatch
does it to avoid inconsistencies.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 dir.c                                       |    2 +-
 t/t3003-ls-files-others-escaped-excludes.sh |   37 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletions(-)
 create mode 100755 t/t3003-ls-files-others-escaped-excludes.sh

diff --git a/dir.c b/dir.c
index cfd1ea5..2245749 100644
--- a/dir.c
+++ b/dir.c
@@ -137,7 +137,7 @@ int match_pathspec(const char **pathspec, const char *name, int namelen,
 
 static int no_wildcard(const char *string)
 {
-	return string[strcspn(string, "*?[{")] == '\0';
+	return string[strcspn(string, "*?[{\\")] == '\0';
 }
 
 void add_exclude(const char *string, const char *base,
diff --git a/t/t3003-ls-files-others-escaped-excludes.sh b/t/t3003-ls-files-others-escaped-excludes.sh
new file mode 100755
index 0000000..bce8741
--- /dev/null
+++ b/t/t3003-ls-files-others-escaped-excludes.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Finn Arne Gangstad
+#
+
+test_description='git ls-files --others with escaped excludes
+
+This test tests exclusion patterns with \ in them and makes sure they
+are treated correctly and identically both for normal and wildcard rules.
+'
+
+. ./test-lib.sh
+
+touch \#ignore1 &&
+touch \#ignore2 &&
+touch \#hidden &&
+touch keep
+
+echo keep > expect
+
+cat >.gitignore <<EOF
+.gitignore
+expect
+output
+\#ignore1
+\#ignore2*
+\#hid*n
+EOF
+
+test_expect_success \
+    'git ls-files --others with escaped excludes.' \
+    'git ls-files --others \
+       --exclude-per-directory=.gitignore \
+       >output &&
+     test_cmp expect output'
+
+test_done
-- 
1.6.2.rc0.11.g665ed
