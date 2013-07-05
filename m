From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 5 Jul 2013 08:33:26 -0400
Message-ID: <CAPig+cReC8TnU0P3-qgeXGeyV=tHaHpa1Cz6r3AAZDw2ZH6B_A@mail.gmail.com>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
	<1373025947-26495-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 14:33:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv5Ce-0008Sp-LD
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313Ab3GEMd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:33:28 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49067 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050Ab3GEMd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:33:28 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so1985013lbi.5
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=pvnvj+tFkY4k44Yt6dsxl9q/SfPR4jP/2JXBQLmpTQw=;
        b=fTefQqz0EC2+VueCpAxoq/4RmLJ5riVqNCrzbdgwpPEf2PsWo1RAgmctdY0/QFFT2k
         RbpA5RGZ3EzSTVTto4uX/s6KWRD4rQXdeU9T6cRkkrxt80uHJInZoiSCK5GhHo3dbnVY
         YHkiwOa2nIzwGx2E+vvpE5OaxsfTG8gQaBa28DQtW9GAv2cu5R6CvCzJhR4NypEsCpKw
         7WCaLxPwUF4GK5XpJd3WF/eJsFOmMJQ7vPNUKhnMCYOojOD7J7gE+Ti5K5/szcziVaY6
         MpoXZ+2rIeBcM80WrW+6PPIlUCFr7wLUj9s+RZyHRTaz3x3ynaoUegDVhXbahbjRpnZb
         1giA==
X-Received: by 10.112.77.164 with SMTP id t4mr5455903lbw.52.1373027606333;
 Fri, 05 Jul 2013 05:33:26 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Fri, 5 Jul 2013 05:33:26 -0700 (PDT)
In-Reply-To: <1373025947-26495-3-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: yyAlZPf3dtVNXFBjaCy7QxGWMeg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229660>

On Fri, Jul 5, 2013 at 8:05 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Use the ca-certificates in /etc/ssl/certs by default (that's where most
> distributions put it).  SSL_VERIFY_NONE is now the fallback mode.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 758100d..026bcbc 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1193,13 +1197,23 @@ X-Mailer: git-send-email $gitversion
>                                                  Debug => $debug_net_smtp);
>                         if ($smtp_encryption eq 'tls' && $smtp) {
>                                 require Net::SMTP::SSL;
> -                               use IO::Socket::SSL qw(SSL_VERIFY_NONE);
> +                               use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
>                                 $smtp->command('STARTTLS');
>                                 $smtp->response();
>                                 if ($smtp->code == 220) {
> -                                       $smtp = Net::SMTP::SSL->start_SSL($smtp,
> -                                                                         SSL_verify_mode => SSL_VERIFY_NONE)
> -                                               or die "STARTTLS failed! ".$smtp->message;
> +                                       # Attempt to use a ca-certificate by default
> +                                       $smtp_ssl_cert_path |= "/etc/ssl/certs";

You're going to want to use logical ||= here. Bitwise |= on a string
does not do what you expect[1]:

  my $s = '/usr/local/etc/ssl/certs';
  $s |= '/etc/ssl/certs';
  print $s, "\n";

Outputs: /uws/oooowts/ssl/certs

[1]: http://perldoc.perl.org/perlop.html#Bitwise-String-Operators

> +                                       if (-d $smtp_ssl_cert_path) {
> +                                               $smtp = Net::SMTP::SSL->start_SSL($smtp,
> +                                                                                 SSL_verify_mode => SSL_VERIFY_PEER,
> +                                                                                 SSL_ca_path => $smtp_ssl_cert_path)
> +                                                       or die "STARTTLS failed! ".$smtp->message;
> +                                       } else {
> +                                               print STDERR "warning: Using SSL_VERIFY_NONE.  See sendemail.smtpsslcertpath.\n";
> +                                               $smtp = Net::SMTP::SSL->start_SSL($smtp,
> +                                                                                 SSL_verify_mode => SSL_VERIFY_NONE)
> +                                                       or die "STARTTLS failed! ".$smtp->message;
> +                                       }
>                                         $smtp_encryption = '';
>                                         # Send EHLO again to receive fresh
>                                         # supported commands
