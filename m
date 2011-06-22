From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetool: Don't assume paths are unmerged
Date: Wed, 22 Jun 2011 14:33:12 -0700
Message-ID: <7v1uyl5z6v.fsf@alter.siamese.dyndns.org>
References: <92B6FB42-FE0D-48DC-ABD0-BA1903D842D2@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 23:33:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZV32-00058b-UN
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 23:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758919Ab1FVVdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 17:33:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758913Ab1FVVdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 17:33:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7DEA24BC5;
	Wed, 22 Jun 2011 17:35:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tYcRQNJDVBwoefdUdnw3h6HUOtI=; b=CYGjZ4
	DuSN5Shr7uDHSF5hucly227Kk3UBB4GFBl8xwitt1mLdSsnuI3Janj3t+uAdsTNK
	1SOnJ0XyglYwaGivZco6PkEMIIdm+uUIXLec2Ymt7K84IR4vRJEPYfQgu9qC5Tgx
	53AicXnZkpWcPxRFt12vRbfs45m2bHz87ytZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KOOYUkUoW+8zafLLMb4lJHyKi0KLBvu4
	GuU0qd6nyIOyUMF5xFErOPAMrYWv5B3wwTFbF9EYaLB58vlGvwUgh1SmV0WxoQ0i
	5MyJmKujfubyrPt8SpQYAQpBhMBD0gnNozR6sxSLbk0q9fuEOt0xh4JqEoqfrMfd
	hg3jBhJkvJ4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 769444BC4;
	Wed, 22 Jun 2011 17:35:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BCB464BC3; Wed, 22 Jun 2011
 17:35:25 -0400 (EDT)
In-Reply-To: <92B6FB42-FE0D-48DC-ABD0-BA1903D842D2@JonathonMah.com> (Jonathon
 Mah's message of "Tue, 21 Jun 2011 19:46:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AB19AE2-9D17-11E0-8986-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176256>

Jonathon Mah <me@JonathonMah.com> writes:

>  if test $# -eq 0 ; then
>      cd_to_toplevel
>  
>      if test -e "$GIT_DIR/MERGE_RR"
>      then
> +	files=$(git rerere remaining)
> +    else
> +	files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
>      fi
>  else
>      while test $# -gt 0; do
> +	matches=$(git ls-files -u -- "$1" | sed -e 's/^[^	]*	//' | sort -u)
> +	if test -n "$matches"; then
> +	    if test -z "$files"; then
> +		files=$matches
> +	    else
> +		files=$(printf "%s\n%s" "$files" "$matches")
> +	    fi
>  	fi
>  	shift
>      done
> +    files=$(printf "%s" "$files" | sort -u)
>  fi

Why do you need a loop here in the else clause, instead of just a single:

	files=$(git ls-files -u -- "$@" |...)
