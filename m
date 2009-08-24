From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 16:20:52 +0200
Message-ID: <200908241620.52838.johan@herland.net>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home> <7vocq5q0j7.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908240946390.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 16:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfaQU-0006GM-Mu
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbZHXOV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 10:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbZHXOV2
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:21:28 -0400
Received: from sam.opera.com ([213.236.208.81]:60562 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbZHXOV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 10:21:28 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n7OEKrLs028087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 24 Aug 2009 14:20:58 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0908240946390.6044@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126929>

On Monday 24 August 2009, Nicolas Pitre wrote:
> On Sun, 23 Aug 2009, Junio C Hamano wrote:
> > Nicolas Pitre <nico@cam.org> writes:
> > > If all refs sent by the remote repo during a fetch are reachable
> > > locally, then no further conversation is performed with the
> > > remote. This check is skipped when the --depth argument is
> > > provided to allow the deepening of a shallow clone which
> > > corresponding remote repo has no changed.
> > >
> > > However, some additional filtering was added in commit c29727d5
> > > to remove those refs which are equal on both sides.  If the
> > > remote repo has not changed, then the list of refs to give the
> > > remote process becomes empty and simply attempting to deepen a
> > > shallow repo always fails.
> > >
> > > Let's stop being smart in that case and simply send the whole
> > > list over when that condition is met.  The remote will do the
> > > right thing anyways.
> > >
> > > Test cases for this issue are also provided.
> > >
> > > Signed-off-by: Nicolas Pitre <nico@cam.org>
> > > ---
> >
> > Thanks.  The fix looks correct (as usual with patches from you).
> >
> > But it makes me wonder if this logic to filter refs is buying us
> > anything.
> >
> > >  	for (rm = refs; rm; rm = rm->next) {
> > > +		nr_refs++;
> > >  		if (rm->peer_ref &&
> > >  		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
> > >  			continue;
> >
> > 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
> > 		heads[nr_heads++] = rm;
> > 	}
> >
> > What is the point of not asking for the refs that we know are the
> > same?
>
> I could see the advantage if the number of refs is really huge. 
> Wasn't some converted repositories producing a lot of branches and/or
> tags significantly slowing down a fetch operation?  Granted that was
> long ago when that issue got "fixed" so the details are fuzzy to me.

I'm converting several CVS repos to Git with ~50 000 refs, so I'm happy 
with any change that can speed things up for repos with many refs.

Right now, my biggest gripe is that a 'git push --mirror' on such a repo 
can easily take ~10 min. even though the actual pack generation and 
transfer only takes a couple of seconds. It seems like it needs ~10 
minutes to generate the list of changed/added/deleted refs...
Unfortunately I haven't had time to look properly into it, yet...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
