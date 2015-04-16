From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] config: use utf8_bom[] from utf.[ch] in git_parse_source()
Date: Thu, 16 Apr 2015 11:39:07 -0700
Message-ID: <1429209548-32297-4-git-send-email-gitster@pobox.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
 <1429209548-32297-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 20:39:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiohE-00072P-19
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbbDPSjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:39:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753664AbbDPSjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:39:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E4524A38F;
	Thu, 16 Apr 2015 14:39:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=O1uL
	hN0Hb9VVwXrZl6DkV9KDhJM=; b=oehG+PLIvMHrcws/AuVu5X4ZXnX1UTjGfcSX
	f89jWV1etxBkmafzBnkP1l+F9fGwCr+8xl3KKTxbUW5+dRQmnBIToAPm9eVUVClp
	XdHEQWxr20te8mCxGfnym4FGqe5QENpH7hJFj2o7NseeV2/TMFZOuehHNR/zm+pl
	HT5X2Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=evVFhB
	h9dW4FvuKo2G1/f8m5NXjsG2HyUiZULA3D3wrsDlr4PR5ZOk6ocuUPn6QZqZubbh
	G/IhEcuXAjQvS5c6OBs17H1ItZT0MIg42ebs9CCMdgXh/C2tG6wNIu78bdNoE/3Z
	rBldLuDBefvJ5uRpnudSR0VEGVHqA4mb49p6c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06F1C4A38E;
	Thu, 16 Apr 2015 14:39:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D1114A387;
	Thu, 16 Apr 2015 14:39:13 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc2-171-g98ddf7f
In-Reply-To: <1429209548-32297-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E104EA52-E467-11E4-8512-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267326>

Because the function reads one character at the time, unfortunately
we cannot use the easier skip_utf8_bom() helper, but at least we do
not have to duplicate the constant string this way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 752e2e2..9618aa4 100644
--- a/config.c
+++ b/config.c
@@ -12,6 +12,7 @@
 #include "quote.h"
 #include "hashmap.h"
 #include "string-list.h"
+#include "utf8.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -412,8 +413,7 @@ static int git_parse_source(config_fn_t fn, void *data)
 	struct strbuf *var = &cf->var;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
-	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
-	const unsigned char *bomptr = utf8_bom;
+	const char *bomptr = utf8_bom;
 
 	for (;;) {
 		int c = get_next_char();
@@ -421,7 +421,7 @@ static int git_parse_source(config_fn_t fn, void *data)
 			/* We are at the file beginning; skip UTF8-encoded BOM
 			 * if present. Sane editors won't put this in on their
 			 * own, but e.g. Windows Notepad will do it happily. */
-			if ((unsigned char) c == *bomptr) {
+			if (c == (*bomptr & 0377)) {
 				bomptr++;
 				continue;
 			} else {
-- 
2.4.0-rc2-171-g98ddf7f
