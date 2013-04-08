From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] progress: create public humanize() to show sizes
Date: Mon, 08 Apr 2013 14:40:47 -0700
Message-ID: <7vli8svgyo.fsf@alter.siamese.dyndns.org>
References: <CALWbr2wgJmY86Fic-eE9AbtP=HMPddTO=LDp5RGYmt6_kFawpg@mail.gmail.com>
 <1365445101-10425-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:40:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJo8-0005Cj-4w
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935988Ab3DHVkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:40:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935173Ab3DHVku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:40:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93756127FB;
	Mon,  8 Apr 2013 21:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pKxfO3adJW4lUnH0yfNQlsHMJsw=; b=qK425+
	jKUKafVEQofO+Hf5490v4Mkc4Ozi0kWM1UJ78s7HBInro8DIGZJQsYnp7+lZic1/
	jxfSE4v2ImdMzdDoHNL9TDZ0CKFVG2KHtf8khI45b5SxCaoM6p9tbUX9t+3Y4qZH
	Ec56CwRTVjgZAt9HNn8D7ZBgu1JnvE97770lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g0y4sxOcfvvbN0fFEnKKa69OgpPFZ07P
	VOh8/uOyNPLhc2XgiqxN1aZcCWKGFHnx35/3r/3zFPbH9WqCXPQUznepryXHUW1B
	IGer+49WgSJxYhPIzWTadWJyU7Zrdr7nd27briUIyyNEax5vZohjqr8wtYOQraf+
	s7wzygZ5lWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86B5D127FA;
	Mon,  8 Apr 2013 21:40:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A731D127F8; Mon,  8 Apr
 2013 21:40:48 +0000 (UTC)
In-Reply-To: <1365445101-10425-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Mon, 8 Apr 2013 20:18:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA25BCDC-A094-11E2-9061-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220524>

Antoine Pelisse <apelisse@gmail.com> writes:

> Currently, humanization of downloaded size is done in the same function
> as text formatting. This is an issue if anyone else wants to use this.
>
> Separate text formatting from size simplification and make the function
> public so that it can easily be used by other clients.
>
> We now can use humanize() for both downloaded size and download speed
> calculation. One of the drawbacks is that speed will no look like this
> when download is stalled: "0 bytes/s" instead of "0 KiB/s".
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---

Sounds good, but I think this helper function should live in
strbuf.[ch], where many other text/string helpers that take a strbuf
as their first parameter live.

>  progress.c |   60 ++++++++++++++++++++++++++++++++++--------------------------
>  progress.h |    2 ++
>  2 files changed, 36 insertions(+), 26 deletions(-)
>
> diff --git a/progress.c b/progress.c
> index 3971f49..76c1e42 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -8,8 +8,11 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <string.h>
> +

Please do not do this.

If you somehow need to have <string.h>, a suitable place should be
found in git-compat-util.h; various platforms seem to have quirks
with the ordering of system header files, and git-compat-util.h is
meant to encapsulate them.

In fact, git-compat-util.h should already include it.

