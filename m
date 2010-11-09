From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] imap-send: Support SSL using GnuTLS
Date: Tue, 9 Nov 2010 09:09:41 -0600
Message-ID: <20101109150941.GD18960@burratino>
References: <AANLkTim=hL6ONwu1i+xN=N0vJaF21g5PSj5wdjqoEm5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Miller <mtmiller@ieee.org>
X-From: git-owner@vger.kernel.org Tue Nov 09 16:10:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFppl-0004Bp-7f
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 16:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab0KIPJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 10:09:59 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37063 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0KIPJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 10:09:58 -0500
Received: by pzk28 with SMTP id 28so1280755pzk.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tNVQKiAhloZ7wFn6gqw8ua8AhgOlEFQj8uO/yOdM/V0=;
        b=MaxBsXRr60rJ6+DbDtpXppO2w+bI5W0bnrZbwWuQJ+b5T+hA/IFSaUB5+c1DNYBp+C
         uu384OybqZUjVQf7AdZutfkCw0vW7EtDjR7Y2atIkXi39Fcz83YLdP5yDIEuMamxko/4
         VuUKXcO9xGr/Ad3GL5PsC4HkcpbgQmLFpphaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pR88m7OgqgR0D8BhlC7UpKKVjSPztneF2HpkBwMzG19Eit1F2FU7Ry7wr0l0TOmymh
         Q8O97JlsiAu/MYh63xZAokugQzGp99YLMU41EOI2O3AWUTs73Z/m52Zx4MdeNLF1JnNZ
         xjpDxVNBpstv1aFFjb7aHL0eA7pLF13oKBot8=
Received: by 10.142.240.15 with SMTP id n15mr5887398wfh.380.1289315397710;
        Tue, 09 Nov 2010 07:09:57 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id i2sm369313vcs.33.2010.11.09.07.09.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 07:09:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim=hL6ONwu1i+xN=N0vJaF21g5PSj5wdjqoEm5c@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161053>

Hi Mike,

Mike Miller wrote:

> GnuTLS is an LGPL alternative to OpenSSL, required for IMAP over SSL
> support on Debian.
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=434599
> 
> This patch uses the OpenSSL compatibility library of GnuTLS for the same
> behavior with minimal differences.

That's awesome.  Just as a quality-of-implementation issue, it is good
to be able to handle multiple backends so we can be sure we are not
relying on tiny implementation details.

> However, GnuTLS does not provide equivalents to the base64 and md5
> routines needed for CRAM-MD5 authentication.

Mm, that feels like it should be a separate patch.  It could be useful
when not using an SSL lib at all.

Maybe the base64 routine could share some code with base85.c?  (Just
a thought.)

> When compiling, GnuTLS is only used when NO_OPENSSL is defined.
> ---

Sign-off?  (See Documentation/SubmittingPatches for what I'm talking
about.)

> --- a/Makefile
> +++ b/Makefile
> @@ -24,6 +24,9 @@ all::
>  # Define NO_OPENSSL environment variable if you do not have OpenSSL.
>  # This also implies BLK_SHA1.
>  #
> +# Define NO_GNUTLS if you do not have gnutls installed.  gnutls provides
> +# SSL when OpenSSL is not used.
> +#

Shouldn't this say "if NO_OPENSSL is defined and you do not have GnuTLS
installed"?

> @@ -1244,8 +1247,21 @@ ifndef NO_OPENSSL
>  else
>  	BASIC_CFLAGS += -DNO_OPENSSL
>  	BLK_SHA1 = 1
> +ifndef NO_GNUTLS
> +	OPENSSL_LIBSSL = -lgnutls-openssl -lgnutls -lgcrypt

Probably should be indented another level to convey structure.

