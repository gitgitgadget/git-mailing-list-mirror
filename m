From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/9] git rm: do not abort due to an initialised
 submodule
Date: Sat, 10 Apr 2010 18:25:31 -0700
Message-ID: <7vaatasruc.fsf@alter.siamese.dyndns.org>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
 <1270923830-11830-8-git-send-email-peter@pcc.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Collingbourne <peter@pcc.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 03:25:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0lvw-0001ts-5M
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 03:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab0DKBZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 21:25:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab0DKBZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 21:25:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7949EA9D83;
	Sat, 10 Apr 2010 21:25:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=3QH3VafcQ546JEfFQOpuN3NWkQ4=; b=c+OGvj
	SuRZgMxtuswIDEJSfDUa5IubP/HDfONDzUqHwKiwNlpFY3k0woBwOz8nfpR6FJ6N
	a8mYzVQH34ogej4GsJ5JEVAUkWgov1JYwA4EERoMOCLrgnx63PzRwGDxckooS/A1
	HP2IEwfRn4zJtcn7Mdv1kRrskKoBdgyfwR6EA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FltyiHZbMHSjF5hwHU8eMgY1v+yzsZ66
	dqEv2SUinw79nuRPQgdCzFufRbKsseQA6Wnc/LPE2MOxyzReSRLlbzwyS+PnNRDx
	ar9ctuTooiWCjE8rqUu6tj/3yJv0WYgN2lxNc7N/TJW2eBlL/6FW5TOV1Xm+rxvU
	6YfErErFI+A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 570E4A9D7D;
	Sat, 10 Apr 2010 21:25:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEC03A9D7B; Sat, 10 Apr
 2010 21:25:32 -0400 (EDT)
In-Reply-To: <1270923830-11830-8-git-send-email-peter@pcc.me.uk> (Peter
 Collingbourne's message of "Sat\, 10 Apr 2010 19\:23\:48 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20E45198-4509-11DF-A63E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144623>

Peter Collingbourne <peter@pcc.me.uk> writes:

> This patch causes the "git rm" command to consider "directory not
> empty" errors as nonfatal, which will be caused by a submodule being
> in an initialised state.  As this is a normal state for a submodule,
> ...
> Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> ---
>  builtin/rm.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 6ac5114..02ee259 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -250,7 +250,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  	 * abort the "git rm" (but once we've successfully removed
>  	 * any file at all, we'll go ahead and commit to it all:
>  	 * by then we've already committed ourselves and can't fail
> -	 * in the middle)
> +	 * in the middle).  However failure to remove a submodule
> +	 * directory due to the submodule being initialised is never
> +	 * a fatal condition.
>  	 */


Your messages both in the commit log and comment talk only about
submodules, ...

> @@ -261,7 +263,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  				removed = 1;
>  				continue;
>  			}
> -			if (!removed)
> +			if (!removed && errno != EEXIST && errno != ENOTEMPTY)
>  				die_errno("git rm: '%s'", path);
>  			else
>  				warning("git rm: '%s': %s", path, strerror(errno));

... but the code does not seem to limit itself to the case where a
submodule removal has failed.

How does this patch affect the failure case for regular files and
directories without any submodules?
