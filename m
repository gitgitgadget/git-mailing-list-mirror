From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 5/5] tag: recognize rfc1991 signatures
Date: Wed, 10 Nov 2010 12:17:30 +0100
Message-ID: <052734203b66fea86fda1b9aee0cf1975a3a6f9c.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 12:19:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG8iW-00055t-UH
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 12:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572Ab0KJLTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 06:19:34 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53887 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755410Ab0KJLTb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 06:19:31 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 386EC97D;
	Wed, 10 Nov 2010 06:19:31 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 10 Nov 2010 06:19:31 -0500
X-Sasl-enc: SQhFTsy61OXJavezQVZnFKSxg6E4qBaD5hxzG4maIyip 1289387970
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8ABB95E6453;
	Wed, 10 Nov 2010 06:19:30 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289387142.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161147>

We have always been creating rfc1991 signatures for users with "rfc1991"
in their gpg config but failed to recognize them (tag -l -n largenumber)
and verify them (tag -v, verify-tag).

Make good use of the refactored signature detection and let us recognize
and verify those signatures also.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7004-tag.sh |   12 ++++++------
 tag.c          |    4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index c7d49e1..6841c23 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1048,19 +1048,19 @@ cp "$1" actual
 EOF
 chmod +x fakeeditor
 
-test_expect_failure GPG \
+test_expect_success GPG \
 	'reediting a signed tag body omits signature' '
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
 	test_cmp expect actual
 '
 
-test_expect_failure GPG \
+test_expect_success GPG \
 	'verifying rfc1991 signature' '
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_failure GPG \
+test_expect_success GPG \
 	'list tag with rfc1991 signature' '
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
 	git tag -l -n1 rfc1991-signed-tag >actual &&
@@ -1073,12 +1073,12 @@ test_expect_failure GPG \
 
 rm -f gpghome/gpg.conf
 
-test_expect_failure GPG \
+test_expect_success GPG \
 	'verifying rfc1991 signature without --rfc1991' '
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_failure GPG \
+test_expect_success GPG \
 	'list tag with rfc1991 signature without --rfc1991' '
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
 	git tag -l -n1 rfc1991-signed-tag >actual &&
@@ -1089,7 +1089,7 @@ test_expect_failure GPG \
 	test_cmp expect actual
 '
 
-test_expect_failure GPG \
+test_expect_success GPG \
 	'reediting a signed tag body omits signature' '
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
diff --git a/tag.c b/tag.c
index d4f3080..f789744 100644
--- a/tag.c
+++ b/tag.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
 
 const char *tag_type = "tag";
 
@@ -140,7 +141,8 @@ size_t parse_signature(const char *buf, unsigned long size)
 {
 	char *eol;
 	size_t len = 0;
-	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)) {
+	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE) &&
+			prefixcmp(buf + len, PGP_MESSAGE)) {
 		eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
-- 
1.7.3.2.193.g78bbb
