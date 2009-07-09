From: Jeff King <peff@peff.net>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Thu, 9 Jul 2009 02:37:35 -0400
Message-ID: <20090709063735.GA22544@coredump.intra.peff.net>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu>
 <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu>
 <7vd48b6md8.fsf@alter.siamese.dyndns.org>
 <200907082242.51495.j6t@kdbg.org>
 <7vvdm26bbk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Fritz Anderson <fritza@uchicago.edu>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 08:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOnGY-0000rW-7z
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 08:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbZGIGhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 02:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbZGIGhk
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 02:37:40 -0400
Received: from peff.net ([208.65.91.99]:35746 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbZGIGhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 02:37:39 -0400
Received: (qmail 12968 invoked by uid 107); 9 Jul 2009 06:39:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 09 Jul 2009 02:39:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jul 2009 02:37:35 -0400
Content-Disposition: inline
In-Reply-To: <7vvdm26bbk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122935>

On Wed, Jul 08, 2009 at 03:48:15PM -0700, Junio C Hamano wrote:

> > However, if Fritz runs 'sudo /usr/local/bin/git clone ...', then the interim 
> > PATH is "/usr/local/bin:/usr/local/libexec/git-core:/bin:/usr/bin" because 
> > this time setup_path() finds a non-empty argv0_path, and the command works.
> 
> Ahh, that is what I was missing.
> 
> As I said elsewhere already, I personally do not think sudo is worth
> supporting compared to the cost of this kind of pain resulting from its
> misguided "safety" brokenness, but apparently it is widely used.  I think
> what Peff suggests in this thread might be a reasonable workaround.

Yes, I find sudo's restrictions silly, considering that most people use
it to allow arbitrary code execution, which is why I wrote this some
time ago:

  http://peff.net/tinysu/

However, sudo is pretty popular, and it should be easy enough for us to
work around it in this case. Patch is below. It's longer than the
one-liner necessary, because it now uses "git" as the magic "everything
should link to this" file instead of "git-add", which I think is a bit
more obvious.

-- >8 --
Subject: [PATCH] Makefile: install 'git' in execdir

When a git command executes a subcommand, it uses the "git
foo" form, which relies on finding "git" in the PATH.
Normally this should not be a problem, since the same "git"
that was used to invoke git in the first place will be
found.  And if somebody invokes a "git" outside of the PATH
(e.g., by giving its absolute path), this case is already
covered: we put that absolute path onto the front of PATH.

However, if one is using "sudo", then sudo will execute the
"git" from the PATH, but pass along a restricted PATH that
may not contain the original "git" directory. In this case,
executing a subcommand will fail.

To solve this, we put the "git" wrapper itself into the
execdir; this directory is prepended to the PATH when git
starts, so the wrapper will always be found.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 78cc113..311ce7d 100644
--- a/Makefile
+++ b/Makefile
@@ -1641,15 +1641,15 @@ ifneq (,$X)
 endif
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
-	{ $(RM) "$$execdir/git-add$X" && \
+	{ $(RM) "$$execdir/git$X" && \
 		test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
-		ln "$$bindir/git$X" "$$execdir/git-add$X" 2>/dev/null || \
-		cp "$$bindir/git$X" "$$execdir/git-add$X"; } && \
-	{ for p in $(filter-out git-add$X,$(BUILT_INS)); do \
+		ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
+		cp "$$bindir/git$X" "$$execdir/git$X"; } && \
+	{ for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \
-		ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \
-		ln -s "git-add$X" "$$execdir/$$p" 2>/dev/null || \
-		cp "$$execdir/git-add$X" "$$execdir/$$p" || exit; \
+		ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
+		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
+		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
 	  done; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
-- 
1.6.3.3.529.g74caa.dirty
