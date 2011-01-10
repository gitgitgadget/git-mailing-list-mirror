From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] submodule: fix relative url parsing for scp-style origin
Date: Mon, 10 Jan 2011 11:37:26 +0100
Message-ID: <7a578ef3384a891cebd4a39421302983499771e0.1294655635.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 10 11:37:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcF8B-0005nq-GB
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 11:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab1AJKhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 05:37:33 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:41213 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459Ab1AJKhb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 05:37:31 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 11:37:29 +0100
Received: from localhost.localdomain (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 11:37:29 +0100
X-Mailer: git-send-email 1.7.4.rc1.309.g58aa0
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164869>

The function resolve_relative_url was not prepared to deal with an
scp-style origin 'user@host:path' in the case where 'path' is only a
single component.  Fix this by extending the logic that strips one
path component from the $remoteurl.

Also add tests for both styles of URLs.

Noticed-by: Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

If Mark agrees with the fix, I think this should go in before 1.7.4
since it's a pretty annoying bug.

 git-submodule.sh           |   16 ++++++++++++++--
 t/t7400-submodule-basic.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c21b77a..8b90589 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -37,12 +37,24 @@ resolve_relative_url ()
 		die "remote ($remote) does not have a url defined in .git/config"
 	url="$1"
 	remoteurl=${remoteurl%/}
+	sep=/
 	while test -n "$url"
 	do
 		case "$url" in
 		../*)
 			url="${url#../}"
-			remoteurl="${remoteurl%/*}"
+			case "$remoteurl" in
+			*/*)
+				remoteurl="${remoteurl%/*}"
+				;;
+			*:*)
+				remoteurl="${remoteurl%:*}"
+				sep=:
+				;;
+			*)
+				die "cannot strip one component off url '$remoteurl'"
+				;;
+			esac
 			;;
 		./*)
 			url="${url#./}"
@@ -51,7 +63,7 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
-	echo "$remoteurl/${url%/}"
+	echo "$remoteurl$sep${url%/}"
 }
 
 #
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2c49db9..874279e 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -446,4 +446,42 @@ test_expect_success 'add should fail when path is used by an existing directory'
 	)
 '
 
+test_expect_success 'set up for relative path tests' '
+	mkdir reltest &&
+	(
+		cd reltest &&
+		git init &&
+		mkdir sub &&
+		(
+			cd sub &&
+			git init &&
+			test_commit foo
+		) &&
+		git add sub &&
+		git config -f .gitmodules submodule.sub.path sub &&
+		git config -f .gitmodules submodule.sub.url ../subrepo &&
+		cp .git/config pristine-.git-config
+	)
+'
+
+test_expect_success 'relative path works with URL' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ssh://hostname/repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ssh://hostname/subrepo
+	)
+'
+
+test_expect_success 'relative path works with user@host:path' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url user@host:repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = user@host:subrepo
+	)
+'
+
 test_done
-- 
1.7.4.rc1.309.g58aa0
