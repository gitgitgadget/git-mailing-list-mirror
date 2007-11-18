From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] send-pack: assign remote errors to each ref
Date: Sat, 17 Nov 2007 17:03:57 -0800
Message-ID: <7vir40z7nm.fsf@gitster.siamese.dyndns.org>
References: <20071117125323.GA23125@sigill.intra.peff.net>
	<20071117125602.GC23186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 18 02:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItYaN-00011l-2k
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 02:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbXKRBEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 20:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbXKRBEH
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 20:04:07 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52977 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbXKRBEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 20:04:06 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 10B032F0;
	Sat, 17 Nov 2007 20:04:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 33CA896E80;
	Sat, 17 Nov 2007 20:04:21 -0500 (EST)
In-Reply-To: <20071117125602.GC23186@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 17 Nov 2007 07:56:03 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65328>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index c7d07aa..bcf7143 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -146,19 +146,43 @@ static void get_local_heads(void)
>  	for_each_ref(one_local_ref, NULL);
>  }
>  
> -static int receive_status(int in)
> +static struct ref *set_ref_error(struct ref *refs, const char *line)
>  {
> +	struct ref *ref;
> +
> +	for (ref = refs; ref; ref = ref->next) {
> +		const char *msg;
> +		if (prefixcmp(line, ref->name))
> +			continue;
> +		msg = line + strlen(ref->name);
> +		if (*msg++ != ' ')
> +			continue;
> +		ref->status = REF_STATUS_REMOTE_REJECT;
> +		ref->error = xstrdup(msg);
> +		ref->error[strlen(ref->error)-1] = '\0';
> +		return ref;
> +	}
> +	return NULL;
> +}

It probably would not matter for sane repositories, but with
thousands of refs, strlen() and prefixcmp() may start to hurt:

	struct ref *ref;
	int reflen;
	const char *msg = strchr(line, ' ');

        if (!msg)
        	return NULL;
	reflen = msg - line;
	msg++;
	for (ref = refs; ref; ref = ref->next) {
        	if (strncmp(line, ref->name, reflen) || line[reflen] != ' ')
			continue;
		...
		return ref->next;
	}
	return NULL;

but the "hint" optimization probably make the above
micro-optimization irrelevant.

> +/* a return value of -1 indicates that an error occurred,
> + * but we were able to set individual ref errors. A return
> + * value of -2 means we couldn't even get that far. */

It is preferred to have a multi-line comment like this:

	/*
         * A return value of -1 ...
	 * ...
	 * ... couldn't even get that far.
	 */

> +static int receive_status(int in, struct ref *refs)
> ...
> +	hint = NULL;
>  	while (1) {
>  		len = packet_read_line(in, line, sizeof(line));
>  		if (!len)
> @@ -171,7 +195,10 @@ static int receive_status(int in)
>  		}
>  		if (!memcmp(line, "ok", 2))
>  			continue;
> -		fputs(line, stderr);
> +		if (hint)
> +			hint = set_ref_error(hint, line + 3);
> +		if (!hint)
> +			hint = set_ref_error(refs, line + 3);

Clever... taking advantage of the order receive-pack reports to
optimize.

Before receive_status() is called, can the refs already have the
error status and string set?

> @@ -429,12 +463,15 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
>  	}
>  	close(out);
>  
> -	print_push_status(dest, remote_refs);
> -
>  	if (expect_status_report) {
> -		if (receive_status(in))
> +		ret = receive_status(in, remote_refs);
> +		if (ret == -2)
>  			return -1;

Hmm.  When we did not receive status, we cannot tell what
succeeded or failed, but what we _can_ tell the user is which
refs we attempted to push.  I wonder if robbing that information
from the user with this "return -1" is a good idea.  Perhaps we
would instead want to set the status of all the refs to error
and call print_push_status() anyway?  I dunno.

>  	}
> +	else
> +		ret = 0;
> +
> +	print_push_status(dest, remote_refs);
>  
>  	if (!args.dry_run && remote) {
>  		for (ref = remote_refs; ref; ref = ref->next)
