From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Wed, 11 Feb 2009 19:49:21 -0500
Message-ID: <20090212004921.GD30231@coredump.intra.peff.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net> <7vwsbynv0o.fsf@gitster.siamese.dyndns.org> <20090210181052.GA19634@coredump.intra.peff.net> <20090210191118.GA26651@coredump.intra.peff.net> <7vtz72kjz0.fsf@gitster.siamese.dyndns.org> <20090210225539.GC26954@coredump.intra.peff.net> <7v3aellwoa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 01:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXPn1-00013m-VU
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 01:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbZBLAtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 19:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbZBLAtY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 19:49:24 -0500
Received: from peff.net ([208.65.91.99]:37589 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbZBLAtY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 19:49:24 -0500
Received: (qmail 4366 invoked by uid 107); 12 Feb 2009 00:49:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 19:49:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 19:49:21 -0500
Content-Disposition: inline
In-Reply-To: <7v3aellwoa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109551>

On Tue, Feb 10, 2009 at 03:05:57PM -0800, Junio C Hamano wrote:

> There is an obvious optimization you can do to "diff-index --cached" using
> cache-tree.  If your index is really clean, computing the tree object the
> index would represent (without writing the tree object out) and comparing
> it against HEAD^{tree} may be a tad faster.

Clever, but I think you may just be trading one scenario for "worst
case" versus another (i.e., now when you _do_ have a difference to do an
early return, you still have to touch everything in the cache).

Just for fun, I timed a quick and dirty implementation. It looks like
generating the tree actually ends up taking just a little bit longer,
even with an unchanged index (which should be the case it speeds up).

But maybe I just did it wrong. My implementation was basically just:

  t = cache_tree();
  if (!cache_tree_fully_valid(t))
    cache_tree_update(t, active_cache, active_nr, 0, 0);
  get_sha1("HEAD", sha1);
  return hashcmp(t->sha1, sha1);

-Peff
