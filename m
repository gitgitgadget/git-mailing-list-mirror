From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/10] rev-list: call new "filter_skip" function
Date: Mon, 30 Mar 2009 09:54:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903300951460.7534@intel-tinevez-2-302>
References: <20090326055549.e1f244d9.chriscool@tuxfamily.org> <7v8wmssrrs.fsf@gitster.siamese.dyndns.org> <200903300526.12978.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1849218998-1238399669=:7534"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 09:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoCLg-0006AG-Nu
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 09:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZC3Hyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 03:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbZC3Hyd
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 03:54:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:57050 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751425AbZC3Hyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 03:54:32 -0400
Received: (qmail invoked by alias); 30 Mar 2009 07:54:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp062) with SMTP; 30 Mar 2009 09:54:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rW/hlIxlr28Lw879Vxz/GJatm2vWSJRlvhFFgsA
	JgCaJCW+QIJk8J
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200903300526.12978.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115099>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1849218998-1238399669=:7534
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 30 Mar 2009, Christian Couder wrote:

> Le jeudi 26 mars 2009, Junio C Hamano a écrit :
> > Christian Couder <chriscool@tuxfamily.org> writes:
> > > This patch implements a new "filter_skip" function in C in
> > > "bisect.c" that will later replace the existing implementation in
> > > shell in "git-bisect.sh".
> > >
> > > An array is used to store the skipped commits. But the array is
> > > not yet fed anything.
> > >
> > > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > > ---
> > >  bisect.c           |   65
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++++ bisect.h          
> > > |    6 ++++-
> > >  builtin-rev-list.c |   30 ++++++++++++++++++++----
> > >  3 files changed, 95 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/bisect.c b/bisect.c
> > > index 27def7d..39189f2 100644
> > > --- a/bisect.c
> > > +++ b/bisect.c
> > > @@ -4,6 +4,11 @@
> > >  #include "revision.h"
> > >  #include "bisect.h"
> > >
> > > +
> > > +static unsigned char (*skipped_sha1)[20];
> > > +static int skipped_sha1_nr;
> > > +static int skipped_sha1_alloc;
> > > +
> > >  /* bits #0-15 in revision.h */
> > >
> > >  #define COUNTED		(1u<<16)
> > > @@ -386,3 +391,63 @@ struct commit_list *find_bisection(struct
> > > commit_list *list, return best;
> > >  }
> > >
> > > +static int skipcmp(const void *a, const void *b)
> > > +{
> > > +	return hashcmp(a, b);
> > > +}
> >
> > I've learned to suspect without reading a qsort() callback that does not
> > derefence its arguments.  Is this doing the right thing?
> 
> I think so.

I suspect something much worse: you are trying to build a list of sha1s of 
commits that need to be skipped, later to look up every commit via 
binary search.

But it has been proven a lot of times that using a hash set is superior to 
that approach, and even better: we already have the framework in place in 
the form of struct decorate.

Ciao,
Dscho "who is too busy to review patches ATM"
--8323329-1849218998-1238399669=:7534--
