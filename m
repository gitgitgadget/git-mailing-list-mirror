From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Make 'configure --with-expat=path' actually
 work
Date: Wed, 28 Jan 2009 11:13:40 -0800
Message-ID: <7vocxrqm57.fsf@gitster.siamese.dyndns.org>
References: <alpine.BSF.2.00.0901251938120.97940@toad.stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Serge van den Boom <svdb@stack.nl>
X-From: git-owner@vger.kernel.org Wed Jan 28 20:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSFsY-0008SE-EW
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 20:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbZA1TNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 14:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbZA1TNs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 14:13:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZA1TNs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 14:13:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C45DB944FD;
	Wed, 28 Jan 2009 14:13:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 873A2944FB; Wed,
 28 Jan 2009 14:13:42 -0500 (EST)
In-Reply-To: <alpine.BSF.2.00.0901251938120.97940@toad.stack.nl> (Serge van
 den Boom's message of "Sun, 25 Jan 2009 20:24:41 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C8DA8022-ED6F-11DD-B9CB-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107566>

Serge van den Boom <svdb@stack.nl> writes:

> The prefix specified with the --with-expat option of configure was not
> actually used.

I see configure.ac already has support for autodetection but I realized it
only after running "git grep EXPATDIR".  "Even though the configure script
knows how to autodetect presence of the expat library and set EXPATDIR to
the prefix of the location it was found, the Makefile ignored it and only
honoured NO_EXPAT" might have been a better way to describe the breakage
the patch fixes.

If you look at the Makefile, you will notice a sequence of comments like
this:

    # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
    # git-http-push are not built, and you cannot use http:// and https://
    # transports.
    #
    # Define CURLDIR=/foo/bar if your curl header and library files are in
    # /foo/bar/include and /foo/bar/lib directories.
    #

Please add one for EXPATDIR, just after "Define NO_EXPAT if ...".  People
who do not run ./configure but add their own customizations in config.mak
should benefit from your patch as well.

You might want to add a logic to drop NO_EXPAT when EXPATDIR is specified
to the Makefile as well, but I didn't check.

Please do *not* send a patch in 'text/plain; format="flowed"' content-type.
You will get a whitespace mangled patch that I have to fix up by hand.

Thanks.

> Signed-off-by: Serge van den Boom <svdb@stack.nl>
> ---
> diff --git a/Makefile b/Makefile
> index b4d9cb4..e7218cb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -849,7 +849,12 @@ else
>  		endif
>  	endif
>  	ifndef NO_EXPAT
> -		EXPAT_LIBEXPAT = -lexpat
> +		ifdef EXPATDIR
> +			BASIC_CFLAGS += -I$(EXPATDIR)/include
> +			EXPAT_LIBEXPAT = -L$(EXPATDIR)/$(lib) $(CC_LD_DYNPATH)$(EXPATDIR)/$(lib) -lexpat
> +		else
> +			EXPAT_LIBEXPAT = -lexpat
> +		endif
>  	endif
>  endif
