From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 5/5] t3910: use the SYMLINKS test prereq
Date: Thu, 26 Jul 2012 15:39:57 +0200
Message-ID: <af454679a3544e8a33764d92c894af6de66b0815.1343309173.git.git@drmicha.warpmail.net>
References: <5001B82B.1060201@web.de>
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 15:40:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuOIf-0004LP-QS
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 15:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab2GZNkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 09:40:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50448 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751773Ab2GZNkI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 09:40:08 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8FB402098D;
	Thu, 26 Jul 2012 09:40:07 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 26 Jul 2012 09:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=OI
	MTXctLWk1NEXUdEhZ2EI2eRAk=; b=jjTli7RvxpKt4hmUwlvsCub1RJw57CBicw
	5sOje0uuFxku+9mztC4ql4eeV1ZuwndYQe4uoDNEOPOAmfpM4L7ag+6dfDujAFda
	ayY8PFx4x77UuHhpM/r51gPwa9rGmbnC7pFqeDQtdqlfKayKkWP4a2d4947lrGoa
	op/P7P1gM=
X-Sasl-enc: soOrUFq9sBI83ANEFla6DYIQrgPUiWBfmeriSDTXkyAq 1343310007
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 15B284836D8;
	Thu, 26 Jul 2012 09:40:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc0.198.gd66b616
In-Reply-To: <5001B82B.1060201@web.de>
In-Reply-To: <cover.1343309173.git.git@drmicha.warpmail.net>
References: <cover.1343309173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202266>

Besides reusing the new test prerequisite, this fixes also the issue
that the current output is not TAP compliant and produces the output "no
reason given" [for skipping].

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3910-mac-os-precompose.sh | 281 +++++++++++++++++++++----------------------
 1 file changed, 135 insertions(+), 146 deletions(-)

diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 88b7a20..9244b69 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -7,158 +7,147 @@ test_description='utf-8 decomposed (nfd) converted to precomposed (nfc)'
 
 . ./test-lib.sh
 
+if ! test_have_prereq UTF8_NFD_TO_NFC
+then
+	skip_all="filesystem does not convert utf-8 nfd to nfc"
+	test_done
+fi
+
+# create utf-8 variables
 Adiarnfc=`printf '\303\204'`
 Adiarnfd=`printf 'A\314\210'`
 
-# check if the feature is compiled in
-mkdir junk &&
->junk/"$Adiarnfc" &&
-case "$(cd junk && echo *)" in
-	"$Adiarnfd")
-	test_nfd=1
-	;;
-	*)	;;
-esac
-rm -rf junk
+Odiarnfc=`printf '\303\226'`
+Odiarnfd=`printf 'O\314\210'`
+AEligatu=`printf '\303\206'`
+Invalidu=`printf '\303\377'`
 
 
-if test "$test_nfd"
-then
-	# create more utf-8 variables
-	Odiarnfc=`printf '\303\226'`
-	Odiarnfd=`printf 'O\314\210'`
-	AEligatu=`printf '\303\206'`
-	Invalidu=`printf '\303\377'`
+#Create a string with 255 bytes (decomposed)
+Alongd=$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd #21 Byte
+Alongd=$Alongd$Alongd$Alongd                                           #63 Byte
+Alongd=$Alongd$Alongd$Alongd$Alongd$Adiarnfd                           #255 Byte
 
+#Create a string with 254 bytes (precomposed)
+Alongc=$AEligatu$AEligatu$AEligatu$AEligatu$AEligatu #10 Byte
+Alongc=$Alongc$Alongc$Alongc$Alongc$Alongc           #50 Byte
+Alongc=$Alongc$Alongc$Alongc$Alongc$Alongc           #250 Byte
+Alongc=$Alongc$AEligatu$AEligatu                     #254 Byte
 
