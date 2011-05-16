From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 2/9] send-pack: Attempt to retrieve remote status even
 if pack-objects fails
Date: Mon, 16 May 2011 02:13:54 -0400
Message-ID: <20110516061354.GA25731@sigill.intra.peff.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-3-git-send-email-johan@herland.net>
 <20110516040745.GA23583@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 08:14:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLr47-0007yW-1I
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 08:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab1EPGN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 02:13:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55493
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043Ab1EPGN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 02:13:57 -0400
Received: (qmail 10959 invoked by uid 107); 16 May 2011 06:15:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 02:15:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 02:13:54 -0400
Content-Disposition: inline
In-Reply-To: <20110516040745.GA23583@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173706>

On Mon, May 16, 2011 at 12:07:45AM -0400, Jeff King wrote:

> But what if we are not using pipes, but have an actual TCP socket? In
> that case, I'm not sure what happens. We don't seem to do a half-duplex
> shutdown() anywhere. So I'm concerned that we are still open for sending
> from the remote's perspective, and we may deadlock.
> 
> However, that would not necessarily be something introduced by your
> patch; you would deadlock in receive_status, but prior to that it would
> deadlock in the sideband demuxer.
> 
> AFAICT, the only way to have an actual TCP connection instead of pipes
> is for the push to go over git://, which is enabled almost nowhere. But
> we should perhaps check for deadlock on failed pack-objects in that
> case, both with and without your patch.

Ugh, yeah, yet another deadlock. I can reproduce reliably with this:

  [in one terminal]
  mkdir daemon &&
  git init --bare daemon/repo.git &&
  git --git-dir=daemon/repo.git config daemon.receivepack true &&
  git daemon --base-path=$PWD/daemon --export-all --verbose

  [in another]
  git init repo &&
  cd repo &&
  git remote add origin git://localhost/repo.git &&
  echo content >file && git add file && git commit -a -m one &&
  git push -f origin HEAD &&
  echo content >>file && git commit -a -m two &&
  sha1=`git rev-parse HEAD:file` &&
  file=`echo $sha1 | sed 's,..,&/,'` &&
  rm -fv .git/objects/$file &&
  git push

and this patch fixes it:

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index e2f4e21..b9da044 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -345,6 +345,13 @@ int send_pack(struct send_pack_args *args,
 				ref->status = REF_STATUS_NONE;
 			if (args->stateless_rpc)
 				close(out);
+			/* in case we actually have a full-duplex socket
+			 * and not two pipes; we can't use "out" because
+			 * it has been closed already, but in the full-duplex
+			 * case, "in" and "out" are merely dups of each other.
+			 * We can't directly use "in" because it may be
+			 * pointing to the sideband demuxer now */
+			shutdown(fd[0], SHUT_WR);
 			if (use_sideband)
 				finish_async(&demux);
 			return -1;

It does call shutdown() on a non-socket in the pipe case. That should be
a harmless noop, AFAIK.

-Peff
