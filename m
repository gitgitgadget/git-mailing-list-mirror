From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Mon, 28 Jan 2008 23:02:07 -0800
Message-ID: <7v7ihtqfm8.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>
	<479D805E.3000209@viscovery.net>
	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>
	<479D9ADE.6010003@viscovery.net>
	<alpine.LSU.1.00.0801281210440.23907@racer.site>
	<7vwspts9vj.fsf@gitster.siamese.dyndns.org>
	<7vbq75s80t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 08:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJkV2-0008Ec-QA
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 08:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbYA2HCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 02:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbYA2HCc
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 02:02:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbYA2HCb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 02:02:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 290D52EF3;
	Tue, 29 Jan 2008 02:02:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 387932EF1;
	Tue, 29 Jan 2008 02:02:20 -0500 (EST)
In-Reply-To: <7vbq75s80t.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 28 Jan 2008 18:03:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71957>

Ok, the three patches from this afternoon, squashed together
into one, seems to give us quite a nice property.

Here is an demonstration.

 t/t7010-setup.sh |  117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 117 insertions(+), 0 deletions(-)
 create mode 100755 t/t7010-setup.sh

diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
new file mode 100755
index 0000000..da20ba5
--- /dev/null
+++ b/t/t7010-setup.sh
@@ -0,0 +1,117 @@
+#!/bin/sh
+
+test_description='setup taking and sanitizing funny paths'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	mkdir -p a/b/c a/e &&
+	D=$(pwd) &&
+	>a/b/c/d &&
+	>a/e/f
+
+'
+
+test_expect_success 'git add (absolute)' '
+
+	git add "$D/a/b/c/d" &&
+	git ls-files >current &&
+	echo a/b/c/d >expect &&
+	diff -u expect current
+
+'
+
+
+test_expect_success 'git add (funny relative)' '
+
+	rm -f .git/index &&
+	(
+		cd a/b &&
+		git add "../e/./f"
+	) &&
+	git ls-files >current &&
+	echo a/e/f >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git rm (absolute)' '
+
+	rm -f .git/index &&
+	git add a &&
+	git rm -f --cached "$D/a/b/c/d" &&
+	git ls-files >current &&
+	echo a/e/f >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git rm (funny relative)' '
+
+	rm -f .git/index &&
+	git add a &&
+	(
+		cd a/b &&
+		git rm -f --cached "../e/./f"
+	) &&
+	git ls-files >current &&
+	echo a/b/c/d >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git ls-files (absolute)' '
+
+	rm -f .git/index &&
+	git add a &&
+	git ls-files "$D/a/e/../b" >current &&
+	echo a/b/c/d >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git ls-files (relative #1)' '
+
+	rm -f .git/index &&
+	git add a &&
+	(
+		cd a/b &&
+		git ls-files "../b/c"
+	)  >current &&
+	echo c/d >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git ls-files (relative #2)' '
+
+	rm -f .git/index &&
+	git add a &&
+	(
+		cd a/b &&
+		git ls-files --full-name "../e/f"
+	)  >current &&
+	echo a/e/f >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git ls-files (relative #3)' '
+
+	rm -f .git/index &&
+	git add a &&
+	(
+		cd a/b &&
+		if git ls-files "../e/f"
+		then
+			echo Gaah, should have failed
+			exit 1
+		else
+			: happy
+		fi
+	)
+
+'
+
+test_done
