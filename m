From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] implement @{push} shorthand
Date: Tue, 31 Mar 2015 13:33:40 -0400
Message-ID: <20150331173339.GA17732@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 19:34:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd02v-0002WC-TY
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbbCaRdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:33:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:40401 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752763AbbCaRdn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:33:43 -0400
Received: (qmail 16648 invoked by uid 102); 31 Mar 2015 17:33:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 12:33:42 -0500
Received: (qmail 25417 invoked by uid 107); 31 Mar 2015 17:34:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:34:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 13:33:40 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266532>

The basic idea is that in a triangular workflow, it's useful to be able
to refer to both @{upstream} and "the place I would push to" with a
shorthand. This idea was discussed over a year ago:

  http://thread.gmane.org/gmane.comp.version-control.git/240144/focus=240198

I've found it useful since then, so I decided to clean it up and submit
it.  This iteration renames it to "@{push}" (rather than "@{publish}"),
which is more descriptive. It's rebased, as there were some changes in
the area, and it also fixes some bugs in the original (of course, I may
also have _introduced_ bugs, as this is largely a rewrite that has not
had a year's worth of exercise).

I also took the opportunity to do some more aggressive refactoring of
the remote.c code, as there were some bits there that confused me every
time I looked at it. I think the result is easier to follow.

  [1/6]: remote.c: drop default_remote_name variable
  [2/6]: remote.c: drop "remote" pointer from "struct branch"
  [3/6]: remote.c: hoist branch.*.remote lookup out of remote_get_1
  [4/6]: remote.c: provide per-branch pushremote name
  [5/6]: sha1_name: refactor upstream_mark
  [6/6]: sha1_name: implement @{push} shorthand

The one thing I _didn't_ do here is refactor the logic in
builtin/push.c so what we could reuse it. There's still a switch
statement here on push_default. I don't like that, but I spent an hour
or so trying to pull out the push.c logic, and it got rather nasty.
There are a lot of global variables that get mutated by one-off
functions, and it all needs to happen in the right order. It looked like
any serious refactoring there is going to have a risk of regressions in
push.

So I punted on that. The simplified logic that is here in sha1_name is
not too bad, and I feel like we can unify the two at a later date if we
want to. And I'd much rather see bug reports like "@{push} doesn't act
like git-push" and deal with that, as opposed to "your series breaks
push".

-Peff
