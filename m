From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/8] repack -A -d: use --keep-unreachable when repacking
Date: Mon, 17 Sep 2007 01:27:08 -0700
Message-ID: <11900176341630-git-send-email-gitster@pobox.com>
References: <1190017633436-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 11:43:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD8a-0006vM-Cu
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbXIQJnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbXIQJnI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:43:08 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42683 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbXIQJnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:43:07 -0400
X-Greylist: delayed 4537 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2007 05:42:51 EDT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917082714.YZCP3549.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 17 Sep 2007 04:27:14 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id pLTE1X00J1gtr5g0000000; Mon, 17 Sep 2007 04:27:15 -0400
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <1190017633436-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58418>

This is a safer variant of "repack -a -d" that does not drop
unreachable objects that are in packs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-repack.sh |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 156c5e8..204084e 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,17 +3,19 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'
+USAGE='[-a|-A] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
-no_update_info= all_into_one= remove_redundant=
+no_update_info= all_into_one= remove_redundant= keep_unreachable=
 local= quiet= no_reuse= extra=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	-n)	no_update_info=t ;;
 	-a)	all_into_one=t ;;
+	-A)	all_into_one=t
+		keep_unreachable=t ;;
 	-d)	remove_redundant=t ;;
 	-q)	quiet=-q ;;
 	-f)	no_reuse=--no-reuse-object ;;
@@ -59,7 +61,13 @@ case ",$all_into_one," in
 			fi
 		done
 	fi
-	[ -z "$args" ] && args='--unpacked --incremental'
+	if test -z "$args"
+	then
+		args='--unpacked --incremental'
+	elif test -n "$keep_unreachable"
+	then
+		args="$args --keep-unreachable"
+	fi
 	;;
 esac
 
-- 
1.5.3.1.967.g6bb01
