From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/13] makefile refactoring
Date: Wed, 5 Feb 2014 12:48:23 -0500
Message-ID: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:48:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6aM-0005re-8n
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbaBERs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:48:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:45132 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753116AbaBERsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:48:25 -0500
Received: (qmail 7342 invoked by uid 102); 5 Feb 2014 17:48:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:48:25 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:48:23 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241618>

This started with the desire to move the setting of the LESS and LV
environment variables into a Makefile knob. But there's a fair bit of
infrastructure involved in that, and this is an attempt to factor out
some of that infrastructure to be more easily reusable. And if we like
the approach, we can move more build-time config in this direction.

There are a couple of things going on here, but the main ideas are:

  1. Try to get build-time data into files as much as possible, because
     the one thing make understands is dependencies between files. Right
     now we rely on sentinel files like GIT-CFLAGS, which have two
     downsides:

       a. It is easy to miss a dependency that should be in a sentinel
          file, leading to failure to rebuild when we should.

       b. Because they are so cumbersome to use, we tend to put a lot of
          items into a small number of sentinel files, leading to
          unnecessary rebuilds (e.g., turning on XDL_FAST_HASH
          recompiles _everything_, even though only one C file cares
          about it).

  2. Some light meta-programming to avoid repeating ourselves and try to
     make a few things more readable. I've done this here with $(call)
     and $(eval), which are basically the only way to do this in GNU
     make (and here we are relying heavily on GNU make, but as far as I
     know, nobody has had a huge problem with that in the past).

     Frankly, some of it is kind of ugly. And there's some potential for
     portability/version problems, just because we're not using more
     advanced features. If we don't like that approach, an alternative
     is to generate snippets of Makefile in a separate script and
     include them (like we do already for GIT-VERSION-FILE). That would
     let us write in whatever language we want, and avoid portability
     problems. The downside is that it may be less obvious to a reader
     not familiar with the system (e.g., you cannot necessarily grep for
     all the rules in Makefile, though that is already somewhat the case
     with pattern rules).

The two potential criticisms I expect are:

  1. Portability issues with $(call), as mentioned above. We avoided
     this in 2006, but it may be sufficiently available now. See patch 3
     for exact numbers/versions.

  2. Some people may simply find it ugly or too confusing for the
     benefit. Hence the RFC. :)

While I tried to polish these patches enough to be applied, please take
this mostly as an RFC on the ideas and direction. There are multiple
alternatives to implement some of these things, and I mainly want to see
if people think this sort of make meta-programming is a good idea.  The
patches are:

  [01/13]: Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS
  [02/13]: Makefile: fix git-instaweb dependency on gitweb

    These first two are cleanups I noticed in the area, and can be
    applied regardless of the rest.

  [03/13]: Makefile: introduce make-var helper function
  [04/13]: Makefile: use tempfile/mv strategy for GIT-*
  [05/13]: Makefile: prefer printf to echo for GIT-*
  [06/13]: Makefile: store GIT-* sentinel files in MAKE/
  [07/13]: Makefile: always create files via make-var

    These ones factor out and improve the GIT-* file handling. Even if
    we decide not to go this route, patches 4, 5, and 7 are improvements
    that could apply to the current code. I didn't float them to the top
    of the series because it would involve making the same change in
    several different spots. If we decide not to apply this series, I
    can re-roll them as appropriate.

  [08/13]: Makefile: introduce sq function for shell-quoting
  [09/13]: Makefile: add c-quote helper function
  [10/13]: Makefile: drop *_SQ variables

    If we accept that we can use $(call), these are further readability
    cleanups we can do. They are technically optional, though, with
    respect to the rest of the series.

  [11/13]: Makefile: auto-build C strings from make variables
  [12/13]: Makefile: teach scripts to include make variables

    These ones lay the groundwork for easily getting make variables into
    shell scripts and C programs.

  [13/13]: move LESS/LV pager environment to Makefile

    And this one is the point of the series, which is fairly
    straightforward because of the earlier groundwork.

-Peff
