From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 07/10] rev-list: documentation and test for --cherry-mark
Date: Thu, 10 Mar 2011 15:45:00 +0100
Message-ID: <fd5b65227573cb8d5ff7c8087814f9b8f8e0851e.1299767413.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhB8-0007ob-8T
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab1CJOsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:55 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38838 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752052Ab1CJOsx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:53 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D68D220D4F;
	Thu, 10 Mar 2011 09:48:52 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 10 Mar 2011 09:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ODm8WvVjX8+ynuQBd69v0fKbQXQ=; b=ZAw61WaKHbFi+YB1gZ8y3MBt9yDlm9YvUFErxEbc/z8ET2R4r0TXuRvZwkeggiooEm1dI1uHpC2JJJ621UVn03HAm4K39BeJ2zihU2rL3dRenMs/cUsdTgnOGR3KjxhFnqns8zDKOGPO4wpEU0T4xpMOIb8hBphMd+0oWKWsX1I=
X-Sasl-enc: h+xsgB6nRH+k55FTLs3FiF9d9/8sZPQaXcm2I0Fxwu+k 1299768532
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 70C3C40D3AC;
	Thu, 10 Mar 2011 09:48:52 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168824>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-list.txt       |    1 +
 Documentation/rev-list-options.txt   |    5 +++++
 t/t6007-rev-list-cherry-pick-file.sh |   28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 5f47a13..8a891ca 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -33,6 +33,7 @@ SYNOPSIS
 	     [ \--left-right ]
 	     [ \--left-only ]
 	     [ \--right-only ]
+	     [ \--cherry-mark ]
 	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index cebba62..4755b83 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -305,6 +305,11 @@ ifdef::git-rev-list[]
 	to /dev/null as the output does not have to be formatted.
 endif::git-rev-list[]
 
+--cherry-mark::
+
+	Like `--cherry-pick` (see below) but mark equivalent commits
+	with `=` rather than omitting them, and inequivalent ones with `+`.
+
 --cherry-pick::
 
 	Omit any commit that introduces the same change as
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index cd089a9..37bd25e 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -100,6 +100,34 @@ test_expect_success '--cherry-pick bar does not come up empty (II)' '
 '
 
 cat >expect <<EOF
++tags/F
+=tags/D
++tags/E
+=tags/C
+EOF
+
+test_expect_success '--cherry-mark' '
+	git rev-list --cherry-mark F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+cat >expect <<EOF
+<tags/F
+=tags/D
+>tags/E
+=tags/C
+EOF
+
+test_expect_success '--cherry-mark --left-right' '
+	git rev-list --cherry-mark --left-right F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+cat >expect <<EOF
 tags/E
 EOF
 
-- 
1.7.4.1.317.gf445f
