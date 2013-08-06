From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] fetch: opportunistically update tracking refs
Date: Tue, 6 Aug 2013 17:46:22 -0400
Message-ID: <20130806214622.GA31766@sigill.intra.peff.net>
References: <20130511161320.GA14990@sigill.intra.peff.net>
 <20130511161652.GD3270@sigill.intra.peff.net>
 <7vsiymhjgz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 23:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6p5O-0000rQ-H9
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 23:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab3HFVqa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Aug 2013 17:46:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:50079 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab3HFVq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 17:46:28 -0400
Received: (qmail 7587 invoked by uid 102); 6 Aug 2013 21:46:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Aug 2013 16:46:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Aug 2013 17:46:22 -0400
Content-Disposition: inline
In-Reply-To: <7vsiymhjgz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231789>

On Tue, Aug 06, 2013 at 09:28:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > @@ -170,6 +172,20 @@ static struct ref *get_ref_map(struct transpor=
t *transport,
> >  			rm->fetch_head_status =3D FETCH_HEAD_MERGE;
> >  		if (tags =3D=3D TAGS_SET)
> >  			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
> > +
> > +		/*
> > +		 * For any refs that we happen to be fetching via command-line
> > +		 * arguments, take the opportunity to update their configured
> > +		 * counterparts. However, we do not want to mention these
> > +		 * entries in FETCH_HEAD at all, as they would simply be
> > +		 * duplicates of existing entries.
> > +		 */
> > +		old_tail =3D tail;
> > +		for (i =3D 0; i < transport->remote->fetch_refspec_nr; i++)
> > +			get_fetch_map(ref_map, &transport->remote->fetch[i],
> > +				      &tail, 0);
> > +		for (rm =3D *old_tail; rm; rm =3D rm->next)
> > +			rm->fetch_head_status =3D FETCH_HEAD_IGNORE;
>=20
> Was there a reason why this change was done by appending new ref at
> the tail of the ref_map list?  I would have expected that a na=C3=AFv=
e
> and obvious implementation would be to iterate existing refs over
> ref_map to find refs with an empty RHS whose LHS is configured to
> usually store the fetched result to somewhere and to update their
> RHS in place.
>=20
> Being curious.

Two reasons:

  1. The implementation you suggest above behaves differently than the
     current code. It does not look for refspecs with an empty RHS. It
     looks for any LHS that matches our configured entries. So if you d=
o
     "git fetch origin master:foobar", we will update both
     "refs/heads/foobar" as well as "refs/remotes/origin/master".

     That means it is purely an opportunistic "hey, during another
     operation we happened to find out something new about
     origin/master, so let's update our tracking branch". Whereas what
     you stated above is more like "we are fetching into FETCH_HEAD, so
     let's also update the tracking branch".

  2. The list of refs after get_ref_map is actually more of an
     instruction/command list for the rest of the code to follow. It
     gets fed to store_updated_ref, but also impacts the status table w=
e
     show. You could implement it such that a single ref entry had
     multiple storage destinations, but that would require changes to
     all of the consumers of the instruction list. Since we already nee=
d
     to handle extra refspecs (e.g., you can say "master:foobar
     master:refs/remotes/origin/master" on the command line already), w=
e
     can treat these the same way. We append to the instruction list,
     and the rest of the code treats it as if you specified it on the
     command line.

-Peff
