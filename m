From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-imap-send: Add support for SSL.
Date: Sun, 22 Jun 2008 13:41:52 -0700
Message-ID: <7vej6pmcbz.fsf@gitster.siamese.dyndns.org>
References: <1096648c0806010829n71de92dcmc19ddb87da19931d@mail.gmail.com>
 <20080622152747.77a0baee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alam Arias <Alam.GBC@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 22:42:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAWOl-0007sY-UO
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 22:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbYFVUmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 16:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYFVUmA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 16:42:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbYFVUl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 16:41:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 381034083;
	Sun, 22 Jun 2008 16:41:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BD0964080; Sun, 22 Jun 2008 16:41:54 -0400 (EDT)
In-Reply-To: <20080622152747.77a0baee@gmail.com> (Alam Arias's message of
 "Sun, 22 Jun 2008 15:27:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A881BF24-409B-11DD-8415-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85800>

Alam Arias <Alam.GBC@gmail.com> writes:

> Allow SSL to be used when a new config setting, imap.ssl, is set to
> true.
>
> Also, automatically use TLS when imap.ssl is not set by using the IMAP
> STARTTLS command, if the server supports it.
>
> Tested with Courier and Gimap IMAP servers.
>
> Signed-off-by: Robert Shearman <robertshearman@gmail.com>
> ---
>  Documentation/git-imap-send.txt |    1 +
>  Makefile                        |    4 +-
>  imap-send.c                     |  163
> +++++++++++++++++++++++++++++++++++---- 3 files changed, 152
> insertions(+), 16 deletions(-)
>

Next time please do _not_ attach *.diff but follow the style of patch
submission other people do (see recent patch from Linus for example).

> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index f4fdc24..ecf2958 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -41,6 +41,7 @@ configuration file (shown with examples):
>      User = bob
>      Pass = pwd
>      Port = 143
> +    Ssl  = false
>  ..........................

This is "start talking plain imap to the standard imap port and then say
STARTTLS to start SSL", not "imap over ssl (aka imaps = 993/tcp)", right?

Is support for the latter (1) widely needed, and/or (2) easy to add on top
of this?  I presume the latter would use imaps:// URL scheme (in which
case the user does not need an extra config)?

> diff --git a/Makefile b/Makefile
> index 6a31c9f..0bd18fa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1157,7 +1157,9 @@ endif
>  git-%$X: %.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  
> -git-imap-send$X: imap-send.o $(LIB_FILE)
> +git-imap-send$X: imap-send.o $(GITLIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)

This looks enough to make it link both with and without NO_OPENSSL, but
has it actually been tested with both configurations?

> diff --git a/imap-send.c b/imap-send.c
> index 1ec1310..7c95c5c 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -225,19 +235,104 @@ static const char *Flags[] = {
>  	"Deleted",
>  };
>  
> +#ifndef NO_OPENSSL
> +static void
> +ssl_socket_perror( const char *func )
> +{
> +	fprintf( stderr, "%s: %s\n", func, ERR_error_string(ERR_get_error(), 0));
> +}
> +#endif

The original code has tons of style violations like this, but please do
not introduce more of them.  I'd even like a follow-up patch after this
one to clean up the style of existing code (you can choose to do the other
way around, first clean up the style of existing code without adding
anything new, and then this patch without the style violations).

 * function name in definition does not start a new line, but follows its
   return type on the same line;

 * open and close parentheses for function parameter list and argument
   list are not followed/preceded by any space;

>  static void
>  socket_perror( const char *func, Socket_t *sock, int ret )
>  {
> -	if (ret < 0)
> -		perror( func );
> +#ifndef NO_OPENSSL
> +	if (sock->ssl) {
> +		int sslerr = SSL_get_error( sock->ssl, ret );
> +		switch (sslerr) {
> +			case SSL_ERROR_NONE:
> +				break;
> +			case SSL_ERROR_SYSCALL:
> +				perror( "SSL_connect" );
> +				break;
> +			default:
> +				ssl_socket_perror( "SSL_connect" );
> +				break;
> +		}

 * "case" arms of switch statement align with "switch" without extra
   indentation;

> +	/* FIXME! Add a config option for this */
> +	if (0)
> +		SSL_CTX_set_verify( ctx, SSL_VERIFY_PEER, NULL );

Indeed ;-).

> +	if (!SSL_CTX_set_default_verify_paths( ctx )) {
> +		ssl_socket_perror( "SSL_CTX_set_default_verify_paths" );
> +		return 1;
> +	}
> +	sock->ssl = SSL_new( ctx );
> +	if (!sock->ssl) {
> +		ssl_socket_perror( "SSL_new" );
> +		return 1;
> +	}

 * We usually signal error by returning negative (e.g. -1) unless there
   otherwise a reason not to.

> @@ -1014,7 +1142,10 @@ imap_open_store( imap_server_conf_t *srvc )
>  			fprintf( stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host );
>  			goto bail;
>  		}
> -		imap_warn( "*** IMAP Warning *** Password is being sent in the clear\n" );
> +#ifndef NO_OPENSSL
> +		if (!imap->buf.sock.ssl)
> +#endif

Hmm.  If NO_OPENSSL compilation had ".ssl" member that is a dummy "int" or
something, you can use this ifndef and it might make it easier to read.
