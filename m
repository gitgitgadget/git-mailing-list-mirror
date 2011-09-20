From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Honor multi-part email messages
Date: Tue, 20 Sep 2011 12:26:18 -0700
Message-ID: <7v1uvb6mn9.fsf@alter.siamese.dyndns.org>
References: <1316507347-6693-1-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:26:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R65xa-0008Q4-P8
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154Ab1ITT0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 15:26:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832Ab1ITT0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 15:26:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD3E75A05;
	Tue, 20 Sep 2011 15:26:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MTur6NM5qi/RxfnL5cte073REw0=; b=rZIUFn
	s5qnzcsqSPYi8OjLnaXxHVQyLv7AoyCcL7xscPbpchk/ppW1VUKmdacNdg61pgfG
	nK7m2wGHzww7UnwlA78jwdT7q0itvpBNBoevxVd3XFUlfrGf8oplwC1iwuanqbm1
	0xPgP+zsBKLVmiPbOE8IbRByvGAbqXE+nJ8zU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x5gXEfgMg2a1RQ6An6ygCmlRIt2lWIL7
	z5eA0xfUlu8joDDleNm8SjJnUx9vSl2bNH/X2RN34RqaDeCS3444iuuOfWXb2hV8
	wwsuxmD7fAtlJq3PZfE5KZT811onTXhj3Ia86tz2Zng/DEZxWNLdhFuTOEL7LBco
	pfKCGuF4XCM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B49725A04;
	Tue, 20 Sep 2011 15:26:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AFBB5A02; Tue, 20 Sep 2011
 15:26:20 -0400 (EDT)
In-Reply-To: <1316507347-6693-1-git-send-email-zapped@mail.ru> (Alexey
 Shumkin's message of "Tue, 20 Sep 2011 12:29:07 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B22F23C-E3BE-11E0-B0BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181781>

Alexey Shumkin <zapped@mail.ru> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 98ab33a..1abf4a4 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1403,12 +1403,17 @@ sub file_has_nonascii {
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

Looks as if you can lose the extra variable and return 0 immediately when
you find a line with that Content-Type inside the loop.

What am I missing?
