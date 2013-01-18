From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] am: invoke perl's strftime in C locale
Date: Fri, 18 Jan 2013 12:36:46 -0800
Message-ID: <7vehhiqlcx.fsf@alter.siamese.dyndns.org>
References: <20130114205933.GA25947@altlinux.org>
 <20130115155953.GB21815@sigill.intra.peff.net>
 <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com>
 <20130115165058.GA29301@sigill.intra.peff.net>
 <20130115174015.GA7471@altlinux.org> <20130115190517.GB7963@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Antoine Pelisse <apelisse@gmail.com>,
	git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:37:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwIgY-0000tE-GW
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 21:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab3ARUgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 15:36:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab3ARUgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 15:36:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB8AABF2;
	Fri, 18 Jan 2013 15:36:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HkJnZ1yD1GY0QaoVi8WJeIneC7o=; b=DZNaTW
	BHmWfePvoZb7MXz+0ZTLXrluEFL3uFYlQUnXyV+womJb6x6Og8c+PKqcdJMat3Cc
	+yJRZcaq9dguxcuJjhDKcdQEY6WN/CG3IVSefMrP4Lwf79VNjURkQnIsJScLvFII
	i/lOXVGN3OPmvZ+XC8XY0x/qB9gYF/P/pGqTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P7xeNGblqh2SVygTy168m6q1KQqBCkS1
	AW8f+dM6OIDLDtQjtEBTZZQoB62IsmAU1ZubOauhXK8+l88pnhT9PUUJfemMlOo6
	A7NM6UqF8B+Uv1b9lkgcbnOuAVgN9tia0esvCYKg6Js6cLjTMdtvcLaDAm8mB42b
	AOaxsqpEntg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF6CBABF1;
	Fri, 18 Jan 2013 15:36:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 213FBABEB; Fri, 18 Jan 2013
 15:36:48 -0500 (EST)
In-Reply-To: <20130115190517.GB7963@altlinux.org> (Dmitry V. Levin's message
 of "Tue, 15 Jan 2013 23:05:17 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7F4B3E6-61AE-11E2-9051-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213936>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> This fixes "hg" patch format support for locales other than C and en_*.
> Before the change, git-am was making "Date:" line from hg changeset
> metadata according to the current locale, and this line was rejected
> later with "invalid date format" diagnostics because localized date
> strings are not supported.
>
> Reported-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
>  v3: alternative implementation using setlocale(LC_TIME, "C")
>
>  git-am.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index c682d34..8677d8c 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -334,7 +334,8 @@ split_patches () {
>  			# Since we cannot guarantee that the commit message is in
>  			# git-friendly format, we put no Subject: line and just consume
>  			# all of the message as the body
> -			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
> +			perl -M'POSIX qw(strftime :locale_h)' -ne '
> +				BEGIN { setlocale(LC_TIME, "C"); $subject = 0 }

I still haven't convinced myself that this is an improvement over
the simple "LC_ALL=C LANG=C perl ..." approach.

This alternative might be theoretically more correct if we cared
about the error and other messages from this Perl invocation, but it
requires that everybody's Perl implementation correctly supports the
additional -M'POSIX ":locale_h"' and "setlocale(LC_TIME, ...)".

I am tempted to use the previous one that puts the whole process
under LC_ALL=C instead, unless I hear a "we already depend on that
elsewhere, look at $that_code".

Thanks.

>  				if ($subject) { print ; }
>  				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
>  				elsif (/^\# Date /) {
