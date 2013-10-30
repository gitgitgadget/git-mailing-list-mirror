From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/19] pack-bitmap: add support for bitmap indexes
Date: Wed, 30 Oct 2013 16:25:43 -0400
Message-ID: <20131030202542.GD23011@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
 <20131024180357.GJ24180@sigill.intra.peff.net>
 <CAJo=hJvw-UNWVDADcGzA1P3GGOKJGh8h4LrETPYnjBNYmfkxjQ@mail.gmail.com>
 <20131030081023.GK11317@sigill.intra.peff.net>
 <CAFFjANQyMfV4M_wynPORfN2S1=eAdBxScgNYzD_dsRmKekp83Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 21:27:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbcM6-0006tb-4y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 21:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228Ab3J3U07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 16:26:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:58753 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755106Ab3J3UZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 16:25:45 -0400
Received: (qmail 21810 invoked by uid 102); 30 Oct 2013 20:25:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 15:25:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 16:25:43 -0400
Content-Disposition: inline
In-Reply-To: <CAFFjANQyMfV4M_wynPORfN2S1=eAdBxScgNYzD_dsRmKekp83Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237067>

On Wed, Oct 30, 2013 at 04:47:57PM +0100, Vicent Mart=C3=AD wrote:

> Yes, our pack writing and bitmap code takes enough precautions to
> arrange the objects in the packfile in a way that can be partially
> reused, so for any given bitmap file written from Git, I'd say we're
> safe to always reuse the leader of the pack if this is possible.

Perhaps it is worth adding a flag to the bitmap index to say "my bases
always come before deltas".

> Obviously I intend to keep the pack reuse on production because the
> CPU savings are noticeable, but we can drop it from the public
> patchset. Ideally, we'd have full pack reuse like JGit, but we cannot
> reasonably do that in GitHub because splitting a pack for the network
> root would double our disk usage for all the forks.

Ah, right, I was forgetting about the fork-network repositories in my
analysis.  This doesn't work out of the box with this series, because w=
e
will have all of the commits for all of the forks, followed by all of
the trees, and so forth.

What the list hasn't seen yet is that we have another patch series that
organizes the objects based on refs, so you can put all of
"refs/remotes/X/*" in one "island", "refs/remotes/Y/*" in another
"island", and so forth (in our scheme, each remote represents a single
fork, but it's configurable).

This lets us avoid deltas to objects that are not in the same island,
because such deltas would need to be thrown out when cloning a single
fork. And it lets us tweak the write order so that we can put all of on=
e
fork's objects at the beginning, making it available for pack-reuse (so
obviously you would want to pick the "root" fork to put at the
beginning).

I'm planning to send those patches once the bitmap code is merged. One
is not strictly dependent on the other, but they touch some of the same
areas, and rely on some of the same infrastructure, so I think it makes
sense to do them in series.

-Peff
