From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] Add LF-to-CRLF streaming conversion
Date: Fri, 20 May 2011 23:58:46 -0700
Message-ID: <1305961127-26540-4-git-send-email-gitster@pobox.com>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg9l-0006jf-Er
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab1EUG7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:59:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab1EUG7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:59:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCB875DF2
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Wnwz
	qy660EapSFNPOw/dHOfFLdM=; b=wv993R2zpKmkdhMBZQZHx6ClUMSElDAJERUw
	6lCV2N4uvYijYtWXYUmunsz5VClfG1q3jC4PsjXE2VqZg4r+alygNfyZ77m+wfPC
	3UitqiJbmJuwMGE3n6/IYrX0TCpX5fqzCBxMesigv/FamcB3e+N+RERhJZkLYg2q
	MpsUlQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=N9FRY7
	xDHMYLPiiW/DFykxPfycKjIenFZZrrMeINSWoAWC1YrUsiiU/jylB2MotN0oygqK
	liZt7M9+dSDCSAxFU6ILMPVL/x3XTZ7mZVpGyvxtRalYQ2Bh0Vb2fr4VRA9R36uL
	bocdlQmDvzkNDU8HVSHceklPDAla/u8V6J2FI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B99BD5DF1
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 201135DF0 for
 <git@vger.kernel.org>; Sat, 21 May 2011 03:01:22 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305961127-26540-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 238B4A92-8378-11E0-89B7-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174110>

If we do not have to guess or validate by scanning the input, we can
just stream this through.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/convert.c b/convert.c
index 1ec91a3..82fb75b 100644
--- a/convert.c
+++ b/convert.c
@@ -868,6 +868,39 @@ int is_null_stream_filter(struct stream_filter *filter)
 	return filter == &null_filter_singleton;
 }
 
+static int lf_to_crlf_filter_fn(struct stream_filter *filter,
+				const char *input, size_t *isize_p,
+				char *output, size_t *osize_p)
+{
+	size_t count = *isize_p;
+	if (count) {
+		size_t i, o;
+		for (i = o = 0; o < *osize_p && i < count; i++) {
+			char ch = input[i];
+			if (ch == '\n') {
+				if (o + 1 < *osize_p)
+					output[o++] = '\r';
+				else
+					break;
+			}
+			output[o++] = ch;
+		}
+
+		*osize_p -= o;
+		*isize_p -= i;
+	}
+	return 0;
+}
+
+static struct stream_filter_vtbl lf_to_crlf_vtbl = {
+	lf_to_crlf_filter_fn,
+	null_free_fn,
+};
+
+static struct stream_filter lf_to_crlf_filter_singleton = {
+	&lf_to_crlf_vtbl,
+};
+
 /*
  * Return an appropriately constructed filter for the path, or NULL if
  * the contents cannot be filtered without reading the whole thing
@@ -892,6 +925,10 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE))
 		return &null_filter_singleton;
 
+	if (output_eol(crlf_action) == EOL_CRLF &&
+	    !(crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS))
+		return &lf_to_crlf_filter_singleton;
+
 	return NULL;
 }
 
-- 
1.7.5.2.369.g8fc017
