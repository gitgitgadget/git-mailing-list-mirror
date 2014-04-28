From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed filenames
Date: Mon, 28 Apr 2014 12:17:28 -0700
Message-ID: <xmqqbnvlqn5j.fsf@gitster.dls.corp.google.com>
References: <20140428161630.GA9435@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:18:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer4n-0007p4-Jd
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbaD1TRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:17:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbaD1TRe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:17:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B29A281839;
	Mon, 28 Apr 2014 15:17:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0uQs4l3wxkUwrKIkc8NkPVQQfmE=; b=AAwTCh
	nI/i4UfMDwWw6CJD/sRUDnMb/kPDWJYoBpe0LtQQAuxnglqZj8vg0CXPui7oH8ms
	OZ5E86bG1W1fahlXrAhoLuFr+Dqd6AUuYU3ynyR+d6n9FmE1hyaEpMCBYRrOKkXx
	38bTj2Kp6bU/Aky9LPHpG/l4oE6lJc7M2Y/mI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ych4lBksnE6of/SKQBHYStQnjt3GgN0F
	UB2Htn4U9kAA2LXqAJO5zri1ny8kVU78p3cNQ/tdo5qAyIav7QIxFwbfdLdJkmRI
	kLD3qAnH0MhgyC4VxGlqeNNvbmtxFS6TUB6Vw0tt8sjtN+hGgLgW4YCAYVZHOV42
	/Rx/fSDe3c4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D5A881838;
	Mon, 28 Apr 2014 15:17:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64B8D81832;
	Mon, 28 Apr 2014 15:17:31 -0400 (EDT)
In-Reply-To: <20140428161630.GA9435@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 28 Apr 2014 12:16:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BED1F4D0-CF09-11E3-9DC1-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247396>

Jeff King <peff@peff.net> writes:

> This patch just adds a test to demonstrate the breakage.
> Some possible fixes are:
> ...
>   2. Do all index filename comparisons using a UTF-8 aware
>      comparison function when core.precomposeunicode is set.
>      This would probably have bad performance, and somewhat
>      defeats the point of converting the filenames at the
>      readdir level in the first place.

As we do this only when core.precomposeunicode is set, projects that
use pathnames encoded not in UTF-8 (e.g. 8859-1, EUC, etc.) will not
be affected by getting their path mangled, as long as we won't flip
the default to true (which I am not suggesting to do, by the way).

>   3. Convert index filenames to their precomposed form when
>      we read the index from disk. This would be efficient,
>      but we would have to be careful not to write the
>      precomposed forms back out to disk.

I think this may be the right approach, especially if you are going
to do this only when core.precomposeunicode is set.

the reasoning behind "we would have to be careful not to write"
part, is unclear to me, though.  Don't decomposing filesystems
perform the manglig from the precomposed form without even being
asked to do so, just like a case insensitive filesystem will
overwrite an existing "makefile" on a request to write to
"Makefile"?

>   4. Introduce some infrastructure to efficiently match up
>      the precomposed/decomposed forms. We already do
>      something similar for case-insensitive files using
>      name-hash.c. We might be able to adapt that strategy
>      here.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t3910-mac-os-precompose.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
> index e4ba601..23aa61e 100755
> --- a/t/t3910-mac-os-precompose.sh
> +++ b/t/t3910-mac-os-precompose.sh
> @@ -140,6 +140,16 @@ test_expect_success "Add long precomposed filename" '
>  	git add * &&
>  	git commit -m "Long filename"
>  '
> +
> +test_expect_failure 'handle existing decomposed filenames' '
> +	echo content >"verbatim.$Adiarnfd" &&
> +	git -c core.precomposeunicode=false add "verbatim.$Adiarnfd" &&
> +	git commit -m "existing decomposed file" &&
> +	>expect &&
> +	git ls-files --exclude-standard -o "verbatim*" >untracked &&
> +	test_cmp expect untracked
> +'
> +
>  # Test if the global core.precomposeunicode stops autosensing
>  # Must be the last test case
>  test_expect_success "respect git config --global core.precomposeunicode" '
