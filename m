From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
	example
Date: Sun, 29 Jul 2007 00:11:59 -0400
Message-ID: <20070729041159.GA5544@coredump.intra.peff.net>
References: <20070729002427.GA1566@coredump.intra.peff.net> <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 06:12:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF08W-00067Z-Su
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 06:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbXG2EME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 00:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbXG2EME
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 00:12:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2786 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbXG2EMB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 00:12:01 -0400
Received: (qmail 23410 invoked from network); 29 Jul 2007 04:12:01 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 Jul 2007 04:12:01 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2007 00:11:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54078>

On Sat, Jul 28, 2007 at 07:06:38PM -0700, Linus Torvalds wrote:

> For diffing against (or using) the index, the "-r" is superfluous.
> 
> Why? Because the index is always the *full* list of files. It's "flat".
> 
> However, when you diff two trees, the -r makes a difference.
> 
> So I think you'd find a difference if you actually diffed two commits 
> with "git diff tree2..tree2".

Ah...right you are.

So if I "git diff" two commits with --raw or --name-status, we don't
recurse into recurse into subdirectories (because they are actually
subtrees). If I "git diff" a commit against the index using --raw or
--name-status, I we do recurse (since the index is actually flat). But
if I "git diff" using -p, --stat, or --summary, it _does_ recurse no
matter what I'm diffing.

Does anybody else find this behavior confusing? I can understand why
diff-tree might not recurse by default, but I wonder if porcelain like
git-diff should try to be a little more consistent and always recurse.

Something like:

diff --git a/builtin-diff.c b/builtin-diff.c
index 7f367b6..b48121e 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -233,6 +233,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			die("diff_setup_done failed");
 	}
 	rev.diffopt.allow_external = 1;
+	rev.diffopt.recursive = 1;
 
 	/* Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.

For comparison, whatchanged, show, and format-patch are already always
recursive. log is not.

-Peff
