From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Thu, 07 Jun 2012 15:49:17 -0700
Message-ID: <7vwr3ieo0i.fsf@alter.siamese.dyndns.org>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 00:49:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SclW8-0007Tp-VE
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 00:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933361Ab2FGWtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 18:49:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757448Ab2FGWtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 18:49:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE0D196D5;
	Thu,  7 Jun 2012 18:49:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6pym/9cFmn9xwVpIPibo2m2Csds=; b=PDnBRx
	u3flyaRfR3ztHT8W9nNeP9qq59bwK6o29pICBwvnISOUfXSbLe0sJN4d/tvXKaNI
	pkJ8L27kGr99i85QpvJ/3So7dCvnTUvDvS4ke8XHoiU75AAyoWsAV+m8gsPDTKMt
	j9M5cQ5nls8bFCh1QsMs+LOsJv2wYeh8DEENQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KXri00X8J0E4uBVzsxjIq3g9B5bm3ejM
	OIDrAIAVVg+qhnLebk2ltbBq22IF5UgjREvYWteO0EhHTQ3NUqc9m2H/DTE8TJ0a
	Tgf4BBCidTi81+R/ugvTUiZo1MA/lj3kVJqdImstxGmcOUItu1Tx14geaKvkfM/c
	okFfP0+842g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E36E996D4;
	Thu,  7 Jun 2012 18:49:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F60196D2; Thu,  7 Jun 2012
 18:49:18 -0400 (EDT)
In-Reply-To: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Lucien Kong's message of "Thu, 7 Jun 2012 23:20:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03C3693E-B0F3-11E1-BA65-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199457>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> +# Add a warning notification at the end of each pick or fixup/squash
> +# line of the todo list, providing the picking commit is already
> +# published.
> +warn_published () {
> +	cat "$1" | while read -r command sha1 message

Make it a habit to question yourself whenever you cat a single file
and immediately pipe it to elsewhere, i.e.

	cat "$1" | anything

because 99% of the time you are much better off writing

	anything <"$1"

instead.

> +	do
> +		test -n "$sha1" || break
> +		if test -n "$(git branch -r --contains "$sha1")"
> +		then
> +			printf "%s\n" "$(sed -e "/"$sha1"/ s|$| [Published]|" "$1")" >"$1"
> +		fi
> +	done

What's inside $() looks like it wants to say something like

	sed -e "/ $sha1 /s/$/ [Published]/" "$1"

but it has a few fishy double-quotes that makes it unclear why $sha1
wants to be outside the quotes.

Why does it need 'printf "%s" $()' in the first place?  Wouldn't

	sed ... >"$1"

sufficient?  You let cat read "$1", sed read "$1" and then the loop
overwrite "$1", which looks very fishy.

The logic is merely _guessing_ that the commit could have been
published, no?  The particular remote repository the test happens to
find may not be for consumption by other people.

I am afraid that doing this would send users a wrong message that is
unnecessarily alarming, especially the marker says "Published" as if
it were a confirmed fact.

In short, I am not unsympathetic to the motivation, but I find the
resulting user experience (mostly the wording) questionable, and I
am not impressed by the implementation very much.
