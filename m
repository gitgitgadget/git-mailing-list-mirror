From: Mike Miller <mtmiller@ieee.org>
Subject: Re: [PATCH] imap-send: Support SSL using GnuTLS
Date: Tue, 09 Nov 2010 21:16:56 -0500
Message-ID: <1289355416.3762.67.camel@tesla>
References: <AANLkTim=hL6ONwu1i+xN=N0vJaF21g5PSj5wdjqoEm5c@mail.gmail.com>
	 <20101109150941.GD18960@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 03:17:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG0FJ-00082f-O3
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 03:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159Ab0KJCRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 21:17:04 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49517 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab0KJCRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 21:17:01 -0500
Received: by gxk23 with SMTP id 23so72670gxk.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 18:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=n5hDUWMY9xT/Ro161KfWH4B9cCnrGdjnNYXf4t7rIVs=;
        b=RSKLhpRbyTwLwo1Cntexd2uO6p1nZZdVG6RJScQDFemRBFtkbAoIppwaTWvvkdAzw9
         Un66kH8rOPr8q1svPhscgfjO49PeF/jPIXRhktJO1YsjjlU2i333hrn/HZFcWC2IcSe4
         zshjtkhUl5KJBLsULHlrfH7lqvGx7LXx6qdQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Dz8WJGhj0iOrx6eCfyP96hwWmDowxWyc1K7FHXE+S1dIIOv9usyuZCSVrRjs9Zs/wm
         b/OY3pJhJDV2L9Qfepw3/luKqBKCSOHYONl9kHYXV8WgTNokwvMe/PUma6gaEHmkIY5j
         rMsb7bnPzG42JljpPmCWFtmV+Gn9cxsI5+2xs=
Received: by 10.150.189.18 with SMTP id m18mr11963836ybf.171.1289355420338;
        Tue, 09 Nov 2010 18:17:00 -0800 (PST)
Received: from [192.168.1.100] (ip70-187-237-171.dc.dc.cox.net [70.187.237.171])
        by mx.google.com with ESMTPS id q4sm1142487yba.14.2010.11.09.18.16.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 18:16:58 -0800 (PST)
In-Reply-To: <20101109150941.GD18960@burratino>
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161123>

Hi Jonathan, thanks for the feedback and newb counseling, this is my
first attempt at a git contribution.

On Tue, 2010-11-09 at 09:09 -0600, Jonathan Nieder wrote: 
> 
> Mike Miller wrote:
> 
> > However, GnuTLS does not provide equivalents to the base64 and md5
> > routines needed for CRAM-MD5 authentication.
> 
> Mm, that feels like it should be a separate patch.  It could be useful
> when not using an SSL lib at all.
> 
> Maybe the base64 routine could share some code with base85.c?  (Just
> a thought.)

Fair enough.  That's a better division grouping functionality with
library dependencies, as gcrypt is needed for CRAM-MD5 and gnutls for
SSL socket layer.

> > When compiling, GnuTLS is only used when NO_OPENSSL is defined.
> > ---
> 
> Sign-off?  (See Documentation/SubmittingPatches for what I'm talking
> about.)

rtfm, got it :)

> 
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -24,6 +24,9 @@ all::
> >  # Define NO_OPENSSL environment variable if you do not have OpenSSL.
> >  # This also implies BLK_SHA1.
> >  #
> > +# Define NO_GNUTLS if you do not have gnutls installed.  gnutls provides
> > +# SSL when OpenSSL is not used.
> > +#
> 
> Shouldn't this say "if NO_OPENSSL is defined and you do not have GnuTLS
> installed"?

Sounds good.

> > @@ -1244,8 +1247,21 @@ ifndef NO_OPENSSL
> >  else
> >  	BASIC_CFLAGS += -DNO_OPENSSL
> >  	BLK_SHA1 = 1
> > +ifndef NO_GNUTLS
> > +	OPENSSL_LIBSSL = -lgnutls-openssl -lgnutls -lgcrypt
> 
> Probably should be indented another level to convey structure.

Yes.

> > +	ifdef GNUTLSDIR
> > +		BASIC_CFLAGS += -I$(GNUTLSDIR)/include
> > +		OPENSSL_LINK = -L$(GNUTLSDIR)/$(lib) $(CC_LD_DYNPATH)$(GNUTLSDIR)/$(lib)
> > +	else
> > +		OPENSSL_LINK =
> > +	endif
> > +	LIB_OBJS += gnutls-base64.o gcrypt-hmac.o
> > +	LIB_H += gnutls-base64.h gcrypt-hmac.h
> 
> This causes all git commands to link to base64 and hmac routines.
> Maybe you meant for them to be linked in to imap-send only?  See
> http.o for an example of this kind of thing.

Right again.

