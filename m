From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: Fix handling of suppresscc option.
Date: Wed, 12 Nov 2014 10:25:14 -0800
Message-ID: <xmqqoasc46ph.fsf@gitster.dls.corp.google.com>
References: <1415801891-28471-1-git-send-email-debian@jstimpfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jens Stimpfle <debian@jstimpfle.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:25:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xocbc-00060T-62
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 19:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbaKLSZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 13:25:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753144AbaKLSZS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 13:25:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57ACA1CED6;
	Wed, 12 Nov 2014 13:25:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yG3LCZSUA0sezM2YMvTyHhOv4I0=; b=H4lYA7
	gEksLXmhkKQMuHSTeWWF6WF8J4Ym4c7sBtTyfy2jCXzN33AGn8a3KH9gQAxEOsH2
	HlBkl+rlbciAOiIYYABWBqi39i48AVFfVbc905/ynag/llqYFF7R8ixvZukEThPX
	+OKuTF+qsLI2WAe1M/YRZrmCPRX78mvu2afQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OqCptlyjKmp5XKcUsML6jd1ngnSW7v10
	iKgZRo3+cZZcmc93V+PMmE36KaMzWMPiDFPC9fylFommSHJB2GbeNyHusSk4B+78
	ypKImUuXuQ7+4tNwuoxBTLSisi6vsdzPsczuD16xREM6bIWQ4mP3RmVgryqyXyxK
	5qSEHVaKQas=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D74C1CED5;
	Wed, 12 Nov 2014 13:25:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BECFE1CED4;
	Wed, 12 Nov 2014 13:25:15 -0500 (EST)
In-Reply-To: <1415801891-28471-1-git-send-email-debian@jstimpfle.de> (Jens
	Stimpfle's message of "Wed, 12 Nov 2014 14:18:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3F9F3CD2-6A99-11E4-8009-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jens Stimpfle <debian@jstimpfle.de> writes:

> Signed-off-by: Jens Stimpfle <debian@jstimpfle.de>
> ---

Thanks.

Please do better than saying "Fix" to explain your changes in your
log message.

Also, on the Subject:, s/Fix/fix/; s/option./option/ to match other
entries in "git shortlog" message.

"What you think is broken" is clear (i.e. "supresscc option" is
broken) with the subject line alone, but "How it is broken", "How it
should behave instead", and "What are the differences between the
broken and the correct behaviour" should be explained in the log
message.

In other words, most of what you wrote below should come before your
S-o-b: line.

> Notes:
> ...

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 9949db0..452a783 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1377,11 +1377,8 @@ foreach my $t (@files) {
>  				foreach my $addr (parse_address_line($1)) {
>  					my $qaddr = unquote_rfc2047($addr);
>  					my $saddr = sanitize_address($qaddr);
> -					if ($saddr eq $sender) {
> -						next if ($suppress_cc{'self'});
> -					} else {
> -						next if ($suppress_cc{'cc'});
> -					}
> +					next if $suppress_cc{'cc'};
> +					next if $suppress_cc{'self'} and $saddr eq $sender;

This smells more like a change in behaviour than bugfix from a
cursory look, though.  It used to be that I could receive a copy by
adding me to cc as long as I did not suppress 'self', even I
squelched everybody else by suppressing 'cc'.  I do not use such a
configuration myself but I wonder if people rely on this behaviour
as a feature.

> @@ -1425,12 +1422,9 @@ foreach my $t (@files) {
>  			my ($what, $c) = ($1, $2);
>  			chomp $c;
>  			my $sc = sanitize_address($c);
> -			if ($sc eq $sender) {
> -				next if ($suppress_cc{'self'});
> -			} else {
> -				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
> -				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
> -			}
> +			next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
> +			next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
> +			next if $suppress_cc{'self'} and $sc eq $sender;

Likewise.

I do like the updated logic flow in both hunks, though.

"When I say addresses on Cc: does not matter, it doesn't.  No matter
what the address in question is" (likewise for S-o-b:) is what the
updated logic says.  It is easier to explain than the traditional
"The way to squelch my address is by 'suppress self'; for all other
addresses on Cc:/S-o-b:, there are separate suppression methods".

But I have a slight suspicion that this special casing of 'self' was
done on purpose, and people may be relying on it.
