From: Junio C Hamano <gitster@pobox.com>
Subject: Re: imap-send: Use parse options API to determine verbosity
Date: Wed, 05 Nov 2014 13:32:02 -0800
Message-ID: <xmqqk339ibal.fsf@gitster.dls.corp.google.com>
References: <545A3441.9040403@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Wed Nov 05 22:32:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm8Bb-0006TA-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 22:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbaKEVcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 16:32:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750936AbaKEVcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 16:32:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE1F11B466;
	Wed,  5 Nov 2014 16:32:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DN+8OP77o7nZoyqNj3xXNWyxSTg=; b=P8Posh
	bF2WUmds7q2K5hKEs0OPu7MLWTgTV18Ee+p249FWKxGR53dWrUZVBT7NRuaXoBRi
	y/HmHJbo7NSHX4b3jatvEPtk4juYeQT1db1cg/YxNBuh/ZQv2hAKAI9cIZjRW2qp
	msdDw6dLSc/4PBSQodJkD5+isblvkh3N1PU5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mSkN9vinn32KCjCabuBMJs5XPs1XiWSh
	pSQjr+f0Cp3DGqDM5sPiSNDkH6UdYfVleSJzv9DtVsAgRPiudrvRLuLCmkh+AqIH
	fgewON/7JCwctkmnr9yhpae7xViGSCfzxK4ZJCx2byIEQRD7ehoF+yI5IlfbhrpB
	8KiWx/iwF5k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B63171B465;
	Wed,  5 Nov 2014 16:32:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A0DB1B464;
	Wed,  5 Nov 2014 16:32:04 -0500 (EST)
In-Reply-To: <545A3441.9040403@raz.or.at> (Bernhard Reiter's message of "Wed,
	05 Nov 2014 15:29:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F7DD572-6533-11E4-A2F2-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bernhard Reiter <ockham@raz.or.at> writes:

> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
> ---
> As requested per <xmqqzjcewq6p.fsf@gitster.dls.corp.google.com>.

Heh, I didn't quite "request" it, but thanks for a patch anyway.

> diff --git a/imap-send.c b/imap-send.c
> index 70bcc7a..7f40960 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -26,11 +26,19 @@
>  #include "credential.h"
>  #include "exec_cmd.h"
>  #include "run-command.h"
> +#include "parse-options.h"
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
>  #endif
>  
> -static const char imap_send_usage[] = "git imap-send < <mbox>";
> +static int verbosity;
> +
> +static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] < <mbox>", NULL };
> +
> +static struct option imap_send_options[] = {
> +	OPT__VERBOSITY(&verbosity),
> +	OPT_END()
> +};
>  
>  #undef DRV_OK
>  #define DRV_OK          0
> @@ -38,8 +46,6 @@ static const char imap_send_usage[] = "git imap-send < <mbox>";
>  #define DRV_BOX_BAD     -2
>  #define DRV_STORE_BAD   -3
>  
> -static int Verbose, Quiet;

So it used to be Verbose and Quiet both defaulting to 0 (false).
Now we have verbosity that defaults to 0, positive telling us to be
verbose and negative telling us to be quiet.

>  __attribute__((format (printf, 1, 2)))
>  static void imap_info(const char *, ...);
>  __attribute__((format (printf, 1, 2)))
> @@ -418,7 +424,7 @@ static int buffer_gets(struct imap_buffer *b, char **s)
>  			if (b->buf[b->offset + 1] == '\n') {
>  				b->buf[b->offset] = 0;  /* terminate the string */
>  				b->offset += 2; /* next line */
> -				if (Verbose)
> +				if (verbosity >= 0)
>  					puts(*s);

... which means this should be "if (0 < verbosity)", i.e. we do not
squeak without "-v", no?

> @@ -433,7 +439,7 @@ static void imap_info(const char *msg, ...)
>  {
>  	va_list va;
>  
> -	if (!Quiet) {
> +	if (verbosity >= 0) {

This one looks sensible; unless we are told to be "-q"uiet, we used
to give this message, and we will continue to do so.

>  		va_start(va, msg);
>  		vprintf(msg, va);
>  		va_end(va);
> @@ -445,7 +451,7 @@ static void imap_warn(const char *msg, ...)
>  {
>  	va_list va;
>  
> -	if (Quiet < 2) {
> +	if (verbosity < 2) {
>  		va_start(va, msg);
>  		vfprintf(stderr, msg, va);
>  		va_end(va);

The cut-off value "2" looks strange, but more importantly this
conversion looks bogus no matter what the cut-off value is.

"As long as the verbosity is smaller than this value, emit this
error message????"  That sounds backwards that you do not give the
message if you see sufficient number of "-v" options, doesn't it?

I think

	if (-2 < verbosity)

would be in line with what the original logic seems to have wanted,
that is "If the caller did not ask us to be extra quiet (i.e. just
the regular Quiet=1 does not count), show this message".

> @@ -522,7 +528,7 @@ static struct imap_cmd *issue_imap_cmd(struct imap_store *ctx,
>  				  cmd->tag, cmd->cmd, cmd->cb.dlen,
>  				  CAP(LITERALPLUS) ? "+" : "");
>  
> -	if (Verbose) {
> +	if (verbosity >= 0) {

Same comment as the one at hunk -418,7 above applies.
