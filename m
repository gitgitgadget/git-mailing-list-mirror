From: Junio C Hamano <gitster@pobox.com>
Subject: [PREVIEW v3 8/9] checkout-index: there are only two line terminators
Date: Wed, 13 Jan 2016 19:03:08 -0800
Message-ID: <1452740590-16827-9-git-send-email-gitster@pobox.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYCN-0007gE-JY
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbcANDDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:03:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752736AbcANDD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:03:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC5243C44C;
	Wed, 13 Jan 2016 22:03:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hR6S
	i+xSePIE1xkWpzEsW7qEirA=; b=RLS6dissfL5j7AP38GXfKzuNO0+VCkt6VMpw
	scgvjXFbF8zOfq7O7nBZVRNL/MKOmnF/CmN8pyfhqgncwSHVWN6kH4kRE/9l6tdV
	HDgZsrfI6cUE+M48j0/z2Kv8hD8M0W6HduiOhgVOo43WXybe56alQ6b4kBlPWsvv
	CV2rmDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	WAIxCJ2XaQfMOwSSgnOStICosPGjGSgNQuqBoyotY4EyKCjYMRN65Q6zSD2ReR7V
	b48NHPQBwTFvNc4MZ+0Dp0ndmd5gTuNcZwzrSCQabNE0ldFgrv7DD5Gp0LedE9+h
	xejijxBBJIUX8ScfUYdofQhfApnVL1iMdDodIBW+riA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 993D63C44B;
	Wed, 13 Jan 2016 22:03:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0EFEE3C44A;
	Wed, 13 Jan 2016 22:03:25 -0500 (EST)
X-Mailer: git-send-email 2.7.0-242-gdd583c7
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 61433FBE-BA6B-11E5-91B5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284009>

The program by default works on LF terminated lines, with an option
to use NUL terminated records.  Instead of using line_termination
that happens to take LF or NUL to call strbuf_getline(), switch
between strbuf_getline_{lf,nul} based on the value of '-z' option.

Note that this still leaves the option open to use NUL-terminated
input mixed with LF-terminated output (and vice versa), and even
HT-terminated output is still left as a possibility, because this
series is only interested in tightening the overly broad interface
on the input side.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout-index.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 8028c37..0368e0d 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -12,6 +12,7 @@
 
 #define CHECKOUT_ALL 4
 static int line_termination = '\n';
+static strbuf_getline_fn getline_fn = strbuf_getline_lf;
 static int checkout_stage; /* default to checkout stage0 */
 static int to_tempfile;
 static char topath[4][TEMPORARY_FILENAME_LENGTH + 1];
@@ -144,10 +145,13 @@ static int option_parse_u(const struct option *opt,
 static int option_parse_z(const struct option *opt,
 			  const char *arg, int unset)
 {
-	if (unset)
+	if (unset) {
 		line_termination = '\n';
-	else
+		getline_fn = strbuf_getline_lf;
+	} else {
 		line_termination = 0;
+		getline_fn = strbuf_getline_nul;
+	}
 	return 0;
 }
 
@@ -258,7 +262,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		if (all)
 			die("git checkout-index: don't mix '--all' and '--stdin'");
 
-		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
 			if (line_termination && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
-- 
2.7.0-242-gdd583c7
