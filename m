From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Allow combined diff to ignore white-spaces
Date: Thu, 14 Mar 2013 08:08:35 +0100
Message-ID: <51417773.5000401@viscovery.net>
References: <7v38wdc4ei.fsf@alter.siamese.dyndns.org> <1363209683-10264-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 08:09:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG2Hq-0004lb-Om
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 08:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab3CNHIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 03:08:48 -0400
Received: from so.liwest.at ([212.33.55.24]:63480 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab3CNHIr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 03:08:47 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UG2HD-0000x7-KN; Thu, 14 Mar 2013 08:08:42 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3EEF01660F;
	Thu, 14 Mar 2013 08:08:35 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <1363209683-10264-1-git-send-email-apelisse@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218120>

Am 3/13/2013 22:21, schrieb Antoine Pelisse:
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
> +
> +	if (!(flags & (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE)))
> +		return (len1 == len2 && !memcmp(line1, line2, len1));
> +
> +	while (len1 > 0 && len2 > 0) {
> +		len1--;
> +		len2--;
> +		if (XDL_ISSPACE(line1[len1]) || XDL_ISSPACE(line2[len2])) {
> +			if ((flags & XDF_IGNORE_WHITESPACE_CHANGE) &&
> +			    (!XDL_ISSPACE(line1[len1]) || !XDL_ISSPACE(line2[len2])))
> +				return 0;
> +
> +			for (; len1 > 0 && XDL_ISSPACE(line1[len1]); len1--);
> +			for (; len2 > 0 && XDL_ISSPACE(line2[len2]); len2--);
> +		}
> +		if (line1[len1] != line2[len2])
> +			return 0;
> +	}
> +
> +	if (flags & XDF_IGNORE_WHITESPACE) {
> +		// Consume remaining spaces
> +		for (; len1 > 0 && XDL_ISSPACE(line1[len1 - 1]); len1--);
> +		for (; len2 > 0 && XDL_ISSPACE(line2[len2 - 1]); len2--);
> +	}
> +
> +	// We matched full line1 and line2
> +	if (!len1 && !len2)
> +		return 1;
> +
> +	return 0;
> +}
> +
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
> @@ -162,6 +203,7 @@ struct combine_diff_state {
>  	int n;
>  	struct sline *sline;
>  	struct sline *lost_bucket;
> +	long flags;
>  };
> 
>  static void consume_line(void *state_, char *line, unsigned long len)
> @@ -201,7 +243,7 @@ static void consume_line(void *state_, char *line, unsigned long len)
>  		return; /* not in any hunk yet */
>  	switch (line[0]) {
>  	case '-':
> -		append_lost(state->lost_bucket, state->n, line+1, len-1);
> +		append_lost(state->lost_bucket, state->n, line+1, len-1, state->flags);
>  		break;
>  	case '+':
>  		state->sline[state->lno-1].flag |= state->nmask;
> @@ -215,7 +257,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
>  			 struct sline *sline, unsigned int cnt, int n,
>  			 int num_parent, int result_deleted,
>  			 struct userdiff_driver *textconv,
> -			 const char *path)
> +			 const char *path, long flags)
>  {
>  	unsigned int p_lno, lno;
>  	unsigned long nmask = (1UL << n);
> @@ -231,9 +273,10 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
>  	parent_file.ptr = grab_blob(parent, mode, &sz, textconv, path);
>  	parent_file.size = sz;
>  	memset(&xpp, 0, sizeof(xpp));
> -	xpp.flags = 0;
> +	xpp.flags = flags;
>  	memset(&xecfg, 0, sizeof(xecfg));
>  	memset(&state, 0, sizeof(state));
> +	state.flags = flags;
>  	state.nmask = nmask;
>  	state.sline = sline;
>  	state.lno = 1;
> @@ -962,7 +1005,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  				     elem->parent[i].mode,
>  				     &result_file, sline,
>  				     cnt, i, num_parent, result_deleted,
> -				     textconv, elem->path);
> +				     textconv, elem->path, opt->xdl_opts);
>  	}
> 
>  	show_hunks = make_hunks(sline, cnt, num_parent, dense);
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

This form of 'echo' is not sufficiently portable. How about:

	tr -d Q <<-\EOF >test &&

	always coalesce
	eol space coalesce Q
	space  change coalesce
	all spa ces coalesce
	eol spaces Q
	space  change
	all spa ces
	EOF

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

Ditto.

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

This loses the exit code of git show. We usually write this as

	git show >actual &&
	grep "^- *eol spaces" &&
	grep "^- *eol space coalesce" &&
	...

(Same for later tests.)

There is nothing i18n-ish in the test patterns. Use regular grep.

BTW, there is compare_diff_patch() in diff-lib.sh. You can use it to
compare diff output to expected output. Then you do not need a grep
invocation for each line of the test file.

-- Hannes
