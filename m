From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Fri, 01 Feb 2008 03:10:37 -0800
Message-ID: <7vtzkt7x02.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<200802010534.55925.robin.rosenberg.lists@dewire.com>
	<7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
	<200802011010.41938.robin.rosenberg.lists@dewire.com>
	<7v63x99dt9.fsf@gitster.siamese.dyndns.org>
	<7v1w7x9cgf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 12:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKtnr-0007L8-77
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 12:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbYBALKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 06:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbYBALKy
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 06:10:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554AbYBALKx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 06:10:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D9A3C1443;
	Fri,  1 Feb 2008 06:10:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E61C81421;
	Fri,  1 Feb 2008 06:10:43 -0500 (EST)
In-Reply-To: <7v1w7x9cgf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 01 Feb 2008 02:51:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72167>

Junio C Hamano <gitster@pobox.com> writes:

> I haven't looked at the code, but I suspect that "git add" and
> anything that uses the same logic as "ls-files --error-unmatch"
> would still not work with the setup patch.

Ok, I looked at the code.

I already had a fix for "ls-files --error-unmatch" in the
weatherbaloon patch.  The logic to complain and fail nonsense
paths was needed for "add".

The attached is on top of the previous one and your test case
updates.  We may want to also add tests for --error-unmatch.

It is very tempting to enhance pathspec API in such a way that
it is not just a NULL terminated array of (char*) pointers, but
a pointer to a richer structure that knows the number of
elements and which strings need to be freed (and we would invent
a "free_pathspec()" function to free them) and such, but that is
an independent surgery that is outside of the scope of flying
weatherbaloons.

---

 builtin-add.c    |   12 ++++++++++++
 t/t7010-setup.sh |   20 ++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 4a91e3e..820110e 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -228,6 +228,18 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		goto finish;
 	}
 
+	if (*argv) {
+		/* Was there an invalid path? */
+		if (pathspec) {
+			int num;
+			for (num = 0; pathspec[num]; num++)
+				; /* just counting */
+			if (argc != num)
+				exit(1); /* error message already given */
+		} else
+			exit(1); /* error message already given */
+	}
+
 	fill_directory(&dir, pathspec, ignored_too);
 
 	if (show_only) {
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index 60c4a46..e809e0e 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -135,20 +135,28 @@ test_expect_success 'blame using absolute path names' '
 	diff -u f1.txt f2.txt
 '
 
-test_expect_failure 'add a directory outside the work tree' '
+test_expect_success 'setup deeper work tree' '
+	test_create_repo tester
+'
+
+test_expect_success 'add a directory outside the work tree' '(
+	cd tester &&
 	d1="$(cd .. ; pwd)" &&
 	git add "$d1"
-	echo $?
-'
+)'
 
-test_expect_failure 'add a file outside the work tree, nasty case 1' '(
+test_expect_success 'add a file outside the work tree, nasty case 1' '(
+	cd tester &&
 	f="$(pwd)x" &&
+	echo "$f" &&
 	touch "$f" &&
 	git add "$f"
 )'
 
-test_expect_failure 'add a file outside the work tree, nasty case 2' '(
-	f="$(pwd|sed "s/.$//")x" &&
+test_expect_success 'add a file outside the work tree, nasty case 2' '(
+	cd tester &&
+	f="$(pwd | sed "s/.$//")x" &&
+	echo "$f" &&
 	touch "$f" &&
 	git add "$f"
 )'
