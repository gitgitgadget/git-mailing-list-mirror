From: Jeff King <peff@peff.net>
Subject: Re: Cannot push a commit
Date: Mon, 16 Jan 2012 16:20:36 -0500
Message-ID: <20120116212036.GA21132@sigill.intra.peff.net>
References: <4F1297E0.1060703@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Mon Jan 16 22:20:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmtz2-0004Ap-7W
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 22:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871Ab2APVUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 16:20:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39464
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756866Ab2APVUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 16:20:39 -0500
Received: (qmail 18560 invoked by uid 107); 16 Jan 2012 21:27:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jan 2012 16:27:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:20:36 -0500
Content-Disposition: inline
In-Reply-To: <4F1297E0.1060703@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188655>

On Sun, Jan 15, 2012 at 10:09:52AM +0100, Matthias Fechner wrote:

> git.exe push --progress  "origin" master:master
> 
> Counting objects: 4, done.
> Compressing objects: 100% (3/3)
> Writing objects: 100% (3/3), 80.00 KiB | 137 KiB/s
> Writing objects: 100% (3/3), 91.63 KiB | 137 KiB/s, done.
> Total 3 (delta 0), reused 0 (delta 0)
> fatal: early EOF
> error: unpack failed: unpack-objects abnormal exit
> To idefix@fechner.net:git-test
> ! [remote rejected] master -> master (n/a (unpacker error))
> error: failed to push some refs to 'idefix@fechner.net:git-test'

Odd. The unpacking process on the other end claims that it didn't get
the whole input (it knows how much to expect based on the earlier parts
of what is sent) . Yet the connection is still going (because we see the
error messages coming from the remote), so it wasn't simply that the
connection was dropped.  So either:

  1. Something in the connection cut out but only in a half-duplex way.
     I guess I could see ssh doing that if its input pipe closed, but
     that would mean the local pack-objects failed, and I believe git
     already detects and reports that case.

  2. The packfile sent indicated that it should have more bytes than it
     does (i.e., either git indicated there were more objects than there
     actually are, or zlib failed to give a stream-end marker in the
     middle of an object). This is one of:

     a. A bug in git or zlib.

     b. Something in the connection corrupting the data (e.g., a
        transport that is not 8-bit clean).

But in either 2a or 2b, I would expect us to have seen this before, and
I don't recall seeing anything like it.

You could try generating a bundle with this pack, like:

  git bundle create foo.bundle master ^origin/master

and then shipping the resulting foo.bundle to the other side, and
pulling from it like:

  git pull /path/to/foo.bundle master

That should use (roughly) the same pack generation code as the
push, but avoid the transport. If it works, then it's either a problem
with the transport, or there is something really subtle going on
inside git.

If it does fail, then that will be a much easier case to repeat and
diagnose from there.

-Peff
