From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Mon, 6 Jun 2011 18:08:21 -0400
Message-ID: <20110606220821.GB13697@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <7vipsi8zwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 00:08:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QThyf-000291-Rr
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 00:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758131Ab1FFWI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 18:08:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45684
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758069Ab1FFWIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 18:08:25 -0400
Received: (qmail 9444 invoked by uid 107); 6 Jun 2011 22:08:31 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jun 2011 18:08:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2011 18:08:21 -0400
Content-Disposition: inline
In-Reply-To: <7vipsi8zwl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175174>

On Mon, Jun 06, 2011 at 01:31:54PM -0700, Junio C Hamano wrote:

> >  static struct ref *wanted_peer_refs(const struct ref *refs,
> >  		struct refspec *refspec)
> >  {
> > -	struct ref *local_refs = NULL;
> > -	struct ref **tail = &local_refs;
> > +	struct ref *head = get_remote_ref(refs, "HEAD");
> 
> The rest of the patch looked quite sane but I wonder if this should be
> using get_remote_ref() that calls find_ref_by_name_abbrev() which in turn
> would hit "refs/heads/HEAD" if the remote side didn't give you "HEAD".
> Shouldn't it be using find_ref_by_name() directly?

Ick, yeah, that was just me blindly cutting down what get_fetch_map was
doing to the bit that I wanted, and thinking get_remote_ref was it.  I
didn't even notice the fact that it was using the _abbrev form of
find_ref_by_name.

It should definitely be an exact match. I'll fix it in my re-roll.

> > @@ -357,8 +358,11 @@ static void write_remote_refs(const struct ref *local_refs)
> >  {
> >  	const struct ref *r;
> >  
> > -	for (r = local_refs; r; r = r->next)
> > +	for (r = local_refs; r; r = r->next) {
> > +		if (!r->peer_ref)
> > +			continue;
> 
> As this is part of this patch, I presume this test reliably catch "HEAD"
> and only "HEAD", but what is it that gives us this guarantee?  Is it that
> in all three possible configurations (i.e. traditional no-separate remote
> layout, separate remote layout, or mirrored layout), we never map anything
> outside refs/heads/* and refs/tags/* namespace, hence things like HEAD
> will never have peer_ref defined?

Until now, nobody fed us a ref without peer_ref mapped, as doing so
would segfault. So this gives a NULL peer ref the meaning "don't bother
saving this into a ref". Which is really the only sensible thing it can
mean, since the peer ref is the local bit that says where to put it.

> This is not a complaint but is an honest question. I am wondering how
> future possible enhancements to "clone" (like the rumored "track only this
> branch") will affect codepaths around this area.

I think it's a good question to ask. The answer is that if you are
cloning only a subset of the remote refs (or even a single ref), then
either:

  1. You will want to write that subset according to a refspec mapping
     (e.g., cloning "jk/*" to "remotes/origin/jk/*"). In that case you
     would have set the peer_ref to show where to put it.

  2. You will not want to write out these refs, because you are handling
     them separately. For example, in this case, we are already handling
     the detached HEAD case separately when we generally figure out what
     HEAD is. And in this case, the code does what you want by silently
     skipping.

     I tried to think of another case where you would want this, but I
     really couldn't come up with one. Even if you are cloning a "track
     only this branch" ref, you would still have its peer_ref pointing
     to its local counterpart (even if it's "refs/heads/master" both
     locally and on the remote).

-Peff
