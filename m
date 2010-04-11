From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] add a library of code for producing structured
 output
Date: Sun, 11 Apr 2010 11:16:18 -0700
Message-ID: <7vy6gtonwt.fsf@alter.siamese.dyndns.org>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
 <20100411113733.80010.3767.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 20:16:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11hy-0008Kp-Ps
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 20:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab0DKSQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 14:16:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab0DKSQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 14:16:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEB93AAA3C;
	Sun, 11 Apr 2010 14:16:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rw5N5NQJ4a6nmhVnODyyPQS4imc=; b=sWYaxY
	LjEXhBArj4y3dYlLda1xr2QUL/jVJYhz3VjyYfqBgQ2nlyx53cbXCq9sn+BaY1Jq
	yqiyLU1i8HUNTCvySCHJxhuezcWMZYrnWTOvToEza7xPGOv7yqtQBAZqeN/NCiCk
	XlnF6BC9a1uM5blfxT7ogyj2hXQmlrkLcDMlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jg0kiGuRMti+Uhy4bAoiaicxYYQ3T4Ur
	OpsmJp6OJ1GekxqAVKq4nfJryb4R9Sr1OIPglOivuiK/kexRN7GtAyqccAiANBFQ
	4j6RDWQng+BjDxtBHF+m8cW0xIUrS3pQP6SjU+UdWK5NDZ/N6STf1tING/9Tzg8Z
	4kfSDJ+sbHk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B6AFAAA3B;
	Sun, 11 Apr 2010 14:16:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C44D5AAA3A; Sun, 11 Apr
 2010 14:16:19 -0400 (EDT)
In-Reply-To: <20100411113733.80010.3767.julian@quantumfyre.co.uk> (Julian
 Phillips's message of "Sun\, 11 Apr 2010 12\:37\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56152C2E-4596-11DF-AFCA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144674>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> Add a library that allows commands to produce structured output in any
> of a range of formats using a single API.
>
> The API includes an OPT_OUTPUT and handle_output_arg so that the
> option handling for different commands will be as similar as possible.

I was hoping that the existing low-level -z routines (e.g. "diff-* -z")
follow similar enough patterns to have a corresponding output-z.c and be
handled inside output.c library.  But that is not a requirement, just
"would have been nicer if the original were written that way".

> diff --git a/output-json.c b/output-json.c
> new file mode 100644
> index 0000000..0eb66b2
> --- /dev/null
> +++ b/output-json.c
> @@ -0,0 +1,128 @@
> +#include "git-compat-util.h"
> +#include "output.h"
> +#include "strbuf.h"
> +
> +static char *json_quote(char *s)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	while (*s) {
> +		switch (*s) {
> +...
> +		default:
> +			/* All control characters must be encode, even if they
> +			 * don't have a specific escape character of their own */
> +			if (*s < 0x20)
> +				strbuf_addf(&buf, "\\u%04x", *s);

As you didn't say your "char" is either signed or unsigned upfront, this
will behave differently when you are fed a UTF-8 string.  If it is signed,
you will end up showing bytes in a single letter separately at wrong
codepoint, and if it is unsigned, you will give UTF-8 string unquoted,
which probably is what you meant to do.

What is your design intention regarding legacy encoding?  This code does
not yet declare "dear user, if you plan to use json/xml output, your
repository metadata (notably the pathnames) has to be in UTF-8", as the
caller _could_ transliterate legacy data before feeding it to output.c
layer.  An alternative would be for the output.c layer to know about the
encoding of incoming data and transliterate when the output format
requires a particular encoding.

> +static void json_obj_item_start(FILE *file, char *name, int first)
> +{
> +	char *quoted = json_quote(name);
> +	if (!first)
> +		fprintf(file, ",\n");
> +	fprintf(file, "\"%s\" : ", quoted);
> +	free(quoted);
> +}
> + ...
> +static void json_str(FILE *file, char *value)
> +{
> +	char *quoted = json_quote(value);
> +	fprintf(file, "\"%s\"", quoted);
> +	free(quoted);
> +}

An obvious improvement would be to make json_quote() to take FILE * to
avoid wasteful allocation and copy, as it doesn't do anything but addstr
and addch, and all of its callers don't do anything but spitting the
result out to FILE *.

> diff --git a/output-xml.c b/output-xml.c
> new file mode 100644
> index 0000000..50dd7d6
> --- /dev/null
> +++ b/output-xml.c
> @@ -0,0 +1,68 @@
> +#include "git-compat-util.h"
> +#include "output.h"

This seems to totally lack quoting of any metacharacters for "name" and
string "value".