>  #include "git-compat-util.h"
>  #include "progress.h"
> +#include "strbuf.h"
>  
>  #define TP_IDX_MAX      8
>  
> @@ -112,34 +115,33 @@ static int display(struct progress *progress, unsigned n, const char *done)
>  	return 0;
>  }
>  
> -static void throughput_string(struct throughput *tp, off_t total,
> -			      unsigned int rate)
> +void humanize(struct strbuf *buf, off_t bytes)
>  {
> -	int l = sizeof(tp->display);
> -	if (total > 1 << 30) {
> -		l -= snprintf(tp->display, l, ", %u.%2.2u GiB",
> -			      (int)(total >> 30),
> -			      (int)(total & ((1 << 30) - 1)) / 10737419);
> -	} else if (total > 1 << 20) {
> -		int x = total + 5243;  /* for rounding */
> -		l -= snprintf(tp->display, l, ", %u.%2.2u MiB",
> -			      x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
> -	} else if (total > 1 << 10) {
> -		int x = total + 5;  /* for rounding */
> -		l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
> -			      x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
> +	if (bytes > 1 << 30) {
> +		strbuf_addf(buf, "%u.%2.2u GiB",
> +			    (int)(bytes >> 30),
> +			    (int)(bytes & ((1 << 30) - 1)) / 10737419);
> +	} else if (bytes > 1 << 20) {
> +		int x = bytes + 5243;  /* for rounding */
> +		strbuf_addf(buf, "%u.%2.2u MiB",
> +			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
> +	} else if (bytes > 1 << 10) {
> +		int x = bytes + 5;  /* for rounding */
> +		strbuf_addf(buf, "%u.%2.2u KiB",
> +			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
>  	} else {
> -		l -= snprintf(tp->display, l, ", %u bytes", (int)total);
> +		strbuf_addf(buf, "%u bytes", (int)bytes);
>  	}
> +}
>  
> -	if (rate > 1 << 10) {
> -		int x = rate + 5;  /* for rounding */
> -		snprintf(tp->display + sizeof(tp->display) - l, l,
> -			 " | %u.%2.2u MiB/s",
> -			 x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
> -	} else if (rate)
> -		snprintf(tp->display + sizeof(tp->display) - l, l,
> -			 " | %u KiB/s", rate);
> +static void throughput_string(struct strbuf *buf, off_t total,
> +			      unsigned int rate)
> +{
> +	strbuf_addstr(buf, ", ");
> +	humanize(buf, total);
> +	strbuf_addstr(buf, " | ");
> +	humanize(buf, rate * 1024);
> +	strbuf_addstr(buf, "/s");
>  }
>  
>  void display_throughput(struct progress *progress, off_t total)
> @@ -183,6 +185,7 @@ void display_throughput(struct progress *progress, off_t total)
>  	misecs += (int)(tv.tv_usec - tp->prev_tv.tv_usec) / 977;
>  
>  	if (misecs > 512) {
> +		struct strbuf buf = STRBUF_INIT;
>  		unsigned int count, rate;
>  
>  		count = total - tp->prev_total;
> @@ -197,7 +200,9 @@ void display_throughput(struct progress *progress, off_t total)
>  		tp->last_misecs[tp->idx] = misecs;
>  		tp->idx = (tp->idx + 1) % TP_IDX_MAX;
>  
> -		throughput_string(tp, total, rate);
> +		throughput_string(&buf, total, rate);
> +		strncpy(tp->display, buf.buf, sizeof(tp->display));
> +		strbuf_release(&buf);
>  		if (progress->last_value != -1 && progress_update)
>  			display(progress, progress->last_value, NULL);
>  	}
> @@ -253,9 +258,12 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
>  
>  		bufp = (len < sizeof(buf)) ? buf : xmalloc(len + 1);
>  		if (tp) {
> +			struct strbuf strbuf = STRBUF_INIT;
>  			unsigned int rate = !tp->avg_misecs ? 0 :
>  					tp->avg_bytes / tp->avg_misecs;
> -			throughput_string(tp, tp->curr_total, rate);
> +			throughput_string(&strbuf, tp->curr_total, rate);
> +			strncpy(tp->display, strbuf.buf, sizeof(tp->display));
> +			strbuf_release(&strbuf);
>  		}
>  		progress_update = 1;
>  		sprintf(bufp, ", %s.\n", msg);
> diff --git a/progress.h b/progress.h
> index 611e4c4..0e70f55 100644
> --- a/progress.h
> +++ b/progress.h
> @@ -2,7 +2,9 @@
>  #define PROGRESS_H
>  
>  struct progress;
> +struct strbuf;
>  
> +void humanize(struct strbuf *buf, off_t bytes);
>  void display_throughput(struct progress *progress, off_t total);
>  int display_progress(struct progress *progress, unsigned n);
>  struct progress *start_progress(const char *title, unsigned total);
