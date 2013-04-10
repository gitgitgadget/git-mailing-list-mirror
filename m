From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] strbuf: create strbuf_humanize() to show byte sizes
Date: Wed, 10 Apr 2013 12:57:38 -0700
Message-ID: <7vr4iikvkd.fsf@alter.siamese.dyndns.org>
References: <7vli8svgyo.fsf@alter.siamese.dyndns.org>
 <1365620604-17851-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:57:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ19P-00077g-DU
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936108Ab3DJT5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:57:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935117Ab3DJT5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:57:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E5D81582C;
	Wed, 10 Apr 2013 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eclngU3r8MsPYSiBBIbUFiexY7g=; b=ekjlq8
	/z/Za9kuGa3nYy+zFggPoOBAGYRyJtL5WG726/Gp/DzL6kDb/JGpUEYzBFyelWHp
	qYnrM9ftoSnne/uabV2Uz68W6oAEDHDP43GKVSdEGMxEgob2KciFOyyXB48YIx2u
	SBfbJKXi839bROKsUXGfuQdJ/jmfrVknO60kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hz0bSz6W5SX29L/7r+qNuqu3IiwYSVvQ
	A/mCuVRN3RnfCXsuUilerTTHPGzTxvhNB5iwiP4pcFj0SCP4aEWPdCLhEU94NZ96
	kx9vKDNCS6v/6FmT3/3ryuJl1/uEkChGojpIeih1RQh4xa0hw86vrhSqWlMd/jdn
	ROBlKJfnc0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02FD51582B;
	Wed, 10 Apr 2013 19:57:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 195871582A; Wed, 10 Apr
 2013 19:57:40 +0000 (UTC)
In-Reply-To: <1365620604-17851-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Wed, 10 Apr 2013 21:03:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E64AD3AC-A218-11E2-BB6B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220741>

Antoine Pelisse <apelisse@gmail.com> writes:

> Currently, humanization of downloaded size is done in the same
> function as text formatting in 'process.c'. This is an issue if anyone
> else wants to use this.
>
> Separate text formatting from size simplification and make the function
> public in strbuf so that it can easily be used by other clients.
>
> We now can use strbuf_humanize() for both downloaded size and download
> speed calculation. One of the drawbacks is that speed will now look like
> this when download is stalled: "0 bytes/s" instead of "0 KiB/s".

Personally, I do not think the "drawback" is so big an issue.  If
the caller really cares, we could always add another parameter to
this formatter to tell it the minimum unit we care about (e.g. pass
1024 to say "Don't bother showing scale lower than kibi").

This is a bit late response, but if we ever want to count something
in a dimention other than "bytes", like time (e.g. "kiloseconds") or
number of commits (e.g. "centicommits"), etc., we cannot reuse this
formatter very easily.  We may want to have "byte" somewhere in its
name for now to make sure the callers understand its limitation.

I'll tentatively rename it to "strbuf_humanize_bytes()" while queuing.

Thanks.

> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  Documentation/technical/api-strbuf.txt |    5 ++++
>  progress.c                             |   43 +++++++++++---------------------
>  strbuf.c                               |   19 ++++++++++++++
>  strbuf.h                               |    1 +
>  4 files changed, 40 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> index 2c59cb2..7b6ecda 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -230,6 +230,11 @@ which can be used by the programmer of the callback as she sees fit.
>  	destination. This is useful for literal data to be fed to either
>  	strbuf_expand or to the *printf family of functions.
>  
> +`strbuf_humanize`::
> +
> +	Append the given byte size as a human-readable string (i.e. 12.23 KiB,
> +	3.50 MiB).
> +
>  `strbuf_addf`::
>  
>  	Add a formatted string to the buffer.
> diff --git a/progress.c b/progress.c
> index 3971f49..8e09058 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -10,6 +10,7 @@
>  
>  #include "git-compat-util.h"
>  #include "progress.h"
> +#include "strbuf.h"
>  
>  #define TP_IDX_MAX      8
>  
> @@ -112,34 +113,14 @@ static int display(struct progress *progress, unsigned n, const char *done)
>  	return 0;
>  }
>  
> -static void throughput_string(struct throughput *tp, off_t total,
> +static void throughput_string(struct strbuf *buf, off_t total,
>  			      unsigned int rate)
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
> -	} else {
> -		l -= snprintf(tp->display, l, ", %u bytes", (int)total);
> -	}
> -
> -	if (rate > 1 << 10) {
> -		int x = rate + 5;  /* for rounding */
> -		snprintf(tp->display + sizeof(tp->display) - l, l,
> -			 " | %u.%2.2u MiB/s",
> -			 x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
> -	} else if (rate)
> -		snprintf(tp->display + sizeof(tp->display) - l, l,
> -			 " | %u KiB/s", rate);
> +	strbuf_addstr(buf, ", ");
> +	strbuf_humanize(buf, total);
> +	strbuf_addstr(buf, " | ");
> +	strbuf_humanize(buf, rate * 1024);
> +	strbuf_addstr(buf, "/s");
>  }
>  
>  void display_throughput(struct progress *progress, off_t total)
> @@ -183,6 +164,7 @@ void display_throughput(struct progress *progress, off_t total)
>  	misecs += (int)(tv.tv_usec - tp->prev_tv.tv_usec) / 977;
>  
>  	if (misecs > 512) {
> +		struct strbuf buf = STRBUF_INIT;
>  		unsigned int count, rate;
>  
>  		count = total - tp->prev_total;
> @@ -197,7 +179,9 @@ void display_throughput(struct progress *progress, off_t total)
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
> @@ -253,9 +237,12 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
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
> diff --git a/strbuf.c b/strbuf.c
> index 48e9abb..8a50e66 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -528,6 +528,25 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
>  	strbuf_add_urlencode(sb, s, strlen(s), reserved);
>  }
>  
> +void strbuf_humanize(struct strbuf *buf, off_t bytes)
> +{
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
> +	} else {
> +		strbuf_addf(buf, "%u bytes", (int)bytes);
> +	}
> +}
> +
>  int printf_ln(const char *fmt, ...)
>  {
>  	int ret;
> diff --git a/strbuf.h b/strbuf.h
> index 958822c..317c5a8 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -170,6 +170,7 @@ extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
>  
>  extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
>  				    int reserved);
> +extern void strbuf_humanize(struct strbuf *buf, off_t bytes);
>  
>  __attribute__((format (printf,1,2)))
>  extern int printf_ln(const char *fmt, ...);
