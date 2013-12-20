From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] prune-packed: fix a possible buffer overflow
Date: Fri, 20 Dec 2013 04:30:48 -0500
Message-ID: <20131220093048.GB9637@sigill.intra.peff.net>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
 <1387287838-25779-2-git-send-email-mhagger@alum.mit.edu>
 <CACsJy8DVc4soBrS1RbTLv93b5rere3htyL1DjRw=UcT4zVN9FA@mail.gmail.com>
 <xmqqd2kvmi85.fsf@gitster.dls.corp.google.com>
 <52B2256A.3060802@alum.mit.edu>
 <20131219000415.GA17420@sigill.intra.peff.net>
 <52B31FF3.1060102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 20 10:31:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtwQ9-000639-9g
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 10:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab3LTJaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 04:30:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:47796 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755536Ab3LTJau (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 04:30:50 -0500
Received: (qmail 13733 invoked by uid 102); 20 Dec 2013 09:30:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Dec 2013 03:30:50 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Dec 2013 04:30:48 -0500
Content-Disposition: inline
In-Reply-To: <52B31FF3.1060102@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239567>

On Thu, Dec 19, 2013 at 05:33:55PM +0100, Michael Haggerty wrote:

> > But we don't loop on ENOENT. So if the rmdir happens in the middle,
> > after the mkdir but before we call open again, we'd fail, because we
> > don't treat ENOENT specially in the second call to open. That is
> > unlikely to happen, though, as prune would not be removing a directory
> > it did not just enter and clean up an object from (in which case we
> > would not have gotten the first ENOENT in the creator). [...]
> 
> The way I read it, prune tries to delete the directory whether or not
> there were any files in it.  So the race could be triggered by a single
> writer that wants to write an object to a not-yet-existent shard
> directory and a single prune process that encounters the directory
> between when it is created and when the object file is added.

Yes, that's true. It does make the race slightly more difficult than a
straight deletion because the prune has to catch it in the moment where
it exists but does not yet have an object. But it's still possible.

> But that doesn't mean I disagree with your conclusion:

I think we're in violent agreement at this point. :)

> Regarding references:
> 
> > On a similar note, I imagine that a simultaneous "branch foo/bar" and
> > "branch -d foo/baz" could race over the creation/deletion of
> > "refs/heads/foo", but I didn't look into it.
> 
> Deleting a loose reference doesn't cause the directory containing it to
> be deleted.  The directory is only deleted by pack-refs (and then only
> when a reference in the directory was just packed) or when there is an
> attempt to create a new reference that conflicts with the directory.  So
> the question is whether the creation of a loose ref file is robust
> against the disappearance of a directory that it just created.

Ah, right, I forgot we leave the directories sitting around after
deletion. So we may run into a collision with another creator, but by
definition we would have a D/F conflict with such a creator anyway, so
we cannot both succeed.

But we can hit the problem with pack-refs, as you note:

> And the answer is "no".  It looks like there are a bunch of places where
> similar races occur involving references.  And probably many others
> elsewhere in the code.  (Any caller of safe_create_leading_directories()
> is a candidate problem point, and in fact that function itself has an
> internal race.)  I've started fixing some of these but it might take a
> while.

Yeah, I think you'd have to teach safe_create_leading_directories to
atomically try-to-create-and-check-errno rather than stat+mkdir. And
then teach it to backtrack when an expected leading path goes missing
after we created it (so mkdir("foo"), then mkdir("foo/bar"), then step
back to mkdir("foo") if we got ENOENT).

I don't think the races are a big deal, though. As with the prune case,
we will ultimately fail to create the lockfile and get a temporary
failure rather than a corruption. So unless we actually have reports of
it happening (and I have seen none), it's probably not worth spending
much time on.

-Peff
