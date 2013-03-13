From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow combined diff to ignore white-spaces
Date: Wed, 13 Mar 2013 16:42:31 -0700
Message-ID: <7v4nge27fc.fsf@alter.siamese.dyndns.org>
References: <7v38wdc4ei.fsf@alter.siamese.dyndns.org>
 <1363209683-10264-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 00:43:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFvK4-0007Qc-3m
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 00:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934357Ab3CMXmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 19:42:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932359Ab3CMXmg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 19:42:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDF26BD8B;
	Wed, 13 Mar 2013 19:42:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SyqvhVvjQBjrPyejAgUAe7GlLaw=; b=lqkTcq
	2qbQvxr5tvx43MVhPAkLAZ3K4ok5RbOS1qKTNs87/Js2QlZEWN+VgKhz/pJXxT41
	DP3FOWsTsmTZerepC5My3VuFLYVp5I2lXubiC7+fJvwA0yDqMEMP1/k+Mc+G7qvy
	WaJwqWQCpKJe56Fff+z5Sa/ln5k23jZvzvO/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M2rB+dSBBjW4WuGKAcPDIoDWaDppAWUe
	DAj89P9IYeA0XH0J4Ensq7ChZUsv2V+zHvBbt/klPD/fMDfeTJD970MtJ1oGby2/
	L45YA0z46edMjAEYlN7q+qkkT3sFA9ZltBHyjA/fRqFbebrgNkTQuTAQeeq3MaZL
	UrzS9rl5qdk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C20A5BD89;
	Wed, 13 Mar 2013 19:42:33 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B353BBD85; Wed, 13 Mar 2013
 19:42:32 -0400 (EDT)
In-Reply-To: <1363209683-10264-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Wed, 13 Mar 2013 22:21:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACF5D260-8C37-11E2-B7BE-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218104>

Antoine Pelisse <apelisse@gmail.com> writes:

> Currently, it's not possible to use the space-ignoring options (-b, -w,
> --ignore-space-at-eol) with combined diff. It makes it pretty impossible
> to read a merge between a branch that changed all tabs to spaces, and a
> branch with functional changes.
>
> Pass diff flags to diff engine, so that combined diff behaves as normal
> diff does with spaces.
> Also coalesce lines that are removed from both (or more) parents.
>
> It also means that a conflict-less merge done using a ignore-* strategy
> option will not show any conflict if shown in combined-diff using the
> same option.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> OK, I added some tests and coalesce similar lost lines (using the same flags
> we used for diff.
>
>  combine-diff.c           |   57 ++++++++++++++++++++++++++++++-----
>  t/t4038-diff-combined.sh |   75 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+), 7 deletions(-)
>
> diff --git a/combine-diff.c b/combine-diff.c
> index 35d41cd..0f33983 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -5,6 +5,7 @@
>  #include "diffcore.h"
>  #include "quote.h"
>  #include "xdiff-interface.h"
> +#include "xdiff/xmacros.h"
>  #include "log-tree.h"
>  #include "refs.h"
>  #include "userdiff.h"
> @@ -122,7 +123,47 @@ static char *grab_blob(const unsigned char *sha1, unsigned int mode,
>  	return blob;
>  }
>
> -static void append_lost(struct sline *sline, int n, const char *line, int len)
> +static int match_string_spaces(const char *line1, int len1,
> +			       const char *line2, int len2,
> +			       long flags)
> +{
> +	if (flags & XDF_WHITESPACE_FLAGS) {
> +		for (; len1 > 0 && XDL_ISSPACE(line1[len1 - 1]); len1--);
> +		for (; len2 > 0 && XDL_ISSPACE(line2[len2 - 1]); len2--);
> +	}

This says "any XDF_WHITESPACE_FLAGS causes the trailing blanks
ignored", which is correct: --ignore-space-at-eol, -b or -w are all
we have.  OK.

> +	if (!(flags & (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE)))
> +		return (len1 == len2 && !memcmp(line1, line2, len1));

If --ignore-space-at-eol is the only one given, or none of the
whitespace flags is given, then we can just do memcmp().  OK.

The remainder of the function is only used when either -b or -w is
(or both are) in effect.

> +	while (len1 > 0 && len2 > 0) {
> +		len1--;
> +		len2--;

Scanning from the tail end of the strings...

> +		if (XDL_ISSPACE(line1[len1]) || XDL_ISSPACE(line2[len2])) {
> +			if ((flags & XDF_IGNORE_WHITESPACE_CHANGE) &&
> +			    (!XDL_ISSPACE(line1[len1]) || !XDL_ISSPACE(line2[len2])))
> +				return 0;

If --ignore-space-change and one side is blank while the other not,
then these cannot be the same.  If we see blank on both sides, that
is fine under --ignore-whitespace, too.

> +			for (; len1 > 0 && XDL_ISSPACE(line1[len1]); len1--);
> +			for (; len2 > 0 && XDL_ISSPACE(line2[len2]); len2--);

Then, strip the blanks, if any, so that the next comparison is done
for the last non-blank char from both sides.  OK.

> +		}
> +		if (line1[len1] != line2[len2])
> +			return 0;

And we can say "not same" as soon as we find differences.  Rinse
and repeat.

> +	}
> +
> +	if (flags & XDF_IGNORE_WHITESPACE) {
> +		// Consume remaining spaces

No C++/C99 comments in our codebase, please.

> +		for (; len1 > 0 && XDL_ISSPACE(line1[len1 - 1]); len1--);
> +		for (; len2 > 0 && XDL_ISSPACE(line2[len2 - 1]); len2--);

If we are ignoring all whitespaces, we can simply discard them.  OK.

I wonder what happens when --ignore-space-change is in effect but
not --ignore-all-space?  The loop must have exited because one (or
both) of len1 and len2 went down to zero.  If both are zero, we
obviously have a match, and otherwise, one has blanks at the
beginning and the other does not.  Wait, is that really true?  Yes,
because if len1 == 0 && len2 != 0, line2[len2] cannot be blank
(otherwise len2 would be zero because we have a loop to eat a run of
blanks).

OK, sounds good.

> +	}
> +
> +	// We matched full line1 and line2

Likewise for "//".

> +	if (!len1 && !len2)
> +		return 1;
> +
> +	return 0;
> +}


