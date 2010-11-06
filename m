From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 5/5] tag: recognize rfc1991 signatures
Date: Sat,  6 Nov 2010 12:04:10 +0100
Message-ID: <553a88c4ac00e681e605b81f3ce10342a881ac2f.1289041051.git.git@drmicha.warpmail.net>
References: <4CAB90EC.1080302@drmicha.warpmail.net>
Cc: Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:15:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEgje-0006Ht-Dm
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019Ab0KFLO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:14:57 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50632 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817Ab0KFLO4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 07:14:56 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3FC2763C;
	Sat,  6 Nov 2010 07:03:58 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 06 Nov 2010 07:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=uBYaVM7uNNHX/Og+d85+oEapoLk=; b=svCEoUWDG3eD5HIB/fyB3FbtWKP26CpwbZtZYmiWZT+eCrGi5cYejni1p3YhaFlGVQK7/1Pt6NXqHXPiuBpdlwQOl2o9oueVBEVUpIDyaHKXkduOSY6M4X1H2pk9tthR0H0GQpvij4OXm6/hyouvNtRZvVuLJwLQ0CZbhf1kC/0=
X-Sasl-enc: KFHkky4aFu0ekwQNOmvQfvaIndQf1JSnwpNQ5S8pWu2Z 1289041437
Received: from localhost (p548596E8.dip0.t-ipconnect.de [84.133.150.232])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6063440244A;
	Sat,  6 Nov 2010 07:03:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <4CAB90EC.1080302@drmicha.warpmail.net>
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160840>

We have always been creating rfc1991 signatures for users with "rfc1991"
in their gpg config but failed to recognize them (tag -l -n largenumber)
and verify them (tag -v, verify-tag).

Make good use of the refactored signature detection and let us recognize
and verify those signatures also.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7004-tag.sh |    6 +++---
 tag.c          |    3 ++-
 tag.h          |    1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 22dcc45..4fe45a4 100755
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
diff --git a/tag.c b/tag.c
index 5f9626c..18a5142 100644
--- a/tag.c
+++ b/tag.c
@@ -138,7 +138,8 @@ size_t parse_signature(const char *buf, unsigned long size)
 {
 	char *eol;
 	size_t len = 0;
-	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)) {
+	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)
+			&& prefixcmp(buf + len, PGP_MESSAGE)) {
 		eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
diff --git a/tag.h b/tag.h
index 4ba2a42..134d572 100644
--- a/tag.h
+++ b/tag.h
@@ -4,6 +4,7 @@
 #include "object.h"
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
 
 extern const char *tag_type;
 
-- 
1.7.3.2.193.g78bbb
