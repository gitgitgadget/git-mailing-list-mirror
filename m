From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: [PATCH 2/3] send-email: validate patches before sending anything
Date: Fri, 18 Jan 2008 12:39:45 -0500
Message-ID: <76718490801180939v12112b5btd71dfb1fb5be5897@mail.gmail.com>
References: <20080118141638.GA14928@coredump.intra.peff.net>
	 <20080118141948.GB19783@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Adam Piatyszek" <ediap@users.sourceforge.net>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 18:40:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFvCU-0001FP-1a
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 18:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759634AbYARRjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 12:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbYARRjr
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 12:39:47 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:35569 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580AbYARRjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 12:39:46 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1852680wah.23
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 09:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=5hDPLTXbcg3BraWDDMDjtTWjvOy563imGdGR7emNlZQ=;
        b=hxbGKJXZtrWwlSu2LNKnq/EBuPHyQHfEdEFK0/MhnPKF6IZkpwCPHzZK/renzo4cijqzu1hFvVhaPFJHxm8wJG+tZ0pEXR4EzY8rSFHpNc6kvHYTVFgxwsuSEin65omcMDnSqReVxlmc29kjhRi4vH6LgKfaxKmaHTdItpvcxc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cc+MQv8faOYo/DrSt6k/5cTUl1mMQp+a1nx9vvIuoZdYD9gjsy93Wu6FB84zUjmbIS+F49cc4fHRgdywxv12N2brKgDWIQ3obhgScEiNgVzAj4KEa6q+m9BqCJMCndefoQ4qY6MfMYKpP4iCXZwRp2PeodPWJLtPhj882TKV9gg=
Received: by 10.114.195.19 with SMTP id s19mr1302533waf.58.1200677985307;
        Fri, 18 Jan 2008 09:39:45 -0800 (PST)
Received: by 10.114.14.17 with HTTP; Fri, 18 Jan 2008 09:39:45 -0800 (PST)
In-Reply-To: <20080118141948.GB19783@coredump.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 08cd2622e93f6b44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71043>

On 1/18/08, Jeff King <peff@peff.net> wrote:

> +foreach my $f (@files) {
> +       my $error = validate_patch($f);
> +       $error and die "fatal: $f: $error\nwarning: no patches were sent\n";
> +}
> +
>  if (@files) {
>         unless ($quiet) {
>                 print $_,"\n" for (@files);
> @@ -837,3 +842,15 @@ sub unique_email_list(@) {
>         }
>         return @emails;
>  }
> +
> +sub validate_patch {
> +       my $fn = shift;
> +       open(my $fh, '<', $fn)
> +               or die "unable to open $fn: $!\n";
> +       while (my $line = <$fh>) {
> +               if (length($line) > 998) {
> +                       return "patch contains line longer than 998 characters";
> +               }
> +       }
> +       return undef;
> +}

How about offering the line number. e.g.:

return "patch line number $. is longer than 998 characters";

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 659f9c7..1c41810 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -78,4 +78,24 @@ test_expect_success 'Show all headers' '
>         diff -u expected-show-all-headers actual-show-all-headers
>  '
>
> +test_expect_success 'no patch was sent' '

Shouldn't that be "no patches were sent" to match the perl output?

j.
