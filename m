From: Jeff King <peff@peff.net>
Subject: Re: wishlist: make it possible to amend commit messages after push
 to remote
Date: Sat, 8 Aug 2015 05:24:32 -0400
Message-ID: <20150808092432.GB24707@sigill.intra.peff.net>
References: <55C3FA66.90805@iki.fi>
 <xmqqd1yzyqzq.fsf@gitster.dls.corp.google.com>
 <55C4E67F.7050109@iki.fi>
 <a0b9f82a46f2887d3ff3fb392e2e4c2c@www.dscho.org>
 <55C5364C.6040904@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jarkko Hietaniemi <jhi@iki.fi>
X-From: git-owner@vger.kernel.org Sat Aug 08 11:24:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZO0Mt-0000q6-9f
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 11:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbbHHJYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 05:24:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:42436 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932432AbbHHJYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 05:24:37 -0400
Received: (qmail 1510 invoked by uid 102); 8 Aug 2015 09:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Aug 2015 04:24:37 -0500
Received: (qmail 21635 invoked by uid 107); 8 Aug 2015 09:24:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Aug 2015 05:24:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Aug 2015 05:24:32 -0400
Content-Disposition: inline
In-Reply-To: <55C5364C.6040904@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275513>

On Fri, Aug 07, 2015 at 06:50:52PM -0400, Jarkko Hietaniemi wrote:

> Or another way to illustrate my idea: assume a create-once-no-delete
> filesystem.
> 
> echo 42 > the_answr.txt
> 
> Oh, darn it...
> 
> ln -s the_answr.txt the_answer.txt
> 
> Now both names still point to the content "42\n".  The first SHA
> would be over ["42\n", "the_answr.txt"] and the second SHA over
> ["42\n", "the_answer.txt"].

But you can't do that on a create-once filesystem; your symlink
overwrites "the_answr.txt", which already exists. Obviously that is a
technicality in the definition of "create-once", but if we take this as
an analogy for a content-addressable object store, it is true. :) The
name "answr.txt" in your case is really a sha1 "1234abcd", and we cannot
create an object of that name that has anything _but_ the specific
matching content in it. Your options are then:

  - add a level of indirection; when we look up 1234abcd, show some
    other object instead (even though its content does not match
    1234abcd). We have this already; it is the git-replace mechanism.

  - during certain operations (e.g., showing the log), use 1234abcd as
    an index into another data store. We have this, too: git-notes.

I think I saw the objection elsewhere in the thread that these are not
seamless to use. That is certainly true. Partially this is inherent
(the client has to understand the extra object, and know when you want
that object versus the original). But git could also improve its
handling of these things.

For instance, we do not fetch notes from a remote by default. The big
problems is that the refs/remotes hierarchy is set really set up only to
hold branches, so we do not know where to put them. There was a
discussion around the v1.8.0 time-frame about improving this[1], but it
was never completed. That might be a productive direction if anyone is
really interested in this topic.

-Peff

[1] I didn't re-read the old thread, but glancing through, this looks
    like a reasonable jumping-off point for reading:

      http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=165885
