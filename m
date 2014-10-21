From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: don't resend known-common refs in find_common
Date: Tue, 21 Oct 2014 10:56:26 -0700
Message-ID: <xmqqd29l1f3p.fsf@gitster.dls.corp.google.com>
References: <1413884908.4175.49.camel@seahawk>
	<20141021144838.GA11589@seahawk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 19:56:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgdfe-0001UA-JE
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 19:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933450AbaJUR4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 13:56:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756024AbaJUR43 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 13:56:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5331B16D1A;
	Tue, 21 Oct 2014 13:56:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jNnTF4i7EPR7JdvNb+uU0fTm1ao=; b=fAxzui
	7h5mLunotwS8LHbkB5VeumbU+jz4FdYUt3CA4dAmxnrNi7DrAxHgAUZ3T3Lb+OLV
	q1TsrCIefQdk/YmI1jTyWhBAbqOZ8ulKflvqHsbodVCCnUJwn9PJnYGnWHft+/kJ
	n+/GNQfPXLUbx47pk19vc4jUTea0PQQRY3cKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kMHTQhUGguMicufYJSj5w6if8KwW8gGl
	CDyJcU/f5oGQgCoJA8d41Y7bSLzzyt2mjsy97XeKH38mFXv1fdKV5Iq0ysArbib+
	BpDZhWlRWuO2LDbun7cqzRVh9SAgPAjH3JWK5xGMyZGFVxencPAz/rTIiP7RL92W
	1rA+ZyXapug=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A81716D19;
	Tue, 21 Oct 2014 13:56:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C935F16D18;
	Tue, 21 Oct 2014 13:56:27 -0400 (EDT)
In-Reply-To: <20141021144838.GA11589@seahawk> (Dennis Kaarsemaker's message of
	"Tue, 21 Oct 2014 16:49:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 94977DF8-594B-11E4-BA63-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> By not clearing the request buffer in stateless-rpc mode, fetch-pack
> would keep sending already known-common commits, leading to ever bigger
> http requests, eventually getting too large for git-http-backend to
> handle properly without filling up the pipe buffer in inflate_request.
> ---
> I'm still not quite sure whether this is the right thing to do, but make
> test still passes :) The new testcase demonstrates the problem, when
> running t5551 with EXPENSIVE, this test will hang without the patch to
> fetch-pack.c and succeed otherwise.

IIUC, because "stateless" is just that, i.e. the server-end does not
keep track of what is already known, not telling what is known to be
common in each request would fundamentally break the protocol.  Am I
mistaken?


>  fetch-pack.c                |  1 -
>  t/t5551-http-fetch-smart.sh | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 655ee64..258245c 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -410,7 +410,6 @@ static int find_common(struct fetch_pack_args *args,
>  						 */
>  						const char *hex = sha1_to_hex(result_sha1);
>  						packet_buf_write(&req_buf, "have %s\n", hex);
> -						state_len = req_buf.len;
>  					}
>  					mark_common(commit, 0, 1);
>  					retval = 0;
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 6cbc12d..2aac237 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -245,5 +245,37 @@ test_expect_success EXPENSIVE 'clone the 50,000 tag repo to check OS command lin
>  	)
>  '
>  
> +test_expect_success EXPENSIVE 'create 50,000 more tags' '
> +	(
> +	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	for i in `test_seq 50001 100000`
> +	do
> +		echo "commit refs/heads/too-many-refs-again"
> +		echo "mark :$i"
> +		echo "committer git <git@example.com> $i +0000"
> +		echo "data 0"
> +		echo "M 644 inline bla.txt"
> +		echo "data 4"
> +		echo "bla"
> +		# make every commit dangling by always
> +		# rewinding the branch after each commit
> +		echo "reset refs/heads/too-many-refs-again"
> +		echo "from :50001"
> +	done | git fast-import --export-marks=marks &&
> +
> +	# now assign tags to all the dangling commits we created above
> +	tag=$(perl -e "print \"bla\" x 30") &&
> +	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
> +	)
> +'
> +
> +test_expect_success EXPENSIVE 'fetch the new tags' '
> +	(
> +		cd too-many-refs &&
> +		git fetch --tags &&
> +		test $(git for-each-ref refs/tags | wc -l) = 100000
> +	)
> +'
> +
>  stop_httpd
>  test_done
