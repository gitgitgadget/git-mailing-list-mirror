From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 1/2] xdiff: add xdl_hash_and_recmatch helper function
Date: Fri, 15 Apr 2016 10:25:21 -0700
Message-ID: <xmqq60vidbsu.fsf@gitster.mtv.corp.google.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
	<20160415165141.4712-2-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:25:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar7Um-00058M-Sh
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbcDORZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 13:25:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752154AbcDORZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 13:25:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 21E3413A1E;
	Fri, 15 Apr 2016 13:25:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UHlvfm2zOY7UlvY2NDs6jhZzveU=; b=fOwaY2
	K+oqfdAxAlJb5M/CjvnSIq6VdC0mPemZPZ9d/AekspZnTEEEs53vPBB08jwxnT7i
	h0O/tz4tsUm0iZG3LNHF6nc7vAApgdxAQJbxl5C7JV/3xxaxo9OoPbQUmIx5F83w
	8PA+0t8obbjZEizSoYkfApEUnBflV+bscGKO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zp2vJ8RL26wdGwDMdueF4y+yMo6ZRj3y
	ODRL2GAiM2f6tCcYLKepo1Oe9iBVAbpJs0FLWsfPWgU/gsQBoc8m9fz1gDWmSaCn
	QkuJVLL7XGhjqPUTOjk6HGQDNot06oePJBpUd6eScz+r9VVQexg3/FiW9IpetX3O
	eI+6547qw4g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A76D13A1D;
	Fri, 15 Apr 2016 13:25:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69BD413A1C;
	Fri, 15 Apr 2016 13:25:22 -0400 (EDT)
In-Reply-To: <20160415165141.4712-2-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Fri, 15 Apr 2016 09:51:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08AAB4EC-032F-11E6-B8E3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291624>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> It is a common pattern in xdl_change_compact to check that hashes and
> strings match. The resulting code to perform this change causes very
> long lines and makes it hard to follow the intention. Introduce a helper
> function xdl_hash_and_recmatch which performs both checks to increase
> code readability.

Think _why_ it is common to check hash and then do recmatch().  What
is the combination of two trying to compute?

How about calling it after "what" it computes, not after "how" it
computes it?  E.g.

    static int recs_match(xrecord_t **recs, long x, long y, long flags)

if we answer the above question "they try to see if two records match".
We could also go s/recs/lines/.

The xdl_recmatch() function appears in xutils.c, and over there the
functions do not use arrays of (xrecord_t *), so I think we are
better off without xdl_ prefix to avoid confusion.

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  xdiff/xdiffi.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 2358a2d6326e..fff97ac3e3c7 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -400,6 +400,14 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
>  }
>  
>  
> +static int xdl_hash_and_recmatch(xrecord_t **recs, long ixs, long ix, long flags)
> +{
> +	return (recs[ixs]->ha == recs[ix]->ha &&
> +		xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size,
> +			     recs[ix]->ptr, recs[ix]->size,
> +			     flags));
> +}
> +
>  int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
>  	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
> @@ -442,8 +450,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  			 * the last line of the current change group, shift backward
>  			 * the group.
>  			 */
> -			while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
> -			       xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags)) {
> +			while (ixs > 0 && xdl_hash_and_recmatch(recs, ixs - 1, ix - 1, flags)) {
>  				rchg[--ixs] = 1;
>  				rchg[--ix] = 0;
>  
> @@ -470,8 +477,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  			 * the line next of the current change group, shift forward
>  			 * the group.
>  			 */
> -			while (ix < nrec && recs[ixs]->ha == recs[ix]->ha &&
> -			       xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size, recs[ix]->ptr, recs[ix]->size, flags)) {
> +			while (ix < nrec && xdl_hash_and_recmatch(recs, ixs, ix, flags)) {
> +				emptylines += is_emptyline(recs[ix]->ptr);
> +
>  				rchg[ixs++] = 0;
>  				rchg[ix++] = 1;
