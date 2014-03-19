From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] t5510: Do not use $(pwd) when fetching / pushing / pulling
 via rsync
Date: Wed, 19 Mar 2014 20:43:53 +0100
Message-ID: <5329F379.3010508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, thomas.braun@byte-physics.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 20:44:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQMPT-00066h-FQ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 20:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbaCSToP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 15:44:15 -0400
Received: from plane.gmane.org ([80.91.229.3]:47308 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914AbaCSToO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 15:44:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WQMPK-0005pa-TN
	for git@vger.kernel.org; Wed, 19 Mar 2014 20:44:10 +0100
Received: from p5ddb3c92.dip0.t-ipconnect.de ([93.219.60.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 20:44:10 +0100
Received: from sschuberth by p5ddb3c92.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 20:44:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb3c92.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244484>

On MINGW, "pwd" is defined as "pwd -W" in test-lib.sh. This usually is the
right thing, but the absolute Windows path with a colon confuses rsync. We
could use $PWD in this case to work around the issue, but in fact there is
no need to use an absolute path in the first place, so get rid of it.

This was discovered in the context of the mingwGitDevEnv project and only
did not surface before with msysgit because the latter does not ship
rsync.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 t/t5510-fetch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ab28594..5acd753 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -301,7 +301,7 @@ test_expect_success 'fetch via rsync' '
 	mkdir rsynced &&
 	(cd rsynced &&
 	 git init --bare &&
-	 git fetch "rsync:$(pwd)/../.git" master:refs/heads/master &&
+	 git fetch "rsync:../.git" master:refs/heads/master &&
 	 git gc --prune &&
 	 test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
 	 git fsck --full)
@@ -312,7 +312,7 @@ test_expect_success 'push via rsync' '
 	(cd rsynced2 &&
 	 git init) &&
 	(cd rsynced &&
-	 git push "rsync:$(pwd)/../rsynced2/.git" master) &&
+	 git push "rsync:../rsynced2/.git" master) &&
 	(cd rsynced2 &&
 	 git gc --prune &&
 	 test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
@@ -323,7 +323,7 @@ test_expect_success 'push via rsync' '
 	mkdir rsynced3 &&
 	(cd rsynced3 &&
 	 git init) &&
-	git push --all "rsync:$(pwd)/rsynced3/.git" &&
+	git push --all "rsync:rsynced3/.git" &&
 	(cd rsynced3 &&
 	 test $(git rev-parse master) = $(cd .. && git rev-parse master) &&
 	 git fsck --full)
-- 
1.8.5.2.msysgit.0