> +static void append_lost(struct sline *sline, int n, const char *line, int len, long flags)
>  {
>  	struct lline *lline;
>  	unsigned long this_mask = (1UL<<n);
> @@ -133,8 +174,8 @@ static void append_lost(struct sline *sline, int n, const char *line, int len)
>  	if (sline->lost_head) {
>  		lline = sline->next_lost;
>  		while (lline) {
> -			if (lline->len == len &&
> -			    !memcmp(lline->line, line, len)) {
> +			if (match_string_spaces(lline->line, lline->len,
> +						line, len, flags)) {
>  				lline->parent_map |= this_mask;
>  				sline->next_lost = lline->next;
>  				return;

Nicely done.

Thanks, will queue with comment style fix-ups.

> diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
> index 614425a..ba8a56b 100755
> --- a/t/t4038-diff-combined.sh
> +++ b/t/t4038-diff-combined.sh
> @@ -113,4 +113,79 @@ test_expect_success 'check --cc --raw with forty trees' '
>  	grep "^::::::::::::::::::::::::::::::::::::::::[^:]" out
>  '
>
> +test_expect_success 'setup combined ignore spaces' '
> +	git checkout master &&
> +	>test &&
> +	git add test &&
> +	git commit -m initial &&
> +
> +	echo "
> +	always coalesce
> +	eol space coalesce \n\
> +	space  change coalesce
> +	all spa ces coalesce
> +	eol spaces \n\
> +	space  change
> +	all spa ces" >test &&
> +	git commit -m "change three" -a &&
> +
> +	git checkout -b side HEAD^ &&
> +	echo "
> +	always coalesce
> +	eol space coalesce
> +	space change coalesce
> +	all spaces coalesce
> +	eol spaces
> +	space change
> +	all spaces" >test &&
> +	git commit -m indent -a &&
> +
> +	test_must_fail git merge master &&
> +	echo "
> +	eol spaces \n\
> +	space  change
> +	all spa ces" > test &&
> +	git commit -m merged -a
> +'
> +
> +test_expect_success 'check combined output (no ignore space)' '
> +	git show | test_i18ngrep "^-\s*eol spaces" &&
> +	git show | test_i18ngrep "^-\s*eol space coalesce" &&
> +	git show | test_i18ngrep "^-\s*space change" &&
> +	git show | test_i18ngrep "^-\s*space change coalesce" &&
> +	git show | test_i18ngrep "^-\s*all spaces" &&
> +	git show | test_i18ngrep "^-\s*all spaces coalesce" &&
> +	git show | test_i18ngrep "^--\s*always coalesce"
> +'
> +
> +test_expect_success 'check combined output (ignore space at eol)' '
> +	git show --ignore-space-at-eol | test_i18ngrep "^\s*eol spaces" &&
> +	git show --ignore-space-at-eol | test_i18ngrep "^--\s*eol space coalesce" &&
> +	git show --ignore-space-at-eol | test_i18ngrep "^-\s*space change" &&
> +	git show --ignore-space-at-eol | test_i18ngrep "^-\s*space change coalesce" &&
> +	git show --ignore-space-at-eol | test_i18ngrep "^-\s*all spaces" &&
> +	git show --ignore-space-at-eol | test_i18ngrep "^-\s*all spaces coalesce" &&
> +	git show --ignore-space-at-eol | test_i18ngrep "^--\s*always coalesce"
> +'
> +
> +test_expect_success 'check combined output (ignore space change)' '
> +	git show -b | test_i18ngrep "^\s*eol spaces" &&
> +	git show -b | test_i18ngrep "^--\s*eol space coalesce" &&
> +	git show -b | test_i18ngrep "^\s*space  change" &&
> +	git show -b | test_i18ngrep "^--\s*space change coalesce" &&
> +	git show -b | test_i18ngrep "^-\s*all spaces" &&
> +	git show -b | test_i18ngrep "^-\s*all spaces coalesce" &&
> +	git show -b | test_i18ngrep "^--\s*always coalesce"
> +'
> +
> +test_expect_success 'check combined output (ignore all spaces)' '
> +	git show -w | test_i18ngrep "^\s*eol spaces" &&
> +	git show -w | test_i18ngrep "^--\s*eol space coalesce" &&
> +	git show -w | test_i18ngrep "^\s*space  change" &&
> +	git show -w | test_i18ngrep "^--\s*space change coalesce" &&
> +	git show -w | test_i18ngrep "^\s*all spa ces" &&
> +	git show -w | test_i18ngrep "^--\s*all spaces coalesce" &&
> +	git show -w | test_i18ngrep "^--\s*always coalesce"
> +'
> +
>  test_done
> --
> 1.7.9.5
