From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Tue, 10 Jun 2008 00:31:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806100024310.1783@racer>
References: <alpine.DEB.1.00.0806091458190.1783@racer> <1213051426-11530-1-git-send-email-vmiklos@frugalware.org> <7v8wxefbtn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:33:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qrn-0005Bd-Vi
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbYFIXcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbYFIXcm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:32:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:50697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754137AbYFIXcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:32:41 -0400
Received: (qmail invoked by alias); 09 Jun 2008 23:32:39 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 10 Jun 2008 01:32:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xZ30qohfx736ORxs8TGqpBRbT89Ks/fmMf9SfFZ
	qY+OHa/QvvciVb
X-X-Sender: gene099@racer
In-Reply-To: <7v8wxefbtn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84453>

Hi,

On Mon, 9 Jun 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > +struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup)
> > +{
> > +	struct commit_list *ret, *i;
> > +
> > +	ret = merge_bases_many(in->item, in->next);
> > +	if (cleanup)
> > +		for(i = in; i; i = i->next)
> > +			clear_commit_marks(i->item, all_flags);
> > +	return ret;
> > +}
> 
> I suspect either me or you are confused, but how is this exactly used?
> 
> The code for merge_bases_many(), at least the one I showed you a few days
> ago, is not a replacement for "show-branch --merge-base", and I do not
> think you would want to use it as such in the rewrite of git-merge, if you
> are trying to replace this part of git-merge.sh:
> 
>         case "$#" in
>         1)
>                 common=$(git merge-base --all $head "$@")
>                 ;;
>         *)
>                 common=$(git show-branch --merge-base $head "$@")
>                 ;;
>         esac
> 
> The purpose of merge-base-many code was to improve this line in the
> git-merge-octopus.sh:
> 
> 	common=$(git merge-base --all $MRC $SHA1) ||
> 		die "Unable to find common commit with $SHA1"
> 
> Instead of keeping a single MRC, we can compute the merge-base-many
> between the SHA1 (i.e. the one we are looking at right now -- it is fed as
> "one") and all the previous SHA1's we have already looked at (they become
> "two's"), like this:
> 
> 	common($git merge-base-many $SHA1 $SHA1_SO_FAR)
> 
> and you would have at the end of the loop:
> 
> 	SHA1_SO_FAR="$SHA1_SO_FAR$SHA1 "
> 
> or something.

Ah!  Even I thought that merge_bases_many() was meant for the show-branch 
--merge-base case.

However, your remark about optimizing for the two-head case got me 
thinking: should we not rather use the simple algorithm Miklos proposed 
for octopus_merge_bases(), even if it is suboptimal?

Octopus is such a rare case that it is more important to have a robust, 
working code, than a fast one, right?  Especially since Octopus will be 
exercized much less often, and therefore has a higher chance of hiding a 
bug.

Ciao,
Dscho
