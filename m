From: Jeff King <peff@peff.net>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Fri, 5 Oct 2012 19:21:08 -0400
Message-ID: <20121005232108.GA7996@sigill.intra.peff.net>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
 <7v391ux7im.fsf@alter.siamese.dyndns.org>
 <7vvceqvses.fsf@alter.siamese.dyndns.org>
 <7vmx01x3s4.fsf@alter.siamese.dyndns.org>
 <7vehlcu091.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 01:21:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKHCw-0006Ei-I1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 01:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab2JEXVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 19:21:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42344 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548Ab2JEXVL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 19:21:11 -0400
Received: (qmail 2566 invoked by uid 107); 5 Oct 2012 23:21:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Oct 2012 19:21:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2012 19:21:08 -0400
Content-Disposition: inline
In-Reply-To: <7vehlcu091.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207127>

On Fri, Oct 05, 2012 at 01:34:02PM -0700, Junio C Hamano wrote:

> OK, I think I am convinced myself that this patch is the right fix.
> 
> The performance regression Markus saw is in fmt-merge-message, and
> it is caused by the updated remove_redundant() that is used by
> get_merge_bases_many() and reduce_heads().  On the topic branch, all
> callers of reduce_heads() were passing commits that are already
> parsed, but before the topic was merged to 'master', we added one
> more caller to reduce_heads() on the 'master' front that passed an
> unparsed commit, which is why the problem surfaced at that merge.

Thanks for tracking it down. That makes a lot of sense with the results
we are seeing.

> It might make sense to assert or die in commit_list_insert_by_date()
> when a caller mistakenly pass an unparsed commit object to prevent
> this kind of breakages in the future.

I wonder if it would be too much to just have commit_list_insert_by_date
call parse_commit. It is, after all, the exact moment when we need to
have the date valid (and by waiting until the last minute, we can
potentially avoid parses that would not otherwise need to happen). The
overhead in the common case should basically be the same as an assert:
checking that commit->object.parsed is true (we can always inline that
bit of parse_commit if we have to).

Of course, in this case it is not just commit_list_insert_by_date that
cares. paint_down_to_common also want commit->parents to be valid; I'm
surprised that dealing with unparsed commits did not also reveal an
error there.

In an object-oriented world, we would always get the attributes of a
commit through accessors that made sure the object was parsed. That
would be nicer, but it would also mean paying for the "if (parsed)"
conditional a lot more frequently.

> > @@ -617,6 +618,8 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
> >  
> >  	one->object.flags |= PARENT1;
> >  	commit_list_insert_by_date(one, &list);
> > +	if (!n)
> > +		return list;
> >  	for (i = 0; i < n; i++) {
> >  		twos[i]->object.flags |= PARENT2;
> >  		commit_list_insert_by_date(twos[i], &list);

This seems like an obvious optimization, but does it really have
anything to do with the patch at hand?

-Peff
