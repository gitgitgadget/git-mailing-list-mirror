From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: support temporarily preserving garbage
Date: Thu, 4 Dec 2014 04:10:23 -0500
Message-ID: <20141204091023.GB27455@peff.net>
References: <1415927805-53644-1-git-send-email-brodie@sf.io>
 <xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
 <20141117213442.GD15880@peff.net>
 <CADQoFhyxFNzazsEaE6Bk2W_KDhogBho8vgJXkDDPsYvC46ZX5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bryan Turner <bturner@atlassian.com>,
	Stefan Saasen <ssaasen@atlassian.com>
To: Brodie Rao <brodie@sf.io>
X-From: git-owner@vger.kernel.org Thu Dec 04 10:10:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwSQm-0000Im-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 10:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbaLDJK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 04:10:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:48244 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753042AbaLDJKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 04:10:25 -0500
Received: (qmail 22858 invoked by uid 102); 4 Dec 2014 09:10:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 03:10:25 -0600
Received: (qmail 4801 invoked by uid 107); 4 Dec 2014 09:10:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 04:10:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 04:10:23 -0500
Content-Disposition: inline
In-Reply-To: <CADQoFhyxFNzazsEaE6Bk2W_KDhogBho8vgJXkDDPsYvC46ZX5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260749>

On Wed, Dec 03, 2014 at 01:21:03PM -0800, Brodie Rao wrote:

> > I think it is also not sufficient. This patch seems to cover only
> > objects. But we assume that we can atomically rename() new versions of
> > files into place whenever we like without disrupting existing readers.
> > This is the case for ref updates (and packed-refs), as well as the index
> > file.  The destination end of the rename is an unlink() in disguise, and
> > would be susceptible to the same problems.
> 
> I'm not aware of renaming over files happening anywhere in gc-related
> code. Do you think that's something that would need to be addressed in
> the rest of the code base before going forward with this garbage
> directory approach? If so, do you have any suggestions on how to
> tackle that problem?

As an example, if you run "git pack-refs --all --prune" (which is run by
"git gc"), it will create a new pack-refs file and rename it into place.
Another git program (say, "git for-each-ref") might be reading the file
at the same time. If you run pack-refs and for-each-ref simultaneously
in tight loops on your problematic NFS setup, what happens?

I have no idea if it breaks or not. I don't have such a misbehaving
system, and I don't know how rename() is implemented on it. But if it
_is_ a problem of the same variety, then I don't see much point in
making an invasive fix to address half of the problem areas, but not the
other half (i.e., if we are still left with a broken git in this setup,
was the invasive fix worth the cost?).

If it is a problem (and again, I am just guessing), I'd imagine you
would need a similar setup to what you proposed for unlink(): before
renaming "packed-refs.lock" into "packed-refs", hard-link it into your
"trash" area. And you'd probably want to intercept rename() there, to
catch all places where we use this technique.

-Peff
