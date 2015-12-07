From: Jeff King <peff@peff.net>
Subject: Re: Git 2.3.7 hangs on fetch but not clone
Date: Mon, 7 Dec 2015 15:21:34 -0500
Message-ID: <20151207202134.GA30203@sigill.intra.peff.net>
References: <001f01d13073$28d428a0$7a7c79e0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 'git mailing list' <git@vger.kernel.org>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:21:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62I1-0000c0-51
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 21:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbbLGUVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 15:21:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:38479 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932668AbbLGUVg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 15:21:36 -0500
Received: (qmail 14757 invoked by uid 102); 7 Dec 2015 20:21:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 14:21:36 -0600
Received: (qmail 22998 invoked by uid 107); 7 Dec 2015 20:21:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 15:21:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 15:21:34 -0500
Content-Disposition: inline
In-Reply-To: <001f01d13073$28d428a0$7a7c79e0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282116>

On Sun, Dec 06, 2015 at 05:12:12PM -0500, Randall S. Becker wrote:

> I have some strange behaviour I am trying to diagnose on the NonStop port of
> git 2.3.7. The situation is we have a *LARGE* cloned repository with some
> local modifications of openssl, which we are trying to clone again for a
> Jenkins build. The command:
> 	git clone /local/openssl openssl

Because the two repositories are on the same local filesystem, git will
skip the usual pack transfer and just copy or hardlink the object files.

You can add "--no-local" to make it more like the fetch that is failing
(I suspect it will then fail, too, but if it doesn't, that would be an
interesting data point).

> 	remote: Counting objects: 113436, done.
> 	remote: Compressing objects: 100% (23462/23462), done.
> then hangs forever without creating any files in the working directory.
> There are also no files or directories modified since the init operation.
> Processes left around, and without consuming resources, are:
> 1493172290 2030043151 - 15:58:29       00:15 git pack-objects --revs --thin
> --stdout --progress --delta-base-offset --include-tag
> 452984908  402653262 - 15:58:29       00:00 git -c core.askpass=true fetch
> --verbose --progress /local/git/openssl +refs/heads/*:refs/remotes/origin/*
> 402653262 1694498903 - 15:58:28       00:00 git -c core.askpass=true fetch
> --verbose --progress /local/git/openssl +refs/heads/*:refs/remotes/origin/*
> 2030043151  402653262 - 15:58:29       00:00 git-upload-pack
> /local/git/openssl

What are the processes doing?

Upload-pack on the "server" side spawns pack-objects, writes the set of
wanted objects to its stdin, and then waits for it to produce pack data
to stdout (which it then multiplexes back to the client). You clearly
got past the write (since pack-objects finished "Counting objects...").
I'd expect it to be waiting for input in poll() for input from the
stdout or stderr of pack-objects. It may also be blocking on write()
back to the client.

Pack-objects clearly completed delta compression, and so should be
writing out the final pack.  It doesn't look like it ever wrote the
"writing objects..." progress line (or perhaps upload-pack got stuck and
failed to relay it). It's probably blocking on write() to upload-pack.

You have two fetch processes. Presumably you build with NO_PTHREADS and
one of them is a fork()ed copy to demux the data from upload-pack. It
clearly runs at least a little while (it relays the "Counting" message).
It should either be blocking on read() from upload-pack, or perhaps
blocking on write() back to main fetch.

The main fetch hasn't yet spawned index-pack or unpack-objects, which
means it hasn't gotten enough of the pack header to do so. So it's
probably blocking on read() from the sideband demuxer process.

Do you have some equivalent of strace on your system? Or better yet, a
debugger?

> This does not happen for our smaller repositories. Any pointers on where to
> look would be appreciated.

My wild guess would be some pipe deadlock between the processes, but I
don't think we've had any of those lately. And v2.3.7 is not _too_ old
(there are some fixes for http deadlocks in v2.3.7..v2.6.3, but that
should not affect you here).

-Peff
