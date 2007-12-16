From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Re-re-re-fix common tail optimization
Date: Sun, 16 Dec 2007 13:49:17 -0800
Message-ID: <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org>
References: <20071215111621.GA8139@coredump.intra.peff.net>
	<20071215155150.GA24810@coredump.intra.peff.net>
	<7vprx7n90t.fsf@gitster.siamese.dyndns.org>
	<20071215200202.GA3334@sigill.intra.peff.net>
	<20071216070614.GA5072@sigill.intra.peff.net>
	<7v8x3ul927.fsf@gitster.siamese.dyndns.org>
	<7v7ijejq6j.fsf@gitster.siamese.dyndns.org>
	<20071216212104.GA32307@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 16 22:50:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J41Mv-0003bE-QE
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 22:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760216AbXLPVt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 16:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758003AbXLPVt3
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 16:49:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760158AbXLPVt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 16:49:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E7BA360B;
	Sun, 16 Dec 2007 16:49:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 533BD3609;
	Sun, 16 Dec 2007 16:49:19 -0500 (EST)
In-Reply-To: <20071216212104.GA32307@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 16 Dec 2007 16:21:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68493>

Jeff King <peff@peff.net> writes:

> No, I think it's right as-is. We forget about the blocks during the
> recovery section of the code. IOW, we just keep reading forward until we
> find all of the context lines, or we run out of trimmed content. In the
> first case, we are fine (we restored the right number of context lines).
> In the latter case, we are also fine, because we end up trimming nothing
> (IOW, there _weren't_ enough context lines in the first place).

Kind'a embarrassing that both of us cannot get this right without so
many rounds, isn't it?

-- >8 --
Subject: [PATCH] Re-re-re-fix common tail optimization

We need to be extra careful recovering the removed common section, so
that we do not break context nor the changed incomplete line (i.e. the
last line that does not end with LF).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 t/t4024-diff-optimize-common.sh |   69 +++++++++++++++++++++++++++++++++++++++
 xdiff-interface.c               |    2 +-
 2 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
new file mode 100755
index 0000000..10405f1
--- /dev/null
+++ b/t/t4024-diff-optimize-common.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='common tail optimization'
+
+. ./test-lib.sh
+
+z=zzzzzzzz ;# 8
+z="$z$z$z$z$z$z$z$z" ;# 64
+z="$z$z$z$z$z$z$z$z" ;# 512
+z="$z$z$z$z" ;# 2048
+z2047=$(expr "$z" : '.\(.*\)') ; #2047
+
+test_expect_success setup '
+
+	echo "a$z2047" >file-a &&
+	echo "b" >file-b &&
+	echo "$z2047" >>file-b &&
+	echo "c$z2047" | tr -d "\012" >file-c &&
+	echo "d" >file-d &&
+	echo "$z2047" | tr -d "\012" >>file-d &&
+
+	git add file-a file-b file-c file-d &&
+
+	echo "A$z2047" >file-a &&
+	echo "B" >file-b &&
+	echo "$z2047" >>file-b &&
+	echo "C$z2047" | tr -d "\012" >file-c &&
+	echo "D" >file-d &&
+	echo "$z2047" | tr -d "\012" >>file-d
+
+'
+
+echo >expect <<\EOF
+diff --git a/file-a b/file-a
+--- a/file-a
++++ b/file-a
+@@ -1 +1 @@
+-aZ
++AZ
+diff --git a/file-b b/file-b
+--- a/file-b
++++ b/file-b
+@@ -1 +1 @@
+-b
++B
+diff --git a/file-c b/file-c
+--- a/file-c
++++ b/file-c
+@@ -1 +1 @@
+-cZ
+\ No newline at end of file
++CZ
+\ No newline at end of file
+diff --git a/file-d b/file-d
+--- a/file-d
++++ b/file-d
+@@ -1 +1 @@
+-d
++D
+EOF
+
+test_expect_success 'diff -U0' '
+
+	git diff -U0 | sed -e "/^index/d" -e "s/$z2047/Z/g" >actual &&
+	diff -u expect actual
+
+'
+
+test_done
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 98b02ed..9ee877c 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -121,7 +121,7 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b, long ctx)
 		bp -= blk;
 	}
 
-	while (recovered < trimmed && ctx)
+	while (recovered < trimmed && 0 <= ctx)
 		if (ap[recovered++] == '\n')
 			ctx--;
 	a->size -= (trimmed - recovered);
