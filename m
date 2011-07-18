From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/14] less annoying http authentication
Date: Mon, 18 Jul 2011 03:46:42 -0400
Message-ID: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:47:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiiXb-00035N-Lq
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082Ab1GRHqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:46:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39944
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab1GRHqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:46:47 -0400
Received: (qmail 19585 invoked by uid 107); 18 Jul 2011 07:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:47:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:46:42 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177342>

Using smart-http with a server that does http authentication can involve
typing your username and password a lot. This is annoying, and is a
frequent complaint of people using smart-http at GitHub.

Storing passwords is tricky, of course, because of the security
concerns. Fortunately this is a problem that has been solved by a
multitude of password wallet and keychain systems. We just have to hook
into whatever secure storage the user is already using.

So the goals of the series are:

  1. Provide an interface to request usernames and passwords from
     external helpers. By making them an external program that we spawn,
     it's easy to write custom helpers for whatever wallet program you
     want. Somebody has already expressed interest in making a helper
     for freedesktop.org's "Secrets API" to do one. Somebody at GitHub
     will probably do an OS X Keychain one.

  2. For users on systems with no secure storage, provide a
     time-limited, in-memory cache that is persistent between program
     invocations. So if you do:

       $ git fetch https://user@example.com/repo.git
       $ hack hack hack
       $ git push https://user@example.com/repo.git

     or:

       $ git push
       $ hack hack hack
       $ git push

     we can use the same password both times.

  3. For users on systems with no secure storage who want to take the
     risk of plaintext storage, provide a persistent disk cache (i.e.,
     prompt once and then store it in a config file). This is what SVN
     does. I think it's a horrible security policy to have by default,
     but it is simple, and it's good enough for many people.

  4. Allow associating usernames with remote hosts. Even if you do want
     to type your password each time, typing your username every time is
     annoying. Two things you can already do are:

       a. Use user@host in your remote URL. This has a few downsides,
          though.

          One is that git assumes that a URL with a user-portion is
          going to want authentication. So now it will ask for your
          password to fetch, even if the server doesn't actually care
          (though we might want to change that, since handles HTTP 401s
          properly these days).

          Two is that it's much simpler to separate the authentication
          from the repo name. Then you never have to worry about adding
          in your username to a URL when cloning, or stripping out
          somebody else's username from the URL they've shared with you.

       b. Use netrc. We don't document anywhere that netrc exists, or
          that we respect it. It's just a feature which comes along with
          curl. And even if we did mention it, some systems don't
          actually have a manpage for netrc. So we'd need to document
          that we use it, and its format.

          It also isn't very git-ish. You can't have per-repo versus
          per-user values. You can't use "git config" to set and look at
          it. It isn't carted around with your .gitconfig when you copy
          it to a new system.

This is still in the RFC stage. I think the code is fine, and I've been
using it for a few weeks. I tried to keep the design of the credential
helper interface simple, but flexible enough to meet the needs of the
various keychain systems. Aside from the usual, what I'd most like
feedback on is whether the interface is sufficient to actually integrate
with those systems. And I suspect we won't really know until people try
to make helpers for their pet systems.

The patches are:

  [01/14]: parse-options: add OPT_STRING_LIST helper

This one is actually a cherry-pick from jk/clone-cmdline-config, which
was marked as "Will merge to master" in the last What's Cooking. So it
probably makes sense to drop this and just build the rest of the series
on top of c8ba1639.

  [02/14]: url: decode buffers that are not NUL-terminated
  [03/14]: improve httpd auth tests
  [04/14]: remote-curl: don't retry auth failures with dumb protocol
  [05/14]: http: retry authentication failures for all http requests
  [06/14]: introduce credentials API
  [07/14]: http: use credential API to get passwords
  [08/14]: look for credentials in config before prompting
  [09/14]: allow the user to configure credential helpers
  [10/14]: http: use hostname in credential description
  [11/14]: docs: end-user documentation for the credential subsystem
  [12/14]: credentials: add "cache" helper
  [13/14]: credentials: add "store" helper
  [14/14]: credentials: add "getpass" helper

-Peff
