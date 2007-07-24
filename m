From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 11:34:30 +0200
Message-ID: <200707241134.31950.robin.rosenberg.lists@dewire.com>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net> <200707241033.36509.robin.rosenberg.lists@dewire.com> <46A5BA87.50105@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:33:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGlh-0003r8-7F
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363AbXGXJdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756985AbXGXJdW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:33:22 -0400
Received: from [83.140.172.130] ([83.140.172.130]:8345 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbXGXJdV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 05:33:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F36338026EE;
	Tue, 24 Jul 2007 11:26:04 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25588-05; Tue, 24 Jul 2007 11:26:04 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 514138026C7;
	Tue, 24 Jul 2007 11:26:04 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46A5BA87.50105@fs.ei.tum.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53547>

tisdag 24 juli 2007 skrev Simon 'corecode' Schubert:
> Robin Rosenberg wrote:
> >>> Since the sleep is per invocation of cvsexportcommit it won't hurt
> >>> too much since it is rarely invoked on a huge number of git commits.
> >> The question also is, why does this happen on two sequential invocations 
> >> of cvsexportcommit, but not on two cvs commits done by cvsexportcommit?  
> >> This should look the same to cvs, no?  
> > 
> > I reread my post here... My last sentence was a comment to the patch
> > and not the sleep in CVS.
> 
> Yes, I realize this.  Still, I wonder the same:  why is this needed *per
> invocation of cvsexportcommit* and not *per invocation of cvs*?  Seems
> unintuitive to me, or I didn't read the patch good enough.  

Besides the potential update and status commands cvs is only invoked once per
invocation of cvsexportcommit so there is no difference between a sleep per CVS
invokation vs a sleep per cvsexportcommit invocation. The sleep is needed to make
sure file modification times resulting from git-apply are different. 

The sleep in CVS fixes that on my machine so I do not have a problem (and cannot 
really verify that the patch I made fixes the problem).

This debug patch reveals the sleep in CVS. CVS does the sleep differently for different platforms.

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 4efa0c9..9a1e998 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -153,7 +153,7 @@ test_expect_success \
       git commit -a -m "With spaces" &&
       id=$(git rev-list --max-count=1 HEAD) &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -c $id &&
+      strace -fF -o a git-cvsexportcommit -c $id &&
       test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" = "with spaces.png/1.1/-kb with spaces.txt/1.1/"
       )'
 
@@ -165,7 +165,7 @@ test_expect_success \
       git commit -a -m "Update with spaces" &&
       id=$(git rev-list --max-count=1 HEAD) &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -c $id
+      strace -fF -o b git-cvsexportcommit -c $id
       test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" = "with spaces.png/1.2/-kb with spaces.txt/1.2/"
       )'

Tail of the first cvsexportcommit invocation (trash/cvswork/a) from the place where it writes the last file
into the CVS repo.
 
27778 write(7, "/with spaces.png/1.1/Tue Jul 24 "..., 99) = 99
27778 close(7)                          = 0
27778 munmap(0xb7f15000, 4096)          = 0
27778 rename("CVS/Entries.Backup", "CVS/Entries") = 0
27778 unlink("CVS/Entries.Log")         = 0
27778 fchdir(6)                         = 0
27778 close(6)                          = 0
27778 rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
27778 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
27778 time(NULL)                        = 1185268822
27778 gettimeofday({1185268822, 953340}, NULL) = 0

Here CVS sleeps. The amount varies between invocations since it
only sleeps enough for the seconds to wrap.

27778 nanosleep({0, 46660000}, NULL)    = 0
27778 time(NULL)                        = 1185268823
27778 rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
27778 close(1 <unfinished ...>
27766 <... read resumed> "", 4096)      = 0
27778 <... close resumed> )             = 0
27766 close(6 <unfinished ...>
27778 munmap(0xb7f14000, 4096 <unfinished ...>
27766 <... close resumed> )             = 0
27778 <... munmap resumed> )            = 0

Back into git-cvsexportcommit
27766 rt_sigaction(SIGHUP, {SIG_IGN},  <unfinished ...>
27778 exit_group(0)                     = ?
27766 <... rt_sigaction resumed> {SIG_DFL}, 8) = 0
27766 --- SIGCHLD (Child exited) @ 0 (0) ---
27766 rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
27766 rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 8) = 0
27766 waitpid(27778, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 27778
27766 rt_sigaction(SIGHUP, {SIG_DFL}, NULL, 8) = 0
27766 rt_sigaction(SIGINT, {SIG_DFL}, NULL, 8) = 0
27766 rt_sigaction(SIGQUIT, {SIG_DFL}, NULL, 8) = 0
27766 unlink(".msg")                    = 0
27766 unlink(".cvsexportcommit.diff")   = 0
27766 stat64("/home/me/tmp/git-cvsapplycommit-55ADfh", {st_mode=S_IFDIR|0700, st_size=6, ...}) = 0
27766 lstat64("/home/me/tmp/git-cvsapplycommit-55ADfh", {st_mode=S_IFDIR|0700, st_size=6, ...}) = 0
27766 chmod("/home/me/tmp/git-cvsapplycommit-55ADfh", 0700) = 0
27766 open("/home/me/tmp/git-cvsapplycommit-55ADfh", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 6
27766 fstat64(6, {st_mode=S_IFDIR|0700, st_size=6, ...}) = 0
27766 fcntl64(6, F_SETFD, FD_CLOEXEC)   = 0
27766 getdents64(6, /* 2 entries */, 4096) = 48
27766 getdents64(6, /* 0 entries */, 4096) = 0
27766 close(6)                          = 0
27766 rmdir("/home/me/tmp/git-cvsapplycommit-55ADfh") = 0
27766 write(1, "/home/me/SW/GIT/t/trash/cvsroot/"..., 234) = 234
27766 exit_group(0)                     = ?

-- robin
