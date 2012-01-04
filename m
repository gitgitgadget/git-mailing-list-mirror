From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] log-tree.c: small refactor in show_signature()
Date: Wed,  4 Jan 2012 14:10:57 -0800
Message-ID: <1325715058-11984-3-git-send-email-gitster@pobox.com>
References: <1325715058-11984-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 23:11:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiZ39-0000SF-MC
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 23:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125Ab2ADWLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 17:11:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757118Ab2ADWLE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 17:11:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEB206798
	for <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GJE0
	ttwcw5RHBQYvnfALQgP0EIU=; b=TC4SdUmeeSPXeBwV3x9QENrbqfeiQmzSypKq
	zRKRQAQEUWHAOYHFS5meb8u+uE5RxYWECf5cOxNpH/JjUdzXzQoPDQWRSGRvCYXa
	iWBBHgQVc0KKxPKgD+8Xn2g4aeD9WLdeM2cGlFKlWqr8AIDcMF+FbCnK6y5Gxz5x
	WeEpqA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bZtmAw
	sOO/+7dpM2MQJ+ATOIMKPFWTFfot8P2gPNdRDhB22b1x0ZQCxIbOqP8iXufnkIIL
	Ta8RLNvGMwB6spJyQvnM5sSnEVH4sBcjvwu1BhBmIqLz7vVI7tv6EC0TdnWNqj4o
	awQFWE7QL5FU/5bBH9p0AdBV3eVVc/OGtWhKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B67A26797
	for <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45BDE6796 for
 <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:03 -0500 (EST)
X-Mailer: git-send-email 1.7.8.2.340.gd18f0f
In-Reply-To: <1325715058-11984-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FDB7222A-3720-11E1-A548-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187946>

The next patch needs to show the result of signature verification on a
mergetag extended header in a way similar to how embedded signature for
the commit object itself is shown. Separate out the logic to go through
the message lines and show them in the "error" color (highlighted) or the
"correct" color (dim).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 142ba51..005c5a5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -404,13 +404,27 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 	*extra_headers_p = extra_headers;
 }
 
+static void show_sig_lines(struct rev_info *opt, int status, const char *bol)
+{
+	const char *color, *reset, *eol;
+
+	color = diff_get_color_opt(&opt->diffopt,
+				   status ? DIFF_WHITESPACE : DIFF_FRAGINFO);
+	reset = diff_get_color_opt(&opt->diffopt, DIFF_RESET);
+	while (*bol) {
+		eol = strchrnul(bol, '\n');
+		printf("%s%.*s%s%s", color, (int)(eol - bol), bol, reset,
+		       *eol ? "\n" : "");
+		bol = (*eol) ? (eol + 1) : eol;
+	}
+}
+
 static void show_signature(struct rev_info *opt, struct commit *commit)
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
 	struct strbuf gpg_output = STRBUF_INIT;
 	int status;
-	const char *color, *reset, *bol, *eol;
 
 	if (parse_signed_commit(commit->object.sha1, &payload, &signature) <= 0)
 		goto out;
@@ -421,17 +435,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	if (status && !gpg_output.len)
 		strbuf_addstr(&gpg_output, "No signature\n");
 
-	color = diff_get_color_opt(&opt->diffopt,
-				   status ? DIFF_WHITESPACE : DIFF_FRAGINFO);
-	reset = diff_get_color_opt(&opt->diffopt, DIFF_RESET);
-
-	bol = gpg_output.buf;
-	while (*bol) {
-		eol = strchrnul(bol, '\n');
-		printf("%s%.*s%s%s", color, (int)(eol - bol), bol, reset,
-		       *eol ? "\n" : "");
-		bol = (*eol) ? (eol + 1) : eol;
-	}
+	show_sig_lines(opt, status, gpg_output.buf);
 
  out:
 	strbuf_release(&gpg_output);
-- 
1.7.8.2.340.gd18f0f
