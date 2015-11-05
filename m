From: Jeff King <peff@peff.net>
Subject: Re: About global --progress option
Date: Thu, 5 Nov 2015 02:08:41 -0500
Message-ID: <20151105070841.GC4725@sigill.intra.peff.net>
References: <CAOc6etYiGV0v4gkkpudi3ACa6kA3H8CnqYYeSksfO4mGGfEyXg@mail.gmail.com>
 <xmqqk2px7z7h.fsf@gitster.mtv.corp.google.com>
 <CAOc6etbuK7=-8kH60taO8uH+6XNGTFRNGmmkswgP-19bCRNB3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:11:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuEhR-0005wo-Op
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 08:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032703AbbKEHIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 02:08:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:53200 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1032298AbbKEHIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 02:08:44 -0500
Received: (qmail 20013 invoked by uid 102); 5 Nov 2015 07:08:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 01:08:44 -0600
Received: (qmail 10786 invoked by uid 107); 5 Nov 2015 07:09:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 02:09:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Nov 2015 02:08:41 -0500
Content-Disposition: inline
In-Reply-To: <CAOc6etbuK7=-8kH60taO8uH+6XNGTFRNGmmkswgP-19bCRNB3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280913>

On Thu, Nov 05, 2015 at 12:47:22AM -0600, Edmundo Carmona Antoranz wrote:

> On the technical side, I think the global --progress option (and
> removing the option from the builtins) would not add complexity but
> the opposite because setting the flag would be done at the "main git"
> level and then all the builtins would just forget about it and would
> use progress regardless (cause deciding _if_ progress should be shown
> or not won't be up to them anymore) so the code from the builtins to
> support the option would be gone. It would certainly be more complex
> while keeping global and builtin options alive. Anyway, I do
> understand your concerns and will stand down on the topic (as in....
> global --progress who???).

I think you are missing one important element, which is that git
programs do not all share a memory space with the main git binary. So
you cannot simply set the "progress" variable in the main program and
expect everybody to see it. Running "git foo" may invoke a separate
"git-foo" program, written in another language entirely.

For that reason, options to the main git binary typically set an
environment variable which is communicated to all sub-processes. For an
example, see how "--literal-pathspecs" is implemented. So it actually
does add some complexity.

That being said, the environment variable can be a good thing. For
example, imagine I have a script "git-foo" which runs several commands,
including "git-fetch". It's cumbersome for "git-foo" to take a
"--progress" option and then pass that down to "git-fetch". If you could
instead run:

  git --no-progress foo

and have that flag magically propagate to any git sub-programs which
care about showing progress, then that could perhaps make the feature
worthwhile (I say perhaps because while it seems plausible to me, I have
not heard of anyone actually wanting this feature in practice).

But adding in "git --progress" is an orthogonal decision to removing
support for "git <cmd> --progress". I do not see any big advantage to
the latter at this point, and a lot of potential negatives as we break
scripts and user expectations.

-Peff
