From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug (?) in send email
Date: Mon, 30 Jul 2012 08:38:21 -0700
Message-ID: <7vpq7ds1hu.fsf@alter.siamese.dyndns.org>
References: <50145A90.1090904@web.de> <50166408.8000008@web.de>
 <873949mnx0.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Miebach <christoph.miebach@web.de>,
	<git@vger.kernel.org>,
	=?utf-8?B?SsO8cmdlbiBSw7xobGU=?= <j-r@online.de>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 30 17:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svs3D-0003Fw-51
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 17:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab2G3PiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 11:38:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754016Ab2G3PiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 11:38:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 410188CEF;
	Mon, 30 Jul 2012 11:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/mlMI9aDP9Jcip394oPsBno5vs8=; b=hWEqdK
	PbtEtqiJvvJapImSzJ4S5NA/FSA42jNxyWIZxXI3X/w9PJ/3P67KQLgMVAnpOFG5
	3RfGdXhInph5MqlwDsJ4UBj/Fd3ShumWTUQ7/pe6lSlzq2CB0LPpleVquqJb11tK
	RLMtibJWGEm793buwTuA4V9lJpgAhhWjJJM2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n5GfNMDiefOSvEY1xKUfYV2NMT5+4w+K
	8NIm2QRLxWZpAVSvnNqnIiyLKhf66dCtELdc9Nas4zTJZ7ZU7PW0TdOqMeMFJgbX
	KTyStTCrKtI46xHwxvRFZrjzJxeyd5hihyAukkaep+m9F1iK5S9X6JfXb5Hq0Bn9
	GLE46ZpyyIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DF078CEE;
	Mon, 30 Jul 2012 11:38:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8751F8CED; Mon, 30 Jul 2012
 11:38:22 -0400 (EDT)
In-Reply-To: <873949mnx0.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 30 Jul 2012 14:30:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9858CA0C-DA5C-11E1-9D8D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202564>

Thomas Rast <trast@student.ethz.ch> writes:

> It would prevent spaces from being decoded correctly if the encoding
> program chooses to make the '_'.  git-format-patch does not actually do
> this, see the big comment around pretty.c:304.
>
> I think this patch would be a better match for what RFC2047 specifies.
> On the one hand it avoids substituting _ outside of encodings, but OTOH
> it also handles more than one encoded-word.

Yeah, I think it is an improvement.

I however wonder if the captured pattern for $2 should be minimized
with ? at the end, i.e. "..\?q\?(.*?)\?="?

> It still does not handle
> the case where there are several encoded-words of *different* encodings,
> but who would do such a crazy thing?

Even if somebody did so, it wouldn't have worked, and to make it
work, the sub and its caller (there is only one caller that actually
cares what the original encoding was) needs to be rethought anyway,
so I do not think it matters.

It may deserve an in-code NEEDSWORK comment, though.

Thanks.

> diff --git i/git-send-email.perl w/git-send-email.perl
> index ef30c55..88c4758 100755
> --- i/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -862,11 +862,13 @@ sub make_message_id {
>  sub unquote_rfc2047 {
>  	local ($_) = @_;
>  	my $encoding;
> -	if (s/=\?([^?]+)\?q\?(.*)\?=/$2/g) {
> +	s{=\?([^?]+)\?q\?(.*)\?=}{
>  		$encoding = $1;
> -		s/_/ /g;
> -		s/=([0-9A-F]{2})/chr(hex($1))/eg;
> -	}
> +		my $e = $2;
> +		$e =~ s/_/ /g;
> +		$e =~ s/=([0-9A-F]{2})/chr(hex($1))/eg;
> +		$e;
> +	}eg;
>  	return wantarray ? ($_, $encoding) : $_;
>  }
