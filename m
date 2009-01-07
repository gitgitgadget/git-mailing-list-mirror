From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/3] Implement the patience diff algorithm
Date: Wed, 7 Jan 2009 19:32:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901071924350.7496@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp>
 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
 <20090107143926.GB831@artemis.corp> <alpine.DEB.1.00.0901071610290.7496@intel-tinevez-2-302> <alpine.DEB.1.00.0901071802190.7496@intel-tinevez-2-302> <alpine.DEB.1.10.0901071001360.16651@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 19:34:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKdEJ-0004cH-8v
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 19:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbZAGScs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 13:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754408AbZAGScs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 13:32:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:53067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754118AbZAGScr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 13:32:47 -0500
Received: (qmail invoked by alias); 07 Jan 2009 18:32:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 07 Jan 2009 19:32:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lsR94m2aldaJZPpBKtKqxYE8u5XAEUE/9b41QRN
	pOV360qYSbm1eb
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.10.0901071001360.16651@alien.or.mcafeemobile.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104818>

Hi,

On Wed, 7 Jan 2009, Davide Libenzi wrote:

> On Wed, 7 Jan 2009, Johannes Schindelin wrote:
> 
> > The patience diff algorithm produces slightly more intuitive output 
> > than the classic Myers algorithm, as it does not try to minimize the 
> > number of +/- lines first, but tries to preserve the lines that are 
> > unique.
> 
> Johannes, sorry I had not time to follow this one.

What?  You mean you actually took some time off around Christmas???

:-)

> A couple of minor comments that arose just at glancing at the patch.

Thanks.

> > +/*
> > + *  LibXDiff by Davide Libenzi ( File Differential Library )
> > + *  Copyright (C) 2003-2009 Davide Libenzi, Johannes E. Schindelin
> > + *
> > + *  This library is free software; you can redistribute it and/or
> > + *  modify it under the terms of the GNU Lesser General Public
> > + *  License as published by the Free Software Foundation; either
> > + *  version 2.1 of the License, or (at your option) any later version.
> > + *
> > + *  This library is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + *  Lesser General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU Lesser General Public
> > + *  License along with this library; if not, write to the Free Software
> > + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> > + *
> > + *  Davide Libenzi <davidel@xmailserver.org>
> 
> You do not need to give me credit for something I don't even know how it 
> works ;)

Well, I meant to pass the copyright to you, or at least share it.

> > +static int fall_back_to_classic_diff(struct hashmap *map,
> > +		int line1, int count1, int line2, int count2)
> > +{
> > +	/*
> > +	 * This probably does not work outside Git, since
> > +	 * we have a very simple mmfile structure.
> > +	 *
> > +	 * Note: ideally, we would reuse the prepared environment, but
> > +	 * the libxdiff interface does not (yet) allow for diffing only
> > +	 * ranges of lines instead of the whole files.
> > +	 */
> > +	mmfile_t subfile1, subfile2;
> > +	xpparam_t xpp;
> > +	xdfenv_t env;
> > +
> > +	subfile1.ptr = (char *)map->env->xdf1.recs[line1 - 1]->ptr;
> > +	subfile1.size = map->env->xdf1.recs[line1 + count1 - 2]->ptr +
> > +		map->env->xdf1.recs[line1 + count1 - 2]->size - subfile1.ptr;
> > +	subfile2.ptr = (char *)map->env->xdf2.recs[line2 - 1]->ptr;
> > +	subfile2.size = map->env->xdf2.recs[line2 + count2 - 2]->ptr +
> > +		map->env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
> > +	xpp.flags = map->xpp->flags & ~XDF_PATIENCE_DIFF;
> > +	if (xdl_do_diff(&subfile1, &subfile2, &xpp, &env) < 0)
> > +		return -1;
> 
> xdiff allows for diffing ranges, and the most efficent method is exactly 
> how you did ;) Once you know the lines pointers, there's no need to pass 
> it the whole file and have it scan it whole to find the lines range it 
> has to diff. Just pass the limited view like you did.

Heh.

Could it be that you misread my patch, and assumed that I faked an 
xdfenv?

I did not, but instead faked two mmfiles, which is only as simple as I did 
it because in git.git, we only have contiguous mmfiles.  (I recall that 
libxdiff allows for ropes instead of arrays.)

The way I did it has one big shortcoming: I need to prepare an xdfenv for 
the subfiles even if I already prepared one for the complete files.  IOW 
the lines are rehashed all over again.

Ciao,
Dscho
