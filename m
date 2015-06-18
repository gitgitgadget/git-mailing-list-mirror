From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 12/19] fsck: Disallow demoting grave fsck errors to
 warnings
Date: Thu, 18 Jun 2015 22:09:17 +0200
Organization: gmx
Message-ID: <02e9e349bbca0c6919e4dd79285232b8eec20d06.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:09:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g8A-0003nn-62
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669AbbFRUJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:09:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:49500 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbbFRUJT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:09:19 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MaW7Z-1ZPHIy2Ozp-00K7vl; Thu, 18 Jun 2015 22:09:17
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:XAAURykEUa/4p/16Fa3KauABtvGf9/T8eNmaDT2l6KGoTJlHej7
 YrTF0GG+WoxjYNe/+AGGL1SJgmtlzwvUGhs+qUN4G/abZJkLFvwNQL/UUoYivvXpwgVrGXl
 pxh9Dk4JwEYF3hPRXz3H1ZVF1cLeyCrOfUL4haQBqMCmEJHHSDqeXLqD4JrB+KZTi3IGpxm
 DcNs46lUiN+j/TGJhdAAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hts6p3ldUI4=:opyOaohQ3rcNJQ8yNtUhQH
 KepAuO2qoR8Z6cQFC1gF9+m3KiTH4i+LraTPnoSsuw38b/2S0NY20DCrIIm/WCxhm7W7X9Zlo
 QT8rGMYaSdVzjo4hrbBQftWxbXIhf7CC0E2xxr+somnf/xKGXD+LtUYBWIHL6IjseS8kKRD8M
 X6XjCL198xRATXDaQhypJqD+qfKo9qbraf5X388siPkq2q/P+YjB7zjrpKc+QnNMk1MXXh4Fu
 JrvrK5RvNnVMNOTPbZvETh7t5fC2a9QeB8AwYRBNvjHvNahrQpsTo3E++ddLDaYSsxKAbZAE+
 vL1AsmvI66rS82FGpupIirh8TgOlMYvA1L/NvijsCQHbE48KefO2H4wWnWm1/r7O7RXweo5c4
 RNoFigfGCEPmJuciIebqQlz3fjeBfPw3pHi2+zlOSDj7TtLIx/6ZBIV7dZbZZsBRNoa2MMa0H
 r5I9UnJMcpN2IKql8tcnWegl0NdB/T+CuMUF/SRx1Fv6v296ZLsLo0XV/lL9QKc+bsZE1z1Ng
 J3IFZloQ6QT+Zuw1V/vPK1hsDNIeDsm8V7LAYv4dpwriPIEkDZpyhj5AO8eXTDSBKQP1wpfeK
 klcmQWiffxuvRCx1hKlQW9JMrEZplDrudG+DL7DMgxpiu00qbWXaj31yW635DfdQDu2hyOPmw
 fzjnJkB55EARjOuvJMekmaTOve9P4q47pDsJ+74OzGH1nLLoE42YqyaYIT0Ks2IUkXOU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272054>

Some kinds of errors are intrinsically unrecoverable (e.g. errors while
uncompressing objects). It does not make sense to allow demoting them to
mere warnings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 14 ++++++++++++--
 t/t5504-fetch-receive-strict.sh | 11 +++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index bd4bfc2..2b2a360 100644
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
 	FUNC(BAD_EMAIL, ERROR) \
@@ -40,10 +45,8 @@
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(NOT_SORTED, ERROR) \
-	FUNC(NUL_IN_HEADER, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
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
