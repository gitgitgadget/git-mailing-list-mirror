From: Matthias Lederhofer <matled@gmx.net>
Subject: bugfix, rfc alias.foo = --git-dir /path/to/repo ...
Date: Thu, 12 Apr 2007 20:52:03 +0200
Message-ID: <20070412185203.GA28255@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 20:52:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc4PA-0004J8-Ny
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 20:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030736AbXDLSwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 14:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030751AbXDLSwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 14:52:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:37736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030736AbXDLSwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 14:52:07 -0400
Received: (qmail invoked by alias); 12 Apr 2007 18:52:05 -0000
Received: from pD9EBB89C.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.184.156]
  by mail.gmx.net (mp045) with SMTP; 12 Apr 2007 20:52:05 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX191O9gaePV1iyluMWndOlGsKmGhzCQCivtC5ULPmL
	E1Edg4BCENVKqc
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44347>

I found this while playing with alias.foo = --git-dir /path/to/repo
(looking for other problems):

    $ git foo
    *** glibc detected *** realloc(): invalid pointer: 0x0811d14c ***
    [1]    24815 abort      git foo

Patch for this problem is below.  Now that this is fixed the more
interesting thing is

    alias.foo = --git-dir /tmp/foo.git log
    alias.bar = --git-dir /tmp/foo.git status

The first one will use the current repository and the second one will
use /tmp/foo.git (because status is no built-in command).

Possible solutions:
(1) allow changing the repository path after reading the config
(2) deny the use of --git-dir in aliases
(3) reexec git for the alias instead of handling commands internally
    if --git-dir is used
I'm in favour of (3).

---
fix bug in handle_options

handle_options did not count the number of used arguments
correctly.  When --git-dir was used the extra argument was
not added to the number of handled arguments.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 git.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 33dd4d3..7def319 100644
--- a/git.c
+++ b/git.c
@@ -66,6 +66,7 @@ static int handle_options(const char*** argv, int* argc)
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
 			(*argv)++;
 			(*argc)--;
+			handled++;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 		} else if (!strcmp(cmd, "--bare")) {
-- 
1.5.1.1.81.g6aead-dirty
