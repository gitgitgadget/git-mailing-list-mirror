From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/17] rev-parse: read parseopt spec with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:09 -0800
Message-ID: <1450303398-25900-9-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAj-00014Y-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967081AbbLPWDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966801AbbLPWDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2182325CA;
	Wed, 16 Dec 2015 17:03:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mqSC
	iP13OBwd36SFAv9kETg7ogc=; b=IQQR8Hfy3EnHu7ZX/v24Ade9PlaFK2WyhS9f
	/HpBkMREtgwltqexVNG5mo51R5CPusvUWI4oH0kS+j8bVHIUlszm1Fo8y3bPj0Ac
	j/YUbZbZRmCWhRxKsq8xUtBGB094bf/1E/BuyV0YvCch9ERtKVCCeroaZhMo1K6C
	QPb51+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eCFISH
	KPFpYpndT++VUNylUx9uq180rn0C6B3R1mK+oOIZZlckKFZoiMEUjJasnBfzgsA+
	74guy4gRsmKPm7x5OkfTfWyi36Ta/kj4iXb8GiQMQC7wHyKrMoKoYubFtTC+A400
	uLffrd5W1zw2Ogqe9UIC2plPPGzWHMaM1eM/8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9AF6325C8;
	Wed, 16 Dec 2015 17:03:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4664C325C7;
	Wed, 16 Dec 2015 17:03:32 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D8928ACA-A440-11E5-8DBB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282602>

"rev-parse --parseopt" specification is clearly text and we
should anticipate that we may be fed CRLF lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rev-parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 02d747d..f2cf99c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -386,7 +386,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 
 	/* get the usage up to the first line with a -- on it */
 	for (;;) {
-		if (strbuf_getline(&sb, stdin, '\n') == EOF)
+		if (strbuf_getline_crlf(&sb, stdin) == EOF)
 			die("premature end of input");
 		ALLOC_GROW(usage, unb + 1, usz);
 		if (!strcmp("--", sb.buf)) {
@@ -399,7 +399,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
-	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
+	while (strbuf_getline_crlf(&sb, stdin) != EOF) {
 		const char *s;
 		const char *help;
 		struct option *o;
-- 
2.7.0-rc1-83-ga8b6b9e
