From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diffcore-pickaxe: unify setup and teardown code
 between log -S/-G
Date: Thu, 04 Apr 2013 22:43:14 -0700
Message-ID: <7vk3ohedn1.fsf@alter.siamese.dyndns.org>
References: <7v1uapfuyp.fsf@alter.siamese.dyndns.org>
 <1365137126-21659-1-git-send-email-gitster@pobox.com>
 <1365137126-21659-3-git-send-email-gitster@pobox.com>
 <20130405052810.GA29815@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 05 07:44:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNzRf-0004du-R1
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 07:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513Ab3DEFnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 01:43:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161597Ab3DEFnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 01:43:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AE5712B01;
	Fri,  5 Apr 2013 05:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z9uOvXwRhfu9JotDjHTX49P7Z7Y=; b=XkIJxG
	vGuTCVzv3pqml9iq43gQdTi/vpksN/gqturHUgD6PM6b7Z0Dz28t369fxJU6mar/
	TiGgn2kQmsLEw+EGsHqzT4l9IU8O7H6tQ+paZPNWPjVxE1DqtD5Ek66f7mt2gJ8y
	Z81fV3BXWWw2Yh3P2BgBX99y2F2iaSeWIfd14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YM5iN2FfTzX3LK7v/U03ADFryv/vszAt
	rf7fG09lJJA3ymyZpf+VQY0Nr95R4RK2TwDDRHdeJRznvxdt9m3ngODHqrU8JOcT
	0S3/TQ/MD4dEnIEtYMowdaA6m/lwg8FArabWRg4cLKmZ6tF2vn+p/0y6aY4uKlpZ
	VAG9vE25/4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E41712B00;
	Fri,  5 Apr 2013 05:43:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1EB212AFF; Fri,  5 Apr
 2013 05:43:15 +0000 (UTC)
In-Reply-To: <20130405052810.GA29815@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 5 Apr 2013 01:28:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B65BA900-9DB3-11E2-BC78-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220146>

Jeff King <peff@peff.net> writes:

> I notice that you are stuck factoring out not just the setup, but also
> the cleanup, and I wondered if things could be made even simpler by just
> encapsulating the checking logic in a callback; then the setup and
> cleanup flow more naturally, as they are in a single function wrapper.
>
> Like this, which ends up saving 20 lines rather than adding 7:

Oh, this is one of those many times I am reminded why I love having
you in the reviewer/contributor pool ;-)

