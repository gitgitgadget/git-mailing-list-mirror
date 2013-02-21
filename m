From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Infinite make recursion when configure.ac changes
Date: Wed, 20 Feb 2013 23:59:09 -0800
Message-ID: <7vbobew10y.fsf@alter.siamese.dyndns.org>
References: <51248D0A.50603@gmail.com>
 <20130221060401.GC25943@sigill.intra.peff.net>
 <7vk3q2w61p.fsf@alter.siamese.dyndns.org>
 <20130221062614.GA8827@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 08:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8R45-0008HL-2b
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 08:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab3BUH7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 02:59:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab3BUH7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 02:59:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 725BF865C;
	Thu, 21 Feb 2013 02:59:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kdhsqr3E2C9gP9lmE80o47Dmlv0=; b=Aw2d0D
	XCyt06Ql8P5XgXmYyVbMsAlwYSLQTJ1brh8tJrDMD3+CkcFXGIpqxMVfMH+BJrCA
	G8/x/eXtTg/Vdx/C8tgab0SjqNbkVrk6uyV0tmceJO7+sKOnW48IaHXUt7wyIhJS
	sdDP0/qot2+MqhXqN4fjDQAleqjsp7LDN+NhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fMs85+fM7kTN2TBIfh96NMR4SkWdb9x0
	8u1ype4BBfEeVSyWpHBsYVFNoPhM+0XZ3cHyg8o5flCTozuARTk6Hg8qe6Of9EGU
	rqdL6x8B7gqjWbLOVe3DZZcYpEDTvPbn0DpoCeu30SgyqZliRBO6W5u7KbGqf6YG
	PZ4he4Gkgkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6728C865B;
	Thu, 21 Feb 2013 02:59:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE2F38657; Thu, 21 Feb 2013
 02:59:10 -0500 (EST)
In-Reply-To: <20130221062614.GA8827@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 21 Feb 2013 01:26:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9345136C-7BFC-11E2-86F8-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216759>

Jeff King <peff@peff.net> writes:

> Anyway, here is the patch to fix the loop.
>
> -- >8 --
> Subject: [PATCH] Makefile: avoid infinite loop on configure.ac change
>
> If you are using autoconf and change the configure.ac, the
> Makefile will notice that config.status is older than
> configure.ac, and will attempt to rebuild and re-run the
> configure script to pick up your changes. The first step in
> doing so is to run "make configure". Unfortunately, this
> tries to include config.mak.autogen, which depends on
> config.status, which depends on configure.ac; so we must
> rebuild config.status. Which leads to us running "make
> configure", and so on.
>
> It's easy to demonstrate with:
>
>   make configure
>   ./configure
>   touch configure.ac
>   make
>
> We can break this cycle by not re-invoking make to build
> "configure", and instead just putting its rules inline into
> our config.status rebuild procedure.  We can avoid a copy by
> factoring the rules into a make variable.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thanks.  This needs to go to both v1.8.1.x and v1.8.2.

Will apply.

>  Makefile | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 3b2c92c..ee1c0b0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1871,12 +1871,14 @@ configure: configure.ac GIT-VERSION-FILE
>  	mv $@+ $@
>  endif # NO_PYTHON
>  
> +CONFIGURE_RECIPE = $(RM) configure configure.ac+ && \
> +		   sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
> +			configure.ac >configure.ac+ && \
> +		   autoconf -o configure configure.ac+ && \
> +		   $(RM) configure.ac+
> +
>  configure: configure.ac GIT-VERSION-FILE
> -	$(QUIET_GEN)$(RM) $@ $<+ && \
> -	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
> -	    $< > $<+ && \
> -	autoconf -o $@ $<+ && \
> -	$(RM) $<+
> +	$(QUIET_GEN)$(CONFIGURE_RECIPE)
>  
>  ifdef AUTOCONFIGURED
>  # We avoid depending on 'configure' here, because it gets rebuilt
> @@ -1885,7 +1887,7 @@ config.status: configure.ac
>  # do want to recheck when the platform/environment detection logic
>  # changes, hence this depends on configure.ac.
>  config.status: configure.ac
> -	$(QUIET_GEN)$(MAKE) configure && \
> +	$(QUIET_GEN)$(CONFIGURE_RECIPE) && \
>  	if test -f config.status; then \
>  	  ./config.status --recheck; \
>  	else \
