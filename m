From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/5] t/t7004-tag: test handling of rfc1991 signatures
Date: Wed, 10 Nov 2010 12:17:26 +0100
Message-ID: <5bad237fcbe2b01481d350b24bd7daea2dd0bd64.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 12:19:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG8i9-0004yp-8z
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 12:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab0KJLTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 06:19:25 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39782 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088Ab0KJLTY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 06:19:24 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9DAB6906;
	Wed, 10 Nov 2010 06:19:23 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 10 Nov 2010 06:19:23 -0500
X-Sasl-enc: f5+i/PGYLAqHInQM88FFj/emAKkazTqDM7Ch2vXb89Pu 1289387963
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F215D5E4ED1;
	Wed, 10 Nov 2010 06:19:22 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289387142.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161143>

Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the beginning of a
signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used with
the "rfc1991" option. This leads to git's failing to verify it's own
signed tags, among other problems.

Add tests for all code paths (tag -v, tag -l -n largenumber, tag -f
without -m) where signature detection matters.

Reported-by: Stephan Hugel <urschrei@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7004-tag.sh |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index ac943f5..c7d49e1 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1030,6 +1030,72 @@ test_expect_success GPG \
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
+test_expect_failure GPG \
+	'verifying rfc1991 signature without --rfc1991' '
+	git tag -v rfc1991-signed-tag
+'
+
+test_expect_failure GPG \
+	'list tag with rfc1991 signature without --rfc1991' '
+	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
+	git tag -l -n1 rfc1991-signed-tag >actual &&
+	test_cmp expect actual &&
+	git tag -l -n2 rfc1991-signed-tag >actual &&
+	test_cmp expect actual &&
+	git tag -l -n999 rfc1991-signed-tag >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure GPG \
+	'reediting a signed tag body omits signature' '
+	echo "RFC1991 signed tag" >expect &&
+	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
+	test_cmp expect actual
+'
+
 # try to sign with bad user.signingkey
 git config user.signingkey BobTheMouse
 test_expect_success GPG \
-- 
1.7.3.2.193.g78bbb
