From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][GSOC2014] add: Rewrite run_add_interactive to use struct argv_array
Date: Tue, 18 Mar 2014 12:47:59 -0700
Message-ID: <xmqq1txz8f0w.fsf@gitster.dls.corp.google.com>
References: <1395145875-5072-1-git-send-email-movchan.pv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Movchan Pavel <movchan.pv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 20:48:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPzze-0007jf-6S
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 20:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575AbaCRTsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 15:48:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779AbaCRTsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 15:48:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61B3772C31;
	Tue, 18 Mar 2014 15:48:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FqgvLpBBhMsiGtiwBJrd4sRFjZ0=; b=jBWYXP
	bKPDNEsAsgSuDW/yfhld4YyK/RnqYlJS2i4X717L4a7XOz5d+Ws4e0oTrbOjY1SE
	Zt/BO9v2hPAWCSWKHAP0NRlqWG5De+SIimSB38IjCCwSAZCIdnx5ULHbKHY0gn8j
	Nvw59W2XP2lp75qAI9f/dwJ5EOhn3q5JWq4F0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J9j3/TWcqpI9X5HpSLZdQRgK94UuCOgc
	7u5Eh+mks6a2vv3FUVcqgAS57VT4k3wV6pWFIzo1m17JgHTc0hZiXD2dQoPZ54TI
	4Z9ZmE6yOatGj+ouwhaHZjcRNebEFsZo2It1FX0jz78qCmR7iXq7Ekk6CXKltp5Q
	1y1MH7ZAIOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A95672C30;
	Tue, 18 Mar 2014 15:48:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36DD672C2B;
	Tue, 18 Mar 2014 15:48:02 -0400 (EDT)
In-Reply-To: <1395145875-5072-1-git-send-email-movchan.pv@gmail.com> (Movchan
	Pavel's message of "Tue, 18 Mar 2014 20:31:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 372069C0-AED6-11E3-84A3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244375>

Movchan Pavel <movchan.pv@gmail.com> writes:

> Origin code are code with own realisation argv array editing.
> It was changed, and code modified for using unified argv-array
> realisation from argv-array.h.
> Commit for Google Summer of Code 2014
>
> Signed-off-by: Movchan Pavel <movchan.pv@gmail.com>
> ---

Thanks.  "Commit for ..." is not something we would want to see in
"git log" output, though.

>  builtin/add.c |   21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 4b045ba..258b491 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -15,6 +15,7 @@
>  #include "diffcore.h"
>  #include "revision.h"
>  #include "bulk-checkin.h"
> +#include "argv-array.h"
>  
>  static const char * const builtin_add_usage[] = {
>  	N_("git add [options] [--] <pathspec>..."),
> @@ -141,23 +142,21 @@ static void refresh(int verbose, const struct pathspec *pathspec)
>  int run_add_interactive(const char *revision, const char *patch_mode,
>  			const struct pathspec *pathspec)
>  {
> -	int status, ac, i;
> -	const char **args;
> +	int status, i;
> +	struct argv_array *argv = ARGV_ARRAY_INIT;

Where does that pointer point at and who allocated the piece of
memory used by it?

See http://thread.gmane.org/gmane.comp.version-control.git/244151
for an example solution.

>  
> -	args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
> -	ac = 0;
> -	args[ac++] = "add--interactive";
> +	argv_array_push(argv, "add--interactive");
>  	if (patch_mode)
> -		args[ac++] = patch_mode;
> +		argv_array_push(argv, patch_mode);
>  	if (revision)
> -		args[ac++] = revision;
> -	args[ac++] = "--";
> +		argv_array_push(argv, revision);
> +	argv_array_push(argv, "--");
>  	for (i = 0; i < pathspec->nr; i++)
>  		/* pass original pathspec, to be re-parsed */
> -		args[ac++] = pathspec->items[i].original;
> +		argv_array_push(argv, pathspec->items[i].original);
>  
> -	status = run_command_v_opt(args, RUN_GIT_CMD);
> -	free(args);
> +	status = run_command_v_opt(argv->argv, RUN_GIT_CMD);
> +	argv_array_clear(argv);
>  	return status;
>  }
