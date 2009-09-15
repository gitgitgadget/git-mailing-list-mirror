From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] diff.c: emit_add_line() takes only the rest of the line
Date: Mon, 14 Sep 2009 23:15:05 -0700
Message-ID: <1252995306-32329-4-git-send-email-gitster@pobox.com>
References: <1252995306-32329-1-git-send-email-gitster@pobox.com>
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 08:15:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnRKF-00057k-BC
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 08:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbZIOGP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 02:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756627AbZIOGPZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 02:15:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581AbZIOGPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 02:15:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 489CD51265;
	Tue, 15 Sep 2009 02:15:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FWaz
	M1B5EoCmtqJBf/k0uiUus+w=; b=D2v8YRllzqj7s+7pVBy05FMftOtZNyrCMYQn
	ak/9HMfvFhPn0FNNxRJkKQl94ewWj1fwpZnUnHIeVEETUruClLp2AECwPDVAjAh1
	ZjzqoTOfZVRIQ/q6VeTSEDzSQa7DPX/9M1anJqsMJIi+sqsxp6+FGrtLDOy9p9y7
	qB8jg1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	HR3rN46YWJARZYmBd77A0xKMPxC/K/2urqOP+Oduj+sfkUXvFtImLaLEADCebwyr
	p+1t7c04idzyBJgF4LePJAc821fAjf7zL1oR/4LfViPryWzykqra31kfx3kfIuat
	Q3ZYCPS9xOj09leq0OYETHSdCS6BwJiIkhqZB/SAJgo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36EDA51263;
	Tue, 15 Sep 2009 02:15:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4940651262; Tue, 15 Sep 2009
 02:15:16 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.54.g4aad
In-Reply-To: <1252995306-32329-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 248DAEEA-A1BF-11DE-A53E-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128516>

As the first character on the line that is fed to this function is always
"+", it is pointless to send that along with the rest of the line.

This change will make it easier to reuse the logic when emitting the
rewrite diff, as we do not want to copy a line only to add "+"/"-"/" "
immediately before its first character when we produce rewrite diff
output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index b5c2574..baf46ab 100644
--- a/diff.c
+++ b/diff.c
@@ -416,20 +416,22 @@ static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line
 	return ws_blank_line(line + 1, len - 1, ecbdata->ws_rule);
 }
 
-static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
+static void emit_add_line(const char *reset,
+			  struct emit_callback *ecbdata,
+			  const char *line, int len)
 {
 	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
 	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
 
 	if (!*ws)
-		emit_line(ecbdata->file, set, reset, line, len);
+		emit_line_0(ecbdata->file, set, reset, '+', line, len);
 	else if (new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line(ecbdata->file, ws, reset, line, len);
+		emit_line_0(ecbdata->file, ws, reset, '+', line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line(ecbdata->file, set, reset, line, 1);
-		ws_check_emit(line + 1, len - 1, ecbdata->ws_rule,
+		emit_line_0(ecbdata->file, set, reset, '+', "", 0);
+		ws_check_emit(line, len, ecbdata->ws_rule,
 			      ecbdata->file, set, reset, ws);
 	}
 }
@@ -726,7 +728,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		emit_line(ecbdata->file, color, reset, line, len);
 	} else {
 		ecbdata->lno_in_postimage++;
-		emit_add_line(reset, ecbdata, line, len);
+		emit_add_line(reset, ecbdata, line + 1, len - 1);
 	}
 }
 
-- 
1.6.5.rc1.54.g4aad
