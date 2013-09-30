From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH] git-svn: fix signed commit parsing
Date: Mon, 30 Sep 2013 16:46:14 +0200
Message-ID: <1380552374-26103-1-git-send-email-boklm@mars-attacks.org>
Cc: normalperson@yhbt.net, Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 30 16:59:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQewL-0003qv-Rg
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 16:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab3I3O7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 10:59:09 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:48685 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab3I3O7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 10:59:08 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2013 10:59:08 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 12CD44E5B;
	Mon, 30 Sep 2013 16:50:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TjRg-9bUAhOd; Mon, 30 Sep 2013 16:50:10 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 5E22E422A;
	Mon, 30 Sep 2013 16:50:10 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id CC783438C6; Mon, 30 Sep 2013 16:49:57 +0200 (CEST)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235614>

When parsing a commit object, git-svn wrongly think that a line
containing spaces means the end of headers and the start of the commit
message. In case of signed commit, the gpgsig entry contains a line with
one space, so "git svn dcommit" will include part of the signature in
the commit message.

An example of such problem :
http://svnweb.mageia.org/treasurer?view=revision&revision=86

This commit changes the regex to only match an empty line as separator
between the headers and the commit message.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 git-svn.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index ff1ce3d..1823db1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1759,7 +1759,7 @@ sub get_commit_entry {
 		my $msgbuf = "";
 		while (<$msg_fh>) {
 			if (!$in_msg) {
-				$in_msg = 1 if (/^\s*$/);
+				$in_msg = 1 if (/^$/);
 				$author = $1 if (/^author (.*>)/);
 			} elsif (/^git-svn-id: /) {
 				# skip this for now, we regenerate the
-- 
1.8.4
