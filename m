From: Linus Torvalds <torvalds@osdl.org>
Subject: Broken directory pathname pruning..
Date: Thu, 26 May 2005 17:41:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri May 27 02:39:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbSrU-0006Pm-6o
	for gcvg-git@gmane.org; Fri, 27 May 2005 02:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVE0Aji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 20:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVE0Aj3
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 20:39:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:43681 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261331AbVE0AjW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 20:39:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4R0d6jA019285
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 May 2005 17:39:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4R0d6BJ024170;
	Thu, 26 May 2005 17:39:06 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The directory-based pathname pruning doesn't work any more.

I used to just say

	git-whatchanged -v -p drivers/usb/

and I just noticed that it doesn't work any more.

It _does_ work if I leave the final '/' off the thing.

diff-tree itself does this right: that's shown by the fact that with the
slash in place, we still do get the right _changelog_ that is restricted
to drivers/usb changes, but the diffs themselves are missing.

So it seems to be purely "diffcore_pathspec()" that is broken.

Btw, I don't think we should call "diffcore_pathspec()" at all in
diff-tree, because diff-tree already handles "interesting" paths correctly
(and has to do so for performance reasons, since it's not acceptable to
expand all the trees and diff them).

So in the "git-whatchanged"  case the fix is as simple as just removing
those two lines, but the bug then continues to exist in the other *diff* 
programs..

Junio?

		Linus

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -268,8 +268,6 @@ static int call_diff_flush(void)
 		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 		return 0;
 	}
-	if (nr_paths)
-		diffcore_pathspec(paths);
 	if (header) {
 		if (diff_output_format == DIFF_FORMAT_MACHINE) {
 			const char *ep, *cp;

