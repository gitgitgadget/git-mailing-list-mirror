From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 7/9] rev-list: documentation and test for --cherry-mark
Date: Mon,  7 Mar 2011 13:31:41 +0100
Message-ID: <438c61ffc424fd29b124927536981c11587e00b6.1299499429.git.git@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 13:35:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZf6-0003Ub-69
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347Ab1CGMfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 07:35:30 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53836 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751004Ab1CGMfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:35:25 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ABD1B20815;
	Mon,  7 Mar 2011 07:35:24 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 07 Mar 2011 07:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=jpHhyr0iTvwWgAvoYFabQBYcSP8=; b=a4uuvjvYBJF49IiDZeM5E1GZY0K0GDmnYZ52Xogg0M+XCNxiG2mqxNfrB9L+k/DswVCduFeTaPdos4+94HfQoLyw/BEVogabfyZGc7F0ku6CpF65GhIDSqDZTa9g4oGeiW6HlIPAUrYGM/+KhVwueic/AtKmbRrNV/gYB/VkbvQ=
X-Sasl-enc: AsiyTndfB/Yzzi+4Cnad76sIfitandWfDji9RfhVUwxd 1299501324
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 11A89444564;
	Mon,  7 Mar 2011 07:35:23 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <cover.1299499429.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168587>

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
1.7.4.1.299.g567d7.dirty
