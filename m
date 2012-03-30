From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of "Better big-file support".
Date: Fri, 30 Mar 2012 15:54:04 -0400
Message-ID: <20120330195404.GA20189@sigill.intra.peff.net>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <CA+M5ThS1XiaGJWmSvfwXoqebnH6fK3h6cC7OnQQi=LXzcA0GRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Bo Chen <chen@chenirvine.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 21:54:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhtq-0000CA-Bv
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761409Ab2C3TyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:54:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41351
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761433Ab2C3TyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:54:06 -0400
Received: (qmail 19276 invoked by uid 107); 30 Mar 2012 19:54:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 15:54:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 15:54:04 -0400
Content-Disposition: inline
In-Reply-To: <CA+M5ThS1XiaGJWmSvfwXoqebnH6fK3h6cC7OnQQi=LXzcA0GRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194398>

On Fri, Mar 30, 2012 at 03:11:40PM -0400, Bo Chen wrote:

> Just make clear one of my confusions. Delta operation is to find out
> the differences between different versions of the same file, right?
> As I know, delta encoding is to re-encode a file based on the
> differences between neighboring blocks, thus can help compress a file
> since after delta encoding, we will have more similar data within the
> file. Can anyone elaborate a little bit what is the relation between
> delta operation in git and delta encoding listed above? Thanks.

Sort of. Git is snapshot based. So each version of a file is its own
"object", and from a high-level view, we store all objects. But we store
the logical objects themselves in packfiles, in which the actual
representation of the object may be stored as a difference to another
object (which is likely to be a different version of the same file, but
does not have to be).

Here's some background reading:

  http://progit.org/book/ch1-3.html

  http://progit.org/book/ch9-4.html

> I am wondering why we cannot divide the 2  2GB files into chunks and
> delta chunks by chunks. Is that any difference, except a little more
> IOs?

It's more complicated than that. What if the file is re-ordered? You
would want to compare early chunks in one version against later chunks
in the other. So yes, you can reduce memory pressure by doing more I/O,
but doing too much I/O will be very slow. Coming up with a solution is
part of what this project is about. And chunking is part of that
solution.

> > Read about rsync algorithm [2]. Bup [1] implements the same (I think)
> > algorithm, but on top of git. For preliminary patches, have a look at
> > jc/split-blob series at commit 4a1242d in git.git.
> 
> Make clear my another confusion. The file which has been updated
> (added, deleted, and modified) is first delta-compressed, and then
> synchronize to the remote repo by some mechanism (rsync?). I am
> wondering what is the the relationship between delta operation and
> rsync.

No, the updated file is delta compressed into a packfile, and the
packfile is transmitted. Rsync comes into play because it uses a novel
chunking algorithm, which was copied by bup (and is referred to as the
"bupsplit" algorithm). Read up on how bup works and why it was invented.

-Peff
