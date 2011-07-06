From: Jeff King <peff@peff.net>
Subject: Re: generation numbers (was: [PATCH 0/4] Speed up git tag --contains)
Date: Wed, 6 Jul 2011 14:12:00 -0400
Message-ID: <20110706181200.GD17978@sigill.intra.peff.net>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
 <20110706065623.GB14164@elie>
 <20110706070311.GA3790@sigill.intra.peff.net>
 <m3mxgr4has.fsf_-_@localhost.localdomain>
 <20110706150103.GA2693@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 06 20:12:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeWa1-00088H-C0
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 20:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab1GFSME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 14:12:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43653
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab1GFSMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 14:12:03 -0400
Received: (qmail 23340 invoked by uid 107); 6 Jul 2011 18:12:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jul 2011 14:12:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2011 14:12:00 -0400
Content-Disposition: inline
In-Reply-To: <20110706150103.GA2693@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176722>

On Wed, Jul 06, 2011 at 11:01:03AM -0400, Ted Ts'o wrote:

> Is it worth it to try to replicate this information across repositories?

Probably not. I suggested notes-cache just because the amount of code is
very trivial.

One problem with notes storage is that it's not well optimized for tiny
pieces of data like this (e.g., the generation number should fit in a
32-bit unsigned int, as its max is the size of the longest single path
in the history graph). But notes are much more general; we will actually
map each commit to a blob object containing the generation number, which
is pretty wasteful.

> Why not just simply have a cache file in the git directory which is
> managed somewhat like gitk.cache; call it generation.cache?

Yeah, that would be fine. With a sorted list of binary sha1s and 32-bit
generation numbers, you're talking about 24 bytes per commit. Or a 6
megabyte cache for linux-2.6.

You'd probably want to be a little clever with updates. If I have
calculated the generation number of every commit, and then do "git
commit; git tag --contains HEAD", you probably don't want to rewrite the
entire cache. You could probably journal a fixed number of entries in an
unsorted file (or even in a parallel directory structure to loose
objects), and then periodically write out the whole sorted list when the
journal gets too big. Or choose a more clever data structure that can do
in-place updates.

-Peff
