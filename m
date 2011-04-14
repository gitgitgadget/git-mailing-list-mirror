From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] t3306,t5304: avoid clock skew issues
Date: Thu, 14 Apr 2011 19:38:13 +0200
Message-ID: <7ba5c34afb2e21355c2ec4b8251738c99895f693.1302802425.git.git@drmicha.warpmail.net>
References: <4D9F706E.2090309@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 19:38:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAQUp-0004Mv-7I
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 19:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab1DNRiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 13:38:17 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52465 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753542Ab1DNRiR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 13:38:17 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9065120BD4;
	Thu, 14 Apr 2011 13:38:16 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 14 Apr 2011 13:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=vXZBRxaF7LZLpn3jPgXmBU97mg4=; b=AQD3QyQIzcuYdcVwuow3l1SHLC0co9muT6bEpSHfPZ8Q0/8bNb0pFmBHDuYoN/5Do+N68FNNNimjfguW/VOJgm2rRmHGdiYcRZCLUAMBv5qrJSPybZ3FPz3A5JHKfYvLjRbkAsMSFUCp7qvrtiFBTkB9avg6xZ0ERFrlXHEWZL0=
X-Sasl-enc: OMCQlXjsFzzcK4nDArlot4Mo1AinezT3YMqpWIVS+ijQ 1302802695
Received: from localhost (p54859211.dip0.t-ipconnect.de [84.133.146.17])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C15B5443E91;
	Thu, 14 Apr 2011 13:38:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1.312.g1936c
In-Reply-To: <4D9F706E.2090309@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171527>

On systems where the local time and file modification time may be out of
sync (e.g. test directory on NFS) t3306 and t5305 can fail because prune
compares times such as "now" (client time) with file modification times
(server times for remote file systems). I.e., these are spurious test
failures.

Avoid this by setting the relevant modification times to the local time.

Noticed on a system with as little as 2s time skew.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I don't think we can safeguard prune itself properly. A filesystem may be out
of time sync sporadically (and produce incorrect time stamps) but then be in
sync when "git prune" is run so that we can't detect it.

v2 uses the known sha1 directly in t3306, just like the rest of the test.
---
 t/t3306-notes-prune.sh |    3 +++
 t/t5304-prune.sh       |    3 ++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index c428217..86bf909 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -20,6 +20,9 @@ test_expect_success 'setup: create a few commits with notes' '
 	git add file3 &&
 	test_tick &&
 	git commit -m 3rd &&
+	COMMIT_FILE=.git/objects/5e/e1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	test -f $COMMIT_FILE &&
+	test-chmtime =+0 $COMMIT_FILE &&
 	git notes add -m "Note #3"
 '
 
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e2ed13d..d645328 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -14,7 +14,8 @@ add_blob() {
 	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE
+	test -f $BLOB_FILE &&
+	test-chmtime =+0 $BLOB_FILE
 }
 
 test_expect_success setup '
-- 
1.7.5.rc1.312.g1936c
