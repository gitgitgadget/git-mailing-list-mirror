From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 1/2] Modify tr expression so that xpg4/tr handles it on Solaris
Date: Sat, 18 Jul 2015 16:21:17 +0100
Message-ID: <1437232877-27897-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 18 17:58:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGUVe-0005ga-0u
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 17:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbbGRP6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 11:58:36 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:42429 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbbGRP6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 11:58:35 -0400
X-Greylist: delayed 2353 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jul 2015 11:58:35 EDT
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:50771 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGTtZ-0005VE-Iz ; Sat, 18 Jul 2015 11:19:21 -0400
Received: from 86-42-134-176-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.134.176]:44771 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGTtY-0006zY-Nf ; Sat, 18 Jul 2015 11:19:20 -0400
Received: from bdwalton by neilyoung with local (Exim 4.84)
	(envelope-from <bdwalton@benandwen.net>)
	id 1ZGTvW-0007Ga-Oj; Sat, 18 Jul 2015 16:21:22 +0100
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274165>

It seems that xpg4/tr mishandles some strings involving [ not followed
by a character class:
% echo '[::1]' | /usr/xpg4/bin/tr -d '[]'
[::1

% echo '[::1]' | /usr/xpg4/bin/tr -d '['
usr/xpg4/bin/tr: Bad string.

This was breaking two tests. To fix the issue, use the octal
representations of [ and ] instead.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t5500-fetch-pack.sh |    2 +-
 t/t5601-clone.sh      |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3a9b775..5bc4da9 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -547,7 +547,7 @@ check_prot_host_port_path () {
 		*ssh*)
 		pp=ssh
 		uah=userandhost
-		ehost=$(echo $3 | tr -d "[]")
+		ehost=$(echo $3 | tr -d "\133\135")
 		diagport="Diag: port=$4"
 		;;
 		*)
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index bfdaf75..fa6be3c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -445,7 +445,7 @@ test_expect_success 'clone ssh://host.xz:22/~repo' '
 #IPv6
 for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::1]:
 do
-	ehost=$(echo $tuah | sed -e "s/1]:/1]/ "| tr -d "[]")
+	ehost=$(echo $tuah | sed -e "s/1]:/1]/ " | tr -d "\133\135")
 	test_expect_success "clone ssh://$tuah/home/user/repo" "
 	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
 	"
@@ -454,7 +454,7 @@ done
 #IPv6 from home directory
 for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
 do
-	euah=$(echo $tuah | tr -d "[]")
+	euah=$(echo $tuah | tr -d "\133\135")
 	test_expect_success "clone ssh://$tuah/~repo" "
 	  test_clone_url ssh://$tuah/~repo $euah '~repo'
 	"
@@ -463,7 +463,7 @@ done
 #IPv6 with port number
 for tuah in [::1] user@[::1] [user@::1]
 do
-	euah=$(echo $tuah | tr -d "[]")
+	euah=$(echo $tuah | tr -d "\133\135")
 	test_expect_success "clone ssh://$tuah:22/home/user/repo" "
 	  test_clone_url ssh://$tuah:22/home/user/repo '-p 22' $euah /home/user/repo
 	"
@@ -472,7 +472,7 @@ done
 #IPv6 from home directory with port number
 for tuah in [::1] user@[::1] [user@::1]
 do
-	euah=$(echo $tuah | tr -d "[]")
+	euah=$(echo $tuah | tr -d "\133\135")
 	test_expect_success "clone ssh://$tuah:22/~repo" "
 	  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
 	"
-- 
1.7.10.4
