From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 1/3] Modify tr expressions so that xpg4/tr handles it on Solaris
Date: Sun, 19 Jul 2015 19:00:34 +0100
Message-ID: <1437328836-19156-2-git-send-email-bdwalton@gmail.com>
References: <1437328836-19156-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, j6t@kdbg.org,
	johannes.schindelin@gmx.de, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 19 19:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGsrO-00009o-1N
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 19:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820AbbGSR6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 13:58:41 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:44639 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800AbbGSR6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 13:58:39 -0400
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:35483 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGsrG-000363-JN ; Sun, 19 Jul 2015 13:58:38 -0400
Received: from 86-42-134-176-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.134.176]:38624 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGsrF-0007fk-Aw ; Sun, 19 Jul 2015 13:58:37 -0400
Received: from bdwalton by neilyoung with local (Exim 4.84)
	(envelope-from <bdwalton@benandwen.net>)
	id 1ZGstE-0004zl-J8; Sun, 19 Jul 2015 19:00:40 +0100
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1437328836-19156-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274273>

It seems that xpg4/tr mishandles some strings involving [ not followed
by a character class:
% echo '[::1]' | /usr/xpg4/bin/tr -d '[]'
[::1

% echo '[::1]' | /usr/xpg4/bin/tr -d '['
usr/xpg4/bin/tr: Bad string.

This was breaking two tests. To fix the issue, use the octal
representations of [ and ] instead. Reference the octal expression as
a newly exported variable so that it's shared across tests and more
easily understood when reading it.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t5500-fetch-pack.sh | 2 +-
 t/t5601-clone.sh      | 8 ++++----
 t/test-lib.sh         | 5 ++++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3a9b775..2db9bde 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -547,7 +547,7 @@ check_prot_host_port_path () {
 		*ssh*)
 		pp=ssh
 		uah=userandhost
-		ehost=$(echo $3 | tr -d "[]")
+		ehost=$(echo $3 | tr -d "$squarebrackets")
 		diagport="Diag: port=$4"
 		;;
 		*)
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index bfdaf75..8299d14 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -445,7 +445,7 @@ test_expect_success 'clone ssh://host.xz:22/~repo' '
 #IPv6
 for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::1]:
 do
-	ehost=$(echo $tuah | sed -e "s/1]:/1]/ "| tr -d "[]")
+	ehost=$(echo $tuah | sed -e "s/1]:/1]/ " | tr -d "$squarebrackets")
 	test_expect_success "clone ssh://$tuah/home/user/repo" "
 	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
 	"
@@ -454,7 +454,7 @@ done
 #IPv6 from home directory
 for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
 do
-	euah=$(echo $tuah | tr -d "[]")
+	euah=$(echo $tuah | tr -d "$squarebrackets")
 	test_expect_success "clone ssh://$tuah/~repo" "
 	  test_clone_url ssh://$tuah/~repo $euah '~repo'
 	"
@@ -463,7 +463,7 @@ done
 #IPv6 with port number
 for tuah in [::1] user@[::1] [user@::1]
 do
-	euah=$(echo $tuah | tr -d "[]")
+	euah=$(echo $tuah | tr -d "$squarebrackets")
 	test_expect_success "clone ssh://$tuah:22/home/user/repo" "
 	  test_clone_url ssh://$tuah:22/home/user/repo '-p 22' $euah /home/user/repo
 	"
@@ -472,7 +472,7 @@ done
 #IPv6 from home directory with port number
 for tuah in [::1] user@[::1] [user@::1]
 do
-	euah=$(echo $tuah | tr -d "[]")
+	euah=$(echo $tuah | tr -d "$squarebrackets")
 	test_expect_success "clone ssh://$tuah:22/~repo" "
 	  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
 	"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 39da9c2..6b5b6cd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -173,7 +173,10 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x40 _z40 LF u200c
+# [ and ], for use by tr commands.
+squarebrackets="\133\135"
+
+export _x05 _x40 _z40 LF u200c squarebrackets
 
 # Each test should start with something like this, after copyright notices:
 #
-- 
2.1.4
