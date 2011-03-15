From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] git-bisect.txt: example for bisecting with hot-fix
Date: Tue, 15 Mar 2011 22:24:56 +0100
Message-ID: <500d8098e1993b3aab3e1ff4f616ae9093cd2a1b.1300224056.git.git@drmicha.warpmail.net>
References: <7vy64hehbh.fsf@alter.siamese.dyndns.org>
Cc: Jan Beulich <JBeulich@novell.com>, "H.J. Lu" <hjl.tools@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 22:25:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzbjr-0006K3-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 22:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711Ab1COVZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 17:25:04 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59835 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758688Ab1COVZC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2011 17:25:02 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4918020743;
	Tue, 15 Mar 2011 17:25:02 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 15 Mar 2011 17:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=KoszJH2yiAdS5B3Cya1OJTyM0zQ=; b=H4noYDl7ywNm59HtIzuoGhpxs6L2LdtqPyNvnR/lZEXEIGl7Itf0kN9euhDPt6dwkekThd6a0RyWGpuWz/ELoCj19xJzY0hGEUbSQQKVSOi8LU3vij7jPLMD9m4uRCG1vXHYFnr3/A4oP8FgZJmlvnRJXtpvwnH6EsNHV1yBqQU=
X-Sasl-enc: 0d93j1iqCNKg0Fto3YIxxiQEIRL2+XSlnnHHLDDJqmLU 1300224301
Received: from localhost (p54859037.dip0.t-ipconnect.de [84.133.144.55])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4A710442ED4;
	Tue, 15 Mar 2011 17:25:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.404.g62d316
In-Reply-To: <7vy64hehbh.fsf@alter.siamese.dyndns.org>
In-Reply-To: <57605e2f4533a3c656d24f3a7ec6264e0bd949fe.1300224056.git.git@drmicha.warpmail.net>
References: <57605e2f4533a3c656d24f3a7ec6264e0bd949fe.1300224056.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169092>

Give an example on how to bisect when older revisions need a hot-fix to
build, run or test. Triggered by the binutils/kernel issue at

http://thread.gmane.org/gmane.comp.gnu.binutils/52601/focus=1112779

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
The example script is basically Junio's, with merge rather than cherry-pick.

 Documentation/git-bisect.txt |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 47e8b1e..989e223 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -294,6 +294,39 @@ It is safer if both "test.sh" and "check_test_case.sh" are
 outside the repository to prevent interactions between the bisect,
 make and test processes and the scripts.
 
+* Automatically bisect with temporary modifications (hot-fix):
++
+------------
+$ cat ~/test.sh
+#!/bin/sh
+
+# tweak the working tree by merging the hot-fix branch
+# and then attempt a build
+if	git merge --no-commit hot-fix &&
+	make
+then
+	# run project specific test and report its status
+	~/check_test_case.sh
+	status=$?
+else
+	# tell the caller this is untestable
+	status=125
+fi
+
+# undo the tweak to allow clean flipping to the next commit
+git reset --hard
+
+# return control
+exit $status
+------------
++
+This applies modifications from a hot-fix branch before each test run,
+e.g. in case your build or test environment changed so that older
+revisions may need a fix which newer ones have already. (Make sure the
+hot-fix branch is based off a commit which is contained in all revisions
+which you are bisecting, so that the merge does not pull in too much, or
+use `git cherry-pick` instead of `git merge`.)
+
 * Automatically bisect a broken test case:
 +
 ------------
-- 
1.7.4.1.404.g62d316
