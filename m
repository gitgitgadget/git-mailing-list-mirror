From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Tue, 27 Jan 2015 15:34:20 -0800
Message-ID: <xmqqwq47iyrn.fsf@gitster.dls.corp.google.com>
References: <xmqq7fwfuu62.fsf@gitster.dls.corp.google.com>
	<1422373918-14132-1-git-send-email-eungjun.yi@navercorp.com>
	<1422373918-14132-2-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershaus?= =?utf-8?Q?en?= 
	<tboegi@web.de>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 00:34:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGFeO-0003xm-No
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 00:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbbA0XeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 18:34:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753962AbbA0XeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 18:34:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06EDB320C4;
	Tue, 27 Jan 2015 18:34:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=BZTyc3U7FbYO8DtEWOyntlXFtyw=; b=uCwXgNSk309DKruPiQRv
	ooCHVGjLiYrEMxAnv7LdK6MHnf7urOv4yp8ouR7BlpSulY264lhhazUZck9LzOqV
	0vsnYZgBsGFpsi/iaaE/5O8RbHG8amUOHeSwk6+JuejDXvSQfpxiyWfuwbwxbjd1
	6nas7/cYuLGeV5wgKq+m/9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=UQDP10YEVqlLlRwmhUQihkIWUVU342dfGapkfpNxyLTf9L
	vFDoVyIXd5bW2EhMOn0PJmp2Zh25Hf2BJKnrdWVmb+i0y9MIvkN89VdI5NO7NyXN
	Yt3f3czAg/epUdh6GN+/TsLdt6cnGFgnokzAwkgCWFu/iUmEh8aEpbd81A8MQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0C51320C3;
	Tue, 27 Jan 2015 18:34:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4FCC2320C2;
	Tue, 27 Jan 2015 18:34:22 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05A9C87E-A67D-11E4-B5FD-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263095>

Yi EungJun <semtlenori@gmail.com> writes:

> +static void write_accept_language(struct strbuf *buf)
> +{
> +	/*
> +	 * MAX_DECIMAL_PLACES must not be larger than 3. If it is larger than
> +	 * that, q-value will be smaller than 0.001, the minimum q-value the
> +	 * HTTP specification allows. See
> +	 * http://tools.ietf.org/html/rfc7231#section-5.3.1 for q-value.
> +	 */
> +	const int MAX_DECIMAL_PLACES = 3;
> +	const int MAX_LANGUAGE_TAGS = 1000;
> +	const int MAX_ACCEPT_LANGUAGE_HEADER_SIZE = 4000;
> +	struct strbuf *language_tags = NULL;
> +	int num_langs = 0;
> +	const char *s = get_preferred_languages();
> +	int i;
> +	struct strbuf tag = STRBUF_INIT;
> +
> +	/* Don't add Accept-Language header if no language is preferred. */
> +	if (!s)
> +		return;
> +
> +	/*
> +	 * Split the colon-separated string of preferred languages into
> +	 * language_tags array.
> +	 */
> +	do {
> +		/* collect language tag */
> +		for (; *s && (isalnum(*s) || *s == '_'); s++)
> +			strbuf_addch(&tag, *s == '_' ? '-' : *s);
> +
> +		/* skip .codeset, @modifier and any other unnecessary parts */
> +		while (*s && *s != ':')
> +			s++;
> +
> +		if (tag.len) {
> +			num_langs++;
> +			REALLOC_ARRAY(language_tags, num_langs);
> +			strbuf_init(&language_tags[num_langs - 1], 0);
> +			strbuf_swap(&tag, &language_tags[num_langs - 1]);
> +
> +			if (num_langs >= MAX_LANGUAGE_TAGS - 1) /* -1 for '*' */
> +				break;
> +		}
> +	} while (*s++);

The structure of this function is much easier to understand than any
of the previous rounds.  You collect up to the max you are going to
support, and then you format up to the max you are going to send.

Very straight-forward and simple.

> +	/* write Accept-Language header into buf */
> +	if (num_langs >= 1) {

micronit: should be OK to just say "if (num_langs)".

> +		int last_buf_len = 0;
> +		int max_q;
> +		int decimal_places;
> +		char q_format[32];
> +
> +		/* add '*' */
> +		REALLOC_ARRAY(language_tags, num_langs + 1);
> +		strbuf_init(&language_tags[num_langs], 0);
> +		strbuf_addstr(&language_tags[num_langs++], "*");
> +
> +		/* compute decimal_places */
> +		for (max_q = 1, decimal_places = 0;
> +				max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
> +				decimal_places++, max_q *= 10)
> +			;

micronit: the second and the third line are indented too deeply and
made me wonder if this has an overlong first line (i.e. the set-up
part to enter the for-loop) split into multiple lines.

> +
> +		sprintf(q_format, ";q=0.%%0%dd", decimal_places);
> +
> +		strbuf_addstr(buf, "Accept-Language: ");
> +
> +		for(i = 0; i < num_langs; i++) {
> +			if (i > 0)
> +				strbuf_addstr(buf, ", ");
> +
> +			strbuf_addstr(buf, strbuf_detach(&language_tags[i], NULL));

This is not wrong per-se, but it looks somewhat convoluted to me.

You can just peek language_tags[i].buf here without detaching, as
you will free the strbufs after you exit the loop anyway.  Your
version is not wrong and it does not result in double-freeing,
because detach clears the strbuf, but at the same time, makes the
responsibility to free language_tags[] strbuf split into here (for
elements up to the ones that are used to fill buf) and the cleanup
loop (for elements that are not used in this loop).

> +			if (i > 0)
> +				strbuf_addf(buf, q_format, max_q - i);
> +
> +			if (buf->len > MAX_ACCEPT_LANGUAGE_HEADER_SIZE) {
> +				strbuf_remove(buf, last_buf_len, buf->len - last_buf_len);
> +				break;
> +			}
> +
> +			last_buf_len = buf->len;
> +		}
> +	}
> +
> +	/* free language tags */
> +	for(i = 0; i < num_langs; i++) {
> +		strbuf_release(&language_tags[i]);
> +	}
> +	free(language_tags);
> +}

