From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 3/3] Fix sed usage in tests to work around broken xpg4/sed on Solaris
Date: Sun, 19 Jul 2015 19:00:36 +0100
Message-ID: <1437328836-19156-4-git-send-email-bdwalton@gmail.com>
References: <1437328836-19156-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, j6t@kdbg.org,
	johannes.schindelin@gmx.de, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 19 19:59:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGsrW-0000Dm-JW
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 19:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbbGSR6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 13:58:48 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:44642 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804AbbGSR6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 13:58:39 -0400
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:35485 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGsrH-00037l-7e ; Sun, 19 Jul 2015 13:58:39 -0400
Received: from 86-42-134-176-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.134.176]:38626 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGsrG-0007fs-SM ; Sun, 19 Jul 2015 13:58:39 -0400
Received: from bdwalton by neilyoung with local (Exim 4.84)
	(envelope-from <bdwalton@benandwen.net>)
	id 1ZGstG-0004zv-Kf; Sun, 19 Jul 2015 19:00:42 +0100
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1437328836-19156-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274274>

In 99094a7a, a trivial && breakage was fixed. This exposed a problem
with the test when run on Solaris with xpg4/sed that had gone silently
undetected since its introduction in e4bd10b2. Solaris' sed executes
the requested substitution but prints a warning about the missing
newline at the end of the file and exits with status 2.

% echo "CHANGE_ME" | \
tr -d "\\012" | /usr/xpg4/bin/sed -e 's/CHANGE_ME/change_me/'
sed: Missing newline at end of file standard input.
change_me
% echo $?
2

To work around this, use perl to perform the substitution instead.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t9500-gitweb-standalone-no-errors.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index e94b2f1..a7383fa 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -290,7 +290,7 @@ test_expect_success 'setup incomplete lines' '
 	echo "incomplete" | tr -d "\\012" >>file &&
 	git commit -a -m "Add incomplete line" &&
 	git tag incomplete_lines_add &&
-	sed -e s/CHANGE_ME/change_me/ <file >file+ &&
+	perl -pne "s/CHANGE_ME/change_me/" file >file+ &&
 	mv -f file+ file &&
 	git commit -a -m "Incomplete context line" &&
 	git tag incomplete_lines_ctx &&
-- 
2.1.4
