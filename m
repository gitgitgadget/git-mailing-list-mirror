From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 15:34:38 -0800
Message-ID: <7vr504f5v5.fsf@alter.siamese.dyndns.org>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
 <vpqr504wf70.fsf@bauges.imag.fr> <7vmxasgqlm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Dec 17 00:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbhId-0006ct-0f
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 00:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760566Ab1LPXen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 18:34:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462Ab1LPXel (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 18:34:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A3C25BA6;
	Fri, 16 Dec 2011 18:34:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KQ926hKQ4Xk7KjgCJBBl2D+QQz0=; b=eYnrC+
	MCZrzfjrkMd7qS3MQlSy5HDRHSvUwXj1gto8DAESlnyhhsTdClNX5EU7UDHjIwqo
	ZxhFhrYFIc6xpB4oE43rpVvxbJnuZ3TgfflO7/HhjB5sBpXsg9djueM0IqoykBm7
	+wKfRMPv8CE/8NwDew19Ha50+mRGl7WbEk2WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h+waH7pRFAky9A1ij3r0nn3fgnHD/qmR
	/FvUBSwG7Dh2r99P+XVXtNbW0CiGJWBqt6+OVj3abQSGAnjVSefu1oGlB6CGj49s
	O/9uZ3tEGiXKkI1JPu/tBV9t9PGLSJM7UmWiQu5oaCAB/O7I7YjhZGcVF1rGEyS0
	DTh20Bu6D10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0180B5BA4;
	Fri, 16 Dec 2011 18:34:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C2465BA3; Fri, 16 Dec 2011
 18:34:40 -0500 (EST)
In-Reply-To: <7vmxasgqlm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Dec 2011 13:21:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8621B1D0-283E-11E1-A283-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187335>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> What you said is _technically_ correct in that sense.
>
> However, I think the CRLF filter used to have a hack to strip "\r" if the
> repository data records "\r" at the end of line. This was intended to help
> people who checked in such a broken text file (if it is a text file, then
> raw ascii CR does not have a place in it in the repository representation)
> and it was a useful hack to help people recover from such mistakes to
> start the project from DOS-only world (with CRLF in the repository data)
> and migrate to cross platform world (with LF in the repository data, CRLF
> in the DOS working tree).  I suspect that the streaming filter conversion
> may not have the same hack in it.

Perhaps something like this, but I do not use CRLF myself, so it probably
needs to be checked by extra sets of eyes.

Thanks.

-- >8 --
Subject: lf_to_crlf_filter(): resurrect CRLF->CRLF hack

The non-streaming version of the filter counts CRLF and LF in the whole
buffer, and returns without doing anything when they match (i.e. what is
recorded in the object store already uses CRLF). This was done to help
people who added files from the DOS world before realizing they want to go
cross platform and adding .gitattributes to tell Git that they only want
CRLF in their working tree.

The streaming version of the filter does not want to read the whole thing
before starting to work, as that defeats the whole point of streaming. So
we instead check what byte follows CR whenever we see one, and add CR
before LF only when the LF does not immediately follow CR already to keep
CRLF as is.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index c028275..8daf4e4 100644
--- a/convert.c
+++ b/convert.c
@@ -879,7 +879,8 @@ int is_null_stream_filter(struct stream_filter *filter)
 
 struct lf_to_crlf_filter {
 	struct stream_filter filter;
-	unsigned want_lf:1;
+	unsigned has_held:1;
+	char held;
 };
 
 static int lf_to_crlf_filter_fn(struct stream_filter *filter,
@@ -889,10 +890,14 @@ static int lf_to_crlf_filter_fn(struct stream_filter *filter,
 	size_t count, o = 0;
 	struct lf_to_crlf_filter *lf_to_crlf = (struct lf_to_crlf_filter *)filter;
 
-	/* Output a pending LF if we need to */
-	if (lf_to_crlf->want_lf) {
-		output[o++] = '\n';
-		lf_to_crlf->want_lf = 0;
+	/*
+	 * We may be holding onto the CR to see if it is followed by a
+	 * LF, in which case we would need to go to the main loop.
+	 * Otherwise, just emit it to the output stream.
+	 */
+	if (lf_to_crlf->has_held && (lf_to_crlf->held != '\r' || !input)) {
+		output[o++] = lf_to_crlf->held;
+		lf_to_crlf->has_held = 0;
 	}
 
 	/* We are told to drain */
@@ -902,22 +907,57 @@ static int lf_to_crlf_filter_fn(struct stream_filter *filter,
 	}
 
 	count = *isize_p;
-	if (count) {
+	if (count || lf_to_crlf->has_held) {
 		size_t i;
+		int was_cr = 0;
+
+		if (lf_to_crlf->has_held) {
+			was_cr = 1;
+			lf_to_crlf->has_held = 0;
+		}
+
 		for (i = 0; o < *osize_p && i < count; i++) {
 			char ch = input[i];
+
 			if (ch == '\n') {
 				output[o++] = '\r';
-				if (o >= *osize_p) {
-					lf_to_crlf->want_lf = 1;
-					continue; /* We need to increase i */
-				}
+			} else if (was_cr) {
+				/*
+				 * Previous round saw CR and it is not followed
+				 * by a LF; emit the CR before processing the
+				 * current character.
+				 */
+				output[o++] = '\r';
 			}
+
+			/*
+			 * We may have consumed the last output slot,
+			 * in which case we need to break out of this
+			 * loop; hold the current character before
+			 * returning.
+			 */
+			if (*osize_p <= o) {
+				lf_to_crlf->has_held = 1;
+				lf_to_crlf->held = ch;
+				continue; /* break but increment i */
+			}
+
+			if (ch == '\r') {
+				was_cr = 1;
+				continue;
+			}
+
+			was_cr = 0;
 			output[o++] = ch;
 		}
 
 		*osize_p -= o;
 		*isize_p -= i;
+
+		if (!lf_to_crlf->has_held && was_cr) {
+			lf_to_crlf->has_held = 1;
+			lf_to_crlf->held = '\r';
+		}
 	}
 	return 0;
 }
