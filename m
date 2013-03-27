From: Jeff King <peff@peff.net>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 16:01:13 -0400
Message-ID: <20130327200113.GC26380@sigill.intra.peff.net>
References: <51531059.8000407@atechmedia.com>
 <7vsj3gn55b.fsf@alter.siamese.dyndns.org>
 <515331F2.3060703@atechmedia.com>
 <874nfw4t0r.fsf@59A2.org>
 <51533E8D.5050206@atechmedia.com>
 <87zjxo3b7b.fsf@59A2.org>
 <20130327194521.GQ2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jed Brown <jed@59A2.org>,
	Charlie Smurthwaite <charlie@atechmedia.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:01:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwXb-0005ik-C8
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab3C0UBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:01:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41845 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580Ab3C0UBS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:01:18 -0400
Received: (qmail 17672 invoked by uid 107); 27 Mar 2013 20:03:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Mar 2013 16:03:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2013 16:01:13 -0400
Content-Disposition: inline
In-Reply-To: <20130327194521.GQ2286@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219315>

On Wed, Mar 27, 2013 at 07:45:21PM +0000, John Keeping wrote:

> On Wed, Mar 27, 2013 at 02:16:24PM -0500, Jed Brown wrote:
> > Charlie Smurthwaite <charlie@atechmedia.com> writes:
> > 
> > > Yes, I would need to be able to do this on a bare repo for my use case. 
> > 
> > And if it's on the server, you don't want this to be observable, so
> > you don't want HEAD to move around. I don't know a better way than:
> > 
> >   $ git clone --shared -b upstream-branch bare-repo.git /tmp/merge-repo
> >   $ cd /tmp/merge-repo
> >   $ git pull URL incoming-branch
> > 
> > Cloning with --shared just writes a path into .git/objects/info/alternatives
> > and it doesn't need to be on the same file system (unlike --local).
> > 
> > Since 'git merge-tree' just works with trees, it has less information
> > than 'git merge'.
> 
> You could use a temporary index and do something like:
> 
> 	rm -f TMP_INDEX
> 	GIT_INDEX_FILE=TMP_INDEX
> 	export GIT_INDEX_FILE
> 	git read-tree -m $base $ours $theirs &&
> 	git merge-index git-merge-one-file -a
> 
> then inspect that with "git diff-index --cached $ours".

That is precisely how we do it at GitHub. You probably want to add in
"--aggressive" to your read-tree to cover a few more simple cases. If
there are conflicts, we just bail and say "this can't be merged", and
expect the user to do it themselves using git.

-Peff
