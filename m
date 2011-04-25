From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/2] send-pack --stateless-rpc: properly close the
 outgoing channel
Date: Mon, 25 Apr 2011 12:40:38 -0400
Message-ID: <20110425164038.GA1589@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104142136.25778.j6t@kdbg.org>
 <20110414202110.GA6525@sigill.intra.peff.net>
 <201104142243.33522.j6t@kdbg.org>
 <20110414205113.GA7451@sigill.intra.peff.net>
 <7vsjtkfs10.fsf@alter.siamese.dyndns.org>
 <4DB48B2C.2090904@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 18:40:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEOq9-0005wZ-6d
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 18:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab1DYQko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 12:40:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38264
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab1DYQkn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 12:40:43 -0400
Received: (qmail 10714 invoked by uid 107); 25 Apr 2011 16:42:22 -0000
Received: from c-67-172-212-47.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.212.47)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Apr 2011 12:42:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2011 12:40:38 -0400
Content-Disposition: inline
In-Reply-To: <4DB48B2C.2090904@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172030>

On Sun, Apr 24, 2011 at 10:42:20PM +0200, Johannes Sixt wrote:

> In the non-stateless-rpc case, the writable end of the channel to the
> remote repo is closed by the start_command() call that runs the
> pack-objects process (after pack-objects inherited a copy). But in the
> --stateless-rpc case, where send-pack takes care of writing data to the
> channel, this was missed.
>
> [...]
>
> Warning: This patch is untested. Furthermore, it does not even fix a resource
> leak because the fd that is now closed in pack_objects() would be closed
> later in cmd_send_pack.

Note that we can also call send_pack directly from git-push via the
transport.c interface. I didn't check whether one can actually trigger
stateless-rpc this way, though; it looks like git-remote-http ends up
exec'ing a separate send-pack.

> However, without closing the fd earlier like this, a --stateless-rpc
> invocation could theoretically dead-lock just like a regular
> invocation in a NO_PTHREADS build. But I also don't know how to
> test-drive send-pack --stateless-rpc to construct such a case. Any
> hints how to do that would be appreciated.

I was able to get a hang using v1.7.5 compiled with pthreads. You need
to have a server accepting smart-http push (if you use github, you can
create an empty test repo there, which is sufficient).

And then do a modified version of the test I posted earlier:

  UPSTREAM=https://peff@github.com/peff/test.git

  git init child &&
  cd child &&
  git remote add origin $UPSTREAM &&
  echo content >file &&
  git add file &&
  git commit -m one &&
  echo content >>file &&
  git add file &&
  git commit -m two &&
  sha1=`git rev-parse HEAD:file` &&
  file=`echo $sha1 | sed 's,..,&/,'` &&
  rm -fv .git/objects/$file

where obviously you need to tweak $UPSTREAM to point to the repo you
created.  That sets up the broken repo state. You can then try "git
push" in the repo with various versions to check their behavior.

With stock v1.7.5, this will hang after pack-objects reports the fatal
error. With your patch, it exits immediately, though the output looks
like this:

  $ git push
  Password:
  Counting objects: 5, done.
  error: unable to find ea0faeb6073ff6cb085727c3647be457051e6ed7
  fatal: unable to read ea0faeb6073ff6cb085727c3647be457051e6ed7
  fatal: The remote end hung up unexpectedly
  fatal: The remote end hung up unexpectedly
  fatal: write error: Bad file descriptor

which could perhaps be a little nicer, but is probably not a big deal (I
didn't dig very deep, but presumably we should exit a little more
immediately after seeing pack-objects fail).

-Peff
