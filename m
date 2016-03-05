From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf_getwholeline: NUL-terminate getdelim buffer on error
Date: Sat, 05 Mar 2016 11:33:08 -0800
Message-ID: <xmqqziucu3d7.fsf@gitster.mtv.corp.google.com>
References: <20160305184330.GA7534@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 05 20:33:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acHwy-00055d-D2
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 20:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbcCETdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 14:33:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750724AbcCETdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 14:33:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12F234A98D;
	Sat,  5 Mar 2016 14:33:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UfL5huMEb1+tuU3hskYym3F46Lc=; b=RRDI48
	mV8A5pgJDthLDC/TrIPXxLTNuxM6tYWSYVXVY5Vbgmnk44emJ8M/mJN9LTcv7ind
	eLpU06QqxW+wH+KIshCmPkqkMNOKBWf/+uKtUOMDtgzO3VwWd9xP3tulR+bfrPJ1
	yyQaIwrEayu8RBE2rigarQCFL/ZlLHO018VsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tmEMjqy0jYf7pK99g+fyrlY4sz5eV+DL
	GcW+QaIjt5XfiQnJwo9ytE0FSjDKYFPqgfMv7TEy8XFZ2fuLTuxwmL/8OYE+ooJ5
	3v8INpNMVSutKWP5tXSuV0uEH8xwsxXi2BTF9DFw1UAEn/7uBIBhsSGgobX17iKX
	ix8d/J21vho=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0AE6B4A98C;
	Sat,  5 Mar 2016 14:33:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 84FB74A98B;
	Sat,  5 Mar 2016 14:33:09 -0500 (EST)
In-Reply-To: <20160305184330.GA7534@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 5 Mar 2016 13:43:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 17A56C44-E309-11E5-879B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288322>

Jeff King <peff@peff.net> writes:

> Not a big rush for 2.8.0-rc, as the bug is in v2.5.0, and I doubt
> there's an easy trigger besides fast-import. But it might be harmless
> enough to squeeze in.

Was it found by a real-world debugging session, or by a code
inspection?  I'd be really impressed if it were the latter ;-)

Thanks, will queue.

>  strbuf.c               | 8 +++++++-
>  t/t9300-fast-import.sh | 4 ++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index f60e2ee..2c08dbb 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -481,9 +481,15 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
>  	if (errno == ENOMEM)
>  		die("Out of memory, getdelim failed");
>  
> -	/* Restore slopbuf that we moved out of the way before */
> +	/*
> +	 * Restore strbuf invariants; if getdelim left us with a NULL pointer,
> +	 * we can just re-init, but otherwise we should make sure that our
> +	 * length is empty, and that the result is NUL-terminated.
> +	 */
>  	if (!sb->buf)
>  		strbuf_init(sb, 0);
> +	else
> +		strbuf_reset(sb);
>  	return EOF;
>  }
>  #else
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 4c5f3c9..25bb60b 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -55,6 +55,10 @@ test_expect_success 'empty stream succeeds' '
>  	git fast-import </dev/null
>  '
>  
> +test_expect_success 'truncated stream complains' '
> +	echo "tag foo" | test_must_fail git fast-import
> +'
> +
>  test_expect_success 'A: create pack from stdin' '
>  	test_tick &&
>  	cat >input <<-INPUT_END &&
