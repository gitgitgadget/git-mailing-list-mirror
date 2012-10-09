From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-send-email: use locale encoding for compose
Date: Tue, 09 Oct 2012 14:34:59 -0700
Message-ID: <7vehl7e3cs.fsf@alter.siamese.dyndns.org>
References: <1349301931-11912-1-git-send-email-krzysiek@podlesie.net>
 <1349301931-11912-2-git-send-email-krzysiek@podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:35:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLhSQ-0006xQ-SO
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 23:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631Ab2JIVfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 17:35:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600Ab2JIVfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 17:35:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CCF78469;
	Tue,  9 Oct 2012 17:35:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nfLnzrFpmdiyh3eX17J4IQb3G4E=; b=tMF4xx
	6yMVpbgiLvbsAjf2cMSK92npgrWpFwyYQtrw+bjpONxdb+T5Kn7NwO1kBE0V6/S2
	K+TZDnlFvmDYQD3SmH77PYm2yD6o/AYVoHZ83SA463Wr9wzZZUqB8hxBTSMgPEIU
	aDaqjWsg3IgfROm9M6HY1PGYsY4cV5Ftik/gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eZJjM+uSuB6lGPBoyUaafrhU3AIjd/fs
	uUAZ1pAK2421yiHd3uWraEoT+iHdspba7X/EnhGmpqwlEZdBIdj7RZ4k3CXt7sFr
	BTt4BbX1iA4xWEv3vpEC5a24h5q8FkH2TsqGc7jXoAZOh4+Rpx2Rvv7nHRIZTAqj
	wBlfreNBv9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 290728468;
	Tue,  9 Oct 2012 17:35:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 718048467; Tue,  9 Oct 2012
 17:35:01 -0400 (EDT)
In-Reply-To: <1349301931-11912-2-git-send-email-krzysiek@podlesie.net>
 (Krzysztof Mazur's message of "Thu, 4 Oct 2012 00:05:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E6B8988-1259-11E2-9E2E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207349>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> The introduction email (--compose option) use UTF-8 as default encoding.
> The current locale encoding is much better default value.
>
> Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
> ---
>  git-send-email.perl | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 107e814..139bb35 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -590,6 +590,16 @@ sub get_patch_subject {
>  	die "No subject line in $fn ?";
>  }
>  
> +sub locale_encoding {
> +	my $encoding = "UTF-8";
> +	eval {
> +		require I18N::Langinfo;
> +		I18N::Langinfo->import(qw(langinfo CODESET));
> +		$encoding = langinfo(CODESET());
> +	};
> +	return $encoding;
> +}
> +
>  if ($compose) {
>  	# Note that this does not need to be secure, but we will make a small
>  	# effort to have it be unique
> @@ -643,7 +653,7 @@ EOT
>  		} elsif (/^\n$/) {
>  			$in_body = 1;
>  			if (!defined $compose_encoding) {
> -				$compose_encoding = "UTF-8";
> +				$compose_encoding = locale_encoding();
>  			}
>  			if ($need_8bit_cte) {
>  				print $c2 "MIME-Version: 1.0\n",

These two patches make sense in general, but t9001.62 (--compose
adds MIME for utf8 body) seems to be broken by it.  I didn't check
to see if the code is broken, or the test has expecting a wrong
behaviour.  If the latter, the test needs to be updated to match the
improved new world order.

Thanks.
