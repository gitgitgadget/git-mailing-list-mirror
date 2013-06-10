From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] templates: Fewer subprocesses in pre-commit hook
Date: Mon, 10 Jun 2013 12:44:49 -0700
Message-ID: <7vy5ahg37y.fsf@alter.siamese.dyndns.org>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
	<1370889365-6239-2-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 21:44:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um81S-0001MP-2X
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 21:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab3FJToy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 15:44:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3FJTox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 15:44:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEAF426A8E;
	Mon, 10 Jun 2013 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2dLTpEoXcWYKCP1PnWN3InN1VlM=; b=iSjGYz
	osz/knDfjfLfuQc4CLhtjAen7JF28rqILzgp3ZpDUjesn42GdzbA1fAqlHFYdLEZ
	L5YGtztENay4a/FtGUH9sK0vI9mAY5F/KnFCGqQSRhT7I0jJm04VPNNX1/sOx6el
	Sgp/OS8uohCmWvQ87SNLnUkg3owpEsdI0HmDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gf7yueheaQm9TbuWJsNOh7qVLfZ+3e5w
	UTiFqHdJIMaUoiLGsCg9J1zC6mjkMZwybypEhgYD3UAJ4VSJa2N0mkPS7/jTFZfY
	mWQ0Cewn4M3rOtmbTrLqzje3oyJ01fgN9AZmwU7vgDBB56qKwg8pSSw6gy5vulNQ
	g4FwlknfPUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F65726A8D;
	Mon, 10 Jun 2013 19:44:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6E4426A8B;
	Mon, 10 Jun 2013 19:44:51 +0000 (UTC)
In-Reply-To: <1370889365-6239-2-git-send-email-richih.mailinglist@gmail.com>
	(Richard Hartmann's message of "Mon, 10 Jun 2013 20:36:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37983B56-D206-11E2-8D85-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227365>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> Spawning a new subprocess for every line printed is inefficient.
> Thus spawn only one instance of `echo`.
>
> Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
> ---
>  templates/hooks--pre-commit.sample |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
> index 18c4829..126ae13 100755
> --- a/templates/hooks--pre-commit.sample
> +++ b/templates/hooks--pre-commit.sample
> @@ -31,18 +31,18 @@ if [ "$allownonascii" != "true" ] &&
>  	test $(git diff --cached --name-only --diff-filter=A -z $against |
>  	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
>  then
> -	echo "Error: Attempt to add a non-ascii file name."
> -	echo
> -	echo "This can cause problems if you want to work"
> -	echo "with people on other platforms."
> -	echo
> -	echo "To be portable it is advisable to rename the file ..."
> -	echo
> -	echo "If you know what you are doing you can disable this"
> -	echo "check using:"
> -	echo
> -	echo "  git config hooks.allownonascii true"
> -	echo
> +	echo 'Error: Attempt to add a non-ascii file name.
> +
> +This can cause problems if you want to work
> +with people on other platforms.
> +
> +To be portable it is advisable to rename the file.
> +
> +If you know what you are doing you can disable this
> +check using:
> +
> +  git config hooks.allownonascii true
> +'
>  	exit 1
>  fi

Thanks.
Writing it as a single here-text

	cat <<-EOF
        Error: Attempt to...

        the message body that is
        multi-line
        EOF

might make it easier for people who want to activate and customize
the message, but honestly this is a borderline "Meh" at least to me.

Will take a look at other patches first before further commenting on
this.
