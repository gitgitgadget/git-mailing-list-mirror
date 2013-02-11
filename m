From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 09:07:53 -0800
Message-ID: <7v7gmeok2e.fsf@alter.siamese.dyndns.org>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:08:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wrd-0004cv-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621Ab3BKRH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:07:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757680Ab3BKRH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:07:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16FAAC58D;
	Mon, 11 Feb 2013 12:07:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=arZl/PrME/oYJXx9fFyTJa2hLlM=; b=bi17Qg
	rx/h9Y/z1yMII/Ey7XJy6R+yPk7V3XF9AJNEiRh3Y90DHlmE36vF4Gqy09+pMSZl
	bPYLbaFJxOvLq2no9Upz10ngVjFNxBDzxQYDAnkAISh1diFEOlUhVFfB2YS7lXD0
	DROWulqLfoyGVNlWeYrhxQyOyx0JBsBG1Fv5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MCvlS7+j6qwJcwCOf2sld3byguC0E9tC
	9YjYZLT79SvwzGiXqUJvcjHIOeGOPQEWl3Np8tMnPgzsgojpL/Kf9Adud3/pmt4T
	DsTdcSMLbif0xf6Ka0u2GM98ZkIO2GqvxK5Ya9nHN3eHIysjJ7cNVW3DGxi/xRBa
	yDcemq658Uw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AF08C58C;
	Mon, 11 Feb 2013 12:07:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79D42C589; Mon, 11 Feb 2013
 12:07:55 -0500 (EST)
In-Reply-To: <1360589687-9233-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Mon, 11 Feb 2013 14:34:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93D5E3F6-746D-11E2-AF64-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216055>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> However, since git only looks at one byte at the time for
> short-options, it ends up reporting a partial UTF-8 sequence
> in such cases, leading to corruption of the output.

Isn't it a workable, easier and more robust alternative to punt and
use the entire ctx.argv[0] as unrecognized?

>
> The "real fix" would probably be to add proper multi-byte
> support to the short-option parser, but this serves little
> purpose in Git; we don't internationalize the command-line
> switches.
>
> So perhaps this is a suitable band-aid instead?
>
>  parse-options.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 67e98a6..20dc742 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -3,6 +3,7 @@
>  #include "cache.h"
>  #include "commit.h"
>  #include "color.h"
> +#include "utf8.h"
>  
>  static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>  			       const char * const *usagestr,
> @@ -462,7 +463,9 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  		if (ctx.argv[0][1] == '-') {
>  			error("unknown option `%s'", ctx.argv[0] + 2);
>  		} else {
> -			error("unknown switch `%c'", *ctx.opt);
> +			const char *next = ctx.opt;
> +			utf8_width(&next, NULL);
> +			error("unknown switch `%.*s'", (int)(next - ctx.opt), ctx.opt);
>  		}
>  		usage_with_options(usagestr, options);
>  	}
