From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] Emit a whole line once a time
Date: Fri, 28 May 2010 18:10:39 -0700
Message-ID: <7vocfz5x80.fsf@alter.siamese.dyndns.org>
References: <1274858637-13243-1-git-send-email-struggleyb.nku@gmail.com>
 <1274858637-13243-2-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 03:10:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIAZm-0005RO-H1
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 03:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722Ab0E2BKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 21:10:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab0E2BKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 21:10:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D45A3B77B4;
	Fri, 28 May 2010 21:10:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=kcdFeg+BuBPs33oGKffOXYUIAYw=; b=phKUw4z3q2iQt2V7BaJ56Fr
	i+3B10NOn3fWJbrnKoN+13Jw0b4M4mtJUrZz3qlu/MVYWf+4e1O7Mp91kaKhXOWI
	5AWEWR4ylLsHNLKy1yqcZRrPlqyR9Fut+ktVKMyUpXgC92n5+vaw5/P+YeUSJvaH
	WyJ8682I21uIGyo2olpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=COXc1n4AD1RvrdWF6GgSu+0ARgR6G4JJAfHdcKFkke78sfsTY
	CndlKKipJOU+EDBZCgWgq8Ma3gsAAQlaAJqMjoMm0BSSS7P0HD8+t4FrZ52xKEt0
	anpC7PTopiCu6voiXFpCV06X4EcGmlyhYkv08cWSG1VW3TXbH9tzIGfpCI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F66AB77B2;
	Fri, 28 May 2010 21:10:46 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73FBBB77B0; Fri, 28 May
 2010 21:10:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03020B8A-6ABF-11DF-B0B3-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147943>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Since the graph prefix will be printed when calling
> emit_line, so the functions should be used to emit a
> complete line out once a time. No one should call
> emit_line to just output some strings instead of a
> complete line.
> Use a strbuf to compose the whole line, and then
> call emit_line to output it once.

"once a time" in your title doesn't sound quite right.  I would say "in
one go" instead.

> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  diff.c |   34 +++++++++++++++++++++++++++++-----
>  1 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 7f2538d..bffaedc 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -370,6 +370,18 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
>  	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
>  	static const char atat[2] = { '@', '@' };
>  	const char *cp, *ep;
> +	struct strbuf msgbuf = STRBUF_INIT;
> +	int org_len = len;
> +
> +	/*
> +	 * trailing \r\n
> +	 */
> +	int i = 1;
> +	for (; i < 3; i++) {
> +		if (line[len - i] == '\r' || line[len - i] == '\n') {
> +			len --;
> +		}
> +	}

I am not very happy with this logic.  The existing code (just outside the
post-context of this hunk) is being defensive and returns early when len
is shorter than what we expect, but this new code blindly assumes that len
is at least 2 bytes long, and also it would eat a line that ends with \r\r.

Can the partial line at the end be on this line?  IOW, can line[len-1] be
different from '\n' in some cases?

What's the reason to strip trailing "\r" at the end of the line to begin
with?

>  	/*
>  	 * As a hunk header must begin with "@@ -<old>, +<new> @@",
