From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 12/19] fsck: Disallow demoting grave fsck errors to
 warnings
Date: Mon, 22 Jun 2015 17:26:42 +0200
Organization: gmx
Message-ID: <d228bf8cfd6e8fdf148128d9ef5d611164d8ab11.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:26:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73cd-0007D2-Ol
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbbFVP0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:26:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:62808 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661AbbFVP0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:26:45 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MBFUT-1ZHCUR43gD-00AF6G; Mon, 22 Jun 2015 17:26:43
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:0a5X/oTByz9/qpzuE1VfKhXntgN84vBiMy1j4RsgVmbYmbx6AZY
 N2rTxxHuhaimGNwB1n4VesX3xkP5lCFLt3QiONMtbuOlYFKx+SwVlzGpz/bebG/+aU6s0yh
 AJjrsDd22wby9BwNhHH+4dE++S7/MxR0M8CguxWwCKc0fy28HgFCtKo8Pfbulc3gKp1V2Tp
 BxUsx0KmLB0uMdXF0yt+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vMt/PERXQkI=:N7Sj5jFTQXV5nUKoJ0Gu81
 T2eeOQcMmt+39J5TgWhHPcg1syYiJLEpOXtsKm4uyV4B6JursaEMRj68jeU+2NVv8rowpF/6e
 1FSALJkiERe2GYOJfPZExIxbso60xOxiYXH9QHz6XA1fFbD8BdoE4ZG/we9IwYhtGQULfcgX6
 Uq46zKapI5loLRAWGKpqDj4OeS4QdAeB5O+OCCwF1xyHsjXMn0ZIYTQRUCGUmmip4hTsfk3Oz
 KKPR1VIhS2s90I5qozU2n6heCAnjLebTSf1N5Cvv61OBJNLwzEsXV+x2p29ulAVBWttmaRO9m
 EKp+JzcOJT+/oaMpWsPsUmWLlJSgOSwLhKnv3rP87spKmggnI+a/TQitXRvz0yyZLF3jdB3Y3
 /tmdQ2F/Uo82X2rlzTtMLAwlGM+JPAbVORHBLkIz/q1vgzWfS95+Ui6jEjlIAH/za6hP4a4rE
 wpVKV1KINs81Y1iuBdct8yDp6TJMm0fOFXGfozVjGAdlEh+tgklI1DV5Volrkvrpbhu4vg7qY
 vsyEVI2obRkGZXZRE35upiWkKW7L8fTj1FxXnIzKUb+9VJrZMa5c9cpzy2w3b8JZMJpfLKdV9
 pLi84hy/mUTlIMkToYZe2O/5p8Jox+WNyZv6FwNgANMA+IiMktvqlhFHXRVScgBYIU4pP4oKx
 mv0DAP6nfILOWtg26mhRkK1kt6Dv98fg1cpS9QDqsxMPQcx2mIPvt6FLG12k8WC7scFI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272382>

Some kinds of errors are intrinsically unrecoverable (e.g. errors while
uncompressing objects). It does not make sense to allow demoting them to
mere warnings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 13 +++++++++++--
 t/t5504-fetch-receive-strict.sh | 11 +++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 3f76f99..85535b1 100644
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
@@ -149,6 +152,9 @@ void fsck_set_msg_type(struct fsck_options *options,
 		die("Unhandled message id: %s", msg_id);
 	type = parse_msg_type(msg_type);
 
+	if (type != FSCK_ERROR && msg_id_info[id].msg_type == FSCK_FATAL)
+		die("Cannot demote %s to %s", msg_id, msg_type);
+
 	if (!options->msg_type) {
 		int i;
 		int *msg_type = xmalloc(sizeof(int) * FSCK_MSG_MAX);
@@ -215,6 +221,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	if (msg_type == FSCK_FATAL)
+		msg_type = FSCK_ERROR;
+
 	append_msg_id(&sb, msg_id_info[id].id_string);
 
 	va_start(ap, fmt);
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 36024fc..f5d6d0d 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -136,4 +136,15 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	grep "missingEmail" act
 '
 
+test_expect_success \
+	'receive.fsck.unterminatedHeader=warn triggers error' '
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
