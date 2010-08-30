From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] tests: factor HOME=$(pwd) in test-lib.sh
Date: Mon, 30 Aug 2010 11:50:42 +0200
Message-ID: <1283161842-22689-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vzkw4edc5.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 30 11:53:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq13u-0001Sv-0d
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 11:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab0H3Jxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 05:53:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:44422 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab0H3Jxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 05:53:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7U9ojR9012773
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Aug 2010 11:50:45 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oq10n-0006xI-5Y; Mon, 30 Aug 2010 11:50:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oq10n-0005um-3H; Mon, 30 Aug 2010 11:50:45 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <7vzkw4edc5.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 30 Aug 2010 11:50:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154781>

The same pattern is used in many tests, and makes it easy for new ones to
rely on $HOME being a trashable, clean, directory.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Junio C Hamano <gitster@pobox.com> writes:

>> --- a/t/t0003-attributes.sh
>> +++ b/t/t0003-attributes.sh
>> +HOME=$(pwd)
>
> I see a few tests here and there that uses the test-trash directory as
> HOME; perhaps we should have done that in test-lib.sh to make our life
> easier?

I just mimicked what the other tests were doing, but doing it in
test-lib.sh makes sense, yes. That also prevents accidental
modification of the actual $HOME when writing buggy tests.

The test-suite still passes if I apply this, so it's probably as easy
as it seems to be :-). The patch comes on top of mine for
.gitattributes, to remove my HOME=$(pwd).

 t/lib-cvs.sh                    |    3 ---
 t/t0001-init.sh                 |    6 ------
 t/t0003-attributes.sh           |    2 --
 t/t5601-clone.sh                |    2 --
 t/t9130-git-svn-authors-file.sh |    2 --
 t/test-lib.sh                   |    3 +++
 6 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 648d161..ad90364 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -3,9 +3,6 @@
 . ./test-lib.sh
 
 unset CVS_SERVER
-# for clean cvsps cache
-HOME=$(pwd)
-export HOME
 
 if ! type cvs >/dev/null 2>&1
 then
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7c0a698..0543723 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -171,8 +171,6 @@ test_expect_success 'init with init.templatedir set' '
 	mkdir templatedir-source &&
 	echo Content >templatedir-source/file &&
 	(
-		HOME="`pwd`" &&
-		export HOME &&
 		test_config="${HOME}/.gitconfig" &&
 		git config -f "$test_config"  init.templatedir "${HOME}/templatedir-source" &&
 		mkdir templatedir-set &&
@@ -188,8 +186,6 @@ test_expect_success 'init with init.templatedir set' '
 
 test_expect_success 'init --bare/--shared overrides system/global config' '
 	(
-		HOME="`pwd`" &&
-		export HOME &&
 		test_config="$HOME"/.gitconfig &&
 		unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" core.bare false &&
@@ -205,8 +201,6 @@ test_expect_success 'init --bare/--shared overrides system/global config' '
 
 test_expect_success 'init honors global core.sharedRepository' '
 	(
-		HOME="`pwd`" &&
-		export HOME &&
 		test_config="$HOME"/.gitconfig &&
 		unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" core.sharedRepository 0666 &&
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 24286e5..b884bb7 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -15,8 +15,6 @@ attr_check () {
 
 }
 
-HOME=$(pwd)
-
 test_expect_success 'setup' '
 
 	mkdir -p a/b/d a/c &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8abb71a..8617965 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -163,8 +163,6 @@ test_expect_success 'clone a void' '
 
 test_expect_success 'clone respects global branch.autosetuprebase' '
 	(
-		HOME=$(pwd) &&
-		export HOME &&
 		test_config="$HOME/.gitconfig" &&
 		unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" branch.autosetuprebase remote &&
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index 3c4f319..ec0a106 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -95,8 +95,6 @@ test_expect_success 'fresh clone with svn.authors-file in config' '
 	(
 		rm -r "$GIT_DIR" &&
 		test x = x"$(git config svn.authorsfile)" &&
-		HOME="`pwd`" &&
-		export HOME &&
 		test_config="$HOME"/.gitconfig &&
 		unset GIT_CONFIG_NOGLOBAL &&
 		unset GIT_DIR &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3a3d4c4..4eff908 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -861,6 +861,9 @@ test_create_repo "$test"
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$test" || exit 1
 
+HOME=$(pwd)
+export HOME
+
 this_test=${0##*/}
 this_test=${this_test%%-*}
 for skp in $GIT_SKIP_TESTS
-- 
1.7.2.2.175.ga619d.dirty
