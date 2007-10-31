From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH] Implement sending mails over TLS in git-send-email.
Date: Wed, 31 Oct 2007 21:45:42 +0000
Message-ID: <2faad3050710311445l51d1152cs6761803e2f3a77d3@mail.gmail.com>
References: <1193845859-1788-1-git-send-email-Simon.Sasburg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Sasburg" <simon.sasburg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InLNu-0002q4-W9
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbXJaVpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbXJaVpp
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:45:45 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:33540 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751775AbXJaVpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:45:45 -0400
Received: by rn-out-0102.google.com with SMTP id s46so380852rnb
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TriHyKfwo6nOw6+mp06q37A1f5V1Ym9mItij9+XhKJI=;
        b=p64H0k0xUBpX2GG9NLYIo0+iNSdRT6zPGfR3y3Ca6GFC+Jn0LgVh0o9Y90ApioIULr+MQ6HRQg6zMFCq89gXO0OZBhM8AyB5yx3GhSux7lb7eFPicFACNQG4mUD62SrdDjMBoddkm+g+oVuLhB+f5dHEFtkdxIhYeMN6tAKprfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mmEpwb+8kx/m+38KVdZ7x2o06J1k8+MWFb9iqJAGRE+ihIBI1H7k66o0EWqXcNGN2owX3fHOGoqT00Ts/2wWI6M+tHfVbBLyQvtn14O+eQ7sBvUEkc3EAemVZxJt28ZvRDhHMJCoPj3YrbjzrYgtNKOjACYnwGkkHLafDBKr4xw=
Received: by 10.142.232.20 with SMTP id e20mr2249912wfh.1193867142571;
        Wed, 31 Oct 2007 14:45:42 -0700 (PDT)
Received: by 10.142.43.18 with HTTP; Wed, 31 Oct 2007 14:45:42 -0700 (PDT)
In-Reply-To: <1193845859-1788-1-git-send-email-Simon.Sasburg@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62884>

On 31/10/2007, Simon Sasburg <simon.sasburg@gmail.com> wrote:
> Signed-off-by: Simon Sasburg <Simon.Sasburg@gmail.com>
> ---
>
> With this patch I was able to use git-send-email to send mail through gmail's
> smpt server, which uses TLS.

Net::SMTP::SSL handles this just fine.

> Net::SMTP::TLS apparently doesn't do proper error handling, so the TLS
> codepath is essentially not checked for errors. I'm not really happy with this.

Net::SMTP::TLS is a bit ugly. It seems unable to do any checking of
the server certificate, a limitation its inherited from the original
script it was hacked from. I suspect some people wouldn't touch this
option if that's the case (although I doubt any tin-foil hatters use
gmail anyway, and we don't use this check for SSL either).

Secondly, Net::SMTP::SSL has no problem connecting to gmail - it does
everything Net::SMTP::TLS does and more; you can use all of the
options of IO::Socket::SSL with it. A common problem seems to be not
having Authen::SASL installed (this is required to authenticate with
gmail) - the one thing Net::SMTP::TLS *does* do is auth without using
that module.

In other words, this patch should be entirely unnecessary if you have
Authen::SASL installed - could you try this? (I've checked for myself,
git-send-email sends me mail fine via gmail without this patch)

> The Net::SMTP::TLS docs say this about error handling:
> >ERROR HANDLING:
> >This module will croak in the event of an SMTP error. Should you wish to handle this gracefully in your application, you may wrap your mail transmission in an eval {} block and check $@ afterward.
>
> But my perl knowledge is way too limited for me to know if/how that helps.
> (This patch was just made by copying existing code and fiddling with it untill it did what i wanted)
>
> Maybe someone who knows more about perl than I do can finish this?

My perl knowledge is a also bit stale, havent had to use it in anger
for a few years; your code looks ok to me, its the dodgy module I'm
worried about :)

