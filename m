From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix link to parent diff with pathinfo
Date: Tue, 24 May 2016 11:17:28 -0700
Message-ID: <xmqq37p75nif.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvo225fg.fsf@gitster.mtv.corp.google.com>
	<1462579902-18907-1-git-send-email-rbraun@sceen.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Richard Braun <rbraun@sceen.net>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 20:17:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Gtf-0001ul-Qs
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 20:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbcEXSRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 14:17:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755107AbcEXSRc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 14:17:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95D231D960;
	Tue, 24 May 2016 14:17:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g5e+qKaRqCj0UzR7VehZpJ40l+o=; b=UnN4BR
	2IV5LrgshFGnFwZ7rwC55l5JA9t2GcZodq5EcWLZ2V1uG7xWVE7gg9Q0vjCh0bW3
	zUhuNcIDIYc0q+x50cPFzBKR5Uzm4R2vZFdqKiGLd7yyHbzF6kGvH1sEAW/H3ui4
	wjKkTJeizSQBzZAl5/4EUcZn9cat2CG2vFvRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u7LxB4+PQEZ14mCd0nahkxMvp2Eg8w3Y
	/d0phfEQ9UA9NdR0iH3qGYSX0ko/bfb2ukOHMfDJJWn0xIzjnM3kVIW4fZIIza5R
	AF57VTZjojYQZIn6yvmXJE+z/Hcr9IIQsIlAT6k1Ul8e9Unl1CbI3VxV4iunIgHA
	Lh6V6KYJ/Ks=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 879EA1D95F;
	Tue, 24 May 2016 14:17:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 022F91D95E;
	Tue, 24 May 2016 14:17:30 -0400 (EDT)
In-Reply-To: <1462579902-18907-1-git-send-email-rbraun@sceen.net> (Richard
	Braun's message of "Sat, 7 May 2016 02:11:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C78394E0-21DB-11E6-98EB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295512>

Richard Braun <rbraun@sceen.net> writes:

> Gitweb, when used with PATH_INFO, shows a link to parent diff
> like http://somedomain/somerepo.git/commitdiff/somehash?hp=parenthash.
> That link reports "400 - Invalid hash parameter".
>
> As I understand it, it should instead directly point to the parent diff,
> i.e. turn it into http://somedomain/somerepo.git/commitdiff/parenthash,
> and delete 'hash_parent' element from the %params hash once we used it,
> otherwise the '?hp=parenthash' string is appended.
>
> Signed-off-by: Richard Braun <rbraun@sceen.net>
> ---

Pinging...

>  gitweb/gitweb.perl | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 05d7910..f7f7936 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1423,7 +1423,12 @@ sub href {
>  			delete $params{'hash'};
>  			delete $params{'hash_base'};
>  		} elsif (defined $params{'hash'}) {
> -			$href .= esc_path_info($params{'hash'});
> +			if (defined $params{'hash_parent'}) {
> +				$href .= esc_path_info($params{'hash_parent'});
> +				delete $params{'hash_parent'};
> +			} else {
> +				$href .= esc_path_info($params{'hash'});
> +			}
>  			delete $params{'hash'};
>  		}
