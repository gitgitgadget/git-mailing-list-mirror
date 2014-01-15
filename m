From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Wed, 15 Jan 2014 11:26:41 -0800
Message-ID: <xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ruben Kerkhof <ruben@rubenkerkhof.com>
To: Igor Gnatenko <i.gnatenko.brain@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 20:26:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3W70-0006OS-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 20:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaAOT0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 14:26:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbaAOT0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 14:26:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB43C620F7;
	Wed, 15 Jan 2014 14:26:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=o9pRELqhF+DxwgHUvG6Gad/aBjY=; b=DfTJKEiD9sFdXaZ2hDMZ
	EgqOTkVO6dclsMb56/BTkDpL9MnVrJD0TDn/4o7Q00M2OnMeks4Rtdzl6oJevrAd
	oiKISZ1LFwFf+vXB0/DOZrxmevee5pTbllRbqI2t4vQlJCI4iiB/Z9NEwG3dXYQl
	Xn6Zm56vfCMxs/ZQWjguBIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=yIj1LUT2UMg2M6kie8jCGfsNQTvT5g6SAWs16W53vpJ/po
	x8Fb8NUOLtVWvN6EJjet1yYfKV3qdNMJZfLZCzut/OzrNZSv9EqnWdF3I8lYjDMR
	DqOEE6WvB5hnfAUA02rxpQovRURoHShATZnU09My7zqqyLTZEgp8dd87QDIt8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADACB620F6;
	Wed, 15 Jan 2014 14:26:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA272620F3;
	Wed, 15 Jan 2014 14:26:43 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F787E1DA-7E1A-11E3-BE8E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240474>

Igor Gnatenko <i.gnatenko.brain@gmail.com> writes:

> From: Ruben Kerkhof <ruben@rubenkerkhof.com>
>
> I use gmail for sending patches.
> If I have the following defined in my ~/.gitconfig:
> [sendemail]
> 	smtpencryption = tls
> 	smtpserver = smtp.gmail.com
> 	smtpuser = ruben@rubenkerkhof.com
> 	smtpserverport = 587
>
> and try to send a patch, this fails with:
> STARTTLS failed! SSL connect attempt failed with unknown error
> error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate
> verify failed at /usr/libexec/git-core/git-send-email line 1236.

... because?  Is it because the cert_path on your platform is
different from /etc/ssl/certs?  What platform was this anyway?

I see in the original discussion in your bugzilla entry that
"/etc/ssl/certs/" _is_ your ssl cert directory, but I wonder why
then this part of the existing codepath does not work for you:

	if (!defined $smtp_ssl_cert_path) {
		$smtp_ssl_cert_path = "/etc/ssl/certs";
	}

	if ($smtp_ssl_cert_path eq "") {
		return (SSL_verify_mode => SSL_VERIFY_NONE());
	} elsif (-d $smtp_ssl_cert_path) {
		return (SSL_verify_mode => SSL_VERIFY_PEER(),
			SSL_ca_path => $smtp_ssl_cert_path);
	} elsif (-f $smtp_ssl_cert_path) {
		return (SSL_verify_mode => SSL_VERIFY_PEER(),
			SSL_ca_file => $smtp_ssl_cert_path);
	} else ...

We set cert_path to "/etc/ssl/certs" and return SSL_VERIFY_PEER() as
the SSL_verify_mode, and also return that directory as SSL_ca_path,
which means the callsites of the ssl_verify_params sub, which are
Net::SMTP:SSL->start_SSL() or IO::Socket::SSL::set_client_defaults(),
will be told with SSL_ca_path (not SSL_ca_file) that
"/etc/ssl/certs" is the directory to find the certificates in.

Now, http://search.cpan.org/~sullr/IO-Socket-SSL-1.964/lib/IO/Socket/SSL.pm
says:

  SSL_ca_file | SSL_ca_path

    Usually you want to verify that the peer certificate has been
    signed by a trusted certificate authority. In this case you
    should use this option to specify the file (SSL_ca_file) or
    directory (SSL_ca_path) containing the certificate(s) of the
    trusted certificate authorities.

So I have to wonder why isn't this working.  Without knowing why
using SSL_ca_path for the certificate directory is not working on
your platform, the patch looks more like a band-aid that works
around an undiagnosed malfunction of IO::Socket::SSL on your
platform than a real solution to the breakage, no?

Puzzled...

By the way, please do not tell the readers of proposed log message
to refer to your custom "Reference:" footer to answer the
"... because?" question at the beginning of this message.  Your
proposed log message should have allowed anybody who comments on
your patch to make the above observation without referring to
external website.

Having said all that.

Does this patch affect people on other distros, who never set the
cert_path in their configuration and have been relying on the
hardwired default?  If so in what way?

My knee-jerk answer to that question is that it would negatively
affect folks only if their platform does have the certs in
/etc/ssl/certs/, but their Perl IO::Socket::SSL somehow defaults to
a wrong location, which is already a broken installation.  In that
sense, I suspect that the potential downside of this patch may be
small, but I'd prefer to see evidence that the patch author thought
through ramifications of the change in the proposed log message ;-)

Also, if the above observation is correct, i.e. we are calling
IO::Socket::SSL with SSL_ca_path set to a correct directory but
somehow your platform is misbehaving and not detecting it as a
proper SSL_ca_path, then it could be argued that the code before
this patch catered people on platforms with one class of breakage,
namely "IO::Socket::SSL does not work with default configuration
without SSL_ca_file nor SSL_ca_path", and the code with this patch
caters people on platforms with another class of breakage, namely
"IO::Socket::SSL does not work when told with SSL_ca_path where the
certificate directory is" (or it could be "/etc/ssl/certs is a
directory that ought to be usable as SSL_ca_path, but it lacks
necessary hash symlinks").  Sort of like robbing Peter to pay Paul,
which is not very nice in principle.

> Tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
> Signed-off-by: Ruben Kerkhof <ruben@rubenkerkhof.com>
> Reference: https://bugzilla.redhat.com/show_bug.cgi?id=1043194
> ---
>  git-send-email.perl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3782c3b..689944f 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1095,7 +1095,8 @@ sub ssl_verify_params {
>  	}
>  
>  	if (!defined $smtp_ssl_cert_path) {
> -		$smtp_ssl_cert_path = "/etc/ssl/certs";
> +		# use the OpenSSL defaults
> +		return (SSL_verify_mode => SSL_VERIFY_PEER());
>  	}
>  
>  	if ($smtp_ssl_cert_path eq "") {
