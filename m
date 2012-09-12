From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Wed, 12 Sep 2012 10:51:46 -0700
Message-ID: <7vy5kfceod.fsf@alter.siamese.dyndns.org>
References: <1347452248-12222-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 19:52:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBr6V-0005G6-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 19:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760943Ab2ILRvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 13:51:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461Ab2ILRvt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 13:51:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70F098D4E;
	Wed, 12 Sep 2012 13:51:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KMz7ZrQtBaTgGz7HqpbEEKGr0qg=; b=svdhCP
	j3bpIS56U/D4JrkzXL3t95vj51B5IXG+2Yw3zW5We0f9Yfw32KX9HtRv9RbW/fTK
	EhRltr8O4JqFxZI/JraCHfhUl2mrMu5Ac9a9duv1/jQTRtp6GFR38PLxye2Qi5KA
	EO5pqQaqRPnkm9iFnx3SAcNeJY/9xhnaqF75Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jHR37Sbvd6iVPU71ZgLM2lwxagVibgHr
	v6L2v66uC9HYrBUwC6jNVd8rwm/7qFv9At9fLRxCnEEimRceYzqTVJwYn7XF9EsR
	L8oybmdiSncQIKGqZdE+DelPm3azX4DBaAe3s/wlBYxh2MtfLf1TaSs1zpa1JlX0
	edtwNYlEqDY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F9948D4D;
	Wed, 12 Sep 2012 13:51:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9EF28D4C; Wed, 12 Sep 2012
 13:51:47 -0400 (EDT)
In-Reply-To: <1347452248-12222-1-git-send-email-gitter.spiros@gmail.com>
 (Elia Pinto's message of "Wed, 12 Sep 2012 05:17:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85FF515A-FD02-11E1-AE28-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205314>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Recent versions of Linux libc (later than 5.4.23) and glibc (2.x)
> include a malloc() implementation which is tunable via environment
> variables. When MALLOC_CHECK_ is set, a special (less efficient)
> implementation is used which is designed to be tolerant against
> simple errors, such as double calls of free() with the same argument,
> or overruns of a single byte (off-by-one bugs). When MALLOC_CHECK_
> is set to 3, a diagnostic message is printed on stderr
> and the program is aborted.
>
> Setting the MALLOC_PERTURB_ environment variable causes the malloc
> functions in libc to return memory which has been wiped and clear
> memory when it is returned.
> Of course this does not affect calloc which always does clear the memory.
>
> The reason for this exercise is, of course, to find code which uses
> memory returned by malloc without initializing it and code which uses
> code after it is freed. valgrind can do this but it's costly to run.
> The MALLOC_PERTURB_ exchanges the ability to detect problems in 100%
> of the cases with speed.
>
> The byte value used to initialize values returned by malloc is the byte
> value of the environment value. The value used to clear memory is the
> bitwise inverse. Setting MALLOC_PERTURB_ to zero disables the feature.
>
> This technique can find hard to detect bugs.
> It is therefore suggested to always use this flag (at least temporarily)
> when testing out code or a new distribution.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  t/test-lib.sh | 6 ++++++
>  1 file changed, 6 insertions(+)

Interesting, but it bothers me to make it enabled unconditionally.
At least, this shouldn't be enabled under GIT_TEST_OPTS=--valgrind, no?

By the way, "export VAR=VAL" all on the same line, even though it is
in POSIX.1, is reported to be unsupported by some shells people care
about, and needs to be corrected to "VAR=VAL" and "export VAR" as
separate commands.  I think we saw a patch to fix an instance or two
that snuck in recently.

>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 78c4286..98c90b0 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -93,6 +93,12 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
>  export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
>  export EDITOR
>  
> +# Add libc malloc_check and MALLOC_PERTURB test 
> +export MALLOC_CHECK_=3
> +export MALLOC_PERTURB_="$( expr \( $$ % 255 \) + 1)"
> +#
> +
> +
>  # Protect ourselves from common misconfiguration to export
>  # CDPATH into the environment
>  unset CDPATH
