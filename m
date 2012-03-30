From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Fri, 30 Mar 2012 16:34:30 -0400
Message-ID: <20120330203430.GB20376@sigill.intra.peff.net>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Bo Chen <chen@chenirvine.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:34:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDiWs-0007ky-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 22:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761379Ab2C3Uee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 16:34:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41382
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756964Ab2C3Uec (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 16:34:32 -0400
Received: (qmail 19982 invoked by uid 107); 30 Mar 2012 20:34:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 16:34:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 16:34:30 -0400
Content-Disposition: inline
In-Reply-To: <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194403>

On Fri, Mar 30, 2012 at 03:51:20PM -0400, Bo Chen wrote:

> The sub-problems of "delta for large file" problem.
> 
> 1 large file
> 
> 1.1 text file (always delta well? need to be confirmed)

They often do, but text files don't tend to be large. There are some
exceptions (e.g., genetic data is often kept in line-oriented text
files, but is very large).

But let's take a step back for a moment. Forget about whether a file is
binary or not. Imagine you want to store a very large file in git.

What are the operations that will perform badly? How can we make them
perform acceptably, and what tradeoffs must we make? E.g., the way the
diff code is written, it would be very difficult to run "git diff" on a
2 gigabyte file. But is that actually a problem? Answering that means
talking about the characteristics of 2 gigabyte files, and what we
expect to see, and to what degree our tradeoffs will impact them.

Here's a more concrete example. At first, even storing a 2 gigabyte file
with "git add" was painful, because we would load the whole thing in
memory. Repacking the repository was painful, because we had to rewrite
the whole 2G file into a packfile. Nowadays, we stream large files
directly into their own packfiles, and we have to pay the I/O only once
(and the memory cost never). As a tradeoff, we no longer get delta
compression of large objects. That's OK for some large objects, like
movie files (which don't tend to delta well, anyway). But it's not for
other objects, like virtual machine images, which do tend to delta well.

So can we devise a solution which efficiently stores these
delta-friendly objects, without losing the performance improvements we
got with the stream-directly-to-packfile approach?

One possible solution is breaking large files into smaller chunks using
something like the bupsplit algorithm (and I won't go into the details
here, as links to bup have already been mentioned elsewhere, and Junio's
patches make a start at this sort of splitting).

Note that there are other problem areas with big files that can be
worked on, too. For example, some people want to store 100 gigabytes in
a repository. Because git is distributed, that means 100G in the repo
database, and 100G in the working directory, for a total of 200G. People
in this situation may want to be able to store part of the repository
database in a network-accessible location, trading some of the
convenience of being fully distributed for the space savings. So another
project could be designing a network-based alternate object storage
system.

-Peff
