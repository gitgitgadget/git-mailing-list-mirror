From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] More test cases for sanitized path names
Date: Fri, 1 Feb 2008 05:34:55 +0100
Message-ID: <200802010534.55925.robin.rosenberg.lists@dewire.com>
References: <47975FE6.4050709@viscovery.net> <7v7ihtqfm8.fsf@gitster.siamese.dyndns.org> <7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 05:35:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKnce-0006B0-DY
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 05:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbYBAEen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 23:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbYBAEen
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 23:34:43 -0500
Received: from [83.140.172.130] ([83.140.172.130]:8285 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbYBAEem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 23:34:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id ACE5B1475CE3;
	Fri,  1 Feb 2008 05:34:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D0bZtbC-V31m; Fri,  1 Feb 2008 05:34:40 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 1FA40802641;
	Fri,  1 Feb 2008 05:34:40 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72147>

Verify a few more commands and pathname variants.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 t/t7010-setup.sh |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

These are a few testcases from my earlier attempt at this. The
log and commit cases succeeded with Junios version, but not 
blame and some of the nastier versions for git add (same
principle for all commands, just that I use add as an example)

-- robin

diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index da20ba5..60c4a46 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -114,4 +114,43 @@ test_expect_success 'git ls-files (relative #3)' '
 
 '
 
+test_expect_success 'commit using absolute path names' '
+	git commit -m "foo" &&
+	echo aa >>a/b/c/d &&
+	git commit -m "aa" "$(pwd)/a/b/c/d"
+'
+
+test_expect_success 'log using absolute path names' '
+	echo bb >>a/b/c/d &&
+	git commit -m "bb" $(pwd)/a/b/c/d &&
+
+	git log a/b/c/d >f1.txt &&
+	git log "$(pwd)/a/b/c/d" >f2.txt &&
+	diff -u f1.txt f2.txt
+'
+
+test_expect_success 'blame using absolute path names' '
+	git blame a/b/c/d >f1.txt &&
+	git blame "$(pwd)/a/b/c/d" >f2.txt &&
+	diff -u f1.txt f2.txt
+'
+
+test_expect_failure 'add a directory outside the work tree' '
+	d1="$(cd .. ; pwd)" &&
+	git add "$d1"
+	echo $?
+'
+
+test_expect_failure 'add a file outside the work tree, nasty case 1' '(
+	f="$(pwd)x" &&
+	touch "$f" &&
+	git add "$f"
+)'
+
+test_expect_failure 'add a file outside the work tree, nasty case 2' '(
+	f="$(pwd|sed "s/.$//")x" &&
+	touch "$f" &&
+	git add "$f"
+)'
+
 test_done
-- 
1.5.4.rc4.25.g81cc
