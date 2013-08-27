From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: do not use C function names as struct members
Date: Mon, 26 Aug 2013 21:38:52 -0700
Message-ID: <xmqq8uznhhnn.fsf@gitster.dls.corp.google.com>
References: <521BB643.304@gmail.com> <20130826201804.GB13130@blizzard>
	<521BBA98.7010102@gmail.com> <20130826203154.GA21357@blizzard>
	<20130826205901.GC23598@sigill.intra.peff.net>
	<20130826215718.GB6219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas Fleischer <git@cryptocrack.de>,
	Lance <lancethepants@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 06:39:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEB3U-0006z5-5x
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab3H0Ei4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:38:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab3H0Eiz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:38:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E75238C8E;
	Tue, 27 Aug 2013 04:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m+A1kzw49YcNUVfgeyNC40mhSMs=; b=Ze2ct4
	5L6D4Pgvp3/15M+pGXsz56kdengv9nq3/9/QLdL/CoPjAj2GUjw8D7DsWhdpeziC
	YX6GcCJoTSuN/JPqd7ujlYtQ0WIdS8Oj1XKf850l+Gcj4Cd8DJRnXIRFDMDCrE8u
	NfIo8fNwngDctgP3CHCE7bl76NFPjf5EmcS4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ssn+DSH82bdV3A75C9Fl9kG4vefMQQIk
	AzfbQg+cIWzErln/SEC9dqOY/klZ1XTzBf81P8rqMaJ/3dodlj585Uuz+ZNSei7g
	bKZ6Z9WD1w4kt+AT3HzYa6RE4C8piptOepd2oGp47EyLFXZ+VoBVM5LKkj1JOTTM
	BuavhODl1oc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4464C38C8D;
	Tue, 27 Aug 2013 04:38:55 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FAB038C8B;
	Tue, 27 Aug 2013 04:38:54 +0000 (UTC)
In-Reply-To: <20130826215718.GB6219@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 26 Aug 2013 17:57:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 944E56E2-0ED2-11E3-ABA7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233073>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 26, 2013 at 04:59:01PM -0400, Jeff King wrote:
>
>> Hmm. I wonder if fgetc is a macro in uclibc? Just grepping their
>> stdio.h, it looks like that is a possibility.
>> 
>> I think they are probably wrong to do so (but I'd have to check the
>> standard). However, the cleaner workaround would probably be to call the
>> fgetc struct member something else.
>
> Nope, it's allowed. I think we should do the patch below:

Thanks.

> -- >8 --
> Subject: config: do not use C function names as struct members
>
> According to C99, section 7.1.4:
>
>   Any function declared in a header may be additionally
>   implemented as a function-like macro defined in the
>   header.
>
> Therefore calling our struct member function pointer "fgetc"
> may run afoul of unwanted macro expansion when we call:
>
>   char c = cf->fgetc(cf);
>
> This turned out to be a problem on uclibc, which defines
> fgetc as a macro and causes compilation failure.
>
> The standard suggests fixing this in a few ways:
>
>   1. Using extra parentheses to inhibit the function-like
>      macro expansion. E.g., "(cf->fgetc)(cf)". This is
>      undesirable as it's ugly, and each call site needs to
>      remember to use it (and on systems without the macro,
>      forgetting will compile just fine).
>
>   2. Using #undef (because a conforming implementation must
>      also be providing fgetc as a function). This is
>      undesirable because presumably the implementation was
>      using the macro for a performance benefit, and we are
>      dropping that optimization.
>
> Instead, we can simply use non-colliding names.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  config.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/config.c b/config.c
> index e13a7b6..9f9bf0c 100644
> --- a/config.c
> +++ b/config.c
> @@ -27,9 +27,9 @@ struct config_source {
>  	struct strbuf value;
>  	struct strbuf var;
>  
> -	int (*fgetc)(struct config_source *c);
> -	int (*ungetc)(int c, struct config_source *conf);
> -	long (*ftell)(struct config_source *c);
> +	int (*do_fgetc)(struct config_source *c);
> +	int (*do_ungetc)(int c, struct config_source *conf);
> +	long (*do_ftell)(struct config_source *c);
>  };
>  
>  static struct config_source *cf;
> @@ -217,13 +217,13 @@ static int get_next_char(void)
>  
>  static int get_next_char(void)
>  {
> -	int c = cf->fgetc(cf);
> +	int c = cf->do_fgetc(cf);
>  
>  	if (c == '\r') {
>  		/* DOS like systems */
> -		c = cf->fgetc(cf);
> +		c = cf->do_fgetc(cf);
>  		if (c != '\n') {
> -			cf->ungetc(c, cf);
> +			cf->do_ungetc(c, cf);
>  			c = '\r';
>  		}
>  	}
> @@ -992,9 +992,9 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
>  		top.u.file = f;
>  		top.name = filename;
>  		top.die_on_error = 1;
> -		top.fgetc = config_file_fgetc;
> -		top.ungetc = config_file_ungetc;
> -		top.ftell = config_file_ftell;
> +		top.do_fgetc = config_file_fgetc;
> +		top.do_ungetc = config_file_ungetc;
> +		top.do_ftell = config_file_ftell;
>  
>  		ret = do_config_from(&top, fn, data);
>  
> @@ -1013,9 +1013,9 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
>  	top.u.buf.pos = 0;
>  	top.name = name;
>  	top.die_on_error = 0;
> -	top.fgetc = config_buf_fgetc;
> -	top.ungetc = config_buf_ungetc;
> -	top.ftell = config_buf_ftell;
> +	top.do_fgetc = config_buf_fgetc;
> +	top.do_ungetc = config_buf_ungetc;
> +	top.do_ftell = config_buf_ftell;
>  
>  	return do_config_from(&top, fn, data);
>  }
> @@ -1196,7 +1196,7 @@ static int store_aux(const char *key, const char *value, void *cb)
>  				return 1;
>  			}
>  
> -			store.offset[store.seen] = cf->ftell(cf);
> +			store.offset[store.seen] = cf->do_ftell(cf);
>  			store.seen++;
>  		}
>  		break;
> @@ -1223,19 +1223,19 @@ static int store_aux(const char *key, const char *value, void *cb)
>  		 * Do not increment matches: this is no match, but we
>  		 * just made sure we are in the desired section.
>  		 */
> -		store.offset[store.seen] = cf->ftell(cf);
> +		store.offset[store.seen] = cf->do_ftell(cf);
>  		/* fallthru */
>  	case SECTION_END_SEEN:
>  	case START:
>  		if (matches(key, value)) {
> -			store.offset[store.seen] = cf->ftell(cf);
> +			store.offset[store.seen] = cf->do_ftell(cf);
>  			store.state = KEY_SEEN;
>  			store.seen++;
>  		} else {
>  			if (strrchr(key, '.') - key == store.baselen &&
>  			      !strncmp(key, store.key, store.baselen)) {
>  					store.state = SECTION_SEEN;
> -					store.offset[store.seen] = cf->ftell(cf);
> +					store.offset[store.seen] = cf->do_ftell(cf);
>  			}
>  		}
>  	}
