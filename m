From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/3] Fix race condition in t9119-git-svn-info.sh
Date: Tue,  5 Aug 2008 00:35:17 -0700
Message-ID: <1217921718-25011-2-git-send-email-normalperson@yhbt.net>
References: <1217921718-25011-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 09:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQH5l-0001pq-FP
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 09:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbYHEHfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 03:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbYHEHfX
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 03:35:23 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52150 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbYHEHfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 03:35:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BE4862DC032;
	Tue,  5 Aug 2008 00:35:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.69.g797ea
In-Reply-To: <1217921718-25011-1-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91430>

From: David D. Kilzer <ddkilzer@kilzer.net>

Changed the ptouch bash function to use the "Text Last Updated"
date reported by 'svn info' when changing the modified time
(mtime) of the file/symlink/directory in the git working
directory.  Previously it used the mtime of the item in the
svn working directory, which caused the race condition.

[ew: swapped argument order of ptouch() to minimize diff]

From: David D. Kilzer <ddkilzer@kilzer.net>

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9119-git-svn-info.sh |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index cc61911..964011e 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -11,11 +11,18 @@ test_done
 ptouch() {
 	perl -w -e '
 		use strict;
+		use POSIX qw(mktime);
 		die "ptouch requires exactly 2 arguments" if @ARGV != 2;
-		die "$ARGV[0] does not exist" if ! -e $ARGV[0];
-		my @s = stat $ARGV[0];
-		utime $s[8], $s[9], $ARGV[1];
-	' "$1" "$2"
+		my $text_last_updated = shift @ARGV;
+		my $git_file = shift @ARGV;
+		die "\"$git_file\" does not exist" if ! -e $git_file;
+		if ($text_last_updated
+		    =~ /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/) {
+			my $mtime = mktime($6, $5, $4, $3, $2 - 1, $1 - 1900);
+			my $atime = $mtime;
+			utime $atime, $mtime, $git_file;
+		}
+	' "`svn info $2 | grep '^Text Last Updated:'`" "$1"
 }
 
 test_expect_success 'setup repository and import' "
-- 
1.6.0.rc1.69.g797ea
