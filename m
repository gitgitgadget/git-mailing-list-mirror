From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t5521: fix and modernize
Date: Wed, 24 Feb 2010 10:22:05 -0800
Message-ID: <1267035726-2815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 19:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkLsH-000578-HX
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 19:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757279Ab0BXSWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 13:22:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab0BXSWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 13:22:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 404E19C5B6
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 13:22:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=MFiWg2d6gy1DJhBRqnNUjWPkH10
	=; b=smjbCcFjgGzVtBKCczzLgaRoOOYOtlesRexqx47GngV1RDpG85h/pnF3XJa
	nEX6kX+pjtUSR1/Ul5otPcfwGqvltUlTOEXq+uHcmOMbedn++lJphZYEbiTHGNCQ
	OUj0pOFldP+6NUCptgzN+3q1Ap3/mNcqfns7G6Oxmzl0kiCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=Cg8S/9OWNfwJA2DoiwuMbSUUcCB+A
	rUlRthX9Ui9jN7JsR2E+dh0CNmbiYdK7XIVNpq4ERSaezHTnXjkgtSCE6tciQemo
	+gCEgzPYrergfv+bJNQ5GRBkXzEf8AMk1fdiJtPK5C9advw4Ghqdgr5nsOttcl9k
	poXtCkrbRO9nIE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C9099C5B3
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 13:22:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A79E9C5B0 for
 <git@vger.kernel.org>; Wed, 24 Feb 2010 13:22:07 -0500 (EST)
X-Mailer: git-send-email 1.7.0.207.gac4ec
X-Pobox-Relay-ID: 847B4E66-2171-11DF-A2C6-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140967>

All of these tests were bogus, as they created new directory and tried to
run "git pull" without even running "git init" in there.  They were mucking
with the repository in $TEST_DIRECTORY.

While fixing it, modernize the style not to chdir around outside of
subshell.  Otherwise a failed test will take us to an unexpected directory
and we need to chdir back to the test directory in each test, which is
ugly and error prone.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5521-pull-options.sh |   46 ++++++++++++++++++++--------------------------
 1 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 83e2e8a..c18d829 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -4,8 +4,6 @@ test_description='pull options'
 
 . ./test-lib.sh
 
-D=`pwd`
-
 test_expect_success 'setup' '
 	mkdir parent &&
 	(cd parent && git init &&
@@ -13,48 +11,44 @@ test_expect_success 'setup' '
 	 git commit -m one)
 '
 
-cd "$D"
-
 test_expect_success 'git pull -q' '
 	mkdir clonedq &&
-	cd clonedq &&
-	git pull -q "$D/parent" >out 2>err &&
-	test ! -s out
+	(cd clonedq && git init &&
+	git pull -q "../parent" >out 2>err &&
+	test ! -s err &&
+	test ! -s out)
 '
 
-cd "$D"
-
 test_expect_success 'git pull' '
 	mkdir cloned &&
-	cd cloned &&
-	git pull "$D/parent" >out 2>err &&
-	test -s out
+	(cd cloned && git init &&
+	git pull "../parent" >out 2>err &&
+	test -s err &&
+	test ! -s out)
 '
-cd "$D"
 
 test_expect_success 'git pull -v' '
 	mkdir clonedv &&
-	cd clonedv &&
-	git pull -v "$D/parent" >out 2>err &&
-	test -s out
+	(cd clonedv && git init &&
+	git pull -v "../parent" >out 2>err &&
+	test -s err &&
+	test ! -s out)
 '
 
-cd "$D"
-
 test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
-	cd clonedvq &&
-	git pull -v -q "$D/parent" >out 2>err &&
-	test ! -s out
+	(cd clonedvq && git init &&
+	git pull -v -q "../parent" >out 2>err &&
+	test ! -s out &&
+	test ! -s err)
 '
 
-cd "$D"
-
 test_expect_success 'git pull -q -v' '
 	mkdir clonedqv &&
-	cd clonedqv &&
-	git pull -q -v "$D/parent" >out 2>err &&
-	test -s out
+	(cd clonedqv && git init &&
+	git pull -q -v "../parent" >out 2>err &&
+	test ! -s out &&
+	test -s err)
 '
 
 test_done
-- 
1.7.0.207.gac4ec
