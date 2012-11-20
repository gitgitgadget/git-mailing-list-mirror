From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: don't return undefined value in
 extract_valid_address()
Date: Tue, 20 Nov 2012 12:27:36 -0800
Message-ID: <7v8v9wrpdz.fsf@alter.siamese.dyndns.org>
References: <1353414053-25261-1-git-send-email-krzysiek@podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 21:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TauQE-0001XM-1X
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 21:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab2KTU1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 15:27:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943Ab2KTU1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 15:27:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DD909D25;
	Tue, 20 Nov 2012 15:27:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RiWMCjaox5C8C5NSL/VoFPNmILQ=; b=dqQ61E
	zH1ZE0LIXNRQ/Bci/Rwmf/gOwAv3uHw8fnw2UXbHTRPFlQ5WHrJNK2wQAwG3hzku
	x7yLl0ePDz+AtnkOVLjNPqZmi7nRrMr6AekwG0PlMbNQudeo438e/MVId4bh9xVg
	oYj82qioVFRQ3707eJmELT6tNRn1TiqJmw/g8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LAXlV2rd+QGe+BGUwQ8E+nz2KTdnvHMP
	7oR/HBocYeigAIbvzG44T8QBTDnqwiE1n+ehdh8GehqBquLYDVfycqQa76HLswb5
	bV2f8NTL4a19F2OXqYE28by5IQyQAqd9zNlZOreN0Dap086S+IjJOGGcK9a4pZeU
	0bBSUyngYHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AB719D24;
	Tue, 20 Nov 2012 15:27:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9BB89D1F; Tue, 20 Nov 2012
 15:27:37 -0500 (EST)
In-Reply-To: <1353414053-25261-1-git-send-email-krzysiek@podlesie.net>
 (Krzysztof Mazur's message of "Tue, 20 Nov 2012 13:20:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B992D7A6-3350-11E2-B317-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210110>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> In the fallback check, when Email::Valid is not available, the
> extract_valid_address() does not check for success of matching regex,
> and $1, which can be undefined, is always returned. Now if match
> fails an empty string is returned.

That much we can read from the code, but a bigger question is why
would it be a good thing for the callers?  Wouldn't they want to
be able to distinguish a failure from an empty string?

> Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
> ---
> This fixes following warnings:
> Use of uninitialized value in string eq at ./git-send-email.perl line 1017.
> Use of uninitialized value in quotemeta at ./git-send-email.perl line 1017.
> W: unable to extract a valid address from: x a.patch
>
> when invalid email address was added by --cc-cmd,
> ./git-send-email.perl --dry-run --to a@podlesie.net --cc-cmd=echo x a.patch

In other words, would we want to *hide* (not "fix") the warning?
Shouldn't we be barfing loudly and possibly erroring it out until
the user fixes her --cc-cmd?

>  git-send-email.perl | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5a7c29d..045f25f 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -831,12 +831,12 @@ sub extract_valid_address {
>  	$address =~ s/^\s*<(.*)>\s*$/$1/;
>  	if ($have_email_valid) {
>  		return scalar Email::Valid->address($address);
> -	} else {
> -		# less robust/correct than the monster regexp in Email::Valid,
> -		# but still does a 99% job, and one less dependency
> -		$address =~ /($local_part_regexp\@$domain_regexp)/;
> -		return $1;
>  	}
> +
> +	# less robust/correct than the monster regexp in Email::Valid,
> +	# but still does a 99% job, and one less dependency
> +	return $1 if $address =~ /($local_part_regexp\@$domain_regexp)/;
> +	return "";
>  }
>  
>  # Usually don't need to change anything below here.
