From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/4] send-pack: abort sideband demuxer on pack-objects error
Date: Thu, 14 Apr 2011 21:36:25 +0200
Message-ID: <201104142136.25778.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104132153.06429.j6t@kdbg.org> <20110414135449.GD12410@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:36:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QASLG-0002kI-51
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 21:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758665Ab1DNTgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 15:36:32 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:61749 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757948Ab1DNTgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 15:36:31 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BFECB2C4006;
	Thu, 14 Apr 2011 21:36:26 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DB45A19F610;
	Thu, 14 Apr 2011 21:36:25 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20110414135449.GD12410@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171541>

On Donnerstag, 14. April 2011, Jeff King wrote:
> Obviously it totally breaks the start_async abstraction if the called
> code needs to care whether it forked or not. But we can use that to our
> advantage, since it means start_async callers must assume the interface
> is very limited.  So I think we can do something like:
>
>   1. Async code declares which file descriptors it cares about. This
>      would automatically include the pipe we give to it, of course.
>      So the declared ones for a sideband demuxer would be stderr, and
>      some network fd for reading.
>
>   2. In the pthreads case, we do nothing. In the forked case, the child
>      closes every descriptor except the "interesting" ones.
>
> And that solves this problem, and the general case that async-callers
> have no idea if they have just leaked pipe descriptors in the forked
> case.

Sounds like a plan. How do you close all file descriptors? Just iterate up to 
getrlimit(RLIMIT_NOFILE)?

>
> I'm still slightly confused, though, because I never see that descriptor
> get closed in the threaded case. So I still don't understand why it
> _doesn't_ deadlock with pthreads.

In the threaded case, this fd is closed by start_command(), where it is passed 
as po.out in pack_objects(). In the fork case this is too late because a 
duplicate was already inherited to the sideband demuxer.

However, pack_objects() works differently in the stateless_rpc case: then it 
does not close fd anywhere, and I think it should be possible to construct a 
similar case that hangs even in the threaded case. And the fix could simply 
look like this:

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 5e772c7..c8f601f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -101,6 +101,7 @@ static int pack_objects(int fd, struct ref *refs,
 		free(buf);
 		close(po.out);
 		po.out = -1;
+		close(fd);
 	}
 
 	if (finish_command(&po))

-- Hannes
