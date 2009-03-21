From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 04/16] t0050: Check whether git init detected symbolic link support correctly
Date: Sat, 21 Mar 2009 22:26:27 +0100
Message-ID: <64e61f2d173b0172d9dbaa9667486764224568fb.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:28:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8kF-0003u8-IH
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbZCUV1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbZCUV07
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:26:59 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27920 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1DEBE1001D;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D9DEA427B8;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114058>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0050-filesystem.sh |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index a449580..89282cc 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -9,7 +9,8 @@ aumlcdiar=`printf '\x61\xcc\x88'`
 
 case_insensitive=
 unibad=
-test_expect_success 'see if we expect ' '
+no_symlinks=
+test_expect_success 'see what we expect' '
 
 	test_case=test_expect_success
 	test_unicode=test_expect_success
@@ -31,13 +32,21 @@ test_expect_success 'see if we expect ' '
 		;;
 	*)	;;
 	esac &&
-	rm -fr junk
+	rm -fr junk &&
+	{
+		ln -s x y 2> /dev/null &&
+		test -h y 2> /dev/null ||
+		no_symlinks=1
+		rm -f y
+	}
 '
 
 test "$case_insensitive" &&
 	say "will test on a case insensitive filesystem"
 test "$unibad" &&
 	say "will test on a unicode corrupting filesystem"
+test "$no_symlinks" &&
+	say "will test on a filesystem lacking symbolic links"
 
 if test "$case_insensitive"
 then
@@ -53,6 +62,21 @@ test_expect_success "detection of case insensitive filesystem during repo init"
 '
 fi
 
+if test "$no_symlinks"
+then
+test_expect_success "detection of filesystem w/o symlink support during repo init" '
+
+	v=$(git config --bool core.symlinks) &&
+	test "$v" = false
+'
+else
+test_expect_success "detection of filesystem w/o symlink support during repo init" '
+
+	test_must_fail git config --bool core.symlinks ||
+	test "$(git config --bool core.symlinks)" = true
+'
+fi
+
 test_expect_success "setup case tests" '
 
 	git config core.ignorecase true &&
-- 
1.6.2.1.224.g2225f
