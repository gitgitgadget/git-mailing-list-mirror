From: Eric Blake <ebb9@byu.net>
Subject: [PATCH] Makefile: building git in cygwin 1.7.0
Date: Fri, 15 Aug 2008 15:01:03 +0000 (UTC)
Message-ID: <loom.20080815T143926-715@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 17:02:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0op-0001V4-IB
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 17:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757697AbYHOPBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 11:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757505AbYHOPBS
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 11:01:18 -0400
Received: from main.gmane.org ([80.91.229.2]:50317 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757330AbYHOPBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 11:01:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KU0nf-0004uU-Ls
	for git@vger.kernel.org; Fri, 15 Aug 2008 15:01:12 +0000
Received: from eblake.csw.l-3com.com ([eblake.csw.l-3com.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 15:01:11 +0000
Received: from ebb9 by eblake.csw.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 15:01:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.124 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92483>

On platforms with $X, make removes any leftover scripts 'a' from
earlier builds if a new binary 'a.exe' is now built.  However, on
cygwin 1.7.0, 'git' and 'git.exe' now consistently name the same file.
Test for file equality before attempting a remove, in order to avoid
nuking just-built binaries.

Signed-off-by: Eric Blake <ebb9@byu.net>
---

On cygwin 1.5.x, a script 'a' and binary 'a.exe' could co-exist in the same 
directory, and exec'ing 'a' tended to favor the script over the binary - 
problematic for the case where incremental building in an existing git checkout 
picks up a switch from a script to a builtin.  Likewise, 'rm -f a' refused to 
remove 'a.exe', so it was a no-op if there was no script 'a', hence the 
addition of a $X-specific rule to nuke those stale scripts.

But the .exe handling will change in cygwin 1.7.0 (to be released later this 
year), where it is much harder to create 'a' and 'a.exe' as distinct files ('a' 
is automatically removed if 'a.exe' is created); and 'rm -f a' now succeeds at 
removing 'a.exe' if there is no 'a'.  But this means Makefile's $X-specific 
rule to kill old scripts now nukes the just built binary files:

$ make
...
    BUILTIN git-status.exe
    BUILTIN git-whatchanged.exe
rm -f 'git-fast-import';  ... rm -f 'git-status';  rm -f 'git-whatchanged';  
rm -f 'git';
    SUBDIR git-gui
...
$ ls git
ls: cannot access git: No such file or directory

and all the hard work of building is lost, on every attempt to build.  All 
platforms that have $X should have a test(1) that understands -ef.


 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index fcff2a4..ca418fc 100644
--- a/Makefile
+++ b/Makefile
@@ -1071,7 +1071,7 @@ SHELL = $(SHELL_PATH)
 
 all:: shell_compatibility_test $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS) 
GIT-BUILD-OPTIONS
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) 
git$X)), $(RM) '$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) 
git$X)), test '$p' -ef '$p$X' || $(RM) '$p';)
 endif
 
 all::
-- 
1.5.6.4
