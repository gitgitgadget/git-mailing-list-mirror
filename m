From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 12/19] fsck: Disallow demoting grave fsck errors to
 warnings
Date: Fri, 19 Jun 2015 15:34:36 +0200
Organization: gmx
Message-ID: <c87d71326fc75773f137eee0ef6a8964645f0b74.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:34:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wRU-0000ZN-As
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbbFSNeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:34:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:56177 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbbFSNen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:34:43 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lg6op-1Yn75D3Mxn-00pbDn; Fri, 19 Jun 2015 15:34:36
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:dEnF3Hs7qrefradFsfjWp+kmhzOSyBUltZvQbKT+0tDGPRE6/nh
 l+OZE99teyVB4BvKFt6HpGeEpw7oLAeqXyPJ7x0ZDw4f44PTBkVeu6O8Ssj9h7qikbCssms
 rAO0amNPj1X2M4GaRgqA89k0hjUUwjZpXmlAmotwWoPuLYT5jpXK44wmS+Z9QhGuGOk7Mjb
 3uK9SM2NDf0MNGB5Qym1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Es8+txwZ/M=:QttQHeeQ05VuZkdNjnZ+6H
 G5l3wDPn3G79BbUNbZoD13813aBP32SA3YdvGj8SNiCrHv3lWxtl26/ve7Vv3Ccwdqloubj9U
 jTRSM602CX98ALJWknMFVyR/RMqGgecSBXqkY0hKjG25UyweztDg+CD+XRXG/QSs+M4f1ITiZ
 0O33/EQdK+93YquhJ71n8kh/ohtKP6UiJV0y9STBDTsyFQuN8ffpWPpJd/ceo2hcUYkRlnMSp
 uKoaB2W7lDQYzAMBLYyLVKrHMZQnI88E2pGovoGpAPA0R8VDHYwC/2gL/7SUk948kHRO0gb3A
 cDdq7GEacsktaHFrjQmsi3pOGiihFYQkL7xHqi7smQ/EmSq7+zmHLdr/c+I0KqVHqpdv1lWd6
 Pf/WVHSSk9oJ+R13F0idwQo4wP3MARXrpLVaHVht1s3ahNQ5wwpWFHPh3Tk3r66KZ6qGE5tQU
 3qrIGxjHTsdndfvhsdZh2qXh4w8ykeezX/w7x8hfc6jhbsLrZSa7GGO4OYqYvza3I1mtbygx1
 u9SkYMQQmALiYF5ci30QhtEzA2Fs7daXa6sRoC9RuVCl3J9Z775NwB3CZ0DNO36ZqcBDv2WNQ
 E54YVdqtQWmZQcpdCRIY7O1pOT3RGQcajg5XLaBKCSwRY6zuMFnhQCiCEbXpqJrL2aa3KjqJ4
 88bFH4vtdgigVKSjKoUD8izrXzT6O/rLcNBRyQ9u5kzKDUTTEEDelSJPzUKVDis0/38I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272148>

Some kinds of errors are intrinsically unrecoverable (e.g. errors while
uncompressing objects). It does not make sense to allow demoting them to
mere warnings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 14 ++++++++++++--
 t/t5504-fetch-receive-strict.sh | 11 +++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 21e3052..a4fbce3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -9,7 +9,12 @@
 #include "refs.h"
 #include "utf8.h"
 
+#define FSCK_FATAL -1
+
 #define FOREACH_MSG_ID(FUNC) \
+	/* fatal errors */ \
+	FUNC(NUL_IN_HEADER, FATAL) \
+	FUNC(UNTERMINATED_HEADER, FATAL) \
 	/* errors */ \
 	FUNC(BAD_DATE, ERROR) \
 	FUNC(BAD_DATE_OVERFLOW, ERROR) \
@@ -39,11 +44,9 @@
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
-	FUNC(NUL_IN_HEADER, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
-	FUNC(UNTERMINATED_HEADER, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
 	/* warnings */ \
 	FUNC(BAD_FILEMODE, WARN) \
@@ -157,6 +160,10 @@ void fsck_set_msg_type(struct fsck_options *options,
 		die("Unhandled message id: %.*s", msg_id_len, msg_id);
 	type = parse_msg_type(msg_type, msg_type_len);
 
+	if (type != FSCK_ERROR && msg_id_info[id].msg_type == FSCK_FATAL)
+		die("Cannot demote %.*s to %.*s", msg_id_len, msg_id,
+				msg_type_len, msg_type);
+
 	if (!options->msg_type) {
 		int i;
 		int *msg_type = xmalloc(sizeof(int) * FSCK_MSG_MAX);
@@ -213,6 +220,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	if (msg_type == FSCK_FATAL)
+		msg_type = FSCK_ERROR;
+
 	append_msg_id(&sb, msg_id_info[id].id_string);
 
 	va_start(ap, fmt);
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 3f7e96a..0d64229 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -136,4 +136,15 @@ test_expect_success 'push with receive.fsck.missingemail=warn' '
 	grep "missingemail" act
 '
 
+test_expect_success \
+	'receive.fsck.unterminatedheader=warn triggers error' '
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	git --git-dir=dst/.git config \
+		receive.fsck.unterminatedheader warn &&
+	test_must_fail git push --porcelain dst HEAD >act 2>&1 &&
+	grep "Cannot demote unterminatedheader" act
+'
+
 test_done
-- 
2.3.1.windows.1.9.g8c01ab4
