From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/8] add functions for memory-efficient bitmaps
Date: Sun, 29 Jun 2014 03:41:37 -0400
Message-ID: <CAPig+cSc=A=+PR7oF43yeLpcd4n=Bd1KU1AHPfMKXEu5wAF4Ug@mail.gmail.com>
References: <20140625233429.GA20457@sigill.intra.peff.net>
	<20140625234000.GD23146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 29 09:41:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X19kJ-00012z-3O
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 09:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbaF2Hlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 03:41:39 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:34747 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbaF2Hli (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 03:41:38 -0400
Received: by mail-yh0-f45.google.com with SMTP id t59so4123465yho.32
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HpTSXWQv7fyOQ/kxdxC/R6OKEHgp6JquOqG9FFOXkkE=;
        b=1GLC6PWqa7uCYAN0CjjDFH3NIaK5FPISKdjuAxxBkgC5mcPpJOhwHrUOOds8xETRy6
         v29XtMd6XiYGYB+4Mu/V7ppG2lxTszildFrB8jZ5FTAdafjD+1giqqZ3a80bHEmFk7JA
         y1z9D1v4vbwtfza1QWdiAi6x2j/KK0N0LJVNuEs7+cQm2TyyN1xM4/+C0Fg4Hsw9MG99
         k1OJSUivgPhzy2amSfzY1a8T636n7zVdMDOltFaQaJVPzZoTGTqPLZlK3emyfz69LFr8
         WEvN0+ymCaZIQtOnmet0NzJNnrpRyMY5sXYCO6wcaTcaHBKQOS3gxYft+XNqjy9P1KVZ
         mQuA==
X-Received: by 10.236.120.110 with SMTP id o74mr47723394yhh.67.1404027697402;
 Sun, 29 Jun 2014 00:41:37 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Sun, 29 Jun 2014 00:41:37 -0700 (PDT)
In-Reply-To: <20140625234000.GD23146@sigill.intra.peff.net>
X-Google-Sender-Auth: tF7wIYjEt-ZWbqAvXU6dAclIYJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252634>

On Wed, Jun 25, 2014 at 7:40 PM, Jeff King <peff@peff.net> wrote:
> We already have a nice-to-use bitmap implementation in
> ewah/bitmap.c. It pretends to be infinitely long when asking
> for a bit (and just returns 0 for bits that haven't been
> allocated or set), and dynamically resizes as appropriate
> when you set bits.
>
> The cost to this is that each bitmap must store its own
> pointer and length, using up to 16 bytes per bitmap on top
> of the actual bit storage. This is a lot of storage (not to
> mention an extra level of pointer indirection) if you are
> going to store one bitmap per commit in a traversal.
>
> These functions provide an alternative bitmap implementation
> that can be used when you have a large number of fixed-size
> bitmaps. See the documentation in the header file for
> details and examples.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/bitset.h b/bitset.h
> new file mode 100644
> index 0000000..5fbc956
> --- /dev/null
> +++ b/bitset.h
> @@ -0,0 +1,113 @@
> +#ifndef BITSET_H
> +#define BITSET_H
> +
> + * Return the number of unsigned chars required to store num_bits bits.
> + *
> + * This is mostly used internally by the bitset functions, but you may need it
> + * when allocating the bitset. Example:
> + *
> + *   bits = xcalloc(1, bitset_sizeof(nr));
> + */
> +static inline int bitset_sizeof(int num_bits)
> +{
> +       return (num_bits + CHAR_BIT - 1) / CHAR_BIT;
> +}
> +
> +/*
> + * Set the bit at position "n". "n" is counted from zero, and must be
> + * smaller than the num_bits given to bitset_sizeof when allocating the bitset.
> + */
> +static inline void bitset_set(unsigned char *bits, int n)
> +{
> +       bits[n / CHAR_BIT] |= 1 << (n % CHAR_BIT);
> +}

Is it intentional or an oversight that there is no way to clear a bit
in the set?

> +/*
> + * Return the bit at position "n" (see bitset_set for a description of "n").
> + */
> +static inline int bitset_get(unsigned char *bits, int n)
> +{
> +       return !!(bits[n / CHAR_BIT] & (1 << (n % CHAR_BIT)));
> +}
> +
> +/*
> + * Return true iff the bitsets contain the same bits. Each bitset should be the
> + * same size, and should have been allocated using bitset_sizeof(max).
> + *
> + * Note that it is not safe to check partial equality by providing a smaller
> + * "max" (we assume any bits beyond "max" up to the next CHAR_BIT boundary are
> + * zeroed padding).
> + */
> +static inline int bitset_equal(unsigned char *a, unsigned char *b, int max)
> +{
> +       int i;
> +       for (i = bitset_sizeof(max); i > 0; i--)
> +               if (*a++ != *b++)
> +                       return 0;
> +       return 1;
> +}
> +
> +/*
> + * Bitwise-or the bitsets in "dst" and "src", and store the result in "dst".
> + *
> + * See bitset_equal for the definition of "max".
> + */
> +static inline void bitset_or(unsigned char *dst, const unsigned char *src, int max)
> +{
> +       int i;
> +       for (i = bitset_sizeof(max); i > 0; i--)
> +               *dst++ |= *src++;
> +}
> +
> +/*
> + * Returns true iff the bitset contains all zeroes.
> + *
> + * See bitset_equal for the definition of "max".
> + */
> +static inline int bitset_empty(const unsigned char *bits, int max)
> +{
> +       int i;
> +       for (i = bitset_sizeof(max); i > 0; i--, bits++)
> +               if (*bits)
> +                       return 0;
> +       return 1;
> +}
> +
> +#endif /* BITSET_H */
> --
> 2.0.0.566.gfe3e6b2
