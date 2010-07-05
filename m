From: Jeff King <peff@peff.net>
Subject: Re: 'git commit --short' without touching index?
Date: Mon, 5 Jul 2010 16:56:52 -0400
Message-ID: <20100705205651.GA32728@sigill.intra.peff.net>
References: <loom.20100703T102242-536@post.gmane.org>
 <20100703091748.GA11714@sigill.intra.peff.net>
 <7veifhy9j0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel <friedan@muon.rutgers.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 22:57:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVsis-0001R4-Ge
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 22:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab0GEU4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 16:56:55 -0400
Received: from peff.net ([208.65.91.99]:45648 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755645Ab0GEU4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 16:56:54 -0400
Received: (qmail 17939 invoked by uid 107); 5 Jul 2010 20:57:50 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 05 Jul 2010 16:57:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jul 2010 16:56:52 -0400
Content-Disposition: inline
In-Reply-To: <7veifhy9j0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150294>

On Mon, Jul 05, 2010 at 01:10:43PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It would be nice if the index-refreshing code only wrote to the index if
> > there was something worth writing. I'm not sure how hard that would be
> > to implement, though.
> 
> Hmm, don't we already do that with "istate->cache_changed"?

Apparently not:

  $ stat .git/index | grep -i modify
  Modify: 2010-07-05 16:52:11.000000000 -0400
  $ git status
  # On branch master
  nothing to commit
  $ stat .git/index | grep -i modify
  Modify: 2010-07-05 16:53:09.000000000 -0400

and it is not just updating some stat-dirtiness. Doing it over and over
will keep updating the index. It looks like we unconditionally do the
lock and write in cmd_status, but I haven't looked further.

> In any case, we should diagnose "commit --short" (and "--procelain") as an
> error, perhaps by splitting option parsers for commit and status further.

I don't think it's an error. "commit --short" implies "commit --dry-run
--short", which is actually a useful thing (well, _I_ don't find it
useful, but I believe it was kept intentionally during the "status is no
longer commit --dry-run" conversion).

-Peff
