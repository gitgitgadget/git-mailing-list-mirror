From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] revert: Make commit descriptions in insn sheet
 optional
Date: Mon, 10 Oct 2011 10:54:50 -0700
Message-ID: <7vwrccn34l.fsf@alter.siamese.dyndns.org>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
 <1318095407-26429-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 19:55:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDK43-0001ku-0e
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 19:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab1JJRyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 13:54:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab1JJRyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 13:54:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB6844750;
	Mon, 10 Oct 2011 13:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zV6u1SPDT0s5DNjBC+Dmk91+Er8=; b=xI6Ggy
	PJsv6A4LgjJO3NYGzTg4NsKsAOsV5yxyx913+CGZPlr2LoshfjuhdeCjXKIPTd+j
	qqSqyOImbB9KU5I1iPTC3R8P1aUMWD4j5lYYb3/Lja6UB5/5+DaNsuB9cEG4KbOq
	BknXQio6VKUyR0P/K5Ajf1YcMV0DFJIDPllD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EarBm8QD+87qOEVRMwLI02qalxSKox5x
	e/EVCkpoYQpUci52njwgFoCioRClJ4NHTYqEekdFuKUwmAtKNaQ7XnDFxkdEMAh3
	of2WQ3QEwYI7eu74/tONhXG66aGgMiiin5y/T1PBfvyGvzehK/JwPC5SMrWVQJyM
	/csLDo78BFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1B92474F;
	Mon, 10 Oct 2011 13:54:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29321474E; Mon, 10 Oct 2011
 13:54:52 -0400 (EDT)
In-Reply-To: <1318095407-26429-5-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Sat, 8 Oct 2011 23:06:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F44AE6F0-F368-11E0-8A79-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183248>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Change the instruction sheet format subtly so that a description of
> the commit after the object name is optional.  As a result, an
> instruction sheet like this is now perfectly valid:
>
>   pick 35b0426
>   pick fbd5bbcbc2e
>   pick 7362160f
>
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/revert.c                |   19 ++++++++-----------
>  t/t3510-cherry-pick-sequence.sh |   14 ++++++++++++++
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 6451089..aa6c34e 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -692,26 +692,23 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
>  	unsigned char commit_sha1[20];
>  	char sha1_abbrev[40];
>  	enum replay_action action;
> -	int insn_len = 0;
> -	char *p, *q;
> +	const char *p, *q;
>  
> +	p = start;
>  	if (!prefixcmp(start, "pick ")) {
>  		action = CHERRY_PICK;
> -		insn_len = strlen("pick");
> -		p = start + insn_len + 1;
> +		p += strlen("pick ");
>  	} else if (!prefixcmp(start, "revert ")) {
>  		action = REVERT;
> -		insn_len = strlen("revert");
> -		p = start + insn_len + 1;
> +		p += strlen("revert ");
>  	} else
>  		return NULL;
>  
> -	q = strchr(p, ' ');
> -	if (!q || q - p + 1 > sizeof(sha1_abbrev))
> +	q = p + strcspn(p, " \n");
> +	if (q - p + 1 > sizeof(sha1_abbrev))
>  		return NULL;
> -	q++;
> -
> -	strlcpy(sha1_abbrev, p, q - p);
> +	memcpy(sha1_abbrev, p, q - p);
> +	sha1_abbrev[q - p] = '\0';

Since this is a part of clean-up series...

Do you even need to have a sha1_abbrev[] local array that is limited to 40
bytes here? The incoming _line_ is not "const char *start", so you should
at least be able to temporarily terminate the commit object name with NUL
(while remembering what byte there was before), give it to get_sha1(), and
then restore the byte at the end before returning from this function.

A bonus point would be to introduce a variant of get_sha1() that can take
(a pointer + len) not (a pointer to NUL terminated string). While I think
that would be a right thing to do in the longer term, it is outside of the
scope of this series.
