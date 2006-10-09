From: Linus Torvalds <torvalds@osdl.org>
Subject: "fatal: Untracked working tree file 'so-and-so' would be overwritten
 by merge"
Date: Sun, 8 Oct 2006 17:11:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610081657400.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Oct 09 02:11:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWijo-0001Zs-86
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 02:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWJIALJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 20:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWJIALJ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 20:11:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751555AbWJIALI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 20:11:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k990B2aX030786
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Oct 2006 17:11:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k990B1Gi015052;
	Sun, 8 Oct 2006 17:11:02 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.467 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28554>


Hmm. I'm getting this message annoyingly often, simply because a few files 
that used to be tracked are now generated, and so they exist in my tree 
but are no longer tracked.

However, they may be tracked in an older tree that I pull, because in that 
older tree they _do_ exist, and we get the

	fatal: Untracked working tree file 'so-and-so' would be overwritten by merge.

which is actually incorrect, because the merge result will not even 
_contain_ that untracked file any more.

So the message is misleading - we should only consider this a fatal thing 
if we actually do generate that file as part of a git-read-tree, but if a 
merge won't touch a file, it shouldn't be "overwritten".

It's true that if the _other_ end actually removed a file that we used to 
have (ie the file _disappears_ as part of the merge), then we should 
verify that that file matched what we're going to remove, but if the old 
index didn't contain the file at all, and the new index won't contain it 
either, it really should be a no-op.

IOW, I think there is one "verify_absent()" too many somewhere, where we 
check this unnecessarily. I think it's the one in "deleted_entry()" in 
unpack-trees.c, but I'm not sure.

		Linus
