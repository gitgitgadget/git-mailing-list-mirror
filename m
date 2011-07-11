From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] commit: add commit_generation function
Date: Mon, 11 Jul 2011 17:10:13 -0400
Message-ID: <20110711211013.GA30155@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161814.GC10418@sigill.intra.peff.net>
 <20110711175709.GA6245@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:10:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgNkJ-0007WH-2c
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782Ab1GKVKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:10:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56547
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961Ab1GKVKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:10:15 -0400
Received: (qmail 5228 invoked by uid 107); 11 Jul 2011 21:10:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jul 2011 17:10:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2011 17:10:13 -0400
Content-Disposition: inline
In-Reply-To: <20110711175709.GA6245@toss.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176893>

On Mon, Jul 11, 2011 at 07:57:09PM +0200, Clemens Buchacher wrote:

> On Mon, Jul 11, 2011 at 12:18:14PM -0400, Jeff King wrote:
> >
> > +unsigned long commit_generation(const struct commit *commit)
> > +{
> [...]
> > +	/* drop const because we may call parse_commit */
> > +	return commit_generation_recurse((struct commit *)commit);
> > +}
> 
> Out of curiosity, why make it const in the first place?

Two reasons:

  1. At the API layer, it's conceptually const. We're not changing the
     commit, but the lazy load of parse_commit is an implementation
     detail.

     In C++, you would stick a "mutable" tag on the parts we lazily load
     via parse_object. Here, we have to cast.

     This isn't C++, of course, and while we do follow some
     object-oriented principles, it's not necessarily worth fighting the
     language like this for the sake of a const. And I would be fine
     with saying "all commit objects should not be marked const, because
     we may lazily parse them, and it's well known that they are not to
     be freed anyway".

     But...

  2. The callsite in pretty.c has a const commit, so we have to cast
     somewhere, and this spot seemed the most appropriate to me (or we
     could drop the consts there, which I would be OK with).

-Peff
