From: Jeff King <peff@peff.net>
Subject: Re: verify_pack ignores return value of verify_fn
Date: Tue, 24 Nov 2015 17:11:35 -0500
Message-ID: <20151124221134.GD29185@sigill.intra.peff.net>
References: <1447806715.5082.11.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:11:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1LoK-0007Sv-04
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbbKXWLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:11:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:33479 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754091AbbKXWLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:11:37 -0500
Received: (qmail 26339 invoked by uid 102); 24 Nov 2015 22:11:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:11:37 -0600
Received: (qmail 19059 invoked by uid 107); 24 Nov 2015 22:11:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:11:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 17:11:35 -0500
Content-Disposition: inline
In-Reply-To: <1447806715.5082.11.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281638>

On Tue, Nov 17, 2015 at 07:31:55PM -0500, David Turner wrote:

> In pack-check.c, line 129, a caller-supplied verification function is
> called.  The function returns an int, but that return value is ignored.
> 
> The only caller of verify_pack is in builtin/fsck.c, whose verify_fn
> *does* return a meaningful error code (which is then ignored).  If it
> were not ignored, fsck might return a different error code (in the
> unlikely event that a weird object gets into a pack and is somehow not 
> totally corrupt enough to fail an earlier check).

Hrm. I think what is supposed to happen is that the callback sets a bit
in errors_found, and ultimately we use that to determine fsck's exit
code. But it seems like there are cases where we do not do so
(specifically, if it's valid git object, but doesn't conform to the
correct tree or commit format).

> I think we should probably have verify_pack return a non-zero result if
> any call to verify_fn returns a non-zero result.  Any objections to
> this?

That makes sense. Usually a callback returning non-zero would also
prematurely end the traversal, but I think we explicitly _don't_ want
that here. We want fsck to continue through all objects.

As an aside, the reason this is the only caller of verify_pack is due to
3de89c9 (verify-pack: use index-pack --verify, 2011-06-03). Using
index-pack is much faster, as it hits the objects topologically by delta
base, so we never have to access a base twice. It might be nice if fsck
learned to use it, too, and then we could just get rid of verify_pack()
entirely.

-Peff
