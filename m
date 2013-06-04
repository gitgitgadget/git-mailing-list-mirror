From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Tue, 04 Jun 2013 11:26:06 -0700
Message-ID: <7vzjv57mwx.fsf@alter.siamese.dyndns.org>
References: <1369591098-11267-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 20:26:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujvw1-0004fQ-7a
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 20:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195Ab3FDS0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 14:26:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab3FDS0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 14:26:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4036E25FC9;
	Tue,  4 Jun 2013 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L7WTjNWuEzOrtolKnwyx7v6Ku/k=; b=eVq1Lh
	OV8yfdEalPlQLt9ZaDCAkSI6MzjAt0woUq7ZyIRt/0PqSwcUAzD/QKqiwpExdTkf
	CUUYRFKJ3eKWiqg64k8VUiohmqDBUjuRlgtRR2Sg+pSTUojQMUdvy1rCw+kZVXRY
	MyNp9NgBJ0jJbD55bn3Rc6iKfmDCUMdmGESQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oHDSToE2qqw300RLkKs6lYqqGEyI2T/s
	7Um2/S7apctcvT07JhcwBSTMmCtheBCfIqmi2HB5y06dFW3enFmD6Bz4dre9h7CG
	TxzbdHMmWdT02sihsS0Y2BD5QVsCvZTQbpnn+Ufg9yeRRQewPIfkLPtgJNUtTmbK
	L6xLqTyjQgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE17C25FC6;
	Tue,  4 Jun 2013 18:26:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 042A225FC4;
	Tue,  4 Jun 2013 18:26:08 +0000 (UTC)
In-Reply-To: <1369591098-11267-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Sun, 26 May 2013 19:58:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A127052-CD44-11E2-8F91-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226389>

Antoine Pelisse <apelisse@gmail.com> writes:

> +xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg) {
>  	xdchange_t *xch, *xchp;
>  	long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
> +	long ignorable_context = max_common / 2 - 1;

Could you explain how this math works?  Also the logic to use it
when either the previous or the current one is "blank only" (as
opposed to having two different settings for "both are blank only"
and "only one of them is, and the other is not", for example)?

The normal case when neither is blank only, we refrain from
collapsing two adjacent xdchanges if the end of xchp (i.e. the
previous one) is before the beginning of xch (i.e. the current one
we are looking at) by more than max_common lines, which makes sense
to me because we count one ctxlen for the trailing context for xchp,
interhunkctxlen to force collapsing, and another ctxlen for the
leading context for xch.

When we have 

    - zero or more "blank only" changes, followed by
    - a meaningful change A, followed by
    - zero or more blank-only changes, followed by
    - a meaningful change C,

we may want to have either two hunks (A with context around it, and
C with context around it) or a single hunk (precontext before A, all
the lines from the beginning of A to the end of C, and postcontext
after C).  In either case, we want to discard the leading "blank
only" changes.

I can sort-of see how the leading "blank only" changes are discarded
in the loop (but not quite---you can ignore everything without any
"thresh", until you set "interesting" to true, i.e. seeing A, no?).

It is not clear to me how you are counting the distance between the
end of A and the beginning of C, which I think is all that matters,
to make the decision to coalesce (or not to coalesce) the above into
a single hunk, without looking ahead to find the next xdchange that
is not marked with xch->ignore flag (that is, when looking at A,
find the beginning of C to see if C.begin-A.end is within the usual
max_common).

Confused...

> +	int interesting = 0;
>
> -	for (xchp = xscr, xch = xscr->next; xch; xchp = xch, xch = xch->next)
> -		if (xch->i1 - (xchp->i1 + xchp->chg1) > max_common)
> -			break;
> +	for (xchp = *xscr, xch = (*xscr)->next; xch; xchp = xch, xch = xch->next) {
> +		long thresh;
> +		if (xchp->ignore || xch->ignore)
> +			thresh = ignorable_context;
> +		else
> +			thresh = max_common;
> +
> +		if (!xchp->ignore)
> +			interesting = 1;
> +
> +		if (xch->i1 - (xchp->i1 + xchp->chg1) > thresh) {
> +			if (interesting)
> +				break;
> +			else
> +				*xscr = xch;
> +		}
> +	}
> +
> +	if (!interesting && xchp->ignore)
> +		*xscr = NULL;
>
>  	return xchp;
>  }
> @@ -139,7 +159,9 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>  		return xdl_emit_common(xe, xscr, ecb, xecfg);
>
>  	for (xch = xscr; xch; xch = xche->next) {
> -		xche = xdl_get_hunk(xch, xecfg);
> +		xche = xdl_get_hunk(&xch, xecfg);
> +		if (!xch)
> +			break;
>
>  		s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
>  		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
> diff --git a/xdiff/xemit.h b/xdiff/xemit.h
> index c2e2e83..d297107 100644
> --- a/xdiff/xemit.h
> +++ b/xdiff/xemit.h
> @@ -27,7 +27,7 @@
>  typedef int (*emit_func_t)(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>  			   xdemitconf_t const *xecfg);
>
> -xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg);
> +xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg);
>  int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>  		  xdemitconf_t const *xecfg);
>
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 9504eae..c047376 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -143,6 +143,19 @@ long xdl_guess_lines(mmfile_t *mf, long sample) {
>  	return nl + 1;
>  }
>
> +int xdl_blankline(const char *line, long flags)
> +{
> +	long i;
> +
> +	if (!(flags & XDF_WHITESPACE_FLAGS))
> +		return (*line == '\n');
> +
> +	for (i = 0; line[i] != '\n' && XDL_ISSPACE(line[i]); i++)
> +		;
> +
> +	return (line[i] == '\n');
> +}
> +
>  int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>  {
>  	int i1, i2;
> diff --git a/xdiff/xutils.h b/xdiff/xutils.h
> index ad1428e..b9cceff 100644
> --- a/xdiff/xutils.h
> +++ b/xdiff/xutils.h
> @@ -32,6 +32,7 @@ int xdl_cha_init(chastore_t *cha, long isize, long icount);
>  void xdl_cha_free(chastore_t *cha);
>  void *xdl_cha_alloc(chastore_t *cha);
>  long xdl_guess_lines(mmfile_t *mf, long sample);
> +int xdl_blankline(const char *line, long flags);
>  int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
>  unsigned long xdl_hash_record(char const **data, char const *top, long flags);
>  unsigned int xdl_hashbits(unsigned int size);
> --
> 1.7.9.5
