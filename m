From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 3/6] git submodule foreach: Provide access to submodule
 name, as '$name'
Date: Wed, 19 Aug 2009 03:45:21 +0200
Message-ID: <1250646324-961-4-git-send-email-johan@herland.net>
References: <1250646324-961-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	mlevedahl@gmail.com, hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 03:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdaFT-0006td-Gj
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 03:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbZHSBps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 21:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbZHSBpr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 21:45:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43415 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751312AbZHSBpo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 21:45:44 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL004CXOWAVN10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:46 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00EC4OW53WE0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:46 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.19.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1250646324-961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126490>

The argument to 'git submodule foreach' already has access to the variables
'$path' (the path to the submodule, relative to the superproject) and '$sha1'
(the submodule commit recorded by the superproject).

This patch adds another variable - '$name' - which contains the name of the
submodule, as recorded in the superproject's .gitmodules file.

Verification of the behaviour of '$name' is also added to the git submodule
foreach selftest.

Signed-off-by: Johan Herland <johan@herland.net>
---

This patch was initially sent stand-alone on 2009-08-16.


...Johan


 Documentation/git-submodule.txt |    3 ++-
 git-submodule.sh                |    1 +
 t/t7407-submodule-foreach.sh    |    6 +++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bb7d159..cfa8d73 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -135,7 +135,8 @@ summary::
 
 foreach::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $path and $sha1:
+	The command has access to the variables $name, $path and $sha1:
+	$name is the name of the relevant submodule section in .gitmodules,
 	$path is the name of the submodule directory relative to the
 	superproject, and $sha1 is the commit as recorded in the superproject.
 	Any submodules defined in the superproject but not checked out are
diff --git a/git-submodule.sh b/git-submodule.sh
index c58eca4..6163d01 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -266,6 +266,7 @@ cmd_foreach()
 		if test -e "$path"/.git
 		then
 			say "Entering '$path'"
+			name=$(module_name "$path")
 			(cd "$path" && eval "$@") ||
 			die "Stopping at '$path'; script returned non-zero status."
 		fi
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 76e0734..991aa80 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -61,9 +61,9 @@ sub3sha1=$(cd super/sub3 && git rev-parse HEAD)
 
 cat > expect <<EOF
 Entering 'sub1'
-sub1-$sub1sha1
+foo1-sub1-$sub1sha1
 Entering 'sub3'
-sub3-$sub3sha1
+foo3-sub3-$sub3sha1
 EOF
 
 test_expect_success 'test basic "submodule foreach" usage' '
@@ -71,7 +71,7 @@ test_expect_success 'test basic "submodule foreach" usage' '
 	(
 		cd clone &&
 		git submodule update --init -- sub1 sub3 &&
-		git submodule foreach "echo \$path-\$sha1" > ../actual
+		git submodule foreach "echo \$name-\$path-\$sha1" > ../actual
 	) &&
 	test_cmp expect actual
 '
-- 
1.6.4.304.g1365c.dirty
