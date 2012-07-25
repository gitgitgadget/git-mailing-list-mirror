From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] help.c: plug leaks with(out) help.autocorrect
Date: Wed, 25 Jul 2012 10:47:57 -0700
Message-ID: <7vy5m7bulu.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
 <1343232982-10540-3-git-send-email-rctay89@gmail.com>
 <1343232982-10540-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 19:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su5gt-00030l-36
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 19:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab2GYRsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 13:48:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab2GYRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 13:47:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D3FB8EF4;
	Wed, 25 Jul 2012 13:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kigg0+3UGwpHvNhIcQg/7WqTKuQ=; b=TyRxrS
	GNpMYavRK2UOf0aGILh+GdKbpJkOX6hSdNphCUOCFMyVBlBcieOqHrZi27QT32z2
	7igVnkNum7wJbnVjo38Rp7t0DGfIuza/9c4ZMbhftvAp7f45A6OxPn/evyqFcu1X
	gOjdwWMk+DDkwkmgtCblhHG8h2rXqQKmdGXBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=otrxRzXY+hHLdE2yJ7ZId6T4KHObOkvo
	Q7acaf1PT2GZKaXFy8NT4n+zwpcNF8/a4vYB6aCJrnj4bfLSgj/dm2X25/pC8B2b
	BpWq7xWUBHh8WFFHTtUZdnmjOTYXYF4VZMxhvLE3lion5CDxnIudJQ6rj/bQTioL
	Kk9mk+Ikm5g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BAB78EF3;
	Wed, 25 Jul 2012 13:47:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7363A8EF2; Wed, 25 Jul 2012
 13:47:58 -0400 (EDT)
In-Reply-To: <1343232982-10540-4-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu, 26 Jul 2012 00:16:21 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF16F7AA-D680-11E1-843E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202180>

Tay Ray Chuan <rctay89@gmail.com> writes:

> When help.autocorrect is set, in an attempt to retain the memory to the
> string name in main_cmds, we unfortunately leaked the struct cmdname
> that held it. Fix this by creating a copy of the string name.

If you are updating help_unknown_cmd() so that the caller can free
(and is responsible for freeing if it wants to avoid leaks) the
piece of memory it returns, that change to "assumed" makes sense.
What we were returning were not freeable.

Butthe caller does not free it; what you did is merely to shift the
leakage from here to its caller.

Is it worth the churn and one extra allocation to still leak
slightly (namely, by sizeof(size_t)) smaller chunk of memory than
what the code currently does?  I doubt it.

> When help.autocorrect is not set, we exit()'d without free'ing it like
> we do when the config is set; fix this.

I don't see any point in doing this, immediately in the same
function on the previous line of exit(1).

> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>
> Changed in v2: plug leak when help.autocorrect is not set.
>
> ---
>  help.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/help.c b/help.c
> index dfb2e9d..ee261f4 100644
> --- a/help.c
> +++ b/help.c
> @@ -362,8 +362,7 @@ const char *help_unknown_cmd(const char *cmd)
>  			; /* still counting */
>  	}
>  	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
> -		const char *assumed = main_cmds.names[0]->name;
> -		main_cmds.names[0] = NULL;
> +		const char *assumed = xstrdup(main_cmds.names[0]->name);
>  		clean_cmdnames(&main_cmds);
>  		fprintf_ln(stderr,
>  			   _("WARNING: You called a Git command named '%s', "
> @@ -390,6 +389,7 @@ const char *help_unknown_cmd(const char *cmd)
>  			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
>  	}
>  
> +	clean_cmdnames(&main_cmds);
>  	exit(1);
>  }
