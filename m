From: Jeff King <peff@peff.net>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 19:15:19 -0400
Message-ID: <20160412231518.GA2210@sigill.intra.peff.net>
References: <570D78CC.9030807@zytor.com>
 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:15:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7Wo-0007dh-No
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbcDLXPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:15:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:48283 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756403AbcDLXPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:15:22 -0400
Received: (qmail 14143 invoked by uid 102); 12 Apr 2016 23:15:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 19:15:21 -0400
Received: (qmail 11940 invoked by uid 107); 12 Apr 2016 23:15:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 19:15:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Apr 2016 19:15:19 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291320>

On Tue, Apr 12, 2016 at 04:00:18PM -0700, Stefan Beller wrote:

> On Tue, Apr 12, 2016 at 3:38 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> > OK, I'm going to open this can of worms...
> >
> > At what point do we migrate from SHA-1?  At this point the cryptoanalysis of
> > SHA-1 is most likely a matter of time.
> 
> And I thought the cryptographic properties of SHA1 did not matter for
> Gits use case.
> We could employ broken md5 or such as well.
> ( see http://stackoverflow.com/questions/28792784/why-does-git-use-a-cryptographic-hash-function
> )
> That is because security goes on top via gpg signing of tags/commits.
> 
> I am not sure if anyone came up with
> a counter argument to Linus reasoning there?

I have never understood that reasoning at all, nor why it is so often
repeated.

The GPG signature is over a single object, that mentions other objects
by their sha1 ids. But users don't care that v1.0 is securely mapped to
tree 1234abcd. They care which files are in 1234abcd, and if sha1 is
broken, it means you can't credibly verify the content down to the blob
level.

There's some additional protection in that git generally prefers objects
it already has to new ones. So it's hard to reliably distribute your
evil colliding object, depending on where people might have fetched
from first. But:

  1. I know there's at least once race[1] where a colliding object can
     still enter the repository. There may be more that have either
     existed all along, or that have grown over the years. I don't think
     this is something we've paid attention to and tested.

  2. That helps some people, I guess, but it's little consolation to
     somebody who runs "git clone" followed by verifying the tag.

-Peff

[1] The race I am thinking of is that for performance reasons, we don't
    re-scan the pack directory when index-pack checks has_sha1_file()
    on an incoming object and it comes up negative. So if somebody else
    is repacking, we might skip the collision check in such a case. At
    least that race is not under control of an attacker, though.
