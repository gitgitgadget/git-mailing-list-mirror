From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/13] parse-options: stop when encounter a non-option
Date: Mon, 12 Jul 2010 09:45:21 -0700
Message-ID: <7v630kd4ym.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 18:45:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYM8L-0005KV-KS
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 18:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab0GLQp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 12:45:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab0GLQp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 12:45:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15F20C4379;
	Mon, 12 Jul 2010 12:45:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=mPwXbVm3nPovsl/uCeZn3lrYg48=; b=oREhaPhEwXvO7GI3Hmk4Uwi
	PCScL1AHjCK3mZJ8AFG/2lSf2Aj8r1bVnKZYh+b3hbeIkZsInRC9IDDTsRChr7W1
	8CqAN5j2cBB5n+R4mMBp9VkS59K5RTXjR3AqhP9tAY2bs1mGBibVsa9laEmdaqFZ
	9+Gs7oMM04f0KlWsR8hk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HqXEVJZFOZmEVjFTrQw956c37XhI8Pa8vswX2JPeDOMDqhTsb
	z/EIAvOm1tPub6JMkobb5zlsfwuV365sFu5OVsCwDAa4PX5L5DQENDCZvr99LLmQ
	9QC2snJBpItGJxnS1t1i1hKZldRIP6gvkZWf/3pXE/RoECgdEL5Nc91jK0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7500C4377;
	Mon, 12 Jul 2010 12:45:25 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 122DEC4376; Mon, 12 Jul
 2010 12:45:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DF0DA160-8DD4-11DF-86EE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150827>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Subject: Re: [PATCH v3 01/13] parse-options: stop when encounter a non-option
>
> We support the syntax like:
> -L n1,m1 pathspec1 -L n2,m2 pathspec2.
>
> Make the parse-options API not stop when encounter a
> non-option argument, report the status and go on parsing
> the remain options.

-ECANTPARSE

Read the above again and wonder...

Does it stop, like the subject line says, or does it not stop???

Perhaps you meant to say something like this...

  Subject: [PATCH v3 01/13] parse-options: enhance STOP_AT_NON_OPTION

  Make parse_options_step() report PARSE_OPT_NON_OPTION, instead of
  PARSE_OPT_DONE, to the caller, when it sees a non-option argument.  

  This will help implementing a nonstandard option syntax that takes more
  than one parameters to an option, e.g.

      -L n1,m1 pathspec1 -L n2,m2 pathspec2

  by directly calling parse_options_step().  The parse_options() API only
  calls parse_options_step() once, and its callers are not affected by
  this change.

  Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
  Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>

Currently blame and shortlog seems to use parse_options_step() but neither
of them uses STOP_AT_NON_OPTION, so this change shouldn't break them.

>
> Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  parse-options.c |    3 ++-
>  parse-options.h |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 0fa79bc..cbb49d3 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -374,7 +374,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  			if (parse_nodash_opt(ctx, arg, options) == 0)
>  				continue;
>  			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
> -				break;
> +				return PARSE_OPT_NON_OPTION;
>  			ctx->out[ctx->cpidx++] = ctx->argv[0];
>  			continue;
>  		}
> @@ -456,6 +456,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  	switch (parse_options_step(&ctx, options, usagestr)) {
>  	case PARSE_OPT_HELP:
>  		exit(129);
> +	case PARSE_OPT_NON_OPTION:
>  	case PARSE_OPT_DONE:
>  		break;
>  	default: /* PARSE_OPT_UNKNOWN */
> diff --git a/parse-options.h b/parse-options.h
> index 7435cdb..407697a 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -161,7 +161,8 @@ extern NORETURN void usage_msg_opt(const char *msg,
>  enum {
>  	PARSE_OPT_HELP = -1,
>  	PARSE_OPT_DONE,
> -	PARSE_OPT_UNKNOWN
> +	PARSE_OPT_NON_OPTION,
> +	PARSE_OPT_UNKNOWN,
>  };
>  
>  /*
> -- 
> 1.7.0.2.273.gc2413.dirty
