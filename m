From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] t5520-pull: Add testcases showing spurious
 conflicts from git pull --rebase
Date: Mon, 09 Aug 2010 12:09:02 -0700
Message-ID: <7vfwyn61td.fsf@alter.siamese.dyndns.org>
References: <1281300917-5610-1-git-send-email-newren@gmail.com>
 <1281300917-5610-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, santi@agolina.net, Johannes.Schindelin@gmx.de,
	avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:09:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiXiu-0005ca-CJ
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab0HITJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 15:09:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab0HITJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 15:09:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E936CC523;
	Mon,  9 Aug 2010 15:09:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lb222yGITtwBxPE4w4owEDUSxlE=; b=hpZ1Ig
	lYTee6CKpJpwnhSWexJl6P4Lm7cZPlMSxCQO7LVVpVk8QUMV48DnIG976rPkz/VD
	d+tM2nWRbq5vCEtSddYKcFQHW0qJvUy0vzVyB1H6QwNzUDI5wf82MQHhd+ROdXjc
	AF1RBazmXeOrqFdxPHWaOoqQ3yKl22jdqHulQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QA3HeBAPOMZ+j1L3O+Xn5vow8emjZVJ1
	sAKCkL629SWVCc5Da0RuzHV4XGRk8hrXIbtjVCGkPqcmW2hJbZ9dveyfmL5/nMGX
	BXyGuARvg6dEe/xxJZSOAY+lhEFVOxlUhWwvCOXF+Knlq5V87wX0+phzkOoNAAaq
	LSdxyXFvHlU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 293C3CC51D;
	Mon,  9 Aug 2010 15:09:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2EE2CC515; Mon,  9 Aug
 2010 15:09:04 -0400 (EDT)
In-Reply-To: <1281300917-5610-2-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sun\,  8 Aug 2010 14\:55\:16 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 978D4D38-A3E9-11DF-8FA4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153001>

Elijah Newren <newren@gmail.com> writes:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t5520-pull.sh |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 63 insertions(+), 0 deletions(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 319e389..9099e55 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -4,6 +4,11 @@ test_description='pulling into void'
>  
>  . ./test-lib.sh
>  
> +modify () {
> +	sed -e "$1" < "$2" > "$2".x &&
> +	mv "$2".x "$2"
> +}

Just a style thing but I'd prefer to see the above written like this:

        modify () {
                sed -e "$1" <"$2" >"$2.x" &&
                mv "$2.x" "$2"
        }

> +test_expect_success 'setup for avoiding reapplying old patches' '
> +	(cd dst &&
> +	 git rebase --abort;

This may be hypothetical but this discards error condition from failing to
ch into dst (for whatever reason).  Don't we expect "git rebase --abort"
to exit with a non-zero status?  Same comment for the last one in the
patch below.

> +test_expect_failure 'git pull --rebase does not reapply old patches' '
> +	(cd dst &&
> +	 git pull --rebase;
> +	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
> +	)
> +'
> +
>  test_done

Thanks.
