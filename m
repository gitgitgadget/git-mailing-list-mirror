From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/4] usage: make error functions a stack
Date: Tue, 15 Jul 2014 15:47:47 -0700
Message-ID: <xmqq7g3etf1o.fsf@gitster.dls.corp.google.com>
References: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
	<1405459754-4220-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 00:48:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7BVw-0004uE-FP
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 00:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbaGOWr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 18:47:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60394 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbaGOWrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 18:47:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 152B829679;
	Tue, 15 Jul 2014 18:47:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rVHBmu4VWJXjqPgKdKqqKjEw9L0=; b=n7r/FA
	tfZn+WcRfWan7CEavGIjSXE+EXWnWjmufMhfkGINHpq06ZHRH5rGfWTnxUj0c4N0
	yS1DGQCwEC0rLrrsLfUHkGoqscRsrAV8z8AHtvO++u70rWwp/dExU1eFjEMQ4U8U
	Z9TRo0iFsuciA7/lP9RMO/XiTWSawFR+6OAUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hcMJ/i7JSpDNPx/0T7om6HzzVRRTa1yH
	TiArStRhcJsXBfXlHAflLImQWDOnjdMrVKdQQpHm7sdoOMiPDxwGSzZ10vupL0rk
	aFE0C76azFcGOSkYLN7p+annwRCEEOStHZPQqILAwKebncFzuL7WeTj9WsmejrMt
	XHFOsq0u/6o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0ACD629678;
	Tue, 15 Jul 2014 18:47:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3D37D29677;
	Tue, 15 Jul 2014 18:47:31 -0400 (EDT)
In-Reply-To: <1405459754-4220-2-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Tue, 15 Jul 2014 14:29:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 011F63E0-0C72-11E4-AC5D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253612>

Jacob Keller <jacob.e.keller@intel.com> writes:

>  extern void set_error_routine(void (*routine)(const char *err, va_list params));
> +extern void pop_error_routine(void);

pop that undoes set smells somewhat weird.  Perhaps we should rename
set to push?  That would allow us catch possible topics that add new
calls to set_error_routine() as well by forcing the system not to
link when they are merged without necessary fixes.

> +/* push error routine onto the error function stack */
>  void set_error_routine(void (*routine)(const char *err, va_list params))
>  {
> -	error_routine = routine;
> +	struct error_func_list *efl = xmalloc(sizeof(*efl));
> +	efl->func = routine;
> +	efl->next = error_funcs;
> +	error_funcs = efl;
> +}
> +
> +/* pop a single error routine off of the error function stack, thus reverting
> + * to previous error. Should always be paired with a set_error_routine */
> +void pop_error_routine(void)
> +{
> +	assert(error_funcs != &default_error_func);
> +
> +	struct error_func_list *efl = error_funcs;

decl-after-stmt.  Can be fixed easily by flipping the above two
lines.

> +	if (efl->next) {
> +		error_funcs = efl->next;
> +		free(efl);
> +	}
>  }
>  
>  void set_die_is_recursing_routine(int (*routine)(void))
> @@ -144,7 +167,7 @@ int error(const char *err, ...)
>  	va_list params;
>  
>  	va_start(params, err);
> -	error_routine(err, params);
> +	error_funcs->func(err, params);
>  	va_end(params);
>  	return -1;
>  }
