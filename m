From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: Serve text/* 'blob_plain' as text/plain with
 $prevent_xss
Date: Thu, 30 Jun 2011 11:22:03 -0700
Message-ID: <7v8vsjqiwk.fsf@alter.siamese.dyndns.org>
References: <1309426761-819-1-git-send-email-jnareb@gmail.com>
 <1309426761-819-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matt McCutchen <matt@mattmccutchen.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 20:22:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcLsS-0005xU-W3
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 20:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab1F3SWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 14:22:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab1F3SWG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 14:22:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7D456700;
	Thu, 30 Jun 2011 14:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xnGZBd1CdU997oQKu32y7TiDfWU=; b=Lav/bR
	7jkoABsrvWnvAy34mqF3zdV47HyX7nJLYOddG68XL+/pjcvsLqyfJkwtLh5krwF/
	1JMB0eZZ4YtWUfCyqXQI+K8U2qukXAC4rExalSmUXj5w/d1CYM7XQZDSmLYzPLFV
	SbbZYRezyh0f936xiacAXun84XpvHV0kLFzxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cHe0PS3xVykt+9xNMdv0qTK/9Ppo/hCH
	WCUJN5A3VCXOjuHTqDujp53ySwcAXD3LUrwvlGakYlb+yudrCEalFAACkfTF9+Dq
	byOOOik+uFk6QwmwNGOxWFqw40/O/KNFmY8uwk+BkGLs9XRdPe9rQYrr9nn/d/Yg
	Xmt5qUP4k50=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D103566FF;
	Thu, 30 Jun 2011 14:24:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2C5FC66FE; Thu, 30 Jun 2011
 14:24:19 -0400 (EDT)
In-Reply-To: <1309426761-819-2-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Thu, 30 Jun 2011 11:39:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B608C4E-A346-11E0-884B-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176497>

Jakub Narebski <jnareb@gmail.com> writes:

> One of mechanism enabled by setting $prevent_xss to true is 'blob_plain'
> view protection.  With XSS prevention on, blobs of all types except a
> few known safe ones are served with "Content-Disposition: attachment" to
> make sure they don't run in our security domain.
>
> Instead of serving text/* type files, except text/plain (and including
> text/html), as attachements, downgrade it to text/plain.  This way HTML
> pages in 'blob_plain' (raw) wiew would be displayed in browser, but

A new typo "wiew" is introduced without touching other parts of the
message. Curious...

> safely as a source, and not asked to be saved.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8620aca..cb2e7bc 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6139,7 +6139,15 @@ sub git_blob_plain {
>  	# want to be sure not to break that by serving the image as an
>  	# attachment (though Firefox 3 doesn't seem to care).
>  	my $sandbox = $prevent_xss &&
> -		$type !~ m!^(?:text/plain|image/(?:gif|png|jpeg))(?:[ ;]|$)!;
> +		$type !~ m!^(?:text/[a-z]+|image/(?:gif|png|jpeg))(?:[ ;]|$)!;
> +
> +	# serve text/* as text/plain
> +	if ($prevent_xss &&
> +	    $type =~ m!^text/[a-z]+\b(.*)$!) {
> +		my $rest = $1;
> +		$rest = defined $rest ? $rest : '';
> +		$type = "text/plain$rest";
> +	}
>  
>  	print $cgi->header(
>  		-type => $type,
