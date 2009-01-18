From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 2/5] sha1_name: tweak @{-N} lookup
Date: Sat, 17 Jan 2009 16:54:28 -0800
Message-ID: <7v4ozx5t8b.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 18 01:56:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOLxM-0000Jw-5L
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 01:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160AbZARAyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 19:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757125AbZARAyj
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 19:54:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469AbZARAyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 19:54:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56247912BC;
	Sat, 17 Jan 2009 19:54:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0C7DA912BA; Sat,
 17 Jan 2009 19:54:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93C910C4-E4FA-11DD-96D3-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106121>

Thomas Rast <trast@student.ethz.ch> writes:

> Have the lookup only look at "interesting" checkouts, meaning those
> that tell you "Already on ..." don't count even though they also cause
> a reflog entry.
>
> Let interpret_nth_last_branch() return the number of characters
> parsed, so that git-checkout can verify that the branch spec was
> @{-N}, not @{-1}^2 or something like that.  (The latter will be added
> later.)

Thanks; you seem to have handled the issues I pointed out in response to
my own weatherbaloon patch.  I think it is probably better to squash the
first two (and you take the authorship).

> diff --git a/sha1_name.c b/sha1_name.c
> index 6377264..34e39db 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -685,29 +685,28 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
>  				  const char *message, void *cb_data)
>  {
>  	struct grab_nth_branch_switch_cbdata *cb = cb_data;
> -	const char *match = NULL;
> -
> -	if (!prefixcmp(message, "checkout: moving to "))
> -		match = message + strlen("checkout: moving to ");
> -	else if (!prefixcmp(message, "checkout: moving from ")) {
> -		const char *cp = message + strlen("checkout: moving from ");
> -		if ((cp = strstr(cp, " to ")) != NULL) {
> -			match = cp + 4;
> -		}
> +	const char *match = NULL, *target = NULL;
> +	size_t len;
> +
> +	if (!prefixcmp(message, "checkout: moving from ")) {
> +		match = message + strlen("checkout: moving from ");
> +		if ((target = strstr(match, " to ")) != NULL)
> +			target += 4;
>  	}

This drops support for older reflog records, but I think it would be Ok.
This "N-th" support is really meant to be for small number of N anyway.

> -	if (--cb->nth <= 0) {
> -		size_t len = strlen(match);
> -		while (match[len-1] == '\n')
> -			len--;
> +	if (cb->nth-- <= 0) {
>  		strbuf_reset(cb->buf);
>  		strbuf_add(cb->buf, match, len);
>  		return 1;

Hmm, did I have an off-by-one I did not notice? ;-)

>  int interpret_nth_last_branch(const char *name, struct strbuf *buf)
>  {
> -	int nth, i;
> +	int nth;
>  	struct grab_nth_branch_switch_cbdata cb;
> +	const char *brace;
> +	char *num_end;
>  
>  	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
>  		return -1;
> -	for (i = 3, nth = 0; name[i] && name[i] != '}'; i++) {
> -		char ch = name[i];
> -		if ('0' <= ch && ch <= '9')
> -			nth = nth * 10 + ch - '0';
> -		else
> -			return -1;
> -	}
> -	if (nth < 0 || 10 <= nth)

The removal of "limit to reasonably small recent N" I somewhat have
reservations on, but I think we can later re-add something based on
configuration variable if we need to.
