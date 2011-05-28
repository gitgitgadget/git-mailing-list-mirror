From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/3] War on nbsp: teach "git apply" to check and fix nbsp
Date: Fri, 27 May 2011 18:31:58 -0700
Message-ID: <7vboynr4oh.fsf_-_@alter.siamese.dyndns.org>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
 <7vzkm9unu0.fsf@alter.siamese.dyndns.org>
 <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
 <m262owhyuy.fsf@igel.home>
 <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com>
 <7vipswro57.fsf@alter.siamese.dyndns.org>
 <7vboyorm4i.fsf@alter.siamese.dyndns.org>
 <BANLkTinwOr5Yzp_N6BNyNK5Y1FcVtdtbUw@mail.gmail.com>
 <7vy61rrcae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 28 03:36:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ8Rk-0007JY-3r
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 03:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757710Ab1E1BcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 21:32:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1E1BcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 21:32:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B33A5953;
	Fri, 27 May 2011 21:34:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tNyN2jCFEyOQ9AdHE2lrNCddulU=; b=I4gEdt
	mnmLOWSUhrJrzO/HvWEnYuSCjALNdPj8Lw1bByCTnoq7yk7ydh4AZVC1tM8okZP3
	u4XhOx0nS5Oc+ZKX4ChigPzey84xbsgXnjk3Zr87m6t4DuNbaZmY7nizr4kcEWnv
	sPnUEAic7UPFjmBBvcweYfkXRkERbZoMjFhqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yVAZWYwJpMH5Gr+EOZwKnYhqkIk7WHf3
	xH8LIWdweQT0AalcDIicN3YutEVUdrbOBXs5EQ9VM+NWr+HeayEkeoX1h4KTR1p6
	N++u0Rdwu7/BSLBdzm7w0umneXetn2CT091ayzDknwZMfqxeoOetiGEXF3HHHMyw
	JUjw7r5WK+c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 50EAA5951;
	Fri, 27 May 2011 21:34:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 140925950; Fri, 27 May 2011
 21:34:07 -0400 (EDT)
In-Reply-To: <7vy61rrcae.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 27 May 2011 15:47:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9731B7EA-88CA-11E0-BE65-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174654>

This still does not work to apply in reverse "git apply -R", but I thought
it is a good place to stop, as it is dubious if this series makes much
sense to begin with.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ws.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/ws.c b/ws.c
index 53e263d..4413f95 100644
--- a/ws.c
+++ b/ws.c
@@ -374,6 +374,7 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 	int last_tab_in_indent = -1;
 	int last_space_in_indent = -1;
 	int need_fix_leading_space = 0;
+	int col_offset = 0;
 
 	/*
 	 * Strip trailing whitespace
@@ -387,10 +388,17 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 				len--;
 			}
 		}
-		if (0 < len && isspace(src[len - 1])) {
-			while (0 < len && isspace(src[len-1]))
-				len--;
-			fixed = 1;
+		if (0 < len) {
+			int orig_len = len;
+			while (len) {
+				if (isspace(src[len - 1]))
+					len--;
+				else if (1 < len && is_nbsp(&src[len - 2]))
+					len -= 2;
+				else
+					break;
+			}
+			fixed = (orig_len != len);
 		}
 	}
 
@@ -404,13 +412,23 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
 			    0 <= last_space_in_indent)
 			    need_fix_leading_space = 1;
-		} else if (ch == ' ') {
-			last_space_in_indent = i;
-			if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
-			    ws_tab_width(ws_rule) <= i - last_tab_in_indent)
-				need_fix_leading_space = 1;
-		} else
+			col_offset = 0;
+			continue;
+		}
+
+		if (ch == ' ') {
+			;
+		} else if ((i < len - 1) && is_nbsp(src + i)) {
+			i++;
+			col_offset++;
+		} else {
 			break;
+		}
+		last_space_in_indent = i;
+
+		if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
+		    ws_tab_width(ws_rule) <= (i - col_offset) - last_tab_in_indent)
+			need_fix_leading_space = 1;
 	}
 
 	if (need_fix_leading_space) {
@@ -432,15 +450,20 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 		 */
 		for (i = 0; i < last; i++) {
 			char ch = src[i];
-			if (ch != ' ') {
+
+			if (ch == ' ') {
+				;
+			} else if ((i < last - 1) && is_nbsp(src + i)) {
+				i++;
+			} else {
 				consecutive_spaces = 0;
 				strbuf_addch(dst, ch);
-			} else {
-				consecutive_spaces++;
-				if (consecutive_spaces == ws_tab_width(ws_rule)) {
-					strbuf_addch(dst, '\t');
-					consecutive_spaces = 0;
-				}
+				continue;
+			}
+			consecutive_spaces++;
+			if (consecutive_spaces == ws_tab_width(ws_rule)) {
+				strbuf_addch(dst, '\t');
+				consecutive_spaces = 0;
 			}
 		}
 		while (0 < consecutive_spaces--)
@@ -465,7 +488,20 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 		fixed = 1;
 	}
 
-	strbuf_add(dst, src, len);
+	if (ws_rule & WS_NBSP) {
+		while (len--) {
+			if (len && is_nbsp(src)) {
+				src++;
+				len--;
+				strbuf_addch(dst, ' ');
+			} else {
+				strbuf_addch(dst, *src);
+			}
+			src++;
+		}
+	} else {
+		strbuf_add(dst, src, len);
+	}
 	if (add_cr_to_tail)
 		strbuf_addch(dst, '\r');
 	if (add_nl_to_tail)
-- 
1.7.5.3.503.g893a4
