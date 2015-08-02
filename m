From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sun, 2 Aug 2015 14:57:19 -0400
Message-ID: <CAPig+cQwFxVtO1C_RAumGP6_et21ggORB4jhpcUtBYNznNH1qA@mail.gmail.com>
References: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 20:57:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLyRp-0007Zh-Gr
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 20:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbbHBS5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 14:57:21 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33694 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbHBS5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 14:57:20 -0400
Received: by ykoo205 with SMTP id o205so5204424yko.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6i0G/cglXFAsu8fgJNtp6/58oWMQskE/6+XG/YP5f+o=;
        b=Vgld0VU/C4x7Q7U6WU2+GAZzvwbKiPReadYZYmaH+WEvGC0G6ls1djrxDCAcQHkCO9
         21lPr02DV3HgiHA0bozpodZkamKkhFNeaQ2SmaZnUDU6ubHvjwwlnc0uqMXxkFwcryXE
         KX+6b4aunBiJz/4O9XIaVDEFOTHw5R+0/IQVv7uPzEDaWKcCt6ethzdXj6LI/TloQMti
         QClsKvDLcCS4C0/OUpxUeKOnesW+WgThGmPmiduI76oa99KLUv2fxtooTpq+mRwLzur0
         ZXC9d6Lz+Z9p89lJ5L/8Ig1McW3YyOImG/o6OzWFzqwfduJm7qrmOB5urX7bPXzYB188
         M4Uw==
X-Received: by 10.170.63.196 with SMTP id f187mr16073060ykf.82.1438541839638;
 Sun, 02 Aug 2015 11:57:19 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 2 Aug 2015 11:57:19 -0700 (PDT)
In-Reply-To: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
X-Google-Sender-Auth: texku6HIBu3RpnhbHOLfljRm4oQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275150>

On Sun, Aug 2, 2015 at 12:42 PM, Jan Viktorin <viktorin@rehivetech.com> wrote:
> When sending an e-mail, the client and server must
> agree on an authentication mechanism. Some servers
> (due to misconfiguration or a bug) deny valid
> credentials for certain mechanisms. In this patch,
> a new option --smtp-auth and configuration entry
> smtpauth are introduced. If smtp_auth is defined,
> it works as a whitelist of allowed mechanisms for
> authentication selected from the ones supported by
> the installed SASL perl library.

Nit: This would read a bit more nicely if wrapped to 70-72 columns.

> Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
> ---
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 7ae467b..c237c80 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -171,6 +171,14 @@ Sending
> +--smtp-auth=<mechs>::
> +       Specify allowed SMTP-AUTH mechanisms. This setting forces using only
> +       the listed mechanisms. Separate allowed mechanisms by a whitespace.

Perhaps:

    Whitespace-separated list of allowed SMTP-AUTH mechanisms.

> +       Example: PLAIN LOGIN GSSAPI. If at least one of the specified mechanisms
> +       matchs those advertised by the SMTP server and it is supported by the SASL

s/matchs/matches/

> +       library we use, it is used for authentication. If neither of 'sendemail.smtpAuth'
> +       or '--smtp-auth' is specified, all mechanisms supported on client can be used.

s/neither of/neither/
s/or/nor/

> diff --git a/git-send-email.perl b/git-send-email.perl
> index ae9f869..ebc1e90 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -75,6 +75,9 @@ git send-email [options] <file | directory | rev-list options >
>                                       Pass an empty string to disable certificate
>                                       verification.
>      --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
> +    --smtp-auth             <str>  * Space separated list of allowed AUTH methods.

s/Space separated/Space-separated/

> +                                     This setting forces to use one of the listed methods.
> +                                     Supported: PLAIN LOGIN CRAM-MD5 DIGEST-MD5.

Since you're no longer checking explicitly for these mechanisms, you
probably want to drop the "Supported:" line.

>      --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
>
>    Automating:
> @@ -1136,6 +1141,10 @@ sub smtp_auth_maybe {
>                 Authen::SASL->import(qw(Perl));
>         };
>
> +       if($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
> +               die "invalid smtp auth: '${smtp_auth}'";
> +       }

Style: space after 'if'

>         # TODO: Authentication may fail not because credentials were
>         # invalid but due to other reasons, in which we should not
>         # reject credentials.
> @@ -1148,6 +1157,20 @@ sub smtp_auth_maybe {
>                 'password' => $smtp_authpass
>         }, sub {
>                 my $cred = shift;
> +
> +               if($smtp_auth) {

Style: space after 'if'

> +                       my $sasl = Authen::SASL->new(
> +                               mechanism => $smtp_auth,
> +                               callback => {
> +                                       user => $cred->{'username'},
> +                                       pass => $cred->{'password'},
> +                                       authname => $cred->{'username'},
> +                               }
> +                       );
> +
> +                       return !!$smtp->auth($sasl);
> +               }
> +
>                 return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
>         });
>
> --
> 2.5.0
