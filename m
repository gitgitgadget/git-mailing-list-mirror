From: Bryan Jacobs <bjacobs@woti.com>
Subject: [PATCH] Teach dcommit --mergeinfo to handle multiple lines
Date: Wed, 31 Aug 2011 12:48:39 -0400
Organization: White Oak Technologies
Message-ID: <20110831124839.69c70486@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 18:48:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyny5-0001uL-Cl
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab1HaQso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:48:44 -0400
Received: from mail02.woti.us ([66.92.158.6]:60366 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756842Ab1HaQsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:48:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id E85C6504D37F0
	for <git@vger.kernel.org>; Wed, 31 Aug 2011 12:48:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fiqL6I9pLcIP for <git@vger.kernel.org>;
	Wed, 31 Aug 2011 12:48:40 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 8CF34504D37EA
	for <git@vger.kernel.org>; Wed, 31 Aug 2011 12:48:40 -0400 (EDT)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180486>

"svn dcommit --mergeinfo" replaces the svn:mergeinfo property in an
upstream SVN repository with the given text. The svn:mergeinfo
property may contain commits originating on multiple branches,
separated by newlines.

Cause space characters in the mergeinfo to be replaced by newlines,
allowing a user to create history representing multiple branches being
merged into one.

Update the corresponding documentation and add a test for the new
functionality.

Signed-off-by: Bryan Jacobs <bjacobs@woti.com>
---
 Documentation/git-svn.txt    |    5 +++--
 git-svn.perl                 |    3 +++
 t/t9158-git-svn-mergeinfo.sh |   13 +++++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ed5eca1..3ed28df 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -211,8 +211,9 @@ discouraged.
 	Add the given merge information during the dcommit
 	(e.g. `--mergeinfo="/branches/foo:1-10"`). All svn server versions can
 	store this information (as a property), and svn clients starting from
-	version 1.5 can make use of it. 'git svn' currently does not use it
-	and does not set it automatically.
+	version 1.5 can make use of it. To specify merge information from multiple
+	branches, use a single space character between the branches
+	(`--mergeinfo="/branches/foo:1-10 /branches/bar:3,5-6,8"`)
 
 'branch'::
 	Create a branch in the SVN repository.
diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..3ee26a2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -548,6 +548,9 @@ sub cmd_dcommit {
 	}
 	my $expect_url = $url;
 	Git::SVN::remove_username($expect_url);
+	if (defined($_merge_info)) {
+		$_merge_info =~ tr{ }{\n};
+	}
 	while (1) {
 		my $d = shift @$linear_refs or last;
 		unless (defined $last_rev) {
diff --git a/t/t9158-git-svn-mergeinfo.sh b/t/t9158-git-svn-mergeinfo.sh
index 3ab4390..8c9539e 100755
--- a/t/t9158-git-svn-mergeinfo.sh
+++ b/t/t9158-git-svn-mergeinfo.sh
@@ -38,4 +38,17 @@ test_expect_success 'verify svn:mergeinfo' '
 	test "$mergeinfo" = "/branches/foo:1-10"
 '
 
+test_expect_success 'change svn:mergeinfo multiline' '
+	touch baz &&
+	git add baz &&
+	git commit -m "baz" &&
+	git svn dcommit --mergeinfo="/branches/bar:1-10 /branches/other:3-5,8,10-11"
+'
+
+test_expect_success 'verify svn:mergeinfo multiline' '
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/trunk)
+	test "$mergeinfo" = "/branches/bar:1-10
+/branches/other:3-5,8,10-11"
+'
+
 test_done
-- 
1.7.6