> Or give an estimate how difficult it would be for me to fix after pointing me in the right direction?
> (I'm willing to learn a little perl for this, but not too much :-p)
> ---
>  git-send-email.perl |   64 +++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 42 insertions(+), 22 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 96051bc..5cf220f 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -88,6 +88,9 @@ Options:
>
>     --smtp-ssl     If set, connects to the SMTP server using SSL.
>
> +   --smtp-tls     If set, connects to the SMTP server using TLS.
> +                  Overrides --smtp-ssl.
> +
>     --suppress-from Suppress sending emails to yourself if your address
>                    appears in a From: line. Defaults to off.
>
> @@ -175,7 +178,7 @@ my ($quiet, $dry_run) = (0, 0);
>
>  # Variables with corresponding config settings
>  my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
> -my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
> +my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl, $smtp_tls);
>  my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
>
>  my %config_bool_settings = (
> @@ -184,6 +187,7 @@ my %config_bool_settings = (
>      "suppressfrom" => [\$suppress_from, 0],
>      "signedoffcc" => [\$signed_off_cc, 1],
>      "smtpssl" => [\$smtp_ssl, 0],
> +    "smtptls" => [\$smtp_tls, 0],
>  );
>
>  my %config_settings = (
> @@ -213,6 +217,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
>                     "smtp-user=s" => \$smtp_authuser,
>                     "smtp-pass=s" => \$smtp_authpass,
>                     "smtp-ssl!" => \$smtp_ssl,
> +                   "smtp-tls!" => \$smtp_tls,
>                     "identity=s" => \$identity,
>                     "compose" => \$compose,
>                     "quiet" => \$quiet,
> @@ -613,31 +618,46 @@ X-Mailer: git-send-email $gitversion
>                         die "The required SMTP server is not properly defined."
>                 }
>
> -               if ($smtp_ssl) {
> -                       $smtp_server_port ||= 465; # ssmtp
> -                       require Net::SMTP::SSL;
> -                       $smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
> +               if ($smtp_tls) {
> +                       require Net::SMTP::TLS;
> +                       $smtp ||= Net::SMTP::TLS->new(
> +                               $smtp_server,
> +                               Port => $smtp_server_port,
> +                               User => $smtp_authuser,
> +                               Password=> $smtp_authpass);
> +
> +                       $smtp->mail( $raw_from );
> +                       $smtp->to( @recipients );
> +                       $smtp->data;
> +                       $smtp->datasend("$header\n$message");
> +                       $smtp->dataend();
>                 }
>                 else {
> -                       require Net::SMTP;
> -                       $smtp ||= Net::SMTP->new((defined $smtp_server_port)
> -                                                ? "$smtp_server:$smtp_server_port"
> -                                                : $smtp_server);
> -               }
> +                       if ($smtp_ssl) {
> +                               require Net::SMTP::SSL;
> +                               $smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
> +                       }
> +                       else {
> +                               require Net::SMTP;
> +                               $smtp ||= Net::SMTP->new((defined $smtp_server_port)
> +                                                        ? "$smtp_server:$smtp_server_port"
> +                                                        : $smtp_server);
> +                       }
>
> -               if (!$smtp) {
> -                       die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
> -               }
> +                       if (!$smtp) {
> +                               die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
> +                       }
>
> -               if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
> -                       $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
> +                       if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
> +                               $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
> +                       }
> +                       $smtp->mail( $raw_from ) or die $smtp->message;
> +                       $smtp->to( @recipients ) or die $smtp->message;
> +                       $smtp->data or die $smtp->message;
> +                       $smtp->datasend("$header\n$message") or die $smtp->message;
> +                       $smtp->dataend() or die $smtp->message;
> +                       $smtp->ok or die "Failed to send $subject\n".$smtp->message;
>                 }
> -               $smtp->mail( $raw_from ) or die $smtp->message;
> -               $smtp->to( @recipients ) or die $smtp->message;
> -               $smtp->data or die $smtp->message;
> -               $smtp->datasend("$header\n$message") or die $smtp->message;
> -               $smtp->dataend() or die $smtp->message;
> -               $smtp->ok or die "Failed to send $subject\n".$smtp->message;
>         }
>         if ($quiet) {
>                 printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
> @@ -651,7 +671,7 @@ X-Mailer: git-send-email $gitversion
>                         print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
>                 }
>                 print "From: $sanitized_sender\nSubject: $subject\nCc: $cc\nTo: $to\n\n";
> -               if ($smtp) {
> +               if ($smtp && !$smtp_tls) {
>                         print "Result: ", $smtp->code, ' ',
>                                 ($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
>                 } else {
> --
> 1.5.3.4.498.g9c514
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
