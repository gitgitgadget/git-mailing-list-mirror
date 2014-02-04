From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 12:24:34 -0800
Message-ID: <xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 04 21:24:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAmXz-0005MX-Sb
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 21:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbaBDUYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 15:24:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbaBDUYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 15:24:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65812675A3;
	Tue,  4 Feb 2014 15:24:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rp9OiXH97H5eKrLf0LUFJTuDEHA=; b=P6wbRn
	Pjt/nooJAoEAzu4iShFHlkK6TLmXj1LP3ldPsgyzlpBuyWSiKG5h2PCBimPO742M
	7ZlXkXr44AgrZIuWysOkRa4pyAs7IqgkghfvgK1oy5NSAK62nRbF6hgeoUamSPHn
	pRMLFkIFZDkLs21ruVcuclqqGYiEyzdg3Rgwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CWVYssnfrafZ8X5IMZ07P+fYFaTG51sn
	WwxQbcwhBEDPOHAArP9B4RJpm5arUt6uyB86Mv2jiwd93LQIpV6xqN1oZ7cF6Sj6
	RJ2vxa+3Eza+wEmYLum27I0S5SmaBMNB8aUJzjOssEifn2+3ygX5/+ZlH1cmdxD2
	MxR4g7HX2yg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FA5A675A2;
	Tue,  4 Feb 2014 15:24:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 581B6675A0;
	Tue,  4 Feb 2014 15:24:36 -0500 (EST)
In-Reply-To: <1391544367-14599-1-git-send-email-dak@gnu.org> (David Kastrup's
	message of "Tue, 4 Feb 2014 21:06:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5D952400-8DDA-11E3-A4DD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241549>

David Kastrup <dak@gnu.org> writes:

> Making a single preparation run for counting the lines will avoid memory
> fragmentation.  Also, fix the allocated memory size which was wrong
> when sizeof(int *) != sizeof(int), and would have been too small
> for sizeof(int *) < sizeof(int), admittedly unlikely.
>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
>  builtin/blame.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index e44a6bb..522986d 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1772,25 +1772,33 @@ static int prepare_lines(struct scoreboard *sb)
>  {
>  	const char *buf = sb->final_buf;
>  	unsigned long len = sb->final_buf_size;
> -	int num = 0, incomplete = 0, bol = 1;
> +	const char *end = buf + len;
> +	const char *p;
> +	int *lineno;
> +	
> +	int num = 0, incomplete = 0;

Is there any significance to the blank line between these two
variable definitions?

> +
> +	for (p = buf;;) {
> +		if ((p = memchr(p, '\n', end-p)) == NULL)
> +			break;
> +		++num, ++p;

You have a peculiar style that is somewhat distracting.  Why isn't
this more like so?

	for (p = buf; p++, num++; ) {
		p = memchr(p, '\n', end - p);
		if (!p)
			break;
	}

which I think is the prevalent style in our codebase.  The same for
the other loop we see in the new code below.

 - favor post-increment unless you use it as rvalue and need
   pre-increment;

 - SP around each binary ops e.g. 'end - p';

 - avoid assignments in conditionals when you do not have to.

> +	}
>  
> -	if (len && buf[len-1] != '\n')
> +	if (len && end[-1] != '\n')
>  		incomplete++; /* incomplete line at the end */

OK, so far we counted "num" complete lines and "incomplete" may be
one if there is an incomplete line after them.

> -	while (len--) {
> -		if (bol) {
> -			sb->lineno = xrealloc(sb->lineno,
> -					      sizeof(int *) * (num + 1));
> -			sb->lineno[num] = buf - sb->final_buf;
> -			bol = 0;
> -		}
> -		if (*buf++ == '\n') {
> -			num++;
> -			bol = 1;
> -		}
> +
> +	sb->lineno = lineno = xmalloc(sizeof(int) * (num + incomplete + 1));

OK, this function is called only once, so we know sb->lineno is NULL
originally and there is no reason to start from xrealloc().

> +	for (p = buf;;) {
> +		*lineno++ = p-buf;
> +		if ((p = memchr(p, '\n', end-p)) == NULL)
> +			break;
> +		++p;
>  	}
> -	sb->lineno = xrealloc(sb->lineno,
> -			      sizeof(int *) * (num + incomplete + 1));

These really *were* unnecessary reallocations.

Thanks for catching them, but this patch needs heavy style fixes.

> -	sb->lineno[num + incomplete] = buf - sb->final_buf;
> +
> +	if (incomplete)
> +		*lineno++ = len;
> +
>  	sb->num_lines = num + incomplete;
>  	return sb->num_lines;
>  }
