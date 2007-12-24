From: Jeff King <peff@peff.net>
Subject: [PATCH] cvsimport: die on cvsps errors
Date: Sun, 23 Dec 2007 22:08:19 -0500
Message-ID: <20071224030819.GA15485@sigill.intra.peff.net>
References: <20071222171801.GE15286@genesis.frugalware.org> <20071224030551.GA12495@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Stefan Sperling <stsp@stsp.name>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 04:08:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6dgK-0005Lm-2g
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 04:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbXLXDIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 22:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbXLXDIU
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 22:08:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1839 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbXLXDIT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 22:08:19 -0500
Received: (qmail 19512 invoked by uid 111); 24 Dec 2007 03:08:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 23 Dec 2007 22:08:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Dec 2007 22:08:19 -0500
Content-Disposition: inline
In-Reply-To: <20071224030551.GA12495@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69202>

We were not previously checking the exit status of cvsps at
all. If it exited before producing any useful output, we
ended up with an empty import, which caused a spew of
confusing error messages from other parts of git:

$ git-cvsimport foo
Initialized empty Git repository in ...
some error from cvsps
fatal: refs/heads/origin: not a valid SHA1
fatal: master: not a valid SHA1
warning: You appear to be on a branch yet to be born.
warning: Forcing checkout of HEAD.
fatal: just how do you expect me to merge 0 trees?
checkout failed: 256

Now we get:

$ git-cvsimport foo
Initialized empty Git repository in ...
some error from cvsps
git-cvsimport: fatal: cvsps reported error

Signed-off-by: Jeff King <peff@peff.net>
---
On Sun, Dec 23, 2007 at 10:05:51PM -0500, Jeff King wrote:

> That being said, it's awful that git-cvsimport doesn't stop when cvsps
> exits with an error, producing all of those meaningless errors. Patch
> will follow.

And here it is.

 git-cvsimport.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1fa9a22..6d8ff93 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -632,6 +632,7 @@ unless ($opt_P) {
 	    print $cvspsfh $_;
 	}
 	close CVSPS;
+	$? == 0 or die "git-cvsimport: fatal: cvsps reported error\n";
 	close $cvspsfh;
 } else {
 	$cvspsfile = $opt_P;
-- 
1.5.4.rc1.1119.g1e6bc-dirty
