From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "git pull" throws away dirty state
Date: Sun, 16 Mar 2008 11:08:03 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 19:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaxJ7-0003hO-35
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 19:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbYCPSI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 14:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbYCPSI6
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 14:08:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54865 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043AbYCPSI6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2008 14:08:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GI99Bk030819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Mar 2008 11:09:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GI83jv007465;
	Sun, 16 Mar 2008 11:08:04 -0700
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.294 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77368>


Ok, this is distressing, and I suspect it's another bug of mine due to 
unpack-trees changes, but before I delve into it deeper I thought I'd 
report it here and see if others see it too, and maybe it's due to 
something else..

I'm used to having dirty state in my tree, and still being able to do a 
lot of my normal work, very much including doing pulls from others. I 
expect that if the dirty state isn't relevant to the merge, it wil just 
remain, with a message like

	xyzzy: needs update
	Merge made by recursive.

and then after the merge my changes to xyzzy are still there.

That doesn't seem to work any more. The merge is successful, but it also 
updated the working tree, overwriting my dirty state!

Appended is a test-script for this behaviour, and I get:

	Before merge:
	diff --git a/a b/a
	index e965047..eacb93d 100644
	--- a/a
	+++ b/a
	@@ -1 +1,2 @@
	 Hello
	+Hi there
	a: needs update
	Merge made by recursive.
	 b |    1 +
	 1 files changed, 1 insertions(+), 0 deletions(-)
	After merge:

with the afte-merge diff being empty.

		Linus

---
#!/bin/sh

rm -rf test-repo
mkdir test-repo
cd test-repo

git init
echo Hello > a
echo Hi > b
git add a b
git commit -m "Initial commit"

git checkout -b newbranch
echo Hullo >> b
git commit -m "Change b in 'newbranch'" b

git checkout master
echo New file > c
git add c
git commit -m "Add new file"

echo Hi there >> a
echo Before merge:
git diff
git pull . newbranch
echo After merge:
git diff
