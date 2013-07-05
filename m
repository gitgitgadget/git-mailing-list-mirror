From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 5 Jul 2013 18:47:30 +0100
Message-ID: <20130705174730.GM9161@serenity.lan>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-3-git-send-email-artagnon@gmail.com>
 <20130705124536.GU862789@vauxhall.crustytoothpaste.net>
 <7vobag7wl0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 19:47:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvA6q-0005jS-5m
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 19:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988Ab3GERrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 13:47:47 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34690 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933597Ab3GERrp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 13:47:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D6A08CDA604;
	Fri,  5 Jul 2013 18:47:44 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bw5P7QIEDv7G; Fri,  5 Jul 2013 18:47:42 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 9CE5FCDA5DB;
	Fri,  5 Jul 2013 18:47:42 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 17643161E38C;
	Fri,  5 Jul 2013 18:47:41 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E5GNJmeoYz7D; Fri,  5 Jul 2013 18:47:38 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 09184161E3FB;
	Fri,  5 Jul 2013 18:47:32 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vobag7wl0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229670>

On Fri, Jul 05, 2013 at 10:20:11AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > You've covered the STARTTLS case, but not the SSL one right above it.
> > Someone using smtps on port 465 will still see the warning.  You can
> > pass SSL_verify_mode to Net::SMTP::SSL->new just like you pass it to
> > start_SSL.
> 
> OK, will a fix-up look like this on top of 1/2 and 2/2?

According to IO::Socket::SSL [1], if neither SSL_ca_file nor SSL_ca_path
is specified then builtin defaults will be used, so I wonder if we
should pass SSL_VERIFY_PEER regardless (possibly with a switch for
SSL_VERIFY_NONE if people really need that).

[1] http://search.cpan.org/~sullr/IO-Socket-SSL-1.951/lib/IO/Socket/SSL.pm

>  git-send-email.perl | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 52028ba..3b80340 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1093,6 +1093,25 @@ sub smtp_auth_maybe {
>  	return $auth;
>  }
>  
> +# Helper to come up with SSL/TLS certification validation params
> +# and warn when doing no verification
> +sub ssl_verify_params {
> +	use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
> +
> +	if (!defined $smtp_ssl_cert_path) {
> +		$smtp_ssl_cert_path = "/etc/ssl/certs";
> +	}
> +
> +	if (-d $smtp_ssl_cert_path) {
> +		return (SSL_verify_mode => SSL_VERIFY_PEER,
> +			SSL_ca_path => $smtp_ssl_cert_path);
> +	} else {
> +		print STDERR "warning: Using SSL_VERIFY_NONE.  " .
> +		    "See sendemail.smtpsslcertpath.\n";
> +		return (SSL_verify_mode => SSL_VERIFY_NONE);
> +	}
> +}
> +
