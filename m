From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Mon, 11 Jul 2011 12:46:35 -0400
Message-ID: <20110711164635.GB29781@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 18:46:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJd5-0004Lp-1t
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149Ab1GKQqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 12:46:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60798
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758138Ab1GKQqh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 12:46:37 -0400
Received: (qmail 3111 invoked by uid 107); 11 Jul 2011 16:47:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jul 2011 12:47:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2011 12:46:35 -0400
Content-Disposition: inline
In-Reply-To: <20110711161754.GB10418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176870>

On Mon, Jul 11, 2011 at 12:17:54PM -0400, Jeff King wrote:

> +Storage
> +-------
> [...]
> +The disk storage consists of a single file per cache, located in the
> +`$GIT_DIR/cache` directory. Each file contains a list of rows ordered by
> +sha1. Each row contains a binary sha1, followed by the fixed-size data
> +mapped to that sha1.

There's nothing else in the file, not even a header. I should probably
add at least a version byte, in case we ever do want to change what goes
into a cache (in which case we could just blow away what's there and
regenerate).

We could also have a "validity" field that must match for the cache to
be valid. Junio mentioned earlier that you would want to regenerate a
generations cache whenever grafts or replace objects changed. It
wouldn't be hard to do something like:

  validity = sha1(grafts + replace);
  if (validity != cache_validity)
    empty_disk_cache();

And then it would just automatically work, without the user having to
remember to clear the cache.  Calculating the validity would be cheap in
the common case (you have no grafts or replace objects), and not much
more expensive when you do have them (we have to read that data anyway
to respect the replacements).

-Peff
