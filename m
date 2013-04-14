From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] t/test-lib.sh: fix TRASH_DIRECTORY handling
Date: Sun, 14 Apr 2013 17:34:56 +0100
Message-ID: <11cf45ad9779240b588da4b25c8ae5b6cc61b427.1365957201.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 18:35:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URPtm-0001y7-I8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 18:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab3DNQfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 12:35:10 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48548 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab3DNQfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 12:35:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A6210CDA5B7;
	Sun, 14 Apr 2013 17:35:08 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fk9z5Yk6t81n; Sun, 14 Apr 2013 17:35:08 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id F3062CDA5A6;
	Sun, 14 Apr 2013 17:35:01 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221145>

After the location of $TRASH_DIRECTORY is adjusted by
$TEST_OUTPUT_DIRECTORY, we go on to use the $test variable to make the
trash directory and cd into it.  This means that when
$TEST_OUTPUT_DIRECTORY is not "." and an absolute --root has not been
specified, we do not remove the trash directory once the tests are
complete (remove_trash is set to $TRASH_DIRECTORY).

Fix this by always referring to the trash directory as $TRASH_DIRECTORY.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/test-lib.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index debd8b4..f79745c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -607,7 +607,7 @@ case "$test" in
  *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$test" ;;
 esac
 test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
-rm -fr "$test" || {
+rm -fr "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
 	exit 1
@@ -618,13 +618,13 @@ export HOME
 
 if test -z "$TEST_NO_CREATE_REPO"
 then
-	test_create_repo "$test"
+	test_create_repo "$TRASH_DIRECTORY"
 else
-	mkdir -p "$test"
+	mkdir -p "$TRASH_DIRECTORY"
 fi
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
-cd -P "$test" || exit 1
+cd -P "$TRASH_DIRECTORY" || exit 1
 
 this_test=${0##*/}
 this_test=${this_test%%-*}
-- 
1.8.2.694.ga76e9c3.dirty
