From: Jeff King <peff@peff.net>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 23:24:56 -0500
Message-ID: <20101112042455.GA20555@sigill.intra.peff.net>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
 <20101111173253.GC16972@burratino>
 <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
 <20101111184829.GG16972@burratino>
 <20101111190508.GA3038@sigill.intra.peff.net>
 <20101112021602.GA10765@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 05:25:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGlCF-0006WF-Fd
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 05:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab0KLEZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 23:25:00 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49444 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041Ab0KLEY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 23:24:59 -0500
Received: (qmail 467 invoked by uid 111); 12 Nov 2010 04:24:58 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 12 Nov 2010 04:24:58 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Nov 2010 23:24:56 -0500
Content-Disposition: inline
In-Reply-To: <20101112021602.GA10765@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161320>

On Thu, Nov 11, 2010 at 08:16:02PM -0600, Jonathan Nieder wrote:

> > I don't think your patch is the right solution, but FWIW, sigchain was
> > explicitly intended to be able to take SIG_DFL and SIG_IGN. Probably
> > sigchain_fun should be removed and we should just use sighandler_t
> > explicitly
> 
> Sorry, that was lazy of me.  The name sighandler_t is a GNU extension[1].

Ah, you're right. ANSI C defines signal() without using a typedef at
all. Maybe that is why I didn't use it in the first place. I don't
recall.

> The following addresses my confusion but I doubt it's worth the
> syntactic ugliness.
>
> -- 8< --
> Subject: sigchain: hide sigchain_fun type

I think it makes the code uglier. Maybe this is a better solution:

-- >8 --
Subject: [PATCH] document sigchain api

It's pretty straightforward, but a stripped-down example
never hurts. And we should make clear that it is explicitly
OK to use SIG_DFL and SIG_IGN.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-sigchain.txt |   41 ++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-sigchain.txt

diff --git a/Documentation/technical/api-sigchain.txt b/Documentation/technical/api-sigchain.txt
new file mode 100644
index 0000000..535cdff
--- /dev/null
+++ b/Documentation/technical/api-sigchain.txt
@@ -0,0 +1,41 @@
+sigchain API
+============
+
+Code often wants to set a signal handler to clean up temporary files or
+other work-in-progress when we die unexpectedly. For multiple pieces of
+code to do this without conflicting, each piece of code must remember
+the old value of the handler and restore it either when:
+
+  1. The work-in-progress is finished, and the handler is no longer
+     necessary. The handler should revert to the original behavior
+     (either another handler, SIG_DFL, or SIG_IGN).
+
+  2. The signal is received. We should then do our cleanup, then chain
+     to the next handler (or die if it is SIG_DFL).
+
+Sigchain is a tiny library for keeping a stack of handlers. Your handler
+and installation code should look something like:
+
+------------------------------------------
+  void clean_foo_on_signal(int sig)
+  {
+	  clean_foo();
+	  sigchain_pop(sig);
+	  raise(sig);
+  }
+
+  void other_func()
+  {
+	  sigchain_push_common(clean_foo_on_signal);
+	  mess_up_foo();
+	  clean_foo();
+  }
+------------------------------------------
+
+Handlers are given the typdef of sigchain_fun. This is the same type
+that is given to signal() or sigaction(). It is perfectly reasonable to
+push SIG_DFL or SIG_IGN onto the stack.
+
+You can sigchain_push and sigchain_pop individual signals. For
+convenience, sigchain_push_common will push the handler onto the stack
+for many common signals.
-- 
1.7.3.2.362.g0e229.dirty
