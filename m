From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] ref_transaction_commit(): only keep one lockfile
 open at a time
Date: Tue, 28 Apr 2015 00:36:53 -0400
Message-ID: <20150428043653.GC24580@peff.net>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
 <1429875349-29736-6-git-send-email-mhagger@alum.mit.edu>
 <553B2F5C.3010007@alum.mit.edu>
 <xmqqiock1yq3.fsf@gitster.dls.corp.google.com>
 <xmqqoamcypy4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 06:37:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmxGe-00072H-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 06:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbbD1Eg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 00:36:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:50944 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751028AbbD1Egz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 00:36:55 -0400
Received: (qmail 15993 invoked by uid 102); 28 Apr 2015 04:36:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Apr 2015 23:36:55 -0500
Received: (qmail 11283 invoked by uid 107); 28 Apr 2015 04:37:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 00:37:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 00:36:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoamcypy4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267892>

On Sat, Apr 25, 2015 at 12:21:07PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I am not too worried about "push --atomic", as we can just add a few
> > words to Release Notes and documentation saying "this is still an
> > experimental broken code that is unusable; don't use the feature in
> > production".
> >
> > I however am more worried about the other one "update-ref --stdin";
> > the change will be pure regression for those who want to do many
> > updates and do not care if the update is atomic, no?
> 
> I should have refrained from touching the keyboard so late at night
> X-<.  This regression was done long time ago (even in v2.1.0 I see
> that ref_transaction_commit() tries to grab all locks at once).
> 
> So it is only "push --atomic".
> 
> The choice is between (1) shipping "push --atomic" that is known to
> be broken, (2) applying your five-patch series which may (a) fix
> both "push --atomic" and "update-ref --stdin", or (b) break other
> transaction users including "update-ref -stdin" in unexpected ways.

I'm not sure "--atomic" is foolproof even with these patches.

Certainly there is the obvious problem that the filesystem is not atomic
(so a power loss halfway through committing the locks will result in a
non-atomic push). But there are also subtle locking issues related to
D/F conflicts.

For instance, if we do (and I take no credit for this discovery; Michael
showed it to me last week):

  {
    echo "create refs/heads/branch $sha1"
    echo "create refs/heads/foo/bar $sha1" &&
    echo "create refs/heads/foo $sha1"
  } | git update-ref --stdin

we do not notice the conflict between "foo" and "foo/bar" until the
commit stage. Fortunately our ref-ordering rules mean we will always try
to write "foo" before "foo/bar", which will fail because "foo" must be a
directory (because we have "foo/bar.lock"). But because "branch" comes
alphabetically first, we will have written that ref already, committing
part of the request.

You can work around this with code to check for D/F conflicts in a
single transaction, but then you are subject to races with other
processes. E.g., one process writes "branch" and "foo", the other is
simultaneously writing "foo/bar". There is no lock contention, but the
write of "foo" may fail at the commit stage.

So I think it is OK to restrict the definition of "atomic" here to the
common case of making sure that we can lock and check the $old_sha1 for
each of the refs. Under that definition, "push --atomic" is not broken
as-is, but there is room for improving its robustness.  And I have no
problem with trying to make our storage format as robust as possible in
these cases, but I think we need to admit that the filesystem ref
storage is never going to be 100% transactional.

I know that sounds a bit like moving the goalposts to say "eh, this
feature is not broken, your definition of broken is just wrong". But my
point is that shipping "push --atomic" as-is is still a useful step
forward, and we can continue to iterate and improve on the concept in
future releases.

-Peff
