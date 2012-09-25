From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/3] git log --pretty=lua
Date: Mon, 24 Sep 2012 20:23:25 -0400
Message-ID: <20120925002325.GA19560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 02:24:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGIwU-0007gv-KP
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 02:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab2IYAXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 20:23:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57440 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521Ab2IYAXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 20:23:31 -0400
Received: (qmail 7315 invoked by uid 107); 25 Sep 2012 00:23:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 20:23:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 20:23:25 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206335>

We've talked off and on about extending the --pretty=format specifiers
to something more flexible. There's also been talk recently of more
flexible commit-filtering (e.g., grepping individual notes).  Rather
than invent a new Turing-complete language, I thought I'd try building
on somebody else's work by embedding an existing language.

Why Lua? I don't especially like it as a language. But it's designed for
this purpose, which makes it very lightweight and relatively simple to
embed. Here are timing results for a few log commands (best-of-five,
warm cache):

  $ git log --oneline >/dev/null
  real    0m1.042s
  user    0m0.660s
  sys     0m0.372s

  $ git log --tformat:"%h %s" >/dev/null
  real    0m1.039s
  user    0m0.624s
  sys     0m0.396s

  $ git log --pretty=lua:'return abbrev(hash()) .. " " .. subject()'
  real    0m1.112s
  user    0m0.716s
  sys     0m0.388s

So you can see that we're a little bit slower than the existing format,
but not too much. There may well be some optimizations we can do, too.
This is the first time I've ever played with embedding Lua, so I would
not be surprised if I got something wrong or suboptimal.

The syntax, on the other hand...yuck. One thing that makes Lua
horrible for this use is that it does not have interpolated strings.
However, there are template libraries for Lua, so maybe there's
something there.

The patches are:

  [1/3]: pretty: make some commit-parsing helpers more public
  [2/3]: add basic lua infrastructure
  [3/3]: add a "lua" pretty format

And a "4/3" patch would probably add "--lua-filter" as a revision option
for limiting commits.

The patches are very rough and not meant to be applied. For me, this was
a bit of an experiment. I'm not sure if I like it or not. It seems like
a cool direction to go, but to be perfectly honest, I do not generally
feel like git's existing filtering or output are inadequate (sure, it's
slower to pipe --pretty=raw out to a separate perl filter and then do
fancy formatting, but it's usually fast enough, and it's very flexible).

So I don't have plans to work on it more any time soon, but I thought
I'd share in case anybody is interested. And if somebody wants to pick
up the topic and run with it, I'd be happy to help.

-Peff
