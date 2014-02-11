From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/diff-highlight: multibyte characters diff
Date: Tue, 11 Feb 2014 11:30:33 -0800
Message-ID: <xmqqioslphuu.fsf@gitster.dls.corp.google.com>
References: <1392109750-47852-1-git-send-email-sugi1982@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yoshihiro Sugi <sugi1982@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 11 20:30:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDJ2c-0007gH-4a
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 20:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbaBKTak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 14:30:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071AbaBKTag (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 14:30:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4EFD69C2E;
	Tue, 11 Feb 2014 14:30:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YhjRmWP9j4lKhzCYZYuiSu000aw=; b=MsiaAU
	UpJ+e6KUDBwl7Vg80joKd77QskxU+i/+Rbhm4OZQjRqpsjXKq6Ci3uI2oXQQHaMs
	45Sc1+v4wDBv0O6vTrcnUYlMcTT7yRLyWDG8rNOMGvscokAHhtQ7PcnoQu6X3wWX
	3F8ijFapL9PJOcmcORiKY+RkqmGNWWM6mQMvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IsRPPvuRJ9GyTs6X9/NGFAZQp/8D8wQI
	eUcBIJPqFN4l+TimGsUKC5K0fxfmvEQgBMkWGvy3/tNu2i9RqZvwMogqisGS5XC4
	uo0cMjRKEyIe+JVmm58k3ucDzGeyySlqaND5YHcGK6+s5gm2Rq2c97b0VCSlAM/S
	NwfdBG8oMWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABD5869C2D;
	Tue, 11 Feb 2014 14:30:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5EC069C2B;
	Tue, 11 Feb 2014 14:30:34 -0500 (EST)
In-Reply-To: <1392109750-47852-1-git-send-email-sugi1982@gmail.com> (Yoshihiro
	Sugi's message of "Tue, 11 Feb 2014 18:09:10 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA662158-9352-11E3-837D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241956>

Yoshihiro Sugi <sugi1982@gmail.com> writes:

> Signed-off-by: Yoshihiro Sugi <sugi1982@gmail.com>
>
> diff-highlight split each hunks and compare them as byte sequences.
> it causes problems when diff hunks include multibyte characters.
> This change enable to work on such cases by decoding inputs and encoding output as utf8 string.
> ---
>  contrib/diff-highlight/diff-highlight | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
> index c4404d4..49b4f53 100755
> --- a/contrib/diff-highlight/diff-highlight
> +++ b/contrib/diff-highlight/diff-highlight
> @@ -2,6 +2,7 @@
>  
>  use warnings FATAL => 'all';
>  use strict;
> +use Encode qw(decode_utf8 encode_utf8);
>  
>  # Highlight by reversing foreground and background. You could do
>  # other things like bold or underline if you prefer.
> @@ -15,8 +16,9 @@ my @added;
>  my $in_hunk;
>  
>  while (<>) {
> +	$_ = decode_utf8($_);
>  	if (!$in_hunk) {
> -		print;
> +		print encode_utf8($_);
>  		$in_hunk = /^$COLOR*\@/;
>  	}
>  	elsif (/^$COLOR*-/) {
> @@ -30,7 +32,7 @@ while (<>) {
>  		@removed = ();
>  		@added = ();
>  
> -		print;
> +		print encode_utf8($_);
>  		$in_hunk = /^$COLOR*[\@ ]/;
>  	}
>  
> @@ -58,7 +60,8 @@ sub show_hunk {
>  
>  	# If one side is empty, then there is nothing to compare or highlight.
>  	if (!@$a || !@$b) {
> -		print @$a, @$b;
> +		print encode_utf8($_) for @$a;
> +		print encode_utf8($_) for @$b;
>  		return;
>  	}
>  
> @@ -67,17 +70,18 @@ sub show_hunk {
>  	# stupid, and only handle multi-line hunks that remove and add the same
>  	# number of lines.
>  	if (@$a != @$b) {
> -		print @$a, @$b;
> +		print encode_utf8($_) for @$a;
> +		print encode_utf8($_) for @$b;
>  		return;
>  	}
>  
>  	my @queue;
>  	for (my $i = 0; $i < @$a; $i++) {
>  		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
> -		print $rm;
> +		print encode_utf8($rm);
>  		push @queue, $add;
>  	}
> -	print @queue;
> +	print encode_utf8($_) for @queue;
>  }
>  
>  sub highlight_pair {
