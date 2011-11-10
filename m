From: Jeff King <peff@peff.net>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Thu, 10 Nov 2011 03:08:51 -0500
Message-ID: <20111110080851.GA28342@sigill.intra.peff.net>
References: <4EB9C7D1.30201@nextest.com>
 <20111109220128.GA31535@sigill.intra.peff.net>
 <20111109222032.GB31535@sigill.intra.peff.net>
 <4EBB8596.6040507@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 09:09:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPh1-0003EY-Em
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 09:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934107Ab1KJII5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 03:08:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38946
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934013Ab1KJIIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 03:08:54 -0500
Received: (qmail 22991 invoked by uid 107); 10 Nov 2011 08:08:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 03:08:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 03:08:51 -0500
Content-Disposition: inline
In-Reply-To: <4EBB8596.6040507@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185215>

On Thu, Nov 10, 2011 at 12:04:38AM -0800, Eric Raible wrote:

> > I think I am leaning towards the latter. It seems to me to be the more
> > likely guess for what the user would want. And there is real benefit to
> > doing it in git, since we can stop the traversal early. In the
> > "grep-like" case, doing it inside git is not really any more efficient
> > than filtering in a pipeline, like:
> > 
> >   git log -g --format='%ct %H' |
> >   awk '{ print $2 if $1 < SOME_TIMESTAMP }'
> 
> And then the sha would have to be fed back into git to be useful, eh?

It's just illustrative. You could replace "%H" with the actual
information you're interested in.

> > Of course we could still offer both (with a "--reflog-since" type of
> > option). We'd also need to turn off the optimization for "--since", and
> > then check whether "--until" has a similar bug (and offer
> > "--reflog-until").
> 
> I don't see the point of --reflog-since.  If the user specifies 'reflog'
> (either directly or with -g), then can't we just use the reflog's timestamp?
> Note: there might be good reasons, as my use of the reflog (and --since, for
> that matter), has been very simplistic so far.

The only point would be to leave "--since" to act on the commit
timestamps, so that you don't have to resort to the external grepping I
mentioned above. However, I'm not convinced anybody even cares about
that use case.

I think the behavior you want is much more sensible.

> > diff --git a/reflog-walk.c b/reflog-walk.c
> > index 5d81d39..2e5b270 100644
> > --- a/reflog-walk.c
> > +++ b/reflog-walk.c
> > @@ -231,6 +231,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
> >  	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
> >  	info->last_commit_reflog = commit_reflog;
> >  	commit_reflog->recno--;
> > +	commit->date = reflog->timestamp;
> >  	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
> >  	if (!commit_info->commit) {
> >  		commit->parents = NULL;
> 
> Is this something you'd be willing to turn into a real patch?
> I'm certainly not qualified.

Yes. We're in release freeze now, so I didn't even bother with sending
it to Junio. But also, I'd like to gather more opinions on whether the
design is the right thing (hopefully the implementation is Obviously
Correct. :) ).

-Peff
