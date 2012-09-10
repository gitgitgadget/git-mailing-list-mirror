From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/14] t5500: add tests of fetch-pack --all --depth=N
 $URL $REF
Date: Mon, 10 Sep 2012 13:46:34 -0700
Message-ID: <7vmx0xmwr9.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <1347171589-13327-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAsY-0003fb-GH
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab2IJUqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:46:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152Ab2IJUqh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:46:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D11C905D;
	Mon, 10 Sep 2012 16:46:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sgEpodU7h6yzJRavwJDVG3Rq9dw=; b=SPGLVT
	lmahQz9UOGeCzgPaG1WTudLRABG8P/HeIL46GgiyPNzs2fciI8joGStJiXHdr53t
	4LSUDBaHtAAfuE5ncDHl4M9AyMspGmi6h4e/nqNjOs03QxkTQEXbn8/UcGpkzD/z
	zsKyfLK0rICk79FeGLTekUi9GBbQNhLG1c5wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mM8kI6Zma2w8PRSJgCWTzVsQTdBNe2rm
	fo4Fq318fHVIfJqPtG642I054iURLykmu5zMFALASwa9NVtYece47fsXTErkQAzl
	0aHhnok9oGktPvypVp2LYnLgVih1RrnwFDomf/o49a6Hu5KJwgqcUHP7O9SmNNZ+
	L9CNnfFXutc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AF71905C;
	Mon, 10 Sep 2012 16:46:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6EBE905B; Mon, 10 Sep 2012
 16:46:35 -0400 (EDT)
In-Reply-To: <1347171589-13327-3-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Sun, 9 Sep 2012 08:19:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C9DE1FE-FB88-11E1-8E5B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205178>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Document some bugs in "git fetch-pack":
>
> 1. If "git fetch-pack" is called with "--all", "--depth", and an
> explicit existing non-tag reference to fetch, then it falsely reports
> that the reference was not found, even though it was fetched
> correctly.
>
> 2. If "git fetch-pack" is called with "--all", "--depth", and an
> explicit existing tag reference to fetch, then it segfaults in
> filter_refs() because return_refs is used without having been
> initialized.

I guess the first one is because "all" already marks the fetched one
"used", and does not allow the explicit one to match any unused one
from the other side?  I wonder what happens when "--all" with an
explicit refspec that names non-existing ref is asked for (it should
notice that refs/heads/no-such-ref does not exist.  I do not know if
it is something that belongs to this set of new tests)?

It is funny that this only happens with "--depth" (I think I know
which part of the code introduces this bug, so it is not all that
interesting, but just funny).

Thanks for working on these glitches.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t5500-fetch-pack.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 6fa1cef..15d277f 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -427,4 +427,19 @@ test_expect_success 'test missing ref before existing' '
>  	test_cmp expect-error error-me
>  '
>  
> +test_expect_failure 'test --all, --depth, and explicit head' '
> +	(
> +		cd client &&
> +		git fetch-pack --no-progress --all --depth=1 .. refs/heads/A
> +	) >out-adh 2>error-adh
> +'
> +
> +test_expect_failure 'test --all, --depth, and explicit tag' '
> +	git tag OLDTAG refs/heads/B~5 &&
> +	(
> +		cd client &&
> +		git fetch-pack --no-progress --all --depth=1 .. refs/tags/OLDTAG
> +	) >out-adt 2>error-adt
> +'
> +
>  test_done
