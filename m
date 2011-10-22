From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] make the sample pre-commit hook script reject names with newlines, too
Date: Sat, 22 Oct 2011 19:19:07 +0200
Message-ID: <87obx9eygk.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 19:19:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHfEE-00074j-6f
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 19:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab1JVRTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 13:19:18 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:33680 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab1JVRTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 13:19:18 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 910A0D48109
	for <git@vger.kernel.org>; Sat, 22 Oct 2011 19:19:10 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 4917C6002D
	for <git@vger.kernel.org>; Sat, 22 Oct 2011 19:19:07 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184102>


The sample pre-commit hook script would fail to reject a file name
like "a\nb" because of the way newlines are handled in "$(...)".
Adjust the test to count filtered bytes and require there be 0.
Also print all diagnostics to standard error, not stdout, so they
will actually be seen.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 templates/hooks--pre-commit.sample |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index b187c4b..1addec5 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -18,6 +18,9 @@ fi
 # If you want to allow non-ascii filenames set this variable to true.
 allownonascii=$(git config hooks.allownonascii)

+# Redirect output to stderr.
+exec 1>&2
+
 # Cross platform projects tend to avoid non-ascii filenames; prevent
 # them from being added to the repository. We exploit the fact that the
 # printable range starts at the space character and ends with tilde.
@@ -26,7 +29,7 @@ if [ "$allownonascii" != "true" ] &&
 	# even required, for portability to Solaris 10's /usr/bin/tr), since
 	# the square bracket bytes happen to fall in the designated range.
 	test "$(git diff --cached --name-only --diff-filter=A -z $against |
-	  LC_ALL=C tr -d '[ -~]\0')"
+	  LC_ALL=C tr -d '[ -~]\0' | wc -c)" != 0
 then
 	echo "Error: Attempt to add a non-ascii file name."
 	echo
@@ -43,4 +46,5 @@ then
 	exit 1
 fi

+# If there are whitespace errors, print the offending file names and fail.
 exec git diff-index --check --cached $against --
--
1.7.7.419.g87009
