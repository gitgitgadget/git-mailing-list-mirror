From: Jeff King <peff@peff.net>
Subject: Re: Should copy/rename detection consider file overwrites?
Date: Fri, 23 Jan 2015 06:04:19 -0500
Message-ID: <20150123110418.GA10028@peff.net>
References: <20150123012908.GA8558@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEc2S-0007SM-Ji
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbbAWLEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:04:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:37763 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754594AbbAWLEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:04:22 -0500
Received: (qmail 25629 invoked by uid 102); 23 Jan 2015 11:04:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 05:04:22 -0600
Received: (qmail 18783 invoked by uid 107); 23 Jan 2015 11:04:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 06:04:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2015 06:04:19 -0500
Content-Disposition: inline
In-Reply-To: <20150123012908.GA8558@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262905>

On Fri, Jan 23, 2015 at 10:29:08AM +0900, Mike Hommey wrote:

> While fooling around with copy/rename detection, I noticed that it
> doesn't detect the case where you copy or rename a file on top of
> another:
> 
> $ git init
> $ (echo foo; echo bar) > foo

If I replace this with a longer input, like:

  cp /usr/share/dict/words foo

> $ git add foo
> $ git commit -m foo
> $ echo 0 > bar
> $ git add bar
> $ git commit -m bar
> $ git mv -f foo bar
> $ git commit -m foobar
> $ git log --oneline --reverse
> 7dc2765 foo
> b0c837d bar
> 88caeba foobar
> $ git blame -s -C -C bar
> 88caebab 1) foo
> 88caebab 2) bar

Then the blame shows me the initial "foo" commit. So I think it is
mainly that your toy example is too small (I think we will do
exact rename detection whatever the size is, but I expect we are getting
hung up on the break detection between "0\n" and "foo\nbar\n").

> I can see how this is not trivially representable in e.g. git diff-tree,
> but shouldn't at least blame try to tell that those lines actually come
> from 7dc2765?

diff-tree can show this, too, but you need to turn on "break detection"
which will notice that "bar" has essentially been rewritten (and then
consider its sides as candidates for rename detection). For example
(with the longer input, as above):

  $ git diff-tree --name-status -M HEAD
  c6fe146b0c73adcbc4dbc2e58eb83af9007678bc
  M       bar
  D       foo

  $ git diff-tree --name-status -M -B HEAD
  c6fe146b0c73adcbc4dbc2e58eb83af9007678bc
  R100    foo     bar

Presumably if you set the break score low enough, your original example
would behave the same way, but I couldn't get it to work (I didn't look
closely, but I imagine it is just so tiny that we hit the internal
limits on how low you can set the score).

-Peff
