From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/5] t/t7004-tag: test handling of rfc1991 signatures
Date: Sat,  6 Nov 2010 12:04:06 +0100
Message-ID: <c20fb62cefcd42533e47f6f1bf5817712e5ebf9a.1289041051.git.git@drmicha.warpmail.net>
References: <4CAB90EC.1080302@drmicha.warpmail.net>
Cc: Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEgfG-0004FV-2N
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab0KFLKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:10:09 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50199 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755364Ab0KFLJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 07:09:57 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9C26E642;
	Sat,  6 Nov 2010 07:03:47 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sat, 06 Nov 2010 07:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ILL9njj9A3N0loeLDvdt4LwRJ98=; b=u0LjNL0I8WJlvBYt+969eNUhcSvtMmJ7zwNBZKX8e3QPHSf8RyidOM+V0A5gutOr6BXQ2vTN7G3GLqLNWdj5FXE0+bYEwB0W4Vz6I1w7th7uND/2oHAkmygm88GWxE4l9CuiC4EyjYPCYphvEngzkNIDHckZa883W/ZxUwHbUGo=
X-Sasl-enc: w5DHSaXuAymjSx0B8y8b94jPNQhFGfR6165QYyAMAMuy 1289041426
Received: from localhost (p548596E8.dip0.t-ipconnect.de [84.133.150.232])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AEF98402E1E;
	Sat,  6 Nov 2010 07:03:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <4CAB90EC.1080302@drmicha.warpmail.net>
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160838>

Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the beginning of a
signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used with
the "rfc1991" option. This leads to git's failing to verify it's own
signed tags, among other problems.

Add tests for all code paths (tag -v, tag -l -n largenumber, tag -f
without -m) where signature detection matters.

Reported-by: Stephan Hugel <urschrei@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7004-tag.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index ac943f5..22dcc45 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1030,6 +1030,49 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
+# usage with rfc1991 signatures
+echo "rfc1991" > gpghome/gpg.conf
+get_tag_header rfc1991-signed-tag $commit commit $time >expect
+echo "RFC1991 signed tag" >>expect
+echo '-----BEGIN PGP MESSAGE-----' >>expect
+test_expect_success GPG \
+	'creating a signed tag with rfc1991' '
+	git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
+	get_tag_msg rfc1991-signed-tag >actual &&
+	test_cmp expect actual
+'
+
+cat >fakeeditor <<'EOF'
+#!/bin/sh
+cp "$1" actual
+EOF
+chmod +x fakeeditor
+
+test_expect_failure GPG \
+	'reediting a signed tag body omits signature' '
+	echo "RFC1991 signed tag" >expect &&
+	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
+	test_cmp expect actual
+'
+
+test_expect_failure GPG \
+	'verifying rfc1991 signature' '
+	git tag -v rfc1991-signed-tag
+'
+
+test_expect_failure GPG \
+	'list tag with rfc1991 signature' '
+	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
+	git tag -l -n1 rfc1991-signed-tag >actual &&
+	test_cmp expect actual &&
+	git tag -l -n2 rfc1991-signed-tag >actual &&
+	test_cmp expect actual &&
+	git tag -l -n999 rfc1991-signed-tag >actual &&
+	test_cmp expect actual
+'
+
+rm -f gpghome/gpg.conf
+
 # try to sign with bad user.signingkey
 git config user.signingkey BobTheMouse
 test_expect_success GPG \
-- 
1.7.3.2.193.g78bbb
