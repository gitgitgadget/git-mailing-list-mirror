From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/11] streaming_write_entry(): use streaming API in
 write_entry()
Date: Fri, 20 May 2011 15:52:51 -0700
Message-ID: <7vvcx50yt8.fsf@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 00:54:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNYaD-0004Zb-5U
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 00:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab1ETWw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 18:52:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab1ETWw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 18:52:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB48F5BB9;
	Fri, 20 May 2011 18:55:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5y3LkAeZMdtbQXBve4BFIrlLYVU=; b=Tpd4TS
	AXvBnTgR+x+KF7XDKogVs3I8Ll9tqvWrsEygaFFdH1Uw8bGz6b+HIl4yG/LIbj9c
	7UnHZI6MlcpweaqjYiCkR9ndjbxGm1pcQMGrPH72wvebycdcb9mGcihcLQG0dMh+
	xZvbFF9ngSX4nfsl9en7yLgi7Sgmfv1khxEk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C5ekb2zHxcxLa+uhmEmBqiut/ZO2XYI6
	ZneafrXgmnuH7bjHWsC67lxrK0I5sH53HeqUBcg15wgQYXaM+U0vYbtQt4hDRgBK
	7HcYHXZBQExipppnsf63l3gXGCZMzLC1uwM8gk/XSaqQJYjvHbhPrfvq0Iinldrj
	Fc90k3GEPwg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BBB185BB8;
	Fri, 20 May 2011 18:55:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7B1D5BB7; Fri, 20 May 2011
 18:55:00 -0400 (EDT)
In-Reply-To: <1305840826-7783-8-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Thu, 19 May 2011 14:33:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3250DBBC-8334-11E0-9B3D-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174082>

Junio C Hamano <gitster@pobox.com> writes:

> When the output to a path does not have to be converted, we can read from
> the object database from the streaming API and write to the file in the
> working tree, without having to hold everything in the memory.

There was an embarrassing bug hiding here.  The way I found it was doubly
embarrassing.

> diff --git a/entry.c b/entry.c
> index cc6502a..7733a6b 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -114,6 +115,50 @@ static int fstat_output(int fd, const struct checkout *state, struct stat *st)
>  	return 0;
>  }
>  
> +static int streaming_write_entry(struct cache_entry *ce, char *path,
> +				 const struct checkout *state, int to_tempfile,
> +				 int *fstat_done, struct stat *statbuf)
> +{
> +	struct git_istream *st;
> +	enum object_type type;
> +	unsigned long sz;
> +	int result = -1;

We see result is initialized to -1 here...

> +	int fd = -1;
> +
> +	st = open_istream(ce->sha1, &type, &sz);
> + ...
> +close_and_exit:
> +	close_istream(st);

...but nobody touches it before coming here via various codepaths.  If I
haven't opened the output, fd is -1, but if I have, then the condition of
the next if statement is met, and I close the output.

> +	if (0 <= fd)
> +		result |= close(fd);

Oops. This is the embarrassment. This has to be an assignment, not OR-ing
it in. I am not clearing the result in a successful case.

> +	if (result && 0 <= fd)
> +		unlink(path);
> +	return result;

Hence, even though the codepath fully wrote out, we run unlink(path), and
return a failure.

> @@ -124,6 +169,12 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
>  	size_t wrote, newsize = 0;
>  	struct stat st;
>  
> +	if ((ce_mode_s_ifmt == S_IFREG) &&
> +	    can_bypass_conversion(path) &&
> +	    !streaming_write_entry(ce, path, state, to_tempfile,
> +				   &fstat_done, &st))
> +		goto finish;

Then the caller just thinks that the contents could not be streamed
(e.g. the data is in pack deltified) and takes the fall-back codepath to
fix everything up, hiding the above bug.

>  	switch (ce_mode_s_ifmt) {
>  	case S_IFREG:
>  	case S_IFLNK:
>		... fall-back code follows ...

The other embarrassment is the way how I found the bug.  I was trying to
rewrite this "if regular file and can bypass conversion, try streaming"
logic, and botched the result to jump to "finish" when streaming write
returned failure.

Will re-queue with the obvious fix squashed in.
