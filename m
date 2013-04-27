From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-gui: fix file name handling with non-empty prefix
Date: Sat, 27 Apr 2013 14:24:16 +0100
Message-ID: <264998b2b2201b7d6ab9bfa8b5518f712b3a6a08.1367069056.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Andrew Wong <andrew.kw.w@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Apr 27 15:24:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW57D-0006bq-0a
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 15:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab3D0NYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 09:24:31 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:44318 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab3D0NYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 09:24:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 315A4CDA59C;
	Sat, 27 Apr 2013 14:24:30 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id irv6uZhtOZFn; Sat, 27 Apr 2013 14:24:29 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EAE49CDA5B0;
	Sat, 27 Apr 2013 14:24:23 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc0.149.g98a72f2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222646>

Commit e3d06ca (git-gui: Detect full path when parsing arguments -
2012-10-02) fixed the handling of absolute paths passed to the browser
and blame subcommands by checking whether the file exists without the
prefix before prepending the prefix and checking again.  Since we have
chdir'd to the top level of the working tree before doing this, this
does not work if a file with the same name exists in a subdirectory and
at the top level (for example Makefile in git.git's t/ directory).

Instead of doing this, revert that patch and fix absolute path issue by
using "file join" to prepend the prefix to the supplied path.  This will
correctly handle absolute paths by skipping the prefix in that case.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-gui.sh | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index e133331..a94ad7f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3003,19 +3003,11 @@ blame {
 	set jump_spec {}
 	set is_path 0
 	foreach a $argv {
-		if {[file exists $a]} {
-			if {$path ne {}} usage
-			set path [normalize_relpath $a]
-			break
-		} elseif {[file exists $_prefix$a]} {
-			if {$path ne {}} usage
-			set path [normalize_relpath $_prefix$a]
-			break
-		}
+		set p [file join $_prefix $a]
 
-		if {$is_path} {
+		if {$is_path || [file exists $p]} {
 			if {$path ne {}} usage
-			set path [normalize_relpath $_prefix$a]
+			set path [normalize_relpath $p]
 			break
 		} elseif {$a eq {--}} {
 			if {$path ne {}} {
-- 
1.8.3.rc0.149.g98a72f2.dirty
