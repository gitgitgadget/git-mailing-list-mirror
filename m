From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add ability to specify SMTP server port when using git-send-email.
Date: Mon, 24 Sep 2007 23:24:33 -0700
Message-ID: <7v8x6v6z4u.fsf@gitster.siamese.dyndns.org>
References: <1190666058-10969-1-git-send-email-glenn@rempe.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Glenn Rempe <glenn@rempe.us>
X-From: git-owner@vger.kernel.org Tue Sep 25 08:24:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia3qg-0005qr-CP
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 08:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbXIYGYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 02:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbXIYGYj
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 02:24:39 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbXIYGYi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 02:24:38 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C9FFD13B716;
	Tue, 25 Sep 2007 02:24:56 -0400 (EDT)
In-Reply-To: <1190666058-10969-1-git-send-email-glenn@rempe.us> (Glenn Rempe's
	message of "Mon, 24 Sep 2007 13:34:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59094>

Glenn Rempe <glenn@rempe.us> writes:

>  git-send-email.perl |   48 +++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 4031e86..7c9c302 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -79,6 +79,10 @@ Options:
>     --smtp-server  If set, specifies the outgoing SMTP server to use.
>                    Defaults to localhost.
>  
> +   --smtp-server-port If set, specifies the port on the outgoing SMTP
> +   server to use. Defaults to port 25 unless --smtp-ssl is set in
> +   which case it will default to port 465.
> +

This paragraph look inconsistent with different indentation
for second and subsequent lines.

> @@ -375,6 +381,14 @@ if (!defined $smtp_server) {
>  	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
>  }
>  
> +if (!defined $smtp_server_port) {
> +  if ($smtp_ssl) {
> +    $smtp_server_port = 465  # SSL port
> +  } else {
> +    $smtp_server_port = 25  # Non-SSL port
> +  }
> +}
> +
>  if ($compose) {
>  	# Note that this does not need to be secure, but we will make a small
>  	# effort to have it be unique
> @@ -604,20 +618,32 @@ X-Mailer: git-send-email $gitversion
>  	} else {
>  		if ($smtp_ssl) {
>  			require Net::SMTP::SSL;
> -			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port => 465 );
> +			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port => $smtp_server_port );
>  		}
>  		else {
>  			require Net::SMTP;
> -			$smtp ||= Net::SMTP->new( $smtp_server );
> +			$smtp ||= Net::SMTP->new( $smtp_server . ":" . $smtp_server_port );
>  		}

This change suggests that, although undocumented, existing users
could have already been using

	--smtp-server=smtp.myisp.com:26

to specify a nonstandard port, and this patch, while bringing in
the support for a nonstandard port as an official feature, would
break such a setup.  I wonder how real the issue is, and if we
can work it around easily.  For example,

 (1) drop the "default to 25 for smtp if undefined" part we saw
     earlier;

 (2) redo this part as

	if ($smtp_ssl) {
		... as you have it ...
	} else {
		require Net::SMTP;
                $smtp ||= Net::SMTP->new((defined $smtp_server_port) ?
					 "$smtp_server:$smtp_server_port" :
                                         $smtp_server);
	}

> -		$smtp->auth( $smtp_authuser, $smtp_authpass )
> -			or die $smtp->message if (defined $smtp_authuser);
> ...
> +    
> +    # we'll get an ugly error if $smtp was undefined above.
> +    # If so we'll catch it and present something friendlier.
> +    if ($smtp) {
> +
> +      if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
> +        $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
> +      }
> +    ...
> +    } else {
> +      die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
> +    }


I'd prefer the check done the opposite order, like

	if (!$smtp) {
        	die ...
	}

without an else clause.
