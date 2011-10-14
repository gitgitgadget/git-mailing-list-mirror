From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t7800: avoid arithmetic expansion notation
Date: Fri, 14 Oct 2011 14:15:31 +0200
Message-ID: <837ad77348b459aa5f5f79e556dbeeeba41027e7.1318594392.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 14:15:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REgfr-0004OW-Q5
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 14:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1JNMPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 08:15:35 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52797 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751781Ab1JNMPe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 08:15:34 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2572120D19;
	Fri, 14 Oct 2011 08:15:34 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 14 Oct 2011 08:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=K2lbOEsE5MX/EfUEGLisUF0R2YM=; b=eluiSS0W+ymBB6x9IL/N
	f2ZZxnIVsznKXvrYq0VyXSO9XX6Iyq7Gp/j7bH3Hd4mpJNg/UhheKXLn/lz41h/l
	l7EsyvHL5BPUHsuGCh/1Ei4quQOpxIMQ+tAnKg4sZSV32PfRrlYEbGaiv9Xwnich
	nJMNpu2TkWKclTS8FIa6PrE=
X-Sasl-enc: QPLCnQf8kf+DoF+cVgO4VrYDmg+GstRfDNa2R+TmqLLO 1318594533
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8CAD8404A4B;
	Fri, 14 Oct 2011 08:15:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.338.g0156b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183565>

ba959de (git-difftool: allow skipping file by typing 'n' at prompt, 2011-10-08)
introduced shell code like

$((foo; bar) | baz)

which some shells (e.g. bash, dash) interpret as an unfinished arithmetic
evaluation $(( expr )).

Write this as

$({foo; bar; } | baz)

which is unambiguous and also avoids an unnecessary subshell.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7800-difftool.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 7fc2b3a..76a8b70 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -289,7 +289,7 @@ test_expect_success PERL 'setup with 2 files different' '
 '
 
 test_expect_success PERL 'say no to the first file' '
-	diff=$((echo n; echo) | git difftool -x cat branch) &&
+	diff=$({ echo n; echo; } | git difftool -x cat branch) &&
 
 	echo "$diff" | stdin_contains m2 &&
 	echo "$diff" | stdin_contains br2 &&
@@ -298,7 +298,7 @@ test_expect_success PERL 'say no to the first file' '
 '
 
 test_expect_success PERL 'say no to the second file' '
-	diff=$((echo; echo n) | git difftool -x cat branch) &&
+	diff=$({ echo; echo n; } | git difftool -x cat branch) &&
 
 	echo "$diff" | stdin_contains master &&
 	echo "$diff" | stdin_contains branch &&
-- 
1.7.7.338.g0156b
