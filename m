From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hacks for AIX
Date: Sun, 20 Jul 2008 01:33:46 -0700
Message-ID: <7vd4l9c5ud.fsf@gitster.siamese.dyndns.org>
References: <5855afd30807161057v54ed4112jaea3bc07cebf44d4@mail.gmail.com>
 <7v3am9sn2p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: "Chris Cowan" <chris.o.cowan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 10:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKUNd-00049a-2s
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 10:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbYGTId4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 04:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbYGTId4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 04:33:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbYGTIdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 04:33:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 48E5533496;
	Sun, 20 Jul 2008 04:33:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B5D8233495; Sun, 20 Jul 2008 04:33:48 -0400 (EDT)
In-Reply-To: <7v3am9sn2p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 16 Jul 2008 11:25:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9664491E-5636-11DD-A0F5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89174>

Junio C Hamano <gitster@pobox.com> writes:

>>     * /usr/bin/patch - really old version, doesn't do well with some
>> diff formats.   I avoid using it.
>
> t4109 seems to use patch to produce expected output for the tests; we
> should ship a precomputed expected results.  Do you know of any other
> places "patch" is used?

As usual, I won't commit this patch unless I hear from people who
potentially would benefit from it.  I do not need such a patch myself and
I really shouldn't be spending too much of my time on these.

-- >8 --
[PATCH] do not rely on external "patch" in tests

Some of our tests assumed a working "patch" command to produce expected
results when checking "git-apply", but some systems have broken "patch".

We can compare our output with expected output that is precomputed
instead to sidestep this issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4109-apply-multifrag.sh |  119 +++++++++++++++++++++++++++++++++++---------
 t/t4110-apply-scan.sh      |   35 ++++++++++---
 2 files changed, 123 insertions(+), 31 deletions(-)

diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
index bd40a21..4805863 100755
--- a/t/t4109-apply-multifrag.sh
+++ b/t/t4109-apply-multifrag.sh
@@ -138,39 +138,112 @@ diff --git a/main.c b/main.c
  
 EOF
 
-test_expect_success "S = git apply (1)" \
-    'git apply patch1.patch patch2.patch'
-mv main.c main.c.git
+cat >expect_1 <<\EOF
+#include <stdlib.h>
+#include <stdio.h>
 
-test_expect_success "S = patch (1)" \
-    'cat patch1.patch patch2.patch | patch -p1'
+int func(int num);
+void print_int(int num);
+void print_ln();
 
-test_expect_success "S = cmp (1)" \
-    'cmp main.c.git main.c'
+int main() {
+	int i;
 
-rm -f main.c main.c.git
+	for (i = 0; i < 10; i++) {
+		print_int(func(i));
+	}
 
-test_expect_success "S = git apply (2)" \
-    'git apply patch1.patch patch2.patch patch3.patch'
-mv main.c main.c.git
+	print_ln();
 
-test_expect_success "S = patch (2)" \
-    'cat patch1.patch patch2.patch patch3.patch | patch -p1'
+	return 0;
+}
 
-test_expect_success "S = cmp (2)" \
-    'cmp main.c.git main.c'
+int func(int num) {
+	return num * num;
+}
 
-rm -f main.c main.c.git
+void print_int(int num) {
+	printf("%d", num);
+}
 
-test_expect_success "S = git apply (3)" \
-    'git apply patch1.patch patch4.patch'
-mv main.c main.c.git
+void print_ln() {
+	printf("\n");
+}
 
-test_expect_success "S = patch (3)" \
-    'cat patch1.patch patch4.patch | patch -p1'
+EOF
+
+test_expect_success 'git apply (1)' '
+	git apply patch1.patch patch2.patch &&
+	mv main.c actual &&
+	test_cmp expect_1 actual
+'
+
+cat >expect_2 <<\EOF
+#include <stdio.h>
+
+int func(int num);
+void print_int(int num);
+
+int main() {
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		print_int(func(i));
+	}
+
+	return 0;
+}
+
+int func(int num) {
+	return num * num;
+}
+
+void print_int(int num) {
+	printf("%d", num);
+}
+
+EOF
 
-test_expect_success "S = cmp (3)" \
-    'cmp main.c.git main.c'
+test_expect_success 'git apply (2)' '
+	rm -f main.c &&
+	git apply patch1.patch patch2.patch patch3.patch &&
+	mv main.c actual &&
+	test_cmp expect_2 actual
+'
+
+cat >expect_3 <<\EOF
+#include <stdio.h>
+
+int func(int num);
+int func2(int num);
+
+int main() {
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		printf("%d", func(i));
+		printf("%d", func3(i));
+	}
+
+	return 0;
+}
+
+int func(int num) {
+	return num * num;
+}
+
+int func2(int num) {
+	return num * num * num;
+}
+
+EOF
+
+test_expect_success 'git apply (3)' '
+	rm -f main.c &&
+	git apply patch1.patch patch4.patch &&
+	mv main.c actual &&
+	test_cmp expect_3 actual
+'
 
 test_done
 
diff --git a/t/t4110-apply-scan.sh b/t/t4110-apply-scan.sh
index db60652..ae300ca 100755
--- a/t/t4110-apply-scan.sh
+++ b/t/t4110-apply-scan.sh
@@ -86,15 +86,34 @@ diff --git a/new.txt b/new.txt
 +c2222
 EOF
 
-test_expect_success "S = git apply scan" \
-    'git apply patch1.patch patch2.patch patch3.patch patch4.patch patch5.patch'
-mv new.txt apply.txt
+cat >expect <<\EOF
+a1
+a11
+a111
+a1111
+b1
+b11
+b111
+b1111
+b2
+b22
+b222
+b2222
+c1
+c11
+c111
+c1111
+c2
+c22
+c222
+c2222
+EOF
 
-test_expect_success "S = patch scan" \
-    'cat patch1.patch patch2.patch patch3.patch patch4.patch patch5.patch | patch'
-mv new.txt patch.txt
 
-test_expect_success "S = cmp" \
-    'cmp apply.txt patch.txt'
+test_expect_success 'apply series of patches' '
+	git apply patch1.patch patch2.patch patch3.patch patch4.patch patch5.patch &&
+	mv new.txt actual &&
+	test_cmp expect actual
+'
 
 test_done