> [...]
> > --- /dev/null
> > +++ b/gcrypt-hmac.c
> > @@ -0,0 +1,41 @@
> > +/*
> > + * gcrypt-hmac.c - interface wrapper to provide OpenSSL HMAC API using gcrypt.
> 
> Maybe this could be useful for inclusion in gcrypt?
> 
> In git, it might make sense to treat these as routines for compat/,
> kind of like compat/basename.c.

As I was working through this part I was debating whether these should
be in a separate file, where to put them, etc.  Compat looked like it
was mostly libc-type functions so I stayed out of there.

Deferring this to gcrypt to handle sounds like a great idea.

> > --- /dev/null
> > +++ b/gnutls-base64.c
> > @@ -0,0 +1,197 @@
> > +/*
> > + * gnutls-base64.c - base64 encode and decode
> > + *                   adapted from GnuTLS, original copyright follows
> 
> Why is this needed?

gnutls has generic base64 encode/decode routines but they are not
exported as callable symbols.  The only callable base64 routines in
gnutls are specific to PEM encoding/decoding.  There are so many base64
implementations out there but I don't know of any that are in the public
API of a relatively common library.  Other than openssl.  I'm open to
suggestions.

Or as you suggested above, merge with base85.c.

Another alternative would be, as with gcrypt, request gnutls to export
the base64 encode/decode functions, and provide an openssl compatible
interface while we're at it.

> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -26,10 +26,19 @@
> >  #include "exec_cmd.h"
> >  #include "run-command.h"
> >  #ifdef NO_OPENSSL
> > +#ifdef NO_GNUTLS
> >  typedef void *SSL;
> >  #else
> > +#include <gnutls/openssl.h>
> > +#include "gnutls-base64.h"
> > +#include "gcrypt-hmac.h"
> > +#undef NO_OPENSSL /* gnutls is providing an openssl API */
> > +#define SSL_VERIFY_PEER 1 /* doesn't matter */
> 
> If it doesn't matter, why set it?  (I assume it does matter but that
> its value is unimportant. ;-))

Something like that.

> > +#endif
> > +#else
> >  #include <openssl/evp.h>
> >  #include <openssl/hmac.h>
> > +#define USE_OPENSSL_REAL 1
> >  #endif
> 
> Nit: this means something like "SSL_IS_OPENSSL", right?
> 
> i.e., it is not actually a request "use such-and-such" but a
> statement of fact "using such-and-such".

Yeah, I think I changed that one back and forth.  At one point I had
changed all "NO_OPENSSL"s to "NO_OPENSSL_API" but I switched back to
minimize the changes and went with this check for the
SSL_CTX_set_default_verify_paths when that ended up being the only
difference.

> > @@ -307,9 +316,9 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
> >  	SSL_load_error_strings();
> >  
> >  	if (use_tls_only)
> > -		meth = TLSv1_method();
> > +		meth = TLSv1_client_method();
> >  	else
> > -		meth = SSLv23_method();
> > +		meth = SSLv23_client_method();
> 
> Is there a semantic difference?  Will old versions of OpenSSL
> continue to work (I assume so, but...)?

Yeah I honestly don't know enough about it to be boldly making that
change.  This could be conditional for gnutls, which only provides
X_client_method and X_server_method but not X_method, which I suppose
can act as either end of the connection?

> > @@ -321,10 +330,12 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
> >  	if (verify)
> >  		SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
> >  
> > +#ifdef USE_OPENSSL_REAL
> >  	if (!SSL_CTX_set_default_verify_paths(ctx)) {
> >  		ssl_socket_perror("SSL_CTX_set_default_verify_paths");
> >  		return -1;
> >  	}
> > +#endif
> 
> Why?  Could this be accomplished with a
> 
> #ifndef USE_OPENSSL_REAL
> 	static inline int SSL_CTX_set_default_verify_paths(...
> 	{
> 		/* Not needed by GnuTLS */
> 		return 0;
> 	}
> #endif
> 
> wrapper?

Looks good.

> >  	sock->ssl = SSL_new(ctx);
> >  	if (!sock->ssl) {
> >  		ssl_socket_perror("SSL_new");
> > @@ -371,9 +382,19 @@ static int socket_write(struct imap_socket *sock, const char *buf, int len)
> >  {
> >  	int n;
> >  #ifndef NO_OPENSSL
> > -	if (sock->ssl)
> > -		n = SSL_write(sock->ssl, buf, len);
> > -	else
> > +	if (sock->ssl) {
> > +		/* loop based on write_in_full, the gnutls implementation of
> > +		 * SSL_write may write a partial buffer. */
> > +		int count = len;
> > +		n = 0;
> > +		while (count > 0) {
> > +			int written = SSL_write(sock->ssl, buf, count);
> > +			if (written <= 0) break;
> > +			count -= written;
> > +			buf += written;
> > +			n += written;
> > +		}
> > +	} else
> 
> Probably a wrapper function would be nicer.

Amusingly enough, the need for this loop only showed up as the patches I
was testing with started to get longer...

Looking at it now I think it would be better to fix this in gnutls,
since the SSL_write manpage does state that the data will always be
written in full.

Thanks again, I'm looking forward to some more comments on this.  I'll
refine it some more, but it's starting to look like we may need some
features added to both gcrypt and gnutls before this can be done
cleanly.  I'm definitely willing to pull out the relevant parts and
forward them to the respective projects to keep this moving.

-- 
mike :: mtmiller at ieee dot org
