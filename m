From: Jeff King <peff@peff.net>
Subject: Re: git push --confirm ?
Date: Sun, 13 Sep 2009 05:33:24 -0400
Message-ID: <20090913093324.GB14438@coredump.intra.peff.net>
References: <1252777897.2974.24.camel@localhost.localdomain>
 <20090912184342.GB20561@coredump.intra.peff.net>
 <7vvdjn8ymk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Owen Taylor <otaylor@redhat.com>, git@vger.kernel.org,
	Colin Walters <walters@verbum.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 11:33:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmlSh-0001KZ-Q0
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 11:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbZIMJdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 05:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbZIMJdY
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 05:33:24 -0400
Received: from peff.net ([208.65.91.99]:50126 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbZIMJdY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 05:33:24 -0400
Received: (qmail 16771 invoked by uid 107); 13 Sep 2009 09:33:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 13 Sep 2009 05:33:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2009 05:33:24 -0400
Content-Disposition: inline
In-Reply-To: <7vvdjn8ymk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128346>

On Sat, Sep 12, 2009 at 05:41:23PM -0700, Junio C Hamano wrote:

> > But what _would_ be useful is doing it atomically. You can certainly do
> > all three of those steps from within one "git push" invocation, and I
> > think that is enough without any protocol changes. The protocol already
> > sends for each ref a line like:
> >
> >   <old-sha1> <new-sha1> <ref>
> >
> > and receive-pack will not proceed with the update unless the <old-sha1>
> > matches what is about to be changed.
> 
> Be careful that using that information and doing things in one session
> won't give you atomicity in the sense that it may still fail after you
> said "yes that is what I want to push, really" to the confirmation
> question.

Of course, but that issue exists already. It is just that the window
between receiving the refs and then asking them to be updated is much
smaller when there is no human input in the loop (and since we haven't
actually _shown_ the list to the user, it appears atomic to them).

I think this type of atomicity is fine for this application. The point
of this is to err on the side of caution. So it is OK to say "Push
this?" and then after the user has confirmed say "Oops, somebody pushed
something else while we were waiting for your input. Try again." The
important thing is to not say "Push this?", have the user confirm that
what they are pushing over is OK, and then end up pushing over something
different (which is what can happen with separate push invocations).

The only way to get true atomicity across the confirmation and push
would be to take a lock at the beginning of the push session. Which is
too coarse-grained in the first place (it disallows simultaneous update
of unrelated refs), but would also require protocol updates.

> It does save you an extra connection, compared to separate invocations
> without and then with --dry-run, so it still is a plus.
> 
> I do not think this is an unreasonable option to have.  Just please don't
> justify this change based on atomicity argument, but justify it as a mere
> convenience feature.

I don't agree. Making sure we use the _same_ <old-sha1> in the
confirmation output we show to the user and in the ref update we send to
the remote is critical for this to be safe.

-Peff
