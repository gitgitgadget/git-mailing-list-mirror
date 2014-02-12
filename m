From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Wed, 12 Feb 2014 11:36:44 -0800
Message-ID: <xmqqvbwkm8c3.fsf@gitster.dls.corp.google.com>
References: <1392215244-26785-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 20:36:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDfc4-0002eI-6w
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 20:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbaBLTgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 14:36:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbaBLTgr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 14:36:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25DFD6A7AE;
	Wed, 12 Feb 2014 14:36:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J257Wq1ws+Xa8ESTmXXBh65eSQw=; b=QKfcW2
	zq26Bz4lfFC+dOMoZNAsxwkz8Q1Vx3EEVhQ9qZ5tYFMWZyieWLSj2v6J5eva1Vch
	tSCxV9YyIux7eDTe0zv07ktOEE8awBxU19IE/m+uLgDh9/Sx/xItwm3hS2BHb+c3
	sIoRorrbeheOKpCzUBDH39scCu+gGLcu0QAS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x2/HfgIhL6z422x4NojL586RbW6JG6Ud
	tV2qWr2zqW/reoZLQh6OXzsgyoIsSsfHFa2gCNDlENdIOih/MNppC5FJBlgIPIfK
	BZGCqbsANOrOpzO4KQjIAf90ij3z+wJ8hkWCblyuWv4wYpOCjAQNaXhjok5OiPZy
	ktwyVZULQWU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 161E06A7AC;
	Wed, 12 Feb 2014 14:36:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59AF46A7AB;
	Wed, 12 Feb 2014 14:36:46 -0500 (EST)
In-Reply-To: <1392215244-26785-1-git-send-email-dak@gnu.org> (David Kastrup's
	message of "Wed, 12 Feb 2014 15:27:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 023CA814-941D-11E3-9B44-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242018>

David Kastrup <dak@gnu.org> writes:

> Making a single preparation run for counting the lines will avoid memory
> fragmentation.  Also, fix the allocated memory size which was wrong
> when sizeof(int *) != sizeof(int), and would have been too small
> for sizeof(int *) < sizeof(int), admittedly unlikely.
>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---

I think I took sizeof(int*)->sizeof(int) patch to the 'next' branch
already, which might have to conflict with this clean-up, but it
should be trivial to resolve.

Thanks for resending.  I was busy elsewhere (i.e. "no feedback" does
not mean "silent rejection" nor "silent agreement" at least from
me), and such a resend does help prevent patches fall thru cracks.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index e44a6bb..1aefedf 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1772,25 +1772,41 @@ static int prepare_lines(struct scoreboard *sb)
>  {
>  	const char *buf = sb->final_buf;
>  	unsigned long len = sb->final_buf_size;
> +	const char *end = buf + len;
> +	const char *p;
> +	int *lineno;
> +	int num = 0, incomplete = 0;
>  
> +	for (p = buf;;) {
> +		p = memchr(p, '\n', end - p);
> +		if (p) {
> +			p++;
>  			num++;
> +			continue;
>  		}
> +		break;
>  	}
> +
> +	if (len && end[-1] != '\n')
> +		incomplete++; /* incomplete line at the end */
> +
> +	sb->lineno = xmalloc(sizeof(*sb->lineno) * (num + incomplete + 1));
> +	lineno = sb->lineno;
> +
> +	*lineno++ = 0;
> +	for (p = buf;;) {
> +		p = memchr(p, '\n', end - p);
> +		if (p) {
> +			p++;
> +			*lineno++ = p - buf;
> +			continue;
> +		}
> +		break;
> +	}
> +
> +	if (incomplete)
> +		*lineno++ = len;
> +
>  	sb->num_lines = num + incomplete;
>  	return sb->num_lines;
>  }
