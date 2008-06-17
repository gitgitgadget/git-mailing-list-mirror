From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: 'setup_work_tree()' considered harmful
Date: Mon, 16 Jun 2008 17:45:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806161723081.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 02:46:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8PLH-0003xl-W5
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 02:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbYFQApk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 20:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYFQApk
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 20:45:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50423 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750956AbYFQApj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2008 20:45:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5H0jRiR019381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jun 2008 17:45:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5H0jPqn022276;
	Mon, 16 Jun 2008 17:45:26 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.36 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85251>


[ Dscho cc'd because I think he is the primary culprits for this thing, I 
  think. Commit e90fdc39b6903502192b2dd11e5503cea721a1ad in particular, 
  methinks. ]

So because I was looking at system call traces for object creation (due to 
those "rename to the final resting place" patches I did that got merged 
recently), I've noticed that some commands have *much* worse system call 
patterns than others.

In particular, doing a "git add ." will use absolute pathnames for all git 
files, while a "git diff" will not. And this is quite noticeable - the 
absolute pathnames are not just longer, they have more path components in 
them. Making them a lot slower to look up and use.

Of course, "a lot" depends on things a bit, but it really is noticeable.

To test, I created a kernel tree (no .git), and did a "git init" followed 
by a "git add .". Here's the timings for current git head:

	[torvalds@woody kernel]$ time git add .

	real    0m8.377s
	user    0m6.556s
	sys     0m1.656s

After that, I fixed "write_loose_object()" to not unnecessarily try to 
open a git object file, because every single caller has already done a 
"has_sha1_file(sha1)" or "has_loose_object(sha1)" check before calling 
that function, so trying to open it again is just pointless.

As a result, git add sped up a tiny bit:

	[torvalds@woody kernel]$ time ~/git/git-add .

	real    0m8.341s
	user    0m6.588s
	sys     0m1.548s

but I'll admit that it's not exactly noticeable. Half a percentage point 
is not a big deal.

Then I created a hack that just made "setup_work_tree()" a no-op (because 
it does all that crazy stuff that forces GIT_DIR to be an absolute path 
etc). As a result I got:

	[torvalds@woody kernel]$ time ~/git/git-add .

	real    0m7.849s
	user    0m6.420s
	sys     0m1.296s

ie now we're talking about a 5%+ performance difference.

Of course, this is all for the hot-cache case, and it wouldn't be 
noticeable for a cold-cache case, but it really can be a real performance 
issue. And no, it's not that "setup_work_tree()" itself is expensive, but 
depending on how GIT_DIR is set up, you get very different system call 
patterns.

Here's what current git does for one file (sound/usb/usbmixer_maps.c):

	lstat("sound/usb/usbmixer_maps.c", {st_mode=S_IFREG|0664, st_size=10230, ...}) = 0
	open("sound/usb/usbmixer_maps.c", O_RDONLY) = 4
	mmap(NULL, 10230, PROT_READ, MAP_PRIVATE, 4, 0) = 0x7fa247228000
	close(4)                                = 0
	access("/home/torvalds/kernel/.git/objects/d7/55be0ad8115da5c1296211678f81a7774277d5", F_OK) = -1 ENOENT (No such file or directory)
	open("/home/torvalds/kernel/.git/objects/d7/55be0ad8115da5c1296211678f81a7774277d5", O_RDONLY) = -1 ENOENT (No such file or directory)
	open("/home/torvalds/kernel/.git/objects/d7/tmp_obj_55be0ad8115da5c12962116_vDqXRl", O_RDWR|O_CREAT|O_EXCL, 0600) = 4
	write(4, "x\1\315ZmS\333H\22\276\257\370W\364\361\t\210\1K\206$\300.\273\6\314\306\273@(l\'"..., 3402) = 3402
	fchmod(4, 0444)                         = 0
	close(4)                                = 0
	link("/home/torvalds/kernel/.git/objects/d7/tmp_obj_55be0ad8115da5c12962116_vDqXRl", "/home/torvalds/kernel/.git/objects/d7/55be0ad8115da5c1296211678f81a7774277d5") = 0
	unlink("/home/torvalds/kernel/.git/objects/d7/tmp_obj_55be0ad8115da5c12962116_vDqXRl") = 0
	munmap(0x7fa247228000, 10230)           = 0

and here is the fixed version:

	lstat("sound/usb/usbmixer_maps.c", {st_mode=S_IFREG|0664, st_size=10230, ...}) = 0
	open("sound/usb/usbmixer_maps.c", O_RDONLY) = 4
	mmap(NULL, 10230, PROT_READ, MAP_PRIVATE, 4, 0) = 0x7f54c231a000
	close(4)                                = 0
	access(".git/objects/d7/55be0ad8115da5c1296211678f81a7774277d5", F_OK) = -1 ENOENT (No such file or directory)
	open(".git/objects/d7/tmp_obj_55be0ad8115da5c12962116_fKy6px", O_RDWR|O_CREAT|O_EXCL, 0600) = 4
	write(4, "x\1\315ZmS\333H\22\276\257\370W\364\361\t\210\1K\206$\300.\273\6\314\306\273@(l\'"..., 3402) = 3402
	fchmod(4, 0444)                         = 0
	close(4)                                = 0
	link(".git/objects/d7/tmp_obj_55be0ad8115da5c12962116_fKy6px", ".git/objects/d7/55be0ad8115da5c1296211678f81a7774277d5") = 0
	unlink(".git/objects/d7/tmp_obj_55be0ad8115da5c12962116_fKy6px") = 0
	munmap(0x7f54c231a000, 10230)           = 0

ie note how it does one unnecessary "open()" less, but more importantly, 
notice the difference between "/home/torvalds/kernel/.git/*" and ".git/*", 
and realize that that second difference was the much more noticeable one.

And no, obviously the right fix is not to just comment out all of 
"setup_work_tree()" (it will break stuff that depends on GIT_WORKTREE), 
but I did that as a minimal example of showing what the bad effect of that 
function is.

In general, I think we've gone in the wrong direction with a lot of the 
"make_absolute_path" stuff. See above. 5% performance loss is not good.

		Linus
