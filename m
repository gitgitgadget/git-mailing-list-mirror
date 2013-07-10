From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] wt-status: use "format" function attribute for status_printf
Date: Tue, 09 Jul 2013 22:26:04 -0700
Message-ID: <7vmwpvt28j.fsf@alter.siamese.dyndns.org>
References: <20130710001659.GA11643@sigill.intra.peff.net>
	<20130710002328.GC19423@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 07:26:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwmuu-0001Ww-T7
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 07:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab3GJF0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 01:26:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab3GJF0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 01:26:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD4B9271EC;
	Wed, 10 Jul 2013 05:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pO0eMVbCvwdNx1QWDg+mQRszYTY=; b=MnIfcD
	E2ZDGwh7V4gdE0MIJWUVJczt3gd5J8FhLmG0m8CX4KOoQDrYtJsfBmwpmjMorwHN
	taox8dvWbY+Z0OVsd1icPykADO8gZLiTWJF8wClhmb1vKigauS2oTpAVFlNRg5lB
	hhw8TKCxSZNOzHyVb1pgSUud4idg+zmoHlTCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LraiCIp7nogXwnWMjjNGLTDOqTNwVTrM
	pbW1lsZXewbbSY5g7DjtEOGoWHjQLoE2II+n5KJdOYGBbPQkPpNug3vgOQZMOfIA
	gbzg/ZClx9KCs4iTXRG5i98zI8552KfxD97UMMEdEWgaZNqh+xwXbOYYJfqusFLY
	HJfnAfaO3MQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B10F9271EA;
	Wed, 10 Jul 2013 05:26:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2629271E6;
	Wed, 10 Jul 2013 05:26:05 +0000 (UTC)
In-Reply-To: <20130710002328.GC19423@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jul 2013 20:23:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 382A5C98-E921-11E2-ABFE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230022>

Jeff King <peff@peff.net> writes:

> These functions could benefit from the added compile-time
> safety of having the compiler check printf arguments.
>
> Unfortunately, we also sometimes pass an empty format string,
> which will cause false positives with -Wformat-zero-length.
> In this case, that warning is wrong because our function is
> not a no-op with an empty format: it may be printing
> colorized output along with a trailing newline.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm torn on this one. It really does provide us with more compile-time
> safety checks, but it's annoying that "-Wall -Werror" will no longer
> work out of the box.

Yeah, that is a show-stopper for me X-<.

> We could also add a status_printf_empty_line() function, but that feels
> like a bit of a hack. Searching online, I also found the amusing
> suggestion to do:
>
>   status_printf_ln(s, color, "%.*s", 0,
>                    "-Wformat-zero-length please choke on a bucket of socks");
>
> but I think that is probably worse than adding a specialized function.
>
>  wt-status.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/wt-status.h b/wt-status.h
> index 4121bc2..fb7152e 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -96,9 +96,9 @@ void wt_porcelain_print(struct wt_status *s);
>  void wt_shortstatus_print(struct wt_status *s);
>  void wt_porcelain_print(struct wt_status *s);
>  
> -void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...)
> -	;
> -void status_printf(struct wt_status *s, const char *color, const char *fmt, ...)
> -	;
> +__attribute__((format (printf, 3, 4)))
> +void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...);
> +__attribute__((format (printf, 3, 4)))
> +void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
>  
>  #endif /* STATUS_H */
