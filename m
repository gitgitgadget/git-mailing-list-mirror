From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH] annotate.sh: Fix failing test on OS X
Date: Wed,  4 May 2011 15:36:21 +0200
Message-ID: <1304516181-92364-1-git-send-email-arjen@yaph.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 15:36:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHcFs-0001MH-VV
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 15:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab1EDNgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 09:36:35 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:4704 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab1EDNge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 09:36:34 -0400
Received: from hal.xs4all.nl (aragorndsl.demon.nl [82.161.19.32])
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id p44DaLjn039295;
	Wed, 4 May 2011 15:36:22 +0200 (CEST)
	(envelope-from arjen@yaph.org)
X-Mailer: git-send-email 1.7.5.278.g5fde9
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172741>

Commit 9b01f0038b63ccdf697b2387f4fcd4b03bd249d5 ('blame: tolerate bogus
e-mail addresses a bit better') introduced a test for obfuscated email
addresses, but it fails on OS X and probably other platforms which don't
use GNU sed.  The test breaks because non-GNU seds append a newline to
every line of the file, including the last one, even if it didn't have
one before editing.  GNU sed is smart about this (if the last line of
the file doesn't have newline, it is omitted when writing the output).

Also, the text after the sed insert command is expected to start on the
next line after a backslash.  GNU sed apparently also understands text
right after the 'i'nsert command.

The fix uses a trick used earlier in the script, which is to remove the
line completely and add it again without a newline using echo and tr.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---

 t/annotate-tests.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index abb1885..a4c6146 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -127,7 +127,9 @@ test_expect_success \
 
 test_expect_success \
     'an obfuscated email added' \
-    'sed -e "1i No robots allowed" < file > file.new &&
+    'sed -e "1i\\
+No robots allowed" -e "/^incomplete/d" < file > file.new &&
+     echo "incomplete" | tr -d "\\012" >>file.new &&
      mv file.new file &&
      GIT_AUTHOR_NAME="E" GIT_AUTHOR_EMAIL="E at test dot git" git commit -a -m "norobots"'
 
-- 
1.7.5.278.g5fde9
