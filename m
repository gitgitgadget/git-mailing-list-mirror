From: Jeff King <peff@peff.net>
Subject: Re: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Mon, 18 Apr 2011 17:18:50 -0400
Message-ID: <20110418211849.GB13566@sigill.intra.peff.net>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <20110418211102.GA13566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:18:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBvqS-0003Pz-Og
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 23:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab1DRVSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 17:18:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52891
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496Ab1DRVSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 17:18:52 -0400
Received: (qmail 3962 invoked by uid 107); 18 Apr 2011 21:19:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Apr 2011 17:19:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Apr 2011 17:18:50 -0400
Content-Disposition: inline
In-Reply-To: <20110418211102.GA13566@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171759>

On Mon, Apr 18, 2011 at 05:11:02PM -0400, Jeff King wrote:

> The good news is that the bug is trivial. It bisects Jonathan's ebec842
> (run-command: prettify -D_FORTIFY_SOURCE workaround, 2011-03-16), which
> introduces:
> 
> -       unused = write(child_err, "fatal: ", 7);
> -       unused = write(child_err, msg, len);
> -       unused = write(child_err, "\n", 1);
> +       if (write(child_err, "fatal: ", 7) ||
> +           write(child_err, msg, len) ||
> +           write(child_err, "\n", 1))
> +               ; /* yes, gcc -D_FORTIFY_SOURCE, we know there was an error. */
> 
> Stare at that for a minute and see if you can guess what's wrong. :)

And here's the fix.

-- >8 --
Subject: [PATCH] run-command: fix broken error messages from child

After we fork, we try to exec the child; if exec fails, we
write an error message and exit. We ignore the return value
of write, since there's nothing we can do about it.

Commit ebec842 turned this into a conditional to make
-D_FORTIFY_SOURCE happy with the ignored return value, but
botched the change so that we never write more than
"fatal:".

Write will return the number of bytes written, so the
conditional as written will always appear as an error. Of
course we don't actually do anything for the error, but
the short-circuit logic means we never execute the
subsequent write()s, giving us a truncated error message.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 8619c76..508a4c6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -83,9 +83,9 @@ static NORETURN void die_child(const char *err, va_list params)
 	if (len > sizeof(msg))
 		len = sizeof(msg);
 
-	if (write(child_err, "fatal: ", 7) ||
-	    write(child_err, msg, len) ||
-	    write(child_err, "\n", 1))
+	if (write(child_err, "fatal: ", 7) < 0 ||
+	    write(child_err, msg, len) < 0 ||
+	    write(child_err, "\n", 1) < 0)
 		; /* yes, gcc -D_FORTIFY_SOURCE, we know there was an error. */
 	exit(128);
 }
-- 
1.7.5.rc2.3.g728b2
