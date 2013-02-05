From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4038: add tests for "diff --cc --raw <trees>"
Date: Tue, 05 Feb 2013 12:48:58 -0800
Message-ID: <7v8v72sczp.fsf@alter.siamese.dyndns.org>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <7vwqup890o.fsf@alter.siamese.dyndns.org>
 <20130203203150.GU1342@serenity.lan>
 <7v8v7585sr.fsf@alter.siamese.dyndns.org>
 <20130203231549.GV1342@serenity.lan>
 <7vip696i3v.fsf@alter.siamese.dyndns.org>
 <20130205202558.GX1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:49:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2pSH-0005Bc-Jq
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309Ab3BEUtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 15:49:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755710Ab3BEUtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 15:49:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E974591FB;
	Tue,  5 Feb 2013 15:49:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HSa52++mScY7+U8VAgc8YJbtXIc=; b=SNrv9u
	C45THuNv8VgEbgqxyHwW1YmikhqeJ1QYXZM/SoBh8kjdMnZ0v7gI/ynkbFHnyB8/
	2pvcQ+SqQ3LrN4DwcppqFkh2PKZPIw6x51vJwiO+E5MH0+JLjkQZ09ek4cB/pyzJ
	wI4QzR43Pkklj9KisZ23FNBn8c6siEDt8G7IA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5nE4ppGitvKAkEI8OQo9UWAeu+xA2TL
	66QKwbktc1wqYIFi+FCNUMO//X0XfhUhics/dFYeuHAyUNR6K6XjIaOkzW/5q7/K
	cd30kii064ohXsIGTxIGnFzCbkZ7nrH4tc4C7Ej+8qsEZ8rmG7FS8eKGILhf4plW
	1e0+ZnCwmUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDCC291F9;
	Tue,  5 Feb 2013 15:49:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BE0791F8; Tue,  5 Feb 2013
 15:49:00 -0500 (EST)
In-Reply-To: <20130205202558.GX1342@serenity.lan> (John Keeping's message of
 "Tue, 5 Feb 2013 20:25:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77CD1720-6FD5-11E2-8526-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215537>

John Keeping <john@keeping.me.uk> writes:

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> ...
> diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
> index 40277c7..a0701bc 100755
> --- a/t/t4038-diff-combined.sh
> +++ b/t/t4038-diff-combined.sh
> @@ -89,4 +89,33 @@ test_expect_success 'diagnose truncated file' '
>  	grep "diff --cc file" out
>  '
>  
> +test_expect_success 'setup for --cc --raw' '
> +	blob=$(echo file |git hash-object --stdin -w) &&
> +	base_tree=$(echo "100644 blob $blob	file" | git mktree) &&
> +	trees= &&
> +	for i in `test_seq 1 40`
> +	do
> +		blob=$(echo file$i |git hash-object --stdin -w) &&
> +		trees="$trees $(echo "100644 blob $blob	file" |git mktree)"

Please have a SP after each of these '|' pipes.

If you collect trees this way:

	trees="$trees$(echo ... | git mktree)$LF"

then ...

> +	done
> +'
> +
> +test_expect_success 'check --cc --raw with four trees' '
> +	four_trees=$(echo "$trees" |awk -e "{
> +		print \$1
> +		print \$2
> +		print \$3
> +		print \$4
> +	}") &&

(What's "awk -e"?)

... you can do

	echo "$trees" | sed -e 4q

which is less repetitive.

Thanks.
