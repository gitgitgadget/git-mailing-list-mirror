From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] address packed-refs speed regressions
Date: Sat, 4 Apr 2015 21:06:11 -0400
Message-ID: <20150405010611.GA15901@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 03:06:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeZ17-0006W8-6w
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 03:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbbDEBGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 21:06:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:42539 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752530AbbDEBGO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 21:06:14 -0400
Received: (qmail 19175 invoked by uid 102); 5 Apr 2015 01:06:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 20:06:14 -0500
Received: (qmail 1796 invoked by uid 107); 5 Apr 2015 01:06:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 21:06:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2015 21:06:11 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266789>

As I've mentioned before, I have some repositories with rather large
numbers of refs. The worst one has ~13 million refs, for a 1.6GB
packed-refs file. So I was saddened by this:

  $ time git.v2.0.0 rev-parse refs/heads/foo >/dev/null 2>&1
  real    0m6.840s
  user    0m6.404s
  sys     0m0.440s

  $ time git.v2.4.0-rc1 rev-parse refs/heads/foo >/dev/null 2>&1
  real    0m19.432s
  user    0m18.996s
  sys     0m0.456s

The command isn't important; what I'm really measuring is loading the
packed-refs file. And yes, of course this repository is absolutely
ridiculous. But the slowdowns here are linear with the number of refs.
So _every_ git command got a little bit slower, even in less crazy
repositories. We just didn't notice it as much.

Here are the numbers after this series:

  real    0m8.539s
  user    0m8.052s
  sys     0m0.496s

Much better, but I'm frustrated that they are still 20% slower than the
original.

The main culprits seem to be d0f810f (which introduced some extra
expensive code for each ref) and my 10c497a, which switched from fgets()
to strbuf_getwholeline. It turns out that strbuf_getwholeline is really
slow.

There may be other problems lurking to account for the remaining 20%.
It's hard to find performance regressions with a bisection if there are
multiple of them; if you stop at a random commit and it is 500ms slow,
it is hard to tell which problem is causing it.

Note that while these are regressions, they are in v2.2.0 and v2.2.2
respectively. So this can wait until post-2.4.

  [1/6]: strbuf_getwholeline: use getc macro
  [2/6]: git-compat-util: add fallbacks for unlocked stdio
  [3/6]: strbuf_getwholeline: use get_unlocked
  [4/6]: strbuf: add an optimized 1-character strbuf_grow
  [5/6]: t1430: add another refs-escape test
  [6/6]: refname_is_safe: avoid expensive normalize_path_copy call

-Peff
