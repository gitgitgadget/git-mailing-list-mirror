From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for filesystem challenges (case and unicode
 normalization)
Date: Mon, 25 Feb 2008 12:44:30 -0800
Message-ID: <7voda4hikx.fsf@gitster.siamese.dyndns.org>
References: <7vlk5vjpi4.fsf@gitster.siamese.dyndns.org>
 <1203873549507-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mitcht.git@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:45:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTkCV-0006uw-71
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569AbYBYUou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 15:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757475AbYBYUou
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:44:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738AbYBYUot (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 15:44:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3973B2E4B;
	Mon, 25 Feb 2008 15:44:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EEA1A2E49; Mon, 25 Feb 2008 15:44:33 -0500 (EST)
In-Reply-To: <1203873549507-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Sun, 24 Feb 2008 18:19:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75065>

Steffen Prohaska <prohaska@zib.de> writes:

> Unfortunately, I had no time to start the real work of fixing the
> issues that are tested below.

That's fine.  We are not in a hurry.

> But at least the tests should be in
> good shape now and could be applied.

I do not think we would want to see "FIXED" on systems that
already behave sanely, so we would want a fix-up like this on
top of your patch, and it would be a good to go.

I do not have a handy way to test this, though, so can you try
it out and make sure test_case and test_unicode are set to
test_expect_failure correctly on problematic filesystems?

Thanks.

--

 t/t0050-filesystem.sh |   38 ++++++++++++++++++++++++++++++++------
 1 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index a0ab02e..b395c22 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -4,6 +4,34 @@ test_description='Various filesystem issues'
 
 . ./test-lib.sh
 
+auml=`perl -CO -e 'print pack("U",0x00E4)'`
+aumlcdiar=`perl -CO -e 'print pack("U",0x0061).pack("U",0x0308)'`
+
+test_expect_success 'see if we expect ' '
+
+	test_case=test_expect_success
+	test_unicode=test_expect_success
+	mkdir junk &&
+	echo good >junk/CamelCase &&
+	echo bad >junk/camelcase &&
+	if test "$(cat junk/CamelCase)" != good
+	then
+		test_camel=test_expect_failure
+		say "will test on a case insensitive filesystem"
+	fi &&
+	rm -fr junk &&
+	mkdir junk &&
+	>junk/"$auml" &&
+	case "$(cd junk && echo *)" in
+	"$aumlcdiar")
+		test_unicode=test_expect_failure
+		say "will test on a unicode corrupting filesystem"
+		;;
+	*)	;;
+	esac &&
+	rm -fr junk
+'
+
 test_expect_success "setup case tests" '
 
 	touch camelcase &&
@@ -18,22 +46,20 @@ test_expect_success "setup case tests" '
 
 '
 
-test_expect_failure 'rename (case change)' '
+$test_case 'rename (case change)' '
 
 	git mv camelcase CamelCase &&
 	git commit -m "rename"
 
 '
 
-test_expect_failure 'merge (case change)' '
+$test_case 'merge (case change)' '
 
 	git reset --hard initial &&
 	git merge topic
 
 '
 
-auml=`perl -CO -e 'print pack("U",0x00E4)'`
-aumlcdiar=`perl -CO -e 'print pack("U",0x0061).pack("U",0x0308)'`
 test_expect_success "setup unicode normalization tests" "
 
   test_create_repo unicode &&
@@ -50,14 +76,14 @@ test_expect_success "setup unicode normalization tests" "
 
 "
 
-test_expect_failure 'rename (silent unicode normalization)' "
+$test_unicode 'rename (silent unicode normalization)' "
 
  git mv $aumlcdiar $auml &&
  git commit -m \"rename\"
 
 "
 
-test_expect_failure 'merge (silent unicode normalization)' '
+$test_unicode 'merge (silent unicode normalization)' '
 
  git reset --hard initial &&
  git merge topic
