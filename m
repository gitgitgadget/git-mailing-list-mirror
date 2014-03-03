From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] commit.c: Use skip_prefix() instead of starts_with()
Date: Mon, 03 Mar 2014 11:43:35 -0800
Message-ID: <xmqqiorvoyoo.fsf@gitster.dls.corp.google.com>
References: <1393862398-2989-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:43:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYmF-0002N8-9f
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbaCCTnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:43:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbaCCTnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:43:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C57CF6F263;
	Mon,  3 Mar 2014 14:43:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n1tXjpaMhSVfv6DUJ5xvYCPk0MA=; b=BkS0Oc
	ZyDQCndR8Iy+Nx0ruajfL0JG8clJSmZTpBPJuvL+PHvzlUEzkAPLJ1WXpt25alnI
	iZYCAMz1/GNBZNIBxvbeK/H5SKhfZLHGpay/Nn2AEzii4r/hlvFaXLkE2Ugse6vG
	lUufJ5RL4VcpF6ML5APH1vBSTyP9bgDDnWYxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dPUoXMGh89FEbr0blacOAvvGnd6EMO1t
	1/PMGw67jfR8EAqm1d1WMlScHmpyx5bi5OHurVPWBlJ0uFz/WjJXhzx75bCKH4kJ
	itEZ/o319AAjpwqynS9qt3FKAwRw5x3jLfI26aQtHEwwfVr0qVAgfuvI6RhbcEuU
	dtQGzVsLGc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F816F25E;
	Mon,  3 Mar 2014 14:43:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD7C16F25A;
	Mon,  3 Mar 2014 14:43:37 -0500 (EST)
In-Reply-To: <1393862398-2989-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 3 Mar 2014 07:59:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D4E2472-A30C-11E3-A74B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243259>

Tanay Abhra <tanayabh@gmail.com> writes:

> In record_author_date() & parse_gpg_output() ,using skip_prefix() instead of
> starts_with() is more elegant and abstracts away the details.

Avoid subjective judgement like "more elegant" when justifying your
change; you are not your own judge.

The caller of starts_with() actually can use the string that follows
the expected prefix and that is the reason why using skip_prefix()
in these places is a good idea.  There is no need to be subjective
to justify that change.

I do not think there is any more abstracting away of the details in
this change.  The updated uses a different and more suitable
abstraction than the original.

> diff --git a/commit.c b/commit.c
> index 6bf4fe0..668c703 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -548,7 +548,7 @@ define_commit_slab(author_date_slab, unsigned long);
>  static void record_author_date(struct author_date_slab *author_date,
>  			       struct commit *commit)
>  {
> -	const char *buf, *line_end;
> +	const char *buf, *line_end, *skip;
>  	char *buffer = NULL;
>  	struct ident_split ident;
>  	char *date_end;
> @@ -566,14 +566,15 @@ static void record_author_date(struct author_date_slab *author_date,
>  	     buf;
>  	     buf = line_end + 1) {
>  		line_end = strchrnul(buf, '\n');
> -		if (!starts_with(buf, "author ")) {
> +		if (!(skip = skip_prefix(buf, "author "))) {

We tend to avoid assignments in conditionals.

>  			if (!line_end[0] || line_end[1] == '\n')
>  				return; /* end of header */
>  			continue;
>  		}
> +		buf = skip;
>  		if (split_ident_line(&ident,
> -				     buf + strlen("author "),
> -				     line_end - (buf + strlen("author "))) ||
> +				     buf,
> +				     line_end - buf) ||
>  		    !ident.date_begin || !ident.date_end)
>  			goto fail_exit; /* malformed "author" line */
>  		break;

If you give a sensible name to what 'buf + strlen("author ")' is,
then the result becomes a lot more readable compared to the
original, and I think that is what this change is about.

And "skip" is not a good name for that.  'but + strlen("author ")'
is what split_ident_line() expects its input to be split; let's
tentatively call it "ident_line" and see what the call looks like:

	split_ident_line(&ident, ident_line, line_end - ident_line))

And that is what we want to see here.  It is a bit more clear than
the original that we are splitting the ident information on the line,
ident_line (you could call it ident_begin) points at the beginning
and line_end points at the end of that ident information.

Use of skip_prefix(), which I am sure you took the name of the new
variable "skip" from, is merely an implementation detail of finding
where the ident begins.  A good rule of thumb to remember is to name
things after what they are, not how you obtain them, how they are
used or what they are used for/as.

> @@ -1193,9 +1194,9 @@ static void parse_gpg_output(struct signature_check *sigc)
>  	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>  		const char *found, *next;
>  
> -		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
> +		if (found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1)) {
>  			/* At the very beginning of the buffer */
> -			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
> +			;
>  		} else {
>  			found = strstr(buf, sigcheck_gpg_status[i].check);
>  			if (!found)

This hunk looks good.  It can be a separate patch but they are both
minor changes so it is OK to have it in a single patch.
