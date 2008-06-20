From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-merge-recursive-{ours,theirs}
Date: Fri, 20 Jun 2008 13:58:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806201351370.6439@racer>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com> <20080616092554.GB29404@genesis.frugalware.org> <48563D6C.8060704@viscovery.net> <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com> <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
 <7vve076d6t.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806181618070.6439@racer> <alpine.DEB.1.00.0806181627260.6439@racer> <7viqw6zovi.fsf@gitster.siamese.dyndns.org> <7vfxr8o8sx.fsf_-_@gitster.siamese.dyndns.org>
 <7vbq1wo8ck.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: geoffrey.russell@gmail.com, sverre@rabbelier.nl,
	Johannes Sixt <j.sixt@viscovery.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:02:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gFF-0002CW-2G
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbYFTNA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbYFTNA3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:00:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:41501 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754663AbYFTNA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:00:28 -0400
Received: (qmail invoked by alias); 20 Jun 2008 13:00:26 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp037) with SMTP; 20 Jun 2008 15:00:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/d/44cUSLdF8Iy3YD0UqltM/isqNj5gUUS4P1tL9
	ORtQG66INokPu1
X-X-Sender: gene099@racer
In-Reply-To: <7vbq1wo8ck.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85634>

Hi,

On Fri, 20 Jun 2008, Junio C Hamano wrote:

> diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
> index 4aa28a1..a355e7a 100644
> --- a/builtin-merge-recursive.c
> +++ b/builtin-merge-recursive.c
> @@ -650,9 +655,26 @@ static int merge_3way(mmbuffer_t *result_buf,
>  	fill_mm(a->sha1, &src1);
>  	fill_mm(b->sha1, &src2);
>  
> +	if (index_only)
> +		favor = 0;
> +	else {
> +		switch (merge_recursive_variants) {
> +		case MERGE_RECURSIVE_OURS:
> +			favor = XDL_MERGE_FAVOR_OURS;
> +			break;
> +		case MERGE_RECURSIVE_THEIRS:
> +			favor = XDL_MERGE_FAVOR_THEIRS;
> +			break;
> +		default:
> +			favor = 0;
> +			break;
> +		}

Hrm.  I would have preferred something like this:

	if (!index_only && merge_recursive_variants == MERGE_RECURSIVE_OURS)
		favor = XDL_MERGE_FAVOR_OURS;
	if (!index_only && merge_recursive_variants == MERGE_RECURSIVE_THEIRS)
		favor = XDL_MERGE_FAVOR_THEIRS;
	else
		favor = 0;

> +	}
> +	flag = LL_MERGE_FLAGS(index_only, favor);
> +
>  	merge_status = ll_merge(result_buf, a->path, &orig,
>  				&src1, name1, &src2, name2,
> -				index_only);
> +				flag);

Sorry, but in my opinion this flag mangling makes the whole code uglier.  
Why not just add another parameter?

Or if you are really concerned about future enhancements to ll_merge(), 
use a struct.

> @@ -1379,11 +1401,18 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>  	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
>  	int index_fd;
>  
> +	merge_recursive_variants = 0;
>  	if (argv[0]) {
>  		int namelen = strlen(argv[0]);
>  		if (8 < namelen &&
>  		    !strcmp(argv[0] + namelen - 8, "-subtree"))
> -			subtree_merge = 1;
> +			merge_recursive_variants = MERGE_RECURSIVE_SUBTREE;
> +		else if (5 < namelen &&
> +			 !strcmp(argv[0] + namelen - 5, "-ours"))
> +			merge_recursive_variants = MERGE_RECURSIVE_OURS;
> +		else if (7 < namelen &&
> +			 !strcmp(argv[0] + namelen - 7, "-theirs"))
> +			merge_recursive_variants = MERGE_RECURSIVE_THEIRS;

This just cries out loud for a new function suffixcmp().

I will not say anything about the long lines in git-merge.sh, since I 
fully expect builtin-merge to happen Real Soon Now.

Anyhow, your comments about this driving the wrong workflow still apply.  
Maybe we want to display them really, really prominently in 
Documentation/merge-strategies.txt.

Ciao,
Dscho
