From: Jeff King <peff@peff.net>
Subject: Re: git hangs on pthread_join
Date: Tue, 28 May 2013 13:51:09 -0400
Message-ID: <20130528175108.GA21210@sigill.intra.peff.net>
References: <20130523130143.GA6376@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Tue May 28 19:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhO3L-0000lz-6J
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915Ab3E1RvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:51:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:57781 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964881Ab3E1RvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:51:14 -0400
Received: (qmail 8804 invoked by uid 102); 28 May 2013 17:51:53 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 May 2013 12:51:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2013 13:51:09 -0400
Content-Disposition: inline
In-Reply-To: <20130523130143.GA6376@pomac.netswarm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225674>

On Thu, May 23, 2013 at 03:01:43PM +0200, Ian Kumlien wrote:

> git 1.8.2.1 is started by xinetd
> [...]
> I have found "git receive-pack"s that has been running for days/weeks
> without terminating....
> 
> Attaching gdb and doing a trace results in:
> #0  0x0000003261207b35 in pthread_join () from /lib64/libpthread.so.0
> #1  0x00000000004ce58b in finish_async ()
> #2  0x000000000045744b in cmd_receive_pack ()
> #3  0x0000000000404851 in handle_internal_command ()
> #4  0x0000000000404c9d in main ()

I recently fixed a deadlock that could happen in receive-pack when
clients hung up before sending a valid pack header. The fix is commit
49ecfa1, and it's in git v1.8.2.2.

The stack trace for the deadlock fixed by 49ecfa1 would have
unpack_with_sideband between #1 and #2 above, but it is entirely
possible that it is simply inlined in your build of git, depending on
the -O level of your build (it is a static function that is only called
from one place). So it seems likely that it is the culprit.

-Peff
