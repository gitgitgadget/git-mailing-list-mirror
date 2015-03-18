From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/14] numparse: new module for parsing integral numbers
Date: Wed, 18 Mar 2015 14:27:56 -0400
Message-ID: <CAPig+cTyCS2-gys0MQSsA4K_k2gnGRvitXzDybyhO5q41OMD_w@mail.gmail.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<1426608016-2978-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.org>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:28:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYIhI-0003U2-B8
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 19:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbbCRS2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 14:28:00 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34118 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbbCRS15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 14:27:57 -0400
Received: by ykfc206 with SMTP id c206so19468460ykf.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TZS8drYmxW2Y6o9DU3yeLQJy7e9J3bmI93a5Cv6f2r4=;
        b=gEfjyLcDWraZo/iUqag4+YiC2YvuOWsvIsFqTdIcJpK9OAtMarN5wNZW4mnDreSOzP
         D+niG5r/+fxqnqT6e8WXbBMCOq1+oAphszAVfiWF3ywcGC9e3z/Qa39ZGh4unaCOFMUp
         5W9627o2Ir30r0qIDua4pI3KtoI9fMGardARAwmBzlJ8Yc7NdhxUGrQIiq1OBZ5y0FX3
         BOyHb61USztwgNod8wmU1P9oX1ue+oWWiHHZkKIflWPu9N/2sjU9LaldTuv5Dnq00Row
         WO/iBCEbtM5irbG1PP3fwSwckANcy055oepa0X61D84rllgEwPFHE/O49QTeytHWkewV
         L7rg==
X-Received: by 10.170.134.198 with SMTP id a189mr72610658ykc.103.1426703276293;
 Wed, 18 Mar 2015 11:27:56 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Wed, 18 Mar 2015 11:27:56 -0700 (PDT)
In-Reply-To: <1426608016-2978-2-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: 61VEyDnpFEwLyFTUakC2hhrJMHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265746>

On Tuesday, March 17, 2015, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Implement wrappers for strtol() and strtoul() that are safer and more
> convenient to use.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/numparse.c b/numparse.c
> new file mode 100644
> index 0000000..90b44ce
> --- /dev/null
> +++ b/numparse.c
> @@ -0,0 +1,180 @@
> +int parse_l(const char *s, unsigned int flags, long *result, char **endptr)
> +{
> +       long l;
> +       const char *end;
> +       int err = 0;
> +
> +       err = parse_precheck(s, &flags);
> +       if (err)
> +               return err;
> +       /*
> +        * Now let strtol() do the heavy lifting:
> +        */

Perhaps use a /* one-line style comment */ to reduce vertical space
consumption a bit, thus make it (very slightly) easier to run the eye
over the code.

> +       errno = 0;
> +       l = strtol(s, (char **)&end, flags & NUM_BASE_MASK);
> +       if (errno) {
> +               if (errno == ERANGE) {
> +                       if (!(flags & NUM_SATURATE))
> +                               return -NUM_SATURATE;
> +               } else {
> +                       return -NUM_OTHER_ERROR;
> +               }
> +       }

Would it reduce cognitive load slightly (and reduce vertical space
consumption) to rephrase the conditionals as:

    if (errno == ERANGE && !(flags & NUM_SATURATE))
        return -NUM_SATURATE;

    if (errno && errno != ERANGE)
        return -NUM_OTHER_ERROR;

or something similar?

More below.

> +       if (end == s)
> +               return -NUM_NO_DIGITS;
> +
> +       if (*end && !(flags & NUM_TRAILING))
> +               return -NUM_TRAILING;
> +
> +       /* Everything was OK */
> +       *result = l;
> +       if (endptr)
> +               *endptr = (char *)end;
> +       return 0;
> +}
> diff --git a/numparse.h b/numparse.h
> new file mode 100644
> index 0000000..4de5e10
> --- /dev/null
> +++ b/numparse.h
> @@ -0,0 +1,207 @@
> +#ifndef NUMPARSE_H
> +#define NUMPARSE_H
> +
> +/*
> + * Functions for parsing integral numbers.
> + *
> + * Examples:
> + *
> + * - Convert s into a signed int, interpreting prefix "0x" to mean
> + *   hexadecimal and "0" to mean octal. If the value doesn't fit in an
> + *   unsigned int, set result to INT_MIN or INT_MAX.

Did you mean s/unsigned int/signed int/ ?

> + *
> + *     if (convert_i(s, NUM_SLOPPY, &result))
> + *             die("...");
> + */
> +
> +/*
> + * The lowest 6 bits of flags hold the numerical base that should be
> + * used to parse the number, 2 <= base <= 36. If base is set to 0,
> + * then NUM_BASE_SPECIFIER must be set too; in this case, the base is
> + * detected automatically from the string's prefix.

Does this restriction go against the goal of making these functions
convenient, even while remaining strict? Is there a strong reason for
not merely inferring NUM_BASE_SPECIFIER when base is 0? Doing so would
make it consistent with strto*l() without (I think) introducing any
ambiguity.

> + */
> +/*
> + * Number parsing functions:
> + *
> + * The following functions parse a number (long, unsigned long, int,
> + * or unsigned int respectively) from the front of s, storing the
> + * value to *result and storing a pointer to the first character after
> + * the number to *endptr. flags specifies how the number should be
> + * parsed, including which base should be used. flags is a combination
> + * of the numerical base (2-36) and the NUM_* constants above (see).

"(see)" what?

> + * Return 0 on success or a negative value if there was an error. On
> + * failure, *result and *entptr are left unchanged.
> + *
> + * Please note that if NUM_TRAILING is not set, then it is
> + * nevertheless an error if there are any characters between the end
> + * of the number and the end of the string.

Again, on the subject of convenience, why this restriction? The stated
purpose of the parse_*() functions is to parse the number from the
front of the string and return a pointer to the first non-numeric
character following. As  a reader of this API, I interpret that as
meaning that NUM_TRAILING is implied. Is there a strong reason for not
inferring NUM_TRAILING for the parse_*() functions at the API level?
(I realize that the convert_*() functions are built atop parse_*(),
but that's an implementation detail.)

> + */
> +
> +int parse_l(const char *s, unsigned int flags,
> +           long *result, char **endptr);

Do we want to perpetuate the ugly (char **) convention for 'endptr'
from strto*l()? Considering that the incoming string is const, it
seems undesirable to return a non-const pointer to some place inside
that string.

> +/*
> + * Number conversion functions:
> + *
> + * The following functions parse a string into a number. They are
> + * identical to the parse_*() functions above, except that the endptr
> + * is not returned. These are most useful when parsing a whole string
> + * into a number; i.e., when (flags & NUM_TRAILING) is unset.

I can formulate arguments for allowing or disallowing NUM_TRAILING
with convert_*(), however, given their purpose of parsing the entire
string into a number, as a reader of the API, I would kind of expect
the convert_*() functions to ensure that NUM_TRAILING is not set
(either by forcibly clearing it or erroring out as an inconsistent
request if it is set).

> + */
> +static inline int convert_l(const char *s, unsigned int flags,
> +                           long *result)
> +{
> +       return parse_l(s, flags, result, NULL);
> +}
