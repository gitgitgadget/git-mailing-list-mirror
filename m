From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [BUG, PATCH] git add -p: demonstrate failure when staging both mode and hunk
Date: Sat, 15 Aug 2009 16:26:49 +0400
Message-ID: <1250339209-27962-1-git-send-email-kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 15 14:51:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McIin-0007Ff-OO
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 14:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055AbZHOMrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 08:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbZHOMrD
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 08:47:03 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:50117 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbZHOMrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 08:47:03 -0400
X-Greylist: delayed 1021 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Aug 2009 08:47:02 EDT
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1McIOO-0002OZ-0E; Sat, 15 Aug 2009 16:29:54 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1McILg-0007HZ-Jm; Sat, 15 Aug 2009 16:27:04 +0400
X-Mailer: git-send-email 1.6.4.134.gb2139
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126002>

When trying to stage changes to file which has also pending `chmod +x`,
`git add -p` produces lots of 'Use of uninitialized value ...' warnings
and fails to do the job:

    $ echo content >> file
    $ chmod +x file
    $ git add -p
    diff --git a/file b/file
    index e69de29..d95f3ad
    --- a/file
    +++ b/file
    old mode 100644
    new mode 100755
    Stage mode change [y,n,q,a,d,/,j,J,g,?]? y
    @@ -0,0 +1 @@
    +content
    Stage this hunk [y,n,q,a,d,/,K,g,e,?]? y
    Use of uninitialized value $o_ofs in addition (+) at /home/kirr/local/git/libexec/git-core/git-add--interactive line 776.
    Use of uninitialized value $ofs in numeric le (<=) at /home/kirr/local/git/libexec/git-core/git-add--interactive line 806.
    Use of uninitialized value $o0_ofs in concatenation (.) or string at /home/kirr/local/git/libexec/git-core/git-add--interactive line 830.
    Use of uninitialized value $n0_ofs in concatenation (.) or string at /home/kirr/local/git/libexec/git-core/git-add--interactive line 830.
    Use of uninitialized value $o_ofs in addition (+) at /home/kirr/local/git/libexec/git-core/git-add--interactive line 776.
    fatal: corrupt patch at line 5
    diff --git a/file b/file
    index e69de29..d95f3ad
    --- a/file
    +++ b/file
    @@ -,0 + @@
    +content

Cc: Jeff King <peff@peff.net>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 t/t3701-add-interactive.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fd2a55a..d5e9351 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -163,6 +163,17 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
 	git diff          file | grep "+content"
 '
 
+
+test_expect_failure FILEMODE 'stage mode and hunk' '
+	git reset --hard &&
+	echo content >>file &&
+	chmod +x file &&
+	printf "y\\ny\\n" | git add -p &&
+	git diff --cached file | grep "new mode" &&
+	git diff --cached file | grep "+content" &&
+	test -z "$(git diff file)"
+'
+
 # end of tests disabled when filemode is not usable
 
 test_expect_success 'setup again' '
-- 
1.6.4.134.gb2139
