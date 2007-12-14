From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 2/2] xdi_diff: trim common trailing lines
Date: Fri, 14 Dec 2007 10:06:14 +0100
Message-ID: <20071214090614.GB15610@xp.machine.xx>
References: <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org> <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <7vzlwps8zf.fsf@gitster.siamese.dyndns.org> <7vejdy4yuw.fsf@gitster.siamese.dyndns.org> <7v7ijorwnc.fsf@gitster.siamese.dyndns.org> <7vabof5mze.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.99999.0712122219160.20487@xanadu.home> <7vmysez0oa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 10:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J36VH-0007Id-Vz
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 10:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbXLNJGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 04:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756011AbXLNJGU
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 04:06:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:41324 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756376AbXLNJGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 04:06:18 -0500
Received: (qmail invoked by alias); 14 Dec 2007 09:06:15 -0000
Received: from p54AA85A9.dip0.t-ipconnect.de (EHLO localhost) [84.170.133.169]
  by mail.gmx.net (mp055) with SMTP; 14 Dec 2007 10:06:15 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/ygN4AUt7yuBeFHHgjzLoeU21ZdTLJL6GWWBQWOt
	+nXLJ9IlC8eBBX
Content-Disposition: inline
In-Reply-To: <7vmysez0oa.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68270>

On Thu, Dec 13, 2007 at 02:31:49PM -0800, Junio C Hamano wrote:
> This implements earlier Linus's optimization to trim common lines at the
> end before passing them down to low level xdiff interface for all of our
> xdiff users.
> 
> We could later enhance this to also trim common leading lines, but that
> would need tweaking of the output function to add the number of lines
> trimmed at the beginning to line numbers that appear in the hunk
> headers.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  xdiff-interface.c |   34 +++++++++++++++++++++++++++++++++-
>  1 files changed, 33 insertions(+), 1 deletions(-)
> 
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 69a022c..f2cd488 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -103,9 +103,41 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
>  	return 0;
>  }
>  
> +/*
> + * Trim down common substring at the end of the buffers,
> + * but leave at least ctx lines at the end.
> + */
> +static void trim_common_tail(mmfile_t *a, mmfile_t *b, int ctx)

Should ctx be a long? (see comment below)

> +{
> +	const int blk = 1024;
> +	long trimmed = 0, recovered = 0;
> +	int i;
> +	char *ap = a->ptr + a->size;
> +	char *bp = b->ptr + b->size;
> +	long smaller = (a->size < b->size) ? a->size : b->size;
> +
> +	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
> +		trimmed += blk;
> +		ap -= blk;
> +		bp -= blk;
> +	}
> +
> +	for (i = 0, recovered = 0; recovered < trimmed && i <= ctx; i++) {
> +		while (recovered < trimmed && ap[recovered] != '\n')
> +			recovered++;
> +	}
> +	a->size -= (trimmed - recovered);
> +	b->size -= (trimmed - recovered);
> +}
> +
>  int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *xecb)
>  {
> -	return xdl_diff(mf1, mf2, xpp, xecfg, xecb);
> +	mmfile_t a = *mf1;
> +	mmfile_t b = *mf2;
> +
> +	trim_common_tail(&a, &b, xecfg->ctxlen);

xdemitconf_t has the following definition

	typedef struct s_xdemitconf {
		long ctxlen;
	        unsigned long flags;
		find_func_t find_func;
	        void *find_func_priv;
	} xdemitconf_t;

So you are loosing some values in your trim_common_tail function by making ctx
only an int. (Not sure that it matters, but I noticed it while glancing over
your code).

> +
> +	return xdl_diff(&a, &b, xpp, xecfg, xecb);
>  }
>  
>  int read_mmfile(mmfile_t *ptr, const char *filename)

-Peter
