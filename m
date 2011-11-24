From: Jeff King <peff@peff.net>
Subject: [PATCH 0/13] credential helpers, take two
Date: Thu, 24 Nov 2011 05:58:02 -0500
Message-ID: <20111124105801.GA6168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 11:58:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTX0Q-0002ag-Ff
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 11:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab1KXK6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 05:58:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49628
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab1KXK6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 05:58:07 -0500
Received: (qmail 9965 invoked by uid 107); 24 Nov 2011 10:58:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 05:58:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 05:58:02 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185895>

Here's a revised version of the http-auth / credential-helper series.

It has the same basic premise as the first series (git contacts external
programs to access secure storage, thus enabling secure password
caching), but there are a number of tweaks in the implementation.

The main departures are:

  1. Helpers now _only_ act as storage; they never ask for credentials
     directly from the user.  This makes writing them much simpler.

     It also means that "askpass" remains the only way to get input from
     the user. However, I've left room in the helper protocol to add an
     "ask" action. If people really want something like a classy
     username/password dialog from the helpers, it will be easy to add.

  2. The helper protocol now happens completely over pipes. In the first
     round, we gave information to helpers on the command line. That was
     OK, since we never gave them a password; they only gave them to us
     (and cached them if they wanted to). But now that git is asking for
     the password itself, it has to send the password to the helper to
     store. And that definitely shouldn't go on the command line.

     The parsing load on the helper is therefore a little higher.
     However, it's still really quite easy.

  3. The old "unique" token has been broken into components. That means
     less parsing for most helpers, which wanted the broken-down fields.
     Helpers that want a single token can pretty easily reassemble.

  4. I dropped the "description" field. I noticed that all of the
     components of a credential context are actually parts of a URL. So
     we can just show the URL (or a subset thereof) to the user in the
     prompt. See the discussion in patches 05 and 08.

  5. Config handling happens at the right place (before helpers) now.

If you want an overview without reading the patches too carefully, I
recommend reading the documentation added in patches 03 and 09, which
contain the API and end-user documentation respectively.

Helper writers may want to look at t0303 added in patch 13; it's an
adaptation of the test script I posted earlier for testing new external
helpers.

  [01/13]: test-lib: add test_config_global variant
  [02/13]: t5550: fix typo
  [03/13]: introduce credentials API
  [04/13]: credential: add function for parsing url components
  [05/13]: http: use credential API to get passwords
  [06/13]: credential: apply helper config
  [07/13]: credential: add credential.*.username
  [08/13]: credential: make relevance of http path configurable
  [09/13]: docs: end-user documentation for the credential subsystem
  [10/13]: credentials: add "cache" helper
  [11/13]: strbuf: add strbuf_add*_urlencode
  [12/13]: credentials: add "store" helper
  [13/13]: t: add test harness for external credential helpers

I've been running with this for a few days, so I think the most horrible
bugs are shaken out. But I had to rewrite almost all of the code from
the first series, so I wouldn't be surprised if there are some new bugs
lurking in there. If you are reviewing, please read from scratch and
don't assume that something that worked in the first series is still
working. :)

-Peff
