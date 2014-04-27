From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Uses git-credential for git-imap-send
Date: Sun, 27 Apr 2014 03:51:10 -0400
Message-ID: <20140427075110.GA19976@sigill.intra.peff.net>
References: <CAFVaGhudmcrh32_h3RPmR_E7e3Jo9xc6AEt5AtN2W5NVbEMg6w@mail.gmail.com>
 <20140426180835.GE21493@sigill.intra.peff.net>
 <CAFVaGhuXvZhRCHRFurKNOC4tsiQ7WZnGb2CbRnoSSYg=XknJtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan Albert <danalbert@google.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 09:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeJrs-0000VL-Od
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 09:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbaD0HvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 03:51:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:39426 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753516AbaD0HvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 03:51:12 -0400
Received: (qmail 4155 invoked by uid 102); 27 Apr 2014 07:51:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 27 Apr 2014 02:51:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Apr 2014 03:51:10 -0400
Content-Disposition: inline
In-Reply-To: <CAFVaGhuXvZhRCHRFurKNOC4tsiQ7WZnGb2CbRnoSSYg=XknJtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247193>

On Sat, Apr 26, 2014 at 11:30:11AM -0700, Dan Albert wrote:

> I had resent a less broken patch after I noticed the tabs, but it seems to
> have gotten lost. Better formatted patch at the bottom of this message.

Your emails (including this one) are multipart/alternatives with an html
part, which will cause the mailing list software to reject them.

This email also still seems whitespace-damaged to me (the leading tabs
are collapsed to a single space).

It looks like you're using gmail to send; you might try using "git
send-email" (the example at the end of "git help send-email" can walk
you through it).

> About imap vs. imaps: I actually had your exact line in before, but decided
> that as long as its for the same host the user probably wants to use the
> same credentials for both imap and imaps (if they for some reason had both
> configured). Hard coding "imap" allows them to use either protocol with
> only one keychain entry. The use case is a stretch, but it doesn't do any
> harm to implement it this way.

My concerns with conflating the two are:

  1. The system helper might care about the distinction and prefer imaps
     (e.g., it might already have the credential stored for your regular
     mail client, which uses imaps). But osxkeychain is the only helper
     that makes the distinction, and I don't really know how OS X's
     keychain code handles the distinction.

  2. With http and https, we are careful to make the distinction,
     because we would not want to accidentally share a credential over http
     that was stored via https. But it's pretty easy to use an http URL
     rather than an https one. It's probably pretty rare to accidentally
     turn off imap SSL.

So I'd be OK with leaving it as "imap" for now, and waiting for somebody
to actually come up with a real case where the distinction matters.

> ---
> 
> Uses git-credential for git-imap-send
> 
> git-imap-send was directly prompting for a password rather than using
> git-credential. git-send-email, on the other hand, supports git-credential.
> 
> This is a necessary improvement for users that use two factor
> authentication, as
> they should not be expected to remember all of their app specific passwords.
> 
> Signed-off-by: Dan Albert <danalbert@google.com>
> ---
>  imap-send.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

A side note on formatting your commit message: The maintainer picks up
patches from the list with "git am", which will take everything up to
the first "---" as the commit message, and discard everything after up
to the start of the diff. So in this case it would take your
cover-letter material as the commit message, and drop your actual commit
message.

The usual formats are either to put the cover letter material after the
"---", like:

  $COMMIT_MESSAGE

  Signed-off-by: You
  ---
  $COVER_LETTER
  $DIFFSTAT
  $DIFF

or to use a scissors-line "-- >8 --" instead of three-dash:

  $COVER_LETTER

  -- >8 --
  $COMMIT_MESSAGE

  ---
  $DIFFSTAT
  $DIFF

-Peff
