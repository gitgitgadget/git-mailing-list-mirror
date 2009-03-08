From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
	cherry-picking an empty commit
Date: Sun, 8 Mar 2009 11:09:44 -0400
Message-ID: <20090308150944.GA32294@coredump.intra.peff.net>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com> <20090308144240.GA30794@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Johnsen <chris_johnsen@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 16:11:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgKf8-00009A-P7
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 16:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbZCHPKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 11:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbZCHPKB
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 11:10:01 -0400
Received: from peff.net ([208.65.91.99]:34568 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbZCHPKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 11:10:00 -0400
Received: (qmail 22736 invoked by uid 107); 8 Mar 2009 15:10:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Mar 2009 11:10:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Mar 2009 11:09:44 -0400
Content-Disposition: inline
In-Reply-To: <20090308144240.GA30794@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112622>

On Sun, Mar 08, 2009 at 10:42:40AM -0400, Jeff King wrote:

>   2. Have test_run_ canonicalize the snippet by removing trailing
>      newlines.
> [...]
> I think (2) is the most reasonable option of those choices.

And here's what that would look like:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7a847ec..276a14d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -273,7 +273,7 @@ test_debug () {
 }
 
 test_run_ () {
-	eval >&3 2>&4 "$1"
+	eval >&3 2>&4 "`echo "$1" | sed -e :a -e '/^ *\n*$/{$d;N;ba' -e '}'`"
 	eval_ret="$?"
 	return 0
 }

That is a truly hideous sed expression, and I would be happy to hear
more readable suggestions (it is based on one from the "sed one-liners"
compilation).

With this applied, t3505 passes for me. However, some other random tests
are broken as a result. It looks like it might be related to an extra
round of '\' expansion.

-Peff