>
> ---
>  diffcore-pickaxe.c | 118 +++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 69 deletions(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index cadb071..63722f8 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -8,7 +8,12 @@
>  #include "xdiff-interface.h"
>  #include "kwset.h"
>  
> -typedef int (*pickaxe_fn)(struct diff_filepair *p, struct diff_options *o, regex_t *regexp, kwset_t kws);
> +typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
> +			  struct diff_options *o,
> +			  regex_t *regexp, kwset_t kws);
> +
> +static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
> +			 regex_t *regexp, kwset_t kws, pickaxe_fn fn);
>  
>  static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
>  		    regex_t *regexp, kwset_t kws, pickaxe_fn fn)
> @@ -22,7 +27,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
>  		/* Showing the whole changeset if needle exists */
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			if (fn(p, o, regexp, kws))
> +			if (pickaxe_match(p, o, regexp, kws, fn))
>  				return; /* do not munge the queue */
>  		}
>  
> @@ -37,7 +42,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
>  		/* Showing only the filepairs that has the needle */
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			if (fn(p, o, regexp, kws))
> +			if (pickaxe_match(p, o, regexp, kws, fn))
>  				diff_q(&outq, p);
>  			else
>  				diff_free_filepair(p);
> @@ -74,64 +79,33 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
>  	line[len] = hold;
>  }
>  
> -static int diff_grep(struct diff_filepair *p, struct diff_options *o,
> +static int diff_grep(mmfile_t *one, mmfile_t *two,
> +		     struct diff_options *o,
>  		     regex_t *regexp, kwset_t kws)
>  {
>  	regmatch_t regmatch;
> -	struct userdiff_driver *textconv_one = NULL;
> -	struct userdiff_driver *textconv_two = NULL;
> -	mmfile_t mf1, mf2;
> -	int hit;
> +	struct diffgrep_cb ecbdata;
> +	xpparam_t xpp;
> +	xdemitconf_t xecfg;
>  
> -	if (!o->pickaxe[0])
> -		return 0;
> +	if (!one)
> +		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
> +	if (!two)
> +		return !regexec(regexp, one->ptr, 1, &regmatch, 0);
>  
> -	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
> -		textconv_one = get_textconv(p->one);
> -		textconv_two = get_textconv(p->two);
> -	}
> -
> -	if (textconv_one == textconv_two && diff_unmodified_pair(p))
> -		return 0;
> -
> -	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
> -	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
> -
> -	if (!DIFF_FILE_VALID(p->one)) {
> -		if (!DIFF_FILE_VALID(p->two))
> -			hit = 0; /* ignore unmerged */
> -		else
> -			/* created "two" -- does it have what we are looking for? */
> -			hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
> -	} else if (!DIFF_FILE_VALID(p->two)) {
> -		/* removed "one" -- did it have what we are looking for? */
> -		hit = !regexec(regexp, mf1.ptr, 1, &regmatch, 0);
> -	} else {
> -		/*
> -		 * We have both sides; need to run textual diff and see if
> -		 * the pattern appears on added/deleted lines.
> -		 */
> -		struct diffgrep_cb ecbdata;
> -		xpparam_t xpp;
> -		xdemitconf_t xecfg;
> -
> -		memset(&xpp, 0, sizeof(xpp));
> -		memset(&xecfg, 0, sizeof(xecfg));
> -		ecbdata.regexp = regexp;
> -		ecbdata.hit = 0;
> -		xecfg.ctxlen = o->context;
> -		xecfg.interhunkctxlen = o->interhunkcontext;
> -		xdi_diff_outf(&mf1, &mf2, diffgrep_consume, &ecbdata,
> -			      &xpp, &xecfg);
> -		hit = ecbdata.hit;
> -	}
> -	if (textconv_one)
> -		free(mf1.ptr);
> -	if (textconv_two)
> -		free(mf2.ptr);
> -	diff_free_filespec_data(p->one);
> -	diff_free_filespec_data(p->two);
> -	return hit;
> +	/*
> +	 * We have both sides; need to run textual diff and see if
> +	 * the pattern appears on added/deleted lines.
> +	 */
> +	memset(&xpp, 0, sizeof(xpp));
> +	memset(&xecfg, 0, sizeof(xecfg));
> +	ecbdata.regexp = regexp;
> +	ecbdata.hit = 0;
> +	xecfg.ctxlen = o->context;
> +	xecfg.interhunkctxlen = o->interhunkcontext;
> +	xdi_diff_outf(one, two, diffgrep_consume, &ecbdata,
> +		      &xpp, &xecfg);
> +	return ecbdata.hit;
>  }
>  
>  static void diffcore_pickaxe_grep(struct diff_options *o)
> @@ -198,9 +172,20 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
>  	return cnt;
>  }
>  
> -static int has_changes(struct diff_filepair *p, struct diff_options *o,
> +static int has_changes(mmfile_t *one, mmfile_t *two,
> +		       struct diff_options *o,
>  		       regex_t *regexp, kwset_t kws)
>  {
> +	if (!one)
> +		return contains(two, o, regexp, kws) != 0;
> +	if (!two)
> +		return contains(one, o, regexp, kws) != 0;
> +	return contains(one, o, regexp, kws) != contains(two, o, regexp, kws);
> +}
> +
> +static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
> +			 regex_t *regexp, kwset_t kws, pickaxe_fn fn)
> +{
>  	struct userdiff_driver *textconv_one = NULL;
>  	struct userdiff_driver *textconv_two = NULL;
>  	mmfile_t mf1, mf2;
> @@ -209,6 +194,10 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
>  	if (!o->pickaxe[0])
>  		return 0;
>  
> +	/* ignore unmerged */
> +	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
> +		return 0;
> +
>  	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
>  		textconv_one = get_textconv(p->one);
>  		textconv_two = get_textconv(p->two);
> @@ -227,18 +216,9 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
>  	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
>  	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
>  
> -	if (!DIFF_FILE_VALID(p->one)) {
> -		if (!DIFF_FILE_VALID(p->two))
> -			ret = 0; /* ignore unmerged */
> -		else
> -			/* created */
> -			ret = contains(&mf2, o, regexp, kws) != 0;
> -	}
> -	else if (!DIFF_FILE_VALID(p->two)) /* removed */
> -		ret = contains(&mf1, o, regexp, kws) != 0;
> -	else
> -		ret = contains(&mf1, o, regexp, kws) !=
> -		      contains(&mf2, o, regexp, kws);
> +	ret = fn(DIFF_FILE_VALID(p->one) ? &mf1 : NULL,
> +		 DIFF_FILE_VALID(p->two) ? &mf2 : NULL,
> +		 o, regexp, kws);
>  
>  	if (textconv_one)
>  		free(mf1.ptr);
