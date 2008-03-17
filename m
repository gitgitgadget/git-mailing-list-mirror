From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Possible Solaris problem in 'checkout_entry()'
Date: Mon, 17 Mar 2008 08:07:14 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803170756390.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 16:09:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbGx6-0006IJ-9b
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbYCQPIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbYCQPIA
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:08:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59491 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751594AbYCQPH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2008 11:07:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2HF8NUL014053
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Mar 2008 08:08:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2HF7Etq017761;
	Mon, 17 Mar 2008 08:07:14 -0700
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.305 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77434>


I was looking at this due to the CE_UPDATE bug, and notice that we do

	if (!lstat(path, &st)) {

		... check if it's unchanged ..

		unlink(path);
		if (S_ISDIR(st.st_mode)) {
			..

and it hit me that didn't we have issues with Solaris allowing an 
"unlink()" to succeed on a directory when you are root, causing various 
problems later with lost inodes during fsck?

We fixed that in commit fa2e71c9e794c43634670b62d1b4bf58d1ae7e60 back last 
July, by avoiding to do the unlink() if it was already a directory in 
create_directories(). But it *looks* like the same problem exists if you 
use "git checkout -f" and have a directory where you expect a file.

I don't have any access to a Solaris box, nor do I want any, but this 
test-script (as root, remember) should show if this is a problem:

	mkdir repo
	cd repo
	git init
	echo "Testfile" > a
	git add a
	git commit -m "Initial commit"
	rm a
	mkdir a
	git checkout -f

where you probably need to then reboot and force a fsck to actually see if 
it caused problems.

Solaris is just totally incredible crap here, but maybe we should move the 
unlink to after that "if (S_ISDIR(..))" statement? And maybe somebody who 
has a Solaris support contract can try to kick some Sun *ss to get them to 
fix their crap?

			Linus
