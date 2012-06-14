From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove the impression of unexpectedness when access is
 denied
Date: Thu, 14 Jun 2012 10:11:10 -0700
Message-ID: <7v395xg6oh.fsf@alter.siamese.dyndns.org>
References: <20120610182310.GB2427@book.hvoigt.net>
 <20120611190207.GA20889@sigill.intra.peff.net>
 <20120614071259.GA51076@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 19:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfDZn-0006SB-0F
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 19:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab2FNRLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 13:11:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60806 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037Ab2FNRLN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 13:11:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB138144;
	Thu, 14 Jun 2012 13:11:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=134A68mERiMsGDGLUSy5Re0TnC0=; b=tl9xg7
	02YadVa7ApUsWvi5TFeHunnsN251+y1xJUfZCfDZEDkeqYYEaD3uP6vCdoSSpjOc
	hNsBVNI4c1ipOEFP2cAXbCxs0iiIQnFhDGmJrPAHs2KxkELFZCOw5EhyEMCwnzUV
	jvTWhcPrJUPuhwQOm6DFkE2k+Qi7NZnJd+AA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T8YSs+eos0G2vskHdT/37cLZX+bFx8Zl
	FAbh44vwbZSqcLkuO+pICva+xcqWGOLCoI+UqJlosGiepPWoiUhj3JSen0CxONrz
	Qv+NJ6XKJCwcuZAZFVJ0fL6VZh2WYYZL7SnADn2iBUz7fqZh+bSnsN1RWjovdDuH
	TMI2mQG33tU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A27AF8143;
	Thu, 14 Jun 2012 13:11:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0A3D8140; Thu, 14 Jun 2012
 13:11:11 -0400 (EDT)
In-Reply-To: <20120614071259.GA51076@book.hvoigt.net> (Heiko Voigt's message
 of "Thu, 14 Jun 2012 09:13:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0F268F4-B643-11E1-A676-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200019>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/connect.c b/connect.c
> index 912cdde..19e73d5 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -56,6 +56,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
>  			      unsigned int flags,
>  			      struct extra_have_objects *extra_have)
>  {
> +	int got_at_least_one_head = 0;
> +
>  	*list = NULL;
>  	for (;;) {
>  		struct ref *ref;
> @@ -64,7 +66,14 @@ struct ref **get_remote_heads(int in, struct ref **list,
>  		char *name;
>  		int len, name_len;
>  
> -		len = packet_read_line(in, buffer, sizeof(buffer));
> +		len = packet_read_line(in, buffer, sizeof(buffer), 1);
> +		if (len < 0) {
> +			if (got_at_least_one_head)
> +				die("The remote end hung up unexpectedly");
> +			else
> +				die("Could not read remote heads");
> +		}

I do not think it is particularly interesting to know we have (or
haven't) read one packet before we got an error. It would be an
improvement if the message lets the user know at what stage of the
exchange the remote threw you a garbage, but using the same "The
remote end hung up unexpectedly" as all the other packet_read_line()
errors show makes it less useful.

How about getting rid of the new boolean variable and say

	len = packet_read(in, buffer, sizeof(buffer));
        if (len < 0)
		die("The remote end hung up upon initial contact");

or something?

>  		if (!len)
>  			break;
>  		if (buffer[len-1] == '\n')
> @@ -95,6 +104,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
>  		hashcpy(ref->old_sha1, old_sha1);
>  		*list = ref;
>  		list = &ref->next;
> +		got_at_least_one_head = 1;
>  	}
>  	return list;
>  }

It seems that all callers other than this one after this patch
behave identically as before like this patch. It would be far more
preferable to introduce a new function that does not die on errors
(including but not necessarily limited to short read situation you
are interested in this patch), and update this caller that wants to
handle these error cases to call that new function.  Perhaps

	len = packet_read(in, buffer, sizeof(buffer));

that returns negative error numbers when it sees an error, with

	#define PKTREAD_UNKNOWN_ERROR (-1)
        #define PKTREAD_SHORT_READ (-2)
        ...

and then over time we should consider converting remaining callers
of packet_read_line() to packet_read().
