From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 12/21] rev-parse: read parseopt spec with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:27 -0800
Message-ID: <1452815916-6447-13-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrns-0003ph-2O
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbcANX7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932085AbcANX66 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 155AF3CD83;
	Thu, 14 Jan 2016 18:58:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lWhA
	Jcy3pgHyShNNX9dCJGNxW/Q=; b=i830Qz1Sx9B9soIA5miEcthONRjlbX+8NOgc
	HxBFRkAG4Lm0jrP+l8ytyv2p8JhdnUNoTlULeRKtPVPzl/4ZL2hXH60IcYLuJkN+
	dBDjva+y8kik1wryk7cnxU4sm3ps9yGVEQQ5/WEmYeX34P8Z/BHGdNUTxSyHJ+yH
	zlACX1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Ot0orspbi7co4knQ9x1GvTCEGTV6hHuXHELbbiWXKzNa9FZS651Fnwora+0XmpUI
	zcLEAJegp+nIuoqJ+q5NrioJqpumSedwZ/jqtMekSEfoGbVrswVGi1m3xhFlLUDa
	OYBwNjvPY20xpInDCAc7bkmXodW61lHhGCcvQQSs50w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D4193CD82;
	Thu, 14 Jan 2016 18:58:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 827A93CD81;
	Thu, 14 Jan 2016 18:58:57 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C651E6E4-BB1A-11E5-86C9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284122>

"rev-parse --parseopt" specification is clearly text and we
should anticipate that we may be fed CRLF lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rev-parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 0324abb..bd16876 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -383,7 +383,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 
 	/* get the usage up to the first line with a -- on it */
 	for (;;) {
-		if (strbuf_getline_lf(&sb, stdin) == EOF)
+		if (strbuf_getline(&sb, stdin) == EOF)
 			die("premature end of input");
 		ALLOC_GROW(usage, unb + 1, usz);
 		if (!strcmp("--", sb.buf)) {
@@ -396,7 +396,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
-	while (strbuf_getline_lf(&sb, stdin) != EOF) {
+	while (strbuf_getline(&sb, stdin) != EOF) {
 		const char *s;
 		const char *help;
 		struct option *o;
-- 
2.7.0-250-ge1b5ba3
