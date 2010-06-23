From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Do not decode url protocol.
Date: Wed, 23 Jun 2010 10:27:39 -0700
Message-ID: <7v4ogtfylw.fsf@alter.siamese.dyndns.org>
References: <4C211A39.2080207@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Jun 23 19:27:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORTjy-0003Q7-UN
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 19:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab0FWR1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 13:27:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0FWR1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 13:27:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 101E5BEF0E;
	Wed, 23 Jun 2010 13:27:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qfbUN7KldjYkq7eB+Npwq77kkRQ=; b=Yacz6p
	OMo3LG5aAmZwnop8A8pd12HE3t/ZoMaVrwYgnKlWC2CUxdwnuZEFDfRmigqTTrmv
	yCob/VCsuIVCr74Ae5C8FuD69xT5LHE4m0r//mxStf16fUq8bdwL6ZUkrozybShP
	DMGxKROPylOmAKDbFkNLXkeA+1B/J/QE/JxHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dKQPK4J4GBVo5XrLLmgusSgWha6UKwge
	sa1LiCiUKosFdj++Jzf9SfZmZsOVNL4Ip1h4lJWVOvrtsaOoL+I/1TxI96U8VaFa
	NMQwEp2Whj5V97D4Sbi2AE50pkkppcK+g2O2UKFyPpIyVNZBW0sV5depddTmhfyL
	83s7FwXsL+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9930BEF0C;
	Wed, 23 Jun 2010 13:27:46 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 998A1BEF0B; Wed, 23 Jun
 2010 13:27:41 -0400 (EDT)
In-Reply-To: <4C211A39.2080207@obry.net> (Pascal Obry's message of "Tue\, 22
 Jun 2010 22\:16\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3A4F55C-7EEC-11DF-8CB2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149521>

Pascal Obry <pascal.obry@gmail.com> writes:

> When using the protocol git+ssh:// for example we do not want to
> decode the '+' as a space. The url decoding must take place only
> for the server name and parameters.
>
> This fixes a regression introduced in 9d2e942.

Sign-off?

As the patch was whitespace-broken, I'm proposing to rewrite it like the
following.

-- >8 -- 
url.c: "<scheme>://" part at the beginning should not be URL decoded

When using the protocol git+ssh:// for example we do not want to
decode the '+' as a space. The url decoding must take place only
for the server name and parameters.

This fixes a regression introduced in 9d2e942.

Initial-fix-by: Pascal Obry <pascal.obry@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 url.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/url.c b/url.c
index cd32b92..bf5bb9c 100644
--- a/url.c
+++ b/url.c
@@ -67,12 +67,10 @@ static int url_decode_char(const char *q)
 	return val;
 }
 
-static char *url_decode_internal(const char **query, const char *stop_at)
+static char *url_decode_internal(const char **query, const char *stop_at, struct strbuf *out)
 {
 	const char *q = *query;
-	struct strbuf out;
 
-	strbuf_init(&out, 16);
 	do {
 		unsigned char c = *q;
 
@@ -86,33 +84,43 @@ static char *url_decode_internal(const char **query, const char *stop_at)
 		if (c == '%') {
 			int val = url_decode_char(q + 1);
 			if (0 <= val) {
-				strbuf_addch(&out, val);
+				strbuf_addch(out, val);
 				q += 3;
 				continue;
 			}
 		}
 
 		if (c == '+')
-			strbuf_addch(&out, ' ');
+			strbuf_addch(out, ' ');
 		else
-			strbuf_addch(&out, c);
+			strbuf_addch(out, c);
 		q++;
 	} while (1);
 	*query = q;
-	return strbuf_detach(&out, NULL);
+	return strbuf_detach(out, NULL);
 }
 
 char *url_decode(const char *url)
 {
-	return url_decode_internal(&url, NULL);
+	struct strbuf out = STRBUF_INIT;
+	const char *slash = strchr(url, '/');
+
+	/* Skip protocol part if present */
+	if (slash && url < slash) {
+		strbuf_add(&out, url, slash - url);
+		url = slash;
+	}
+	return url_decode_internal(&url, NULL, &out);
 }
 
 char *url_decode_parameter_name(const char **query)
 {
-	return url_decode_internal(query, "&=");
+	struct strbuf out = STRBUF_INIT;
+	return url_decode_internal(query, "&=", &out);
 }
 
 char *url_decode_parameter_value(const char **query)
 {
-	return url_decode_internal(query, "&");
+	struct strbuf out = STRBUF_INIT;
+	return url_decode_internal(query, "&", &out);
 }
