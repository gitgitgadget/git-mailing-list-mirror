From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 2/2] Fix sed usage in tests to work around broken xpg4/sed on Solaris
Date: Sat, 18 Jul 2015 16:21:32 +0100
Message-ID: <1437232892-27978-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 18 17:58:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGUVe-0005ga-Pa
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 17:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbbGRP6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 11:58:38 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:42430 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbbGRP6h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 11:58:37 -0400
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:50777 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGTtk-0005Vm-Gy ; Sat, 18 Jul 2015 11:19:32 -0400
Received: from 86-42-134-176-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.134.176]:44773 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGTtk-000707-38 ; Sat, 18 Jul 2015 11:19:32 -0400
Received: from bdwalton by neilyoung with local (Exim 4.84)
	(envelope-from <bdwalton@benandwen.net>)
	id 1ZGTvi-0007Hu-2R; Sat, 18 Jul 2015 16:21:34 +0100
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274166>

The space following the last / in a sed command caused Solaris'
xpg4/sed to fail, claiming the program was garbled and exit with
status 2:

% echo 'foo' | /usr/xpg4/bin/sed -e 's/foo/bar/ '
sed: command garbled: s/foo/bar/
% echo $?
2

Fix this by simply removing the unnecessary space.

Additionally, in 99094a7a, a trivial && breakage was fixed. This
exposed a problem with the test when run on Solaris with xpg4/sed that
had gone silently undetected since its introduction in
e4bd10b2. Solaris' sed executes the requested substitution but prints
a warning about the missing newline at the end of the file and exits
with status 2.

% echo "CHANGE_ME" | \
tr -d "\\012" | /usr/xpg4/bin/sed -e 's/CHANGE_ME/change_me/'
sed: Missing newline at end of file standard input.
change_me
% echo $?
2

To work around this, use perl to execute the substitution instead. By
using inplace replacement, we can subsequently drop the mv command.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t5601-clone.sh                       |    2 +-
 t/t9500-gitweb-standalone-no-errors.sh |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index fa6be3c..2583f84 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -445,7 +445,7 @@ test_expect_success 'clone ssh://host.xz:22/~repo' '
 #IPv6
 for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::1]:
 do
-	ehost=$(echo $tuah | sed -e "s/1]:/1]/ " | tr -d "\133\135")
+	ehost=$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "\133\135")
 	test_expect_success "clone ssh://$tuah/home/user/repo" "
 	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
 	"
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index e94b2f1..eb264f9 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -290,8 +290,7 @@ test_expect_success 'setup incomplete lines' '
 	echo "incomplete" | tr -d "\\012" >>file &&
 	git commit -a -m "Add incomplete line" &&
 	git tag incomplete_lines_add &&
-	sed -e s/CHANGE_ME/change_me/ <file >file+ &&
-	mv -f file+ file &&
+	perl -pi -e "s/CHANGE_ME/change_me/" file &&
 	git commit -a -m "Incomplete context line" &&
 	git tag incomplete_lines_ctx &&
 	echo "Dominus regit me," >file &&
-- 
1.7.10.4