I am wondering if using strbuf for each of the language_tags[] is
even necessary.  How about doing it this way instead?

 http.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/http.c b/http.c
index 6111c6a..db591b3 100644
--- a/http.c
+++ b/http.c
@@ -1027,7 +1027,7 @@ static void write_accept_language(struct strbuf *buf)
 	const int MAX_DECIMAL_PLACES = 3;
 	const int MAX_LANGUAGE_TAGS = 1000;
 	const int MAX_ACCEPT_LANGUAGE_HEADER_SIZE = 4000;
-	struct strbuf *language_tags = NULL;
+	char **language_tags = NULL;
 	int num_langs = 0;
 	const char *s = get_preferred_languages();
 	int i;
@@ -1053,9 +1053,7 @@ static void write_accept_language(struct strbuf *buf)
 		if (tag.len) {
 			num_langs++;
 			REALLOC_ARRAY(language_tags, num_langs);
-			strbuf_init(&language_tags[num_langs - 1], 0);
-			strbuf_swap(&tag, &language_tags[num_langs - 1]);
-
+			language_tags[num_langs - 1] = strbuf_detach(&tag, NULL);
 			if (num_langs >= MAX_LANGUAGE_TAGS - 1) /* -1 for '*' */
 				break;
 		}
@@ -1070,13 +1068,12 @@ static void write_accept_language(struct strbuf *buf)
 
 		/* add '*' */
 		REALLOC_ARRAY(language_tags, num_langs + 1);
-		strbuf_init(&language_tags[num_langs], 0);
-		strbuf_addstr(&language_tags[num_langs++], "*");
+		language_tags[num_langs++] = "*"; /* it's OK; this won't be freed */
 
 		/* compute decimal_places */
 		for (max_q = 1, decimal_places = 0;
-				max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
-				decimal_places++, max_q *= 10)
+		     max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
+		     decimal_places++, max_q *= 10)
 			;
 
 		sprintf(q_format, ";q=0.%%0%dd", decimal_places);
@@ -1087,7 +1084,7 @@ static void write_accept_language(struct strbuf *buf)
 			if (i > 0)
 				strbuf_addstr(buf, ", ");
 
-			strbuf_addstr(buf, strbuf_detach(&language_tags[i], NULL));
+			strbuf_addstr(buf, language_tags[i]);
 
 			if (i > 0)
 				strbuf_addf(buf, q_format, max_q - i);
@@ -1101,10 +1098,9 @@ static void write_accept_language(struct strbuf *buf)
 		}
 	}
 
-	/* free language tags */
-	for(i = 0; i < num_langs; i++) {
-		strbuf_release(&language_tags[i]);
-	}
+	/* free language tags -- last one is a static '*' */
+	for(i = 0; i < num_langs - 1; i++)
+		free(language_tags[i]);
 	free(language_tags);
 }
 
