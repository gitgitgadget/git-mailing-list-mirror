From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/t3800: do not use a temporary file to hold expected result.
Date: Fri, 04 Jan 2008 22:48:12 -0800
Message-ID: <7vbq80g443.fsf@gitster.siamese.dyndns.org>
References: <1199506008-12225-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 07:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB2py-0007ne-FE
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 07:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbYAEGsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 01:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYAEGsZ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 01:48:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbYAEGsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 01:48:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F39D64F2;
	Sat,  5 Jan 2008 01:48:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 27F2D64F1;
	Sat,  5 Jan 2008 01:48:19 -0500 (EST)
In-Reply-To: <1199506008-12225-1-git-send-email-vmiklos@frugalware.org>
	(Miklos Vajna's message of "Sat, 5 Jan 2008 05:06:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69643>

It is a good practice to write program output to a temporary file
during the test, as it would allow easier postmortem when the tested
program does break.  But there is no benefit in writing the expected
output out to the temporary.

This actually fixes a bug in check_verify_failure() routine.
The intention of the test seems to make sure the "git mktag" command
fails, and it spits out the expected error message.  But if the
command did not fail as expected, the shell function as originally
written would not have detected the failure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3800-mktag.sh |   89 +++++++++++++++--------------------------------------
 1 files changed, 25 insertions(+), 64 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e5f3073..f280320 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -12,10 +12,11 @@ test_description='git-mktag: tag object verify test'
 # given in the expect.pat file.
 
 check_verify_failure () {
-    test_expect_success \
-        "$1" \
-        'git-mktag <tag.sig 2>message ||
-       egrep -q -f expect.pat message'
+	expect="$2"
+	test_expect_success "$1" '
+		( ! git-mktag <tag.sig 2>message ) &&
+		grep -q "$expect" message
+	'
 }
 
 ###########################################################
@@ -33,11 +34,8 @@ cat >tag.sig <<EOF
 too short for a tag
 EOF
 
-cat >expect.pat <<EOF
-^error: .*size wrong.*$
-EOF
-
-check_verify_failure 'Tag object length check'
+check_verify_failure 'Tag object length check' \
+	'^error: .*size wrong.*$'
 
 ############################################################
 #  2. object line label check
@@ -48,11 +46,7 @@ type tag
 tag mytag
 EOF
 
-cat >expect.pat <<EOF
-^error: char0: .*"object "$
-EOF
-
-check_verify_failure '"object" line label check'
+check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
 
 ############################################################
 #  3. object line SHA1 check
@@ -63,11 +57,7 @@ type tag
 tag mytag
 EOF
 
-cat >expect.pat <<EOF
-^error: char7: .*SHA1 hash$
-EOF
-
-check_verify_failure '"object" line SHA1 check'
+check_verify_failure '"object" line SHA1 check' '^error: char7: .*SHA1 hash$'
 
 ############################################################
 #  4. type line label check
@@ -78,11 +68,7 @@ xxxx tag
 tag mytag
 EOF
 
-cat >expect.pat <<EOF
-^error: char47: .*"[\]ntype "$
-EOF
-
-check_verify_failure '"type" line label check'
+check_verify_failure '"type" line label check' '^error: char47: .*"\\ntype "$'
 
 ############################################################
 #  5. type line eol check
@@ -90,11 +76,7 @@ check_verify_failure '"type" line label check'
 echo "object 779e9b33986b1c2670fff52c5067603117b3e895" >tag.sig
 printf "type tagsssssssssssssssssssssssssssssss" >>tag.sig
 
-cat >expect.pat <<EOF
-^error: char48: .*"[\]n"$
-EOF
-
-check_verify_failure '"type" line eol check'
+check_verify_failure '"type" line eol check' '^error: char48: .*"\\n"$'
 
 ############################################################
 #  6. tag line label check #1
@@ -105,11 +87,8 @@ type tag
 xxx mytag
 EOF
 
-cat >expect.pat <<EOF
-^error: char57: no "tag " found$
-EOF
-
-check_verify_failure '"tag" line label check #1'
+check_verify_failure '"tag" line label check #1' \
+	'^error: char57: no "tag " found$'
 
 ############################################################
 #  7. tag line label check #2
@@ -120,11 +99,8 @@ type taggggggggggggggggggggggggggggggg
 tag
 EOF
 
-cat >expect.pat <<EOF
-^error: char87: no "tag " found$
-EOF
-
-check_verify_failure '"tag" line label check #2'
+check_verify_failure '"tag" line label check #2' \
+	'^error: char87: no "tag " found$'
 
 ############################################################
 #  8. type line type-name length check
@@ -135,11 +111,8 @@ type taggggggggggggggggggggggggggggggg
 tag mytag
 EOF
 
-cat >expect.pat <<EOF
-^error: char53: type too long$
-EOF
-
-check_verify_failure '"type" line type-name length check'
+check_verify_failure '"type" line type-name length check' \
+	'^error: char53: type too long$'
 
 ############################################################
 #  9. verify object (SHA1/type) check
@@ -150,11 +123,8 @@ type tagggg
 tag mytag
 EOF
 
-cat >expect.pat <<EOF
-^error: char7: could not verify object.*$
-EOF
-
-check_verify_failure 'verify object (SHA1/type) check'
+check_verify_failure 'verify object (SHA1/type) check' \
+	'^error: char7: could not verify object.*$'
 
 ############################################################
 # 10. verify tag-name check
@@ -165,11 +135,8 @@ type commit
 tag my	tag
 EOF
 
-cat >expect.pat <<EOF
-^error: char67: could not verify tag name$
-EOF
-
-check_verify_failure 'verify tag-name check'
+check_verify_failure 'verify tag-name check' \
+	'^error: char67: could not verify tag name$'
 
 ############################################################
 # 11. tagger line label check #1
@@ -180,11 +147,8 @@ type commit
 tag mytag
 EOF
 
-cat >expect.pat <<EOF
-^error: char70: could not find "tagger"$
-EOF
-
-check_verify_failure '"tagger" line label check #1'
+check_verify_failure '"tagger" line label check #1' \
+	'^error: char70: could not find "tagger"$'
 
 ############################################################
 # 12. tagger line label check #2
@@ -196,11 +160,8 @@ tag mytag
 tagger
 EOF
 
-cat >expect.pat <<EOF
-^error: char70: could not find "tagger"$
-EOF
-
-check_verify_failure '"tagger" line label check #2'
+check_verify_failure '"tagger" line label check #2' \
+	'^error: char70: could not find "tagger"$'
 
 ############################################################
 # 13. create valid tag
-- 
1.5.4.rc2.17.g257f
