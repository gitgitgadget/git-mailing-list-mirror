From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH] send-email: Honor multi-part email messages
Date: Fri, 25 Jan 2013 18:47:00 +0100
Message-ID: <20130125174700.GA3700@shrek.podlesie.net>
References: <cover.1359126360.git.Alex.Crezoff@gmail.com>
 <4de442db9fd0896f78166e6038b6ea35ed5ab266.1359126360.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 18:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TynUm-0006TQ-EN
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 18:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181Ab3AYRy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 12:54:58 -0500
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:41346 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757072Ab3AYRy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 12:54:57 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jan 2013 12:54:57 EST
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 708E97E; Fri, 25 Jan 2013 18:47:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4de442db9fd0896f78166e6038b6ea35ed5ab266.1359126360.git.Alex.Crezoff@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214562>

On Fri, Jan 25, 2013 at 07:28:54PM +0400, Alexey Shumkin wrote:
> "git format-patch --attach/--inline" generates multi-part messages.
> Every part of such messages can contain non-ASCII characters with its own
> "Content-Type" and "Content-Transfer-Encoding" headers.
> But git-send-mail script interprets a patch-file as one-part message
> and does not recognize multi-part messages.
> So already quoted printable email subject may be encoded as quoted printable
> again. Due to this bug email subject looks corrupted in email clients.

I don't think that the problem with the Subject is multi-part message
specific. The real problem with the Subject is probably that
is_rfc2047_quoted() does not detect that the Subject is already quoted.

Of course we still need that explicit multi-part message support to
avoid "Which 8bit encoding should I declare [UTF-8]? " message.

> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 94c7f76..d49befe 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1499,12 +1499,17 @@ sub file_has_nonascii {
>  
>  sub body_or_subject_has_nonascii {
>  	my $fn = shift;
> +	my $multipart = 0;
>  	open(my $fh, '<', $fn)
>  		or die "unable to open $fn: $!\n";
>  	while (my $line = <$fh>) {
>  		last if $line =~ /^$/;
> +		if ($line =~ /^Content-Type:\s*multipart\/mixed.*$/) {
> +			$multipart = 1;
> +		}
>  		return 1 if $line =~ /^Subject.*[^[:ascii:]]/;
>  	}
> +	return 0 if $multipart;
>  	while (my $line = <$fh>) {
>  		return 1 if $line =~ /[^[:ascii:]]/;
>  	}

After this change the function name is no longer appropriate.
Maybe we should join body_or_subject_has_nonascii()
and file_declares_8bit_cte() because in case of multi-part messages
	"next unless (body_or_subject_has_nonascii($f)
		     && !file_declares_8bit_cte($f));"
is not valid anymore. We could also check for broken_encoding
in single pass.

Thanks,

Krzysiek