> +	ifdef GNUTLSDIR
> +		BASIC_CFLAGS += -I$(GNUTLSDIR)/include
> +		OPENSSL_LINK = -L$(GNUTLSDIR)/$(lib) $(CC_LD_DYNPATH)$(GNUTLSDIR)/$(lib)
> +	else
> +		OPENSSL_LINK =
> +	endif
> +	LIB_OBJS += gnutls-base64.o gcrypt-hmac.o
> +	LIB_H += gnutls-base64.h gcrypt-hmac.h

This causes all git commands to link to base64 and hmac routines.
Maybe you meant for them to be linked in to imap-send only?  See
http.o for an example of this kind of thing.

On the other hand, see below...

[...]
> --- /dev/null
> +++ b/gcrypt-hmac.c
> @@ -0,0 +1,41 @@
> +/*
> + * gcrypt-hmac.c - interface wrapper to provide OpenSSL HMAC API using gcrypt.

Maybe this could be useful for inclusion in gcrypt?

In git, it might make sense to treat these as routines for compat/,
kind of like compat/basename.c.

> --- /dev/null
> +++ b/gnutls-base64.c
> @@ -0,0 +1,197 @@
> +/*
> + * gnutls-base64.c - base64 encode and decode
> + *                   adapted from GnuTLS, original copyright follows

Why is this needed?

> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -26,10 +26,19 @@
>  #include "exec_cmd.h"
>  #include "run-command.h"
>  #ifdef NO_OPENSSL
> +#ifdef NO_GNUTLS
>  typedef void *SSL;
>  #else
> +#include <gnutls/openssl.h>
> +#include "gnutls-base64.h"
> +#include "gcrypt-hmac.h"
> +#undef NO_OPENSSL /* gnutls is providing an openssl API */
> +#define SSL_VERIFY_PEER 1 /* doesn't matter */

If it doesn't matter, why set it?  (I assume it does matter but that
its value is unimportant. ;-))

> +#endif
> +#else
>  #include <openssl/evp.h>
>  #include <openssl/hmac.h>
> +#define USE_OPENSSL_REAL 1
>  #endif

Nit: this means something like "SSL_IS_OPENSSL", right?

i.e., it is not actually a request "use such-and-such" but a
statement of fact "using such-and-such".

> @@ -307,9 +316,9 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
>  	SSL_load_error_strings();
>  
>  	if (use_tls_only)
> -		meth = TLSv1_method();
> +		meth = TLSv1_client_method();
>  	else
> -		meth = SSLv23_method();
> +		meth = SSLv23_client_method();

Is there a semantic difference?  Will old versions of OpenSSL
continue to work (I assume so, but...)?

> @@ -321,10 +330,12 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
>  	if (verify)
>  		SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
>  
> +#ifdef USE_OPENSSL_REAL
>  	if (!SSL_CTX_set_default_verify_paths(ctx)) {
>  		ssl_socket_perror("SSL_CTX_set_default_verify_paths");
>  		return -1;
>  	}
> +#endif

Why?  Could this be accomplished with a

#ifndef USE_OPENSSL_REAL
	static inline int SSL_CTX_set_default_verify_paths(...
	{
		/* Not needed by GnuTLS */
		return 0;
	}
#endif

wrapper?

>  	sock->ssl = SSL_new(ctx);
>  	if (!sock->ssl) {
>  		ssl_socket_perror("SSL_new");
> @@ -371,9 +382,19 @@ static int socket_write(struct imap_socket *sock, const char *buf, int len)
>  {
>  	int n;
>  #ifndef NO_OPENSSL
> -	if (sock->ssl)
> -		n = SSL_write(sock->ssl, buf, len);
> -	else
> +	if (sock->ssl) {
> +		/* loop based on write_in_full, the gnutls implementation of
> +		 * SSL_write may write a partial buffer. */
> +		int count = len;
> +		n = 0;
> +		while (count > 0) {
> +			int written = SSL_write(sock->ssl, buf, count);
> +			if (written <= 0) break;
> +			count -= written;
> +			buf += written;
> +			n += written;
> +		}
> +	} else

Probably a wrapper function would be nicer.

Thanks for a clean patch.

Hope that helps,
Jonathan
