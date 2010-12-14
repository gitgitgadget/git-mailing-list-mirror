From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Refactor parse_loc
Date: Tue, 14 Dec 2010 14:57:43 -0800
Message-ID: <7v8vzsrmhk.fsf@alter.siamese.dyndns.org>
References: <cover.1292291624.git.trast@student.ethz.ch>
 <ff9def9ac3f207b9f9be9c59ec3a313c9b3d4d84.1292291624.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:58:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdom-0004zO-9e
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab0LNW5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:57:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578Ab0LNW5y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:57:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59E182C2B;
	Tue, 14 Dec 2010 17:58:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v8YKEoYUSBo3kdqRhN7kFJS31MM=; b=CMKkTd
	MFgk2JFwh7zlbC0OetFbPTMGx9QmBiIaY5mR0GpZitO+vt4wOVGsdxUepiu4jpWs
	KZ0hu+YuRWZNfQgGQAUuC8/FPjT96zAOzfxuatKzy3bxD6VVjQRONMHjs3FDZKh2
	KZdJEXEcVH0AuQ5LSHTx6ko2e5dApfHI9oBBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M8lVXxHXVHvWH/0doCxVpsOuY7yO3+OF
	bDnW3vbJlAAfRmGALATW7Qj5LwlzPIFHOVEnHbVN7BTJ3Lbb0xVyoX3RHFAFf9dP
	+XZ7VwsXbQ8ZKyblq0RDHc3ko+DljodRInyj6b/5LhAFQORgiCdlFGIxKpCi+UDl
	xCo4TnS2KWw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24EBF2C2A;
	Tue, 14 Dec 2010 17:58:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE97E2C23; Tue, 14 Dec 2010
 17:58:12 -0500 (EST)
In-Reply-To: <ff9def9ac3f207b9f9be9c59ec3a313c9b3d4d84.1292291624.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue\, 14 Dec 2010 03\:03\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3599388-07D5-11E0-8921-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163714>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/line.c b/line.c
> new file mode 100644
> index 0000000..29898ec
> --- /dev/null
> +++ b/line.c
> @@ -0,0 +1,106 @@
> +#include "git-compat-util.h"
> +#include "line.h"
> +
> +/*
> + * Parse one item in the -L option
> + */
> +const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
> +		void *data, long lines, long begin, long *ret)
> +{
> +        char *term;
> +        const char *line;
> +        long num;
> +        int reg_error;
> +        regex_t regexp;
> +        regmatch_t match[1];
> +
> +        /* Catch the '$' matcher, now it is used to match the last
> +         * line of the file. */

"now"?  What now, as opposed to which then?

Ahh, is it an artifact of squashing multiple patches, one that moves the
function and then another that adds a new feature?

In any case, please fix the style of multi-line comment.  I wouldn't mind
if you fixed the other one you moved from blame.c to this function (I
omitted it from the context but you know which one I mean).

> ...
> +int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
> +		void *cb_data, long lines, long *begin, long *end)
> +{
> +	arg = parse_loc(arg, nth_line_cb, cb_data, lines, -1, begin);
> +
> +        if (*arg == ',') {
> +		arg = parse_loc(arg+1, nth_line_cb, cb_data, lines, *begin+1, end);
> +		if (*begin > *end) {
> +			long tmp = *begin;
> +			*begin = *end;
> +			*end = tmp;
> +		}

It is somewhat unfortunate that this "swap begin and end given -L9,4" is
done here not in the caller---for some callers 9,4 and 4,9 may mean
different things.  But for now this would do.

> diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
> index 230143c..51d313e 100755
> --- a/t/t8003-blame.sh
> +++ b/t/t8003-blame.sh
> @@ -175,6 +175,12 @@ test_expect_success 'blame -L with invalid end' '
>  	grep "has only 2 lines" errors
>  '
>  
> +test_expect_success 'blame -L parses end' '
> +	git blame -L1,1 tres >out &&
> +	cat out &&
> +	test $(wc -l < out) -eq 1
> +'

What does this test exactly?  "end"?