-	#Create a string with 255 bytes (decomposed)
-	Alongd=$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd #21 Byte
-	Alongd=$Alongd$Alongd$Alongd                                           #63 Byte
-	Alongd=$Alongd$Alongd$Alongd$Alongd$Adiarnfd                           #255 Byte
-
-	#Create a string with 254 bytes (precomposed)
-	Alongc=$AEligatu$AEligatu$AEligatu$AEligatu$AEligatu #10 Byte
-	Alongc=$Alongc$Alongc$Alongc$Alongc$Alongc           #50 Byte
-	Alongc=$Alongc$Alongc$Alongc$Alongc$Alongc           #250 Byte
-	Alongc=$Alongc$AEligatu$AEligatu                     #254 Byte
-
-	test_expect_success "detect if nfd needed" '
-		precomposeunicode=`git config core.precomposeunicode` &&
-		test "$precomposeunicode" = false &&
-		git config core.precomposeunicode true
-	'
-	test_expect_success "setup" '
-		>x &&
-		git add x &&
-		git commit -m "1st commit" &&
-		git rm x &&
-		git commit -m "rm x"
-	'
-	test_expect_success "setup case mac" '
-		git checkout -b mac_os
-	'
-	# This will test nfd2nfc in readdir()
-	test_expect_success "add file Adiarnfc" '
-		echo f.Adiarnfc >f.$Adiarnfc &&
-		git add f.$Adiarnfc &&
-		git commit -m "add f.$Adiarnfc"
-	'
-	# This will test nfd2nfc in git stage()
-	test_expect_success "stage file d.Adiarnfd/f.Adiarnfd" '
-		mkdir d.$Adiarnfd &&
-		echo d.$Adiarnfd/f.$Adiarnfd >d.$Adiarnfd/f.$Adiarnfd &&
-		git stage d.$Adiarnfd/f.$Adiarnfd &&
-		git commit -m "add d.$Adiarnfd/f.$Adiarnfd"
-	'
-	test_expect_success "add link Adiarnfc" '
-		ln -s d.$Adiarnfd/f.$Adiarnfd l.$Adiarnfc &&
-		git add l.$Adiarnfc &&
-		git commit -m "add l.Adiarnfc"
-	'
-	# This will test git log
-	test_expect_success "git log f.Adiar" '
-		git log f.$Adiarnfc > f.Adiarnfc.log &&
-		git log f.$Adiarnfd > f.Adiarnfd.log &&
-		test -s f.Adiarnfc.log &&
-		test -s f.Adiarnfd.log &&
-		test_cmp f.Adiarnfc.log f.Adiarnfd.log &&
-		rm f.Adiarnfc.log f.Adiarnfd.log
-	'
-	# This will test git ls-files
-	test_expect_success "git lsfiles f.Adiar" '
-		git ls-files f.$Adiarnfc > f.Adiarnfc.log &&
-		git ls-files f.$Adiarnfd > f.Adiarnfd.log &&
-		test -s f.Adiarnfc.log &&
-		test -s f.Adiarnfd.log &&
-		test_cmp f.Adiarnfc.log f.Adiarnfd.log &&
-		rm f.Adiarnfc.log f.Adiarnfd.log
-	'
-	# This will test git mv
-	test_expect_success "git mv" '
-		git mv f.$Adiarnfd f.$Odiarnfc &&
-		git mv d.$Adiarnfd d.$Odiarnfc &&
-		git mv l.$Adiarnfd l.$Odiarnfc &&
-		git commit -m "mv Adiarnfd Odiarnfc"
-	'
-	# Files can be checked out as nfc
-	# And the link has been corrected from nfd to nfc
-	test_expect_success "git checkout nfc" '
-		rm f.$Odiarnfc &&
-		git checkout f.$Odiarnfc
-	'
-	# Make it possible to checkout files with their NFD names
-	test_expect_success "git checkout file nfd" '
-		rm -f f.* &&
-		git checkout f.$Odiarnfd
-	'
-	# Make it possible to checkout links with their NFD names
-	test_expect_success "git checkout link nfd" '
-		rm l.* &&
-		git checkout l.$Odiarnfd
-	'
-	test_expect_success "setup case mac2" '
-		git checkout master &&
-		git reset --hard &&
-		git checkout -b mac_os_2
-	'
-	# This will test nfd2nfc in git commit
-	test_expect_success "commit file d2.Adiarnfd/f.Adiarnfd" '
-		mkdir d2.$Adiarnfd &&
-		echo d2.$Adiarnfd/f.$Adiarnfd >d2.$Adiarnfd/f.$Adiarnfd &&
-		git add d2.$Adiarnfd/f.$Adiarnfd &&
-		git commit -m "add d2.$Adiarnfd/f.$Adiarnfd" -- d2.$Adiarnfd/f.$Adiarnfd
-	'
-	test_expect_success "setup for long decomposed filename" '
-		git checkout master &&
-		git reset --hard &&
-		git checkout -b mac_os_long_nfd_fn
-	'
-	test_expect_success "Add long decomposed filename" '
-		echo longd >$Alongd &&
-		git add * &&
-		git commit -m "Long filename"
-	'
-	test_expect_success "setup for long precomposed filename" '
-		git checkout master &&
-		git reset --hard &&
-		git checkout -b mac_os_long_nfc_fn
-	'
-	test_expect_success "Add long precomposed filename" '
-		echo longc >$Alongc &&
-		git add * &&
-		git commit -m "Long filename"
-	'
-	# Test if the global core.precomposeunicode stops autosensing
-	# Must be the last test case
-	test_expect_success "respect git config --global core.precomposeunicode" '
-		git config --global core.precomposeunicode true &&
-		rm -rf .git &&
-		git init &&
-		precomposeunicode=`git config core.precomposeunicode` &&
-		test "$precomposeunicode" = "true"
-	'
-else
-	 say "Skipping nfc/nfd tests"
-fi
+test_expect_success "detect if nfd needed" '
+	precomposeunicode=`git config core.precomposeunicode` &&
+	test "$precomposeunicode" = false &&
+	git config core.precomposeunicode true
+'
+test_expect_success "setup" '
+	>x &&
+	git add x &&
+	git commit -m "1st commit" &&
+	git rm x &&
+	git commit -m "rm x"
+'
+test_expect_success "setup case mac" '
+	git checkout -b mac_os
+'
+# This will test nfd2nfc in readdir()
+test_expect_success "add file Adiarnfc" '
+	echo f.Adiarnfc >f.$Adiarnfc &&
+	git add f.$Adiarnfc &&
+	git commit -m "add f.$Adiarnfc"
+'
+# This will test nfd2nfc in git stage()
+test_expect_success "stage file d.Adiarnfd/f.Adiarnfd" '
+	mkdir d.$Adiarnfd &&
+	echo d.$Adiarnfd/f.$Adiarnfd >d.$Adiarnfd/f.$Adiarnfd &&
+	git stage d.$Adiarnfd/f.$Adiarnfd &&
+	git commit -m "add d.$Adiarnfd/f.$Adiarnfd"
+'
+test_expect_success "add link Adiarnfc" '
+	ln -s d.$Adiarnfd/f.$Adiarnfd l.$Adiarnfc &&
+	git add l.$Adiarnfc &&
+	git commit -m "add l.Adiarnfc"
+'
+# This will test git log
+test_expect_success "git log f.Adiar" '
+	git log f.$Adiarnfc > f.Adiarnfc.log &&
+	git log f.$Adiarnfd > f.Adiarnfd.log &&
+	test -s f.Adiarnfc.log &&
+	test -s f.Adiarnfd.log &&
+	test_cmp f.Adiarnfc.log f.Adiarnfd.log &&
+	rm f.Adiarnfc.log f.Adiarnfd.log
+'
+# This will test git ls-files
+test_expect_success "git lsfiles f.Adiar" '
+	git ls-files f.$Adiarnfc > f.Adiarnfc.log &&
+	git ls-files f.$Adiarnfd > f.Adiarnfd.log &&
+	test -s f.Adiarnfc.log &&
+	test -s f.Adiarnfd.log &&
+	test_cmp f.Adiarnfc.log f.Adiarnfd.log &&
+	rm f.Adiarnfc.log f.Adiarnfd.log
+'
+# This will test git mv
+test_expect_success "git mv" '
+	git mv f.$Adiarnfd f.$Odiarnfc &&
+	git mv d.$Adiarnfd d.$Odiarnfc &&
+	git mv l.$Adiarnfd l.$Odiarnfc &&
+	git commit -m "mv Adiarnfd Odiarnfc"
+'
+# Files can be checked out as nfc
+# And the link has been corrected from nfd to nfc
+test_expect_success "git checkout nfc" '
+	rm f.$Odiarnfc &&
+	git checkout f.$Odiarnfc
+'
+# Make it possible to checkout files with their NFD names
+test_expect_success "git checkout file nfd" '
+	rm -f f.* &&
+	git checkout f.$Odiarnfd
+'
+# Make it possible to checkout links with their NFD names
+test_expect_success "git checkout link nfd" '
+	rm l.* &&
+	git checkout l.$Odiarnfd
+'
+test_expect_success "setup case mac2" '
+	git checkout master &&
+	git reset --hard &&
+	git checkout -b mac_os_2
+'
+# This will test nfd2nfc in git commit
+test_expect_success "commit file d2.Adiarnfd/f.Adiarnfd" '
+	mkdir d2.$Adiarnfd &&
+	echo d2.$Adiarnfd/f.$Adiarnfd >d2.$Adiarnfd/f.$Adiarnfd &&
+	git add d2.$Adiarnfd/f.$Adiarnfd &&
+	git commit -m "add d2.$Adiarnfd/f.$Adiarnfd" -- d2.$Adiarnfd/f.$Adiarnfd
+'
+test_expect_success "setup for long decomposed filename" '
+	git checkout master &&
+	git reset --hard &&
+	git checkout -b mac_os_long_nfd_fn
+'
+test_expect_success "Add long decomposed filename" '
+	echo longd >$Alongd &&
+	git add * &&
+	git commit -m "Long filename"
+'
+test_expect_success "setup for long precomposed filename" '
+	git checkout master &&
+	git reset --hard &&
+	git checkout -b mac_os_long_nfc_fn
+'
+test_expect_success "Add long precomposed filename" '
+	echo longc >$Alongc &&
+	git add * &&
+	git commit -m "Long filename"
+'
+# Test if the global core.precomposeunicode stops autosensing
+# Must be the last test case
+test_expect_success "respect git config --global core.precomposeunicode" '
+	git config --global core.precomposeunicode true &&
+	rm -rf .git &&
+	git init &&
+	precomposeunicode=`git config core.precomposeunicode` &&
+	test "$precomposeunicode" = "true"
+'
 
 test_done
-- 
1.7.12.rc0.198.gd66b616
