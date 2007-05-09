From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 14:19:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091414280.4167@racer.site>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070509031803.GA27980@fieldses.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1775973206-1178713143=:4167"
Cc: junio@cox.net, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>, kha@treskal.com,
	barkalow@iabervon.org
X-From: git-owner@vger.kernel.org Wed May 09 14:19:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hll8L-0005QT-W8
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbXEIMTB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755932AbXEIMTB
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:19:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:59006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755604AbXEIMTA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:19:00 -0400
Received: (qmail invoked by alias); 09 May 2007 12:18:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 09 May 2007 14:18:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18csg4gOe8cfoFWM1rwotjhft6ZmboY5GEV/ksIEh
	jytKHhD6QCCl+k
X-X-Sender: gene099@racer.site
In-Reply-To: <20070509031803.GA27980@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46700>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1775973206-1178713143=:4167
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

for your reviewing pleasure, I made a patch on top of the original one, 
but I can easily provide a full patch for application.

--
[PATCH] user-manual: Touch ups on the birdview section

... as suggested by J. Bruce Fields, Karl Hasselström and Daniel Barkalow.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/user-manual.txt |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 2d58bb0..55934db 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3197,7 +3197,15 @@ basically _the_ header file which is included by _all_ of Git's C sources.
 If you grasp the ideas in that initial commit (it is really small and you 
 can get into it really fast, and it will help you recognize things in the 
 much larger code base we have now), you should go on skimming `cache.h`, 
-`object.h` and `commit.h`.
+`object.h` and `commit.h` in the current version.
+
+In the early days, Git (in the tradition of UNIX) was a bunch of programs 
+which were extremely simple, and which you used in scripts, piping the 
+output of one into another. This turned out to be good for initial 
+development, since it was easier to test new things.  However, recently 
+many of these parts have become builtins, and some of the core has been 
+"libified", i.e. put into libgit.a for performance, portability reasons, 
+and to avoid code duplication.
 
 By now, you know what the index is (and find the corresponding data 
 structures in `cache.h`), and that there are just a couple of object types 
@@ -3236,9 +3244,22 @@ options that were relevant for the different plumbing commands that were
 called by the script.
 
 Most of what `git-rev-list` did is contained in `revision.c` and 
-`revision.h`.  It wraps the options in a struct named rev_info, which 
+`revision.h`.  It wraps the options in a struct named `rev_info`, which 
 controls how and what revisions are walked, and more.
 
+The original job of `git-rev-parse` is now taken by the function 
+`setup_revisions()`, which parses the revisions and the common command line 
+options for the revision walker. This information is stored in the struct 
+`rev_info` for later consumption. You can do your own command line option
+parsing after calling `setup_revisions()`. After that, you have to call 
+`prepare_revision_walk()` for initialization, and then you can get the 
+commits one by one with the function `get_revision()`.
+
+If you are interested in more details of the revision walking process, 
+just have a look at the first implementation of `cmd_log()`; call
+`git-show v1.3.0~155^2~4` and scroll down to that function (note that you 
+no longer need to call `setup_pager()` directly).
+
 Nowadays, `git log` is a builtin, which means that it is _contained_ in the 
 command `git`.  The source side of a builtin is
 
@@ -3300,8 +3321,10 @@ Two things are interesting here:
 
 - the variable `sha1` in the function signature of `get_sha1()` is `unsigned 
   char *`, but is actually expected to be a pointer to `unsigned 
-  char[20]`.  This variable will contain the big endian version of the 
-  40-character hex string representation of the SHA-1.
+  char[20]`.  This variable will contain the 160-bit SHA-1 of the given 
+  commit.  Note that whenever a SHA-1 is passed as "unsigned char *", it 
+  is the binary representation (big-endian), as opposed to the ASCII 
+  representation in hex characters, which is passed as "char *".
 
 You will see both of these things throughout the code.
 
-- 
1.5.2.rc2.2502.g46b5cb


--8323584-1775973206-1178713143=:4167--
