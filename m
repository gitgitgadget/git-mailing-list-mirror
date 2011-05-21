From: Kazuki Tsujimoto <kazuki@callcc.net>
Subject: [BUG] realloc failed
Date: Sat, 21 May 2011 10:01:32 +0900
Message-ID: <20110521100126.E3CD.BA9123DE@callcc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 03:11:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNajK-0006vs-A4
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 03:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab1EUBKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 21:10:37 -0400
Received: from callcc.net ([173.230.149.188]:56191 "EHLO mx01.callcc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab1EUBKf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 21:10:35 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 May 2011 21:10:35 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx01.callcc.net (Postfix) with ESMTP id 2212E26B13
	for <git@vger.kernel.org>; Sat, 21 May 2011 10:01:32 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at callcc.net
Received: from mx01.callcc.net ([127.0.0.1])
	by localhost (mx01.callcc.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EZd6OGq4E4vJ for <git@vger.kernel.org>;
	Sat, 21 May 2011 10:01:31 +0900 (JST)
Received: from [192.168.0.128] (p6eb203.tkyoac00.ap.so-net.ne.jp [218.110.178.3])
	by mx01.callcc.net (Postfix) with ESMTPSA id A3A3426282
	for <git@vger.kernel.org>; Sat, 21 May 2011 10:01:30 +0900 (JST)
X-Mailer: Becky! ver. 2.56.04 [ja]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174085>

The following command causes "fatal: Out of memory, realloc failed" error.

$ ./git --version
git version 1.7.5.GIT

$ cat ~/.gitconfig
[alias]
    a = -c n=v status

$ MALLOC_CHECK_=0 ./git a
fatal: Out of memory, realloc failed

$ gdb --args ./git a
(gdb) run
*** glibc detected *** /tmp/git/git: realloc(): invalid pointer: 0x00000000007cd328 ***
...snip...
(gdb) bt
#0  0x00007ffff72c8a75 in raise () from /lib/libc.so.6
#1  0x00007ffff72cc5c0 in abort () from /lib/libc.so.6
#2  0x00007ffff73024fb in ?? () from /lib/libc.so.6
#3  0x00007ffff730c5b6 in ?? () from /lib/libc.so.6
#4  0x00007ffff73132e2 in realloc () from /lib/libc.so.6
#5  0x0000000000510bfb in xrealloc (ptr=0x7cd328, size=16) at wrapper.c:82
#6  0x0000000000405013 in handle_alias (argcp=0x7fffffffdfdc, argv=0x7fffffffdfd0) at git.c:236
#7  0x000000000040550a in run_argv (argcp=0x7fffffffdfdc, argv=0x7fffffffdfd0) at git.c:515
#8  0x000000000040566a in main (argc=1, argv=0x7fffffffe0f0) at git.c:579


When the "-c" option is specified, setenv will be called in git_config_push_parameter.
So it seems "envchanged" flag must be set to true in this case.

 git.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index a5ef3c6..e04e4d4 100644
--- a/git.c
+++ b/git.c
@@ -153,6 +153,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				usage(git_usage_string);
 			}
 			git_config_push_parameter((*argv)[1]);
+			if (envchanged)
+				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 		} else {

After applying this patch, it works.

$ ./git a
fatal: alias 'a' changes environment variables
You can use '!git' in the alias to do this.

$ vi ~/.gitconfig
[alias]
    a = !git -c n=v status
        ~~~~

$ ./git a
# On branch master
nothing to commit (working directory clean)

-- 
Kazuki Tsujimoto
