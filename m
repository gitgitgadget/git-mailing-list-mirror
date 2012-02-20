From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ignore SIGPIPE when running a filter driver
Date: Mon, 20 Feb 2012 14:11:24 -0800
Message-ID: <7vsji5jgtv.fsf@alter.siamese.dyndns.org>
References: <1329771217-9088-1-git-send-email-jehan@orb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net, peff@peff.net,
	jrnieder@gmail.com
To: Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbSF-0002OA-Dh
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 23:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab2BTWL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 17:11:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875Ab2BTWL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 17:11:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A0177B90;
	Mon, 20 Feb 2012 17:11:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oB4HRwJ7/8igT35Bg6PqI4kdxcQ=; b=BKLaZK
	LrxwzuSPpgWlATJeDmWntttA05MLdxeaTz9J186L00hBBzEB/HCqKl6ueeN6ySkF
	g3NrfORPHZrdSAy/m6kHzfF/SF0PdjEKzB22yp5tGDhZG8chRDSuWXvxcxaJIC79
	U80ZKUXfBEcgSQKYlCNFevdt4g/rUxX17fzvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NR6xD/joZCYILQhIQIMC0zSCiQXeehbR
	UCfImKwi2VxPXtbW7RXBI4LGcA/UFcBqdneK0hqXOKI6idXNKWyupnqD+vD1qr3j
	e+KRSoPctPFIb2sFuCeogBDTaU4Ps8qHMb0KMndWiVMmUvshblHibCR5vfiEklpj
	s+TztudeoF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4021B7B8F;
	Mon, 20 Feb 2012 17:11:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC17D7B8D; Mon, 20 Feb 2012
 17:11:25 -0500 (EST)
In-Reply-To: <1329771217-9088-1-git-send-email-jehan@orb.com> (Jehan Bing's
 message of "Mon, 20 Feb 2012 12:53:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D48C2EAE-5C0F-11E1-B676-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191121>

Jehan Bing <jehan@orb.com> writes:

> diff --git a/convert.c b/convert.c
> index c06309f..5d312cb 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -2,6 +2,7 @@
>  #include "attr.h"
>  #include "run-command.h"
>  #include "quote.h"
> +#include "sigchain.h"
>  
>  /*
>   * convert.c - convert a file when checking it out and checking it in.
> @@ -360,12 +361,16 @@ static int filter_buffer(int in, int out, void *data)
>  	if (start_command(&child_process))
>  		return error("cannot fork to run external filter %s", params->cmd);
>  
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
>  	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
>  	if (close(child_process.in))
>  		write_err = 1;
>  	if (write_err)
>  		error("cannot feed the input to external filter %s", params->cmd);
>  
> +	sigchain_pop(SIGPIPE);
> +

Thanks.

I think this is OK on a POSIX system where this function is run by
start_async() which is implemented with a forked child process.

I do not now if it poses a issue on Windows, though.  Johannes, any
comments?
