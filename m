From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: quote paths with spaces
Date: Mon, 25 Jun 2012 19:21:03 -0700
Message-ID: <7vk3yueru8.fsf@alter.siamese.dyndns.org>
References: <1340655120-89736-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 04:26:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjLU5-0002yA-FI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 04:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120Ab2FZCVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 22:21:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757942Ab2FZCVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 22:21:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 483A786D1;
	Mon, 25 Jun 2012 22:21:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4SgDKKpzSY1huzk/MyP8aoOd4YQ=; b=ZfW9OH
	zlKe/4TumcZ8skMHDXqdaryYgxIrPPRgAx1tx1JvcU5N8axKTj5kKtTyKxDWT9br
	iqNjf3M4FNjFxY9yx7sKi9fbGGZTKRviQWgC8PkpxBlKTKKrUH41rWajy8I79ZIe
	dAmCk8z4zXJB6pP1l5qKFrPhSbcRSXmWx7nUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gw0rUBmMaNe5iishhr9nq97rwld/vJd4
	co05fWlX8nvx/DL0sbr95jWOuqxujFLw7G0LKyViwF5fhvr4vXNzmKMtWz0ms6jV
	XYwRmNTPjgbGGIx8KAizi3/AUkW/y0uIo1DKxYwijOCiraUFbnSOstdd90qqA5h+
	BAN+tSzFw/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 408AD86CF;
	Mon, 25 Jun 2012 22:21:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D01086C2; Mon, 25 Jun 2012
 22:21:05 -0400 (EDT)
In-Reply-To: <1340655120-89736-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon, 25 Jun 2012 16:12:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9548B7C4-BF35-11E1-B638-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200618>

Jay Soffian <jaysoffian@gmail.com> writes:

> A path containing a space must be quoted when used as an argument to
> either the copy or rename commands. 6280dfdc3b (fast-export: quote paths
> in output, 2011-08-05) previously attempted to fix fast-export's quoting
> by passing all paths through quote_c_style(). However, that function does
> not consider the space to be a character which requires quoting, so let's
> special-case the space inside print_path(). This will cause
> space-containing paths to also be quoted in other commands where such
> quoting is not strictly necessary, but it does not hurt to do so.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> Sorry, not test added. I barely had time to get out this patch. :-(

Thanks.

I have to say it might be less error prone to always c-quote the
string, as the recipient is expected to be able to grok it anyway,
but I'll let fast-import/export experts to comment on it and perhaps
add a test or two ;-)

>  builtin/fast-export.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index ef7c012094..cc5ef82fe6 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -183,9 +183,11 @@ static int depth_first(const void *a_, const void *b_)
>  static void print_path(const char *path)
>  {
>  	int need_quote = quote_c_style(path, NULL, NULL, 0);
> -	if (need_quote)
> +	if (need_quote) {
>  		quote_c_style(path, NULL, stdout, 0);
> -	else
> +	} else if (strchr(path, ' ')) {
> +		printf("\"%s\"", path);
> +	} else
>  		printf("%s", path);
>  }
