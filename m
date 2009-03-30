From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] quote: add "sq_dequote_to_argv" to put unwrapped
 args in an argv array
Date: Sun, 29 Mar 2009 23:48:04 -0700
Message-ID: <7vhc1bjyl7.fsf@gitster.siamese.dyndns.org>
References: <20090329114452.b19a2f60.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:49:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBJZ-0007Dw-CZ
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbZC3GsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 02:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbZC3GsP
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:48:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbZC3GsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:48:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BA5EA69FD;
	Mon, 30 Mar 2009 02:48:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 99DEAA69FC; Mon,
 30 Mar 2009 02:48:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BCBA0860-1CF6-11DE-A629-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115088>

Christian Couder <chriscool@tuxfamily.org> writes:

> This new function unwraps the space separated shell quoted elements in
> its first argument and put a copy of them in the argv array passed as
> its second argument.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  quote.c |   17 +++++++++++++++++
>  quote.h |    2 ++
>  2 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/quote.c b/quote.c
> index 8cf0ef4..5b12a4a 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -120,6 +120,23 @@ char *sq_dequote(char *arg)
>  	return sq_dequote_many(arg, NULL);
>  }
>  
> +int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc)
> +{
> +	char *next = arg;
> +
> +	if (!*arg)
> +		return 0;
> +	do {
> +		char *dequoted = sq_dequote_many(next, &next);
> +		if (!dequoted)
> +			return 1;

Usually we signal an error with a negative value, e.g. -1.

> +		ALLOC_GROW(*argv, *nr + 1, *alloc);
> +		(*argv)[(*nr)++] = xstrdup(dequoted);

The original sq_dequote() interface takes advantage of the fact that the
result of single-quote unquoting is always shorter than the original and
it can rewrite the argument in-place to return the result.  I would expect
dequote_step() to retain that trait and allow the caller to use its return
value without xstrdup().

But please do not send in replacements just yet.
