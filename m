From: Alex Bennee <kernel-hacker@bennee.com>
Subject: [PATCH] cvs export: ensure we add directories in order
Date: Thu, 18 Oct 2007 17:15:44 +0100
Organization: Insert joke here
Message-ID: <1192724144.26933.64.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 18:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiYTY-0000R6-5F
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 18:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754AbXJRQns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 12:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757509AbXJRQns
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 12:43:48 -0400
Received: from mx.transitive.com ([217.207.128.220]:54436 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757594AbXJRQnr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 12:43:47 -0400
X-Greylist: delayed 1717 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2007 12:43:47 EDT
Received: from [192.168.2.164] (helo=[192.168.2.164])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1IiY0J-0000Rr-RA
	for git@vger.kernel.org; Thu, 18 Oct 2007 16:13:48 +0000
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61545>

Hi,

CVS gets understandably upset if you try and add a subdirectory before
it's parent directory. This patch fixes that.

>From d99d4e7eb0ce7b85fb84d3c57f57abbb100baa5e Mon Sep 17 00:00:00 2001
From: Alex Bennee <alex@bennee.com>
Date: Thu, 18 Oct 2007 17:12:13 +0100
Subject: [PATCH] Ensure we add directories in the correct order

---
 git-cvsexportcommit.perl |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 0a21215..a70c583 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -234,6 +234,17 @@ print "Applying\n";
 
 print "Patch applied successfully. Adding new files and directories to CVS\n";
 my $dirtypatch = 0;
+
+#
+# We have to add the directories in order otherwise we will have
+# problems when we try and add the sub-directory of a directory we
+# have not added yet.
+#
+# Luckily this is easy to deal with by sorting the directories and
+# dealing with the shortest ones first.
+#
+@dirs = sort { length $a <=> length $b} @dirs;
+
 foreach my $d (@dirs) {
     if (system(@cvs,'add',$d)) {
 	$dirtypatch = 1;
-- 
1.5.2.5



-- 
Alex, homepage: http://www.bennee.com/~alex/
Business is a good game -- lots of competition and minimum of rules. You
keep score with money. -- Nolan Bushnell, founder of Atari
