From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] contrib: add convert-grafts-to-replace-refs.sh
Date: Thu, 05 Jun 2014 14:55:26 -0700
Message-ID: <xmqqa99rrpgx.fsf@gitster.dls.corp.google.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.58934.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jun 05 23:55:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsfdK-0004Co-1z
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 23:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbaFEVzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 17:55:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64547 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbaFEVzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 17:55:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31B911D188;
	Thu,  5 Jun 2014 17:55:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WZOzvC1Vm+jrg14o4xkMmd8j9As=; b=iFWX62
	UDOu+FoYgSg5HllZ1eYA/U9a8x02wrzM5eq023MtXPF/bPWF1CZMvZ62c8XMnlA0
	fPnP7OG7HhjsXdecvsw3ktlp+UCibjamd4z513PSaZaPI6cQgzEV5E+9GmnjPpXV
	Li4YyHpKJgGYu6GDhWEX61DbwppoQXyXnEgBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oZkKp79LRWizlUbOcj6t6Citwi5Iwu/3
	JvFIvuo6oEkisOjvgV+Hwa1VCh3YP6W5A4ULEd9fynQ4nXJWcUDDjmL2VMr6/PXM
	FMfYcIMLNKxZxizaTl4LEpEP1FaZqoKlmYPW7fZw3LYHZfLncux6TarjX8hefyo3
	sN1WyoLgUxQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 289801D187;
	Thu,  5 Jun 2014 17:55:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 67BC81D183;
	Thu,  5 Jun 2014 17:55:28 -0400 (EDT)
In-Reply-To: <20140604194353.23903.58934.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 04 Jun 2014 21:43:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1B403816-ECFC-11E3-BFCE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250868>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/contrib/convert-grafts-to-replace-refs.sh b/contrib/convert-grafts-to-replace-refs.sh
> new file mode 100755
> index 0000000..8472879
> --- /dev/null
> +++ b/contrib/convert-grafts-to-replace-refs.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +
> +# You should execute this script in the repository where you
> +# want to convert grafts to replace refs.
> +
> +die () {
> +	echo >&2 "$@"
> +	exit 1
> +}

Don't we install git-sh-setup in GIT_EXEC_PATH, in order to allow
these third-party scripts to begin with:

        . $(git --exec-path)/git-sh-setup

just like our own scripted Porcelains?

> +GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
> +
> +test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
> +
> +grep '^[^# ]' "$GRAFTS_FILE" | while read definition
> +do

Format the above like so:

    grep '^[^# ]' "$GRAFTS_FILE" |
    while read definition
    do

which is easier to see what that "do" is doing.

> +	test -n "$definition" && {
> +		echo "Converting: $definition"
> +		git replace --graft $definition ||
> +			die "Conversion failed for: $definition"
> +	}

Hmph, why not if/then/fi?
