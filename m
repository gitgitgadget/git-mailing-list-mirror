From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere forget: grok files containing NUL
Date: Mon, 01 Apr 2013 15:48:55 -0700
Message-ID: <7vhajpj294.fsf@alter.siamese.dyndns.org>
References: <5159FDE4.2090409@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 02 00:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMnXb-0006kY-Ly
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 00:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759296Ab3DAWs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 18:48:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759286Ab3DAWs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 18:48:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBCE911B1D;
	Mon,  1 Apr 2013 22:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7DkGV8F25uNZNCndQGiyPUBXFF8=; b=c+lo4d
	LeKi3bDgV808WbZznxNmF4EZQvkPz+ZsPJ/qmZGUUxiEzMuI5TTzjBYK8WDmb3O2
	sugphfoicCwJClkY9i23gWGKTThRl62CRz8JM6YbEh0tWRdxnGmmmwEYQYJMP/q0
	BbcyP/I3TucFeYGXMvLvF2q6VRXgkLLQRo/XA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZwmRKQN07BZoBamKvLwas/6A0Acnv94z
	pJHA8havKkdyLu1DEbrUi2eBM9I5df75S5KMDPSvM0FrE2d2Tdejk1cSI3IyyO1P
	mHC8tmxfIFtpFOZR25x+0kCKR9JucsvqOrSsVfb3lt4ot/esGDvwTGoNeA6bPokK
	f2PhpkvO+bw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B397811B1B;
	Mon,  1 Apr 2013 22:48:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 126C411B18; Mon,  1 Apr
 2013 22:48:56 +0000 (UTC)
In-Reply-To: <5159FDE4.2090409@kdbg.org> (Johannes Sixt's message of "Mon, 01
 Apr 2013 23:36:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5620AC6C-9B1E-11E2-8430-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219722>

Johannes Sixt <j6t@kdbg.org> writes:

> Using 'git rerere forget .' after a merge that involved binary files
> runs into an infinite loop if the binary file contains a zero byte.
> Replace a strchrnul by memchr because the former does not make progress
> as soon as the NUL is encountered.

Hmph, thanks.

Is it the right behaviour for rerere to even attempt to interfere
with a merge that involves binary files in the first place?

Does the three-way merge machinery replay recorded resolution for
such a binary file correctly (after your fix, that is)?

> diff --git a/rerere.c b/rerere.c
> index a6a5cd5..4d940cd 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -284,8 +284,10 @@ static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
>  	strbuf_release(sb);
>  	if (!io->input.len)
>  		return -1;
> -	ep = strchrnul(io->input.buf, '\n');
> -	if (*ep == '\n')
> +	ep = memchr(io->input.buf, '\n', io->input.len);
> +	if (!ep)
> +		ep = io->input.buf + io->input.len;
> +	else if (*ep == '\n')
>  		ep++;
>  	len = ep - io->input.buf;
>  	strbuf_add(sb, io->input.buf, len);
> diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
> index f262065..0b699f5 100755
> --- a/t/t2030-unresolve-info.sh
> +++ b/t/t2030-unresolve-info.sh
> @@ -44,9 +44,13 @@ prime_resolve_undo () {
>  
>  test_expect_success setup '
>  	mkdir fi &&
> +	printf "a\0a" >binary &&
> +	git add binary &&
>  	test_commit initial fi/le first &&
>  	git branch side &&
>  	git branch another &&
> +	printf "a\0b" >binary &&
> +	git add binary &&
>  	test_commit second fi/le second &&
>  	git checkout side &&
>  	test_commit third fi/le third &&
> @@ -167,4 +171,12 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'rerere forget (binary)' '
> +	git checkout -f side &&
> +	printf "a\0c" >binary &&
> +	git commit -a -m binary &&
> +	test_must_fail git merge second &&
> +	git rerere forget binary
> +'
> +
>  test_done
