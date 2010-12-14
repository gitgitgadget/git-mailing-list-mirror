From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 10/14] t6038-*.sh: Pass the -b (--binary) option to sed on
 cygwin
Date: Tue, 14 Dec 2010 18:32:12 +0000
Message-ID: <4D07B82C.2060701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZu0-0005Vk-NN
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758770Ab0LNSqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:46:51 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:52767 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758534Ab0LNSqu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:46:50 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZtg-00078B-ZH; Tue, 14 Dec 2010 18:46:49 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163670>


The tests using the fuzz_conflict helper function (tests 5-6)
fail on cygwin in the same way they used to on MinGW, prior
to commit ca02ad3. The solution is also the same; passing the
-b (--binary) option to sed, using the SED_OPTIONS variable.
We introduce a new prerequisite SED_STRIPS_CR to use in the
conditional initialisation of SED_OPTIONS, rather than MINGW.
The new prerequisite is set in test-lib.sh for both MinGW and
Cygwin.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t6038-merge-text-auto.sh |    2 +-
 t/test-lib.sh              |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 460bf74..d9c2d38 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -14,7 +14,7 @@ test_description='CRLF merge conflict across text=auto change
 
 . ./test-lib.sh
 
-test_have_prereq MINGW && SED_OPTIONS=-b
+test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
 
 test_expect_success setup '
 	git config core.autocrlf false &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 48fa516..9e74357 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1057,6 +1057,14 @@ case $(uname -s) in
 	# backslashes in pathspec are converted to '/'
 	# exec does not inherit the PID
 	test_set_prereq MINGW
+	test_set_prereq SED_STRIPS_CR
+	;;
+*CYGWIN*)
+	test_set_prereq POSIXPERM
+	test_set_prereq BSLASHPSPEC
+	test_set_prereq EXECKEEPSPID
+	test_set_prereq NOT_MINGW
+	test_set_prereq SED_STRIPS_CR
 	;;
 *)
 	test_set_prereq POSIXPERM
-- 
1.7.3
