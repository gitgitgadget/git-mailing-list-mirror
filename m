From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 11:50:41 -0700
Message-ID: <xmqqr42u55dq.fsf@gitster.dls.corp.google.com>
References: <cover.1402557437.git.jmmahler@gmail.com>
	<f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:50:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvA5N-0006BM-U6
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbaFLSuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:50:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63479 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbaFLSus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 14:50:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D72D1E5BA;
	Thu, 12 Jun 2014 14:50:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OzQdni/vJrNeJFJD7EnQ4Xw4FQg=; b=lq8Wwj
	e/cGT5FwJU7CmjhKKuUpejEW1Wl4y2dcFputkRWfKBhBm6hRM3FEWN4W+MFWVVT0
	Kp374dPptlqGgAvqZkAwdtU7cxHRQltlsNSYfbE3xpAqQymuV1qkdOgjDpps/Upt
	tVeHFrLrA22Cxye3HAqq9fIqoY9Cu8C2JQxsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olAb8sO/fGQb4Y5iW69HJTQQvcWW7Ch+
	21OQntUidIe4dEDZzWCrFnxVdpyelQsPdqRwNk31hCmfIRALlInPeFdyV8jxTYqS
	FWgEswQPZx9Rz6w3bc/8xtTy6xhxqCFDDLil5A4rC1Rcj3jEj34g3Oavp6pjuL2R
	ctbbcldkTkM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9288D1E5B9;
	Thu, 12 Jun 2014 14:50:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7E5AE1E5B3;
	Thu, 12 Jun 2014 14:50:43 -0400 (EDT)
In-Reply-To: <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
	(Jeremiah Mahler's message of "Thu, 12 Jun 2014 00:29:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 75065F36-F262-11E3-B632-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251478>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> A common use case with strubfs is to set the buffer to a new value.
> This must be done in two steps: a reset followed by an add.
>
>   strbuf_reset(buf);
>   strbuf_add(buf, new_buf, len);
>
> In cases where the buffer is being built up in steps, these operations
> make sense and correctly convey what is being performed.
>
>   strbuf_reset(buf);
>   strbuf_add(buf, data1, len1);
>   strbuf_add(buf, data2, len2);
>   strbuf_add(buf, data3, len3);
>
> However, in other cases, it can be confusing and is not very concise.
>
>   strbuf_reset(buf);
>   strbuf_add(buf, default, len1);
>
>   if (cond1) {
>     strbuf_reset(buf);
>     strbuf_add(buf, data2, len2);
>   }
>
>   if (cond2) {
>     strbuf_reset(buf);
>     strbuf_add(buf, data3, len3);
>   }
>
> Add strbuf_set operations so that it can be re-written in a clear and
> concise way.
>
>   strbuf_set(buf, default len1);
>
>   if (cond1) {
>     strbuf_set(buf, data2, len2);
>   }
>
>   if (cond2) {
>     strbuf_set(buf, data3, len3);
>   }

Or even more concisely without making unnecessary internal calls to
strbuf_reset():

	strbuf_reset(buf);
        if (cond2)
        	strbuf_add(buf, data3, len3);
	else if (cond1)
        	strbuf_add(buf, data2, len2);
	else
        	strbuf_add(buf, default, len2);

;-)

I am on the fence.

I have this suspicion that the addition of strbuf_set() would *only*
help when the original written with reset-and-then-add sequence was
suboptimal to begin with, and it helps *only* how the code reads,
without correcting the fact that it is still doing unnecessary
"first set to a value to be discarded and then reset to set the
right value", sweeping the issue under the rug.

Repeated reset-and-then-add on the same strbuf used to be something
that may indicate that the code is doing unnecessary work.  Now,
repeated uses of strbuf_set on the same strbuf replaced that pattern
to be watched for to spot wasteful code paths.

I dunno...

> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
>  strbuf.c                               | 21 +++++++++++++++++++++
>  strbuf.h                               | 13 +++++++++++++
>  3 files changed, 52 insertions(+)
>
> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> index f9c06a7..ae9c9cc 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -149,6 +149,24 @@ Functions
>  	than zero if the first buffer is found, respectively, to be less than,
>  	to match, or be greater than the second buffer.
>  
> +* Setting the buffer
> +
> +`strbuf_set`::
> +
> +	Replace content with data of a given length.
> +
> +`strbuf_setstr`::
> +
> +	Replace content with data from a NUL-terminated string.
> +
> +`strbuf_setf`::
> +
> +	Replace content with a formatted string.
> +
> +`strbuf_setbuf`::
> +
> +	Replace content with data from another buffer.
> +
>  * Adding data to the buffer
>  
>  NOTE: All of the functions in this section will grow the buffer as necessary.
> diff --git a/strbuf.c b/strbuf.c
> index ac62982..9d64b00 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -189,6 +189,27 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
>  	strbuf_setlen(sb, sb->len + dlen - len);
>  }
>  
> +void strbuf_set(struct strbuf *sb, const void *data, size_t len)
> +{
> +	strbuf_reset(sb);
> +	strbuf_add(sb, data, len);
> +}
> +
> +void strbuf_setf(struct strbuf *sb, const char *fmt, ...)
> +{
> +	va_list ap;
> +	strbuf_reset(sb);
> +	va_start(ap, fmt);
> +	strbuf_vaddf(sb, fmt, ap);
> +	va_end(ap);
> +}
> +
> +void strbuf_setbuf(struct strbuf *sb, const struct strbuf *sb2)
> +{
> +	strbuf_reset(sb);
> +	strbuf_add(sb, sb2->buf, sb2->len);
> +}
> +
>  void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
>  {
>  	strbuf_splice(sb, pos, 0, data, len);
> diff --git a/strbuf.h b/strbuf.h
> index e9ad03e..5041c35 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -101,6 +101,19 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
>   */
>  extern void strbuf_list_free(struct strbuf **);
>  
> +/*----- set buffer to data -----*/
> +extern void strbuf_set(struct strbuf *sb, const void *data, size_t len);
> +
> +static inline void strbuf_setstr(struct strbuf *sb, const char *s)
> +{
> +	strbuf_set(sb, s, strlen(s));
> +}
> +
> +__attribute__((format (printf,2,3)))
> +extern void strbuf_setf(struct strbuf *sb, const char *fmt, ...);
> +
> +extern void strbuf_setbuf(struct strbuf *sb, const struct strbuf *sb2);
> +
>  /*----- add data in your buffer -----*/
>  static inline void strbuf_addch(struct strbuf *sb, int c)
>  {
