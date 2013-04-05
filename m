From: Mike Crowe <mac@mcrowe.com>
Subject: git diff --quiet on dirty tree sometimes erroneously exits with
 status 0
Date: Fri, 5 Apr 2013 12:09:00 +0100
Message-ID: <20130405110900.GA2446@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:49:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFL-0002u6-N4
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765107Ab3DELP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:15:29 -0400
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:62370 "EHLO
	smtpout.karoo.kcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab3DELP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:15:28 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Apr 2013 07:15:28 EDT
X-IronPort-AV: E=Sophos;i="4.87,413,1363132800"; 
   d="scan'208";a="7783144"
Received: from deneb.mcrowe.com ([82.152.148.4])
  by smtpout.karoo.kcom.com with ESMTP; 05 Apr 2013 12:09:00 +0100
Received: from mac by deneb.mcrowe.com with local (Exim 4.72)
	(envelope-from <mac@mcrowe.com>)
	id 1UO4Vw-0000ee-2f
	for git@vger.kernel.org; Fri, 05 Apr 2013 12:09:00 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220164>

I'm seeing a strange problem where "git diff --quiet" sometimes returns an
exit code of zero even though the tree is dirty and other invocations of
"git diff --quiet" in the same directory return an exit code of 1. I'm
using git v1.8.2 from Debian unstable but I've also seen the problem when
running v1.8.2 built from source and using older versions from Debian. The
repository in question is a submodule.

Unfortunately this bad behaviour only happens deep inside a variable
expansion under OpenEmbedded's bitbake so investigation is not
straightforward. It's possible that when the bad behaviour occurs other
"git diff" and similar informational commands are being run on the same
repository in parallel. I have been unable to provoke the problem by more
conventional means. :( I can reproduce it on a separate repository on the
same machine though.

Using "git diff --exit-code --no-ext-diff" instead seems to avoid the
problem but unfortunately so does adding a sleep before calling "git diff
--quiet" so that result isn't necessarily significant.

I have been able to strace the problematic case. Diffing the straces and
ignoring unrelated differences such as addresses yields  (+ =
diff returns 0, - = diff returns 1):

 [...lots of omitted stuff...]
 open("/home/mac/src/oe/sources/linux/.gitmodules", O_RDONLY) = -1 ENOENT
 (No such file or directory)
 access("/etc/gitconfig", R_OK)          = -1 ENOENT (No such file or
 directory)
 access("/home/mac/.config/git/config", R_OK) = -1 ENOENT (No such file or
 directory)
 access("/home/mac/.gitconfig", R_OK)    = 0
 open("/home/mac/.gitconfig", O_RDONLY)  = 20
 fstat(20, {st_mode=S_IFREG|0644, st_size=424, ...}) = 0
0x7f22bfa18000
 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7f79414f1000
 read(20, "[color]\n\tui = true\n[core]\n#\tpage"..., 4096) = 424
 read(20, "", 4096)                      = 0
 close(20)                               = 0
 munmap(0x7f79414f1000, 4096)            = 0
 access("/home/mac/src/oe/.git/modules/sources/linux/config", R_OK) = 0
 open("/home/mac/src/oe/.git/modules/sources/linux/config", O_RDONLY) = 20
 fstat(20, {st_mode=S_IFREG|0644, st_size=1467, ...}) = 0
 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7f79414f1000
 read(20, "[core]\n\trepositoryformatversion "..., 4096) = 1467
 read(20, "", 4096)                      = 0
 close(20)                               = 0
 munmap(0x7f79414f1000, 4096)            = 0
 chdir("/home/mac/src/oe/sources/linux") = 0
 lstat(".gitignore", {st_mode=S_IFREG|0644, st_size=955, ...}) = 0

At this point the diff that erroneously returned zero went off and did:

+lstat(".gitignore", {st_mode=S_IFREG|0644, st_size=955, ...}) = 0
+open("/home/mac/src/oe/.git/modules/sources/linux/objects/pack",
O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 20
+getdents(20, /* 4 entries */, 32768)    = 192
+access("/home/mac/src/oe/.git/modules/sources/linux/objects/pack/pack-2711d98bc06e8caa9c8d8e10ee40e645e6d05f18.keep",
F_OK) = -1 ENOENT (No such file or directory)
+stat("/home/mac/src/oe/.git/modules/sources/linux/objects/pack/pack-2711d98bc06e8caa9c8d8e10ee40e645e6d05f18.pack",
{st_mode=S_IFREG|0444, st_size=148768254, ...}) = 0
+getdents(20, /* 0 entries */, 32768)    = 0
+close(20)                               = 0

..and spent a while re-reading config files before continuing to recurse
over all the files but whilst the diff that provides the correct result
merely lstats each file this one reads them too:

 lstat("COPYING", {st_mode=S_IFREG|0644, st_size=18693, ...}) = 0
+open("COPYING", O_RDONLY)               = 21
+read(21, "\n   NOTE! This copyright does *n"..., 18693) = 18693
+close(21)                               = 0

When it comes across the repository file that has been changed the
behaviour of the invocation that provides the correct result is rather
different:

 lstat("drivers/net/bcmgenet/bcmgenet.c", {st_mode=S_IFREG|0644,
 st_size=114290, ...}) = 0
-lstat("drivers/net/bcmgenet/bcmgenet.c", {st_mode=S_IFREG|0644,
st_size=114290, ...}) = 0
-open("/home/mac/src/oe/.git/modules/sources/linux/objects/pack",
O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 20
-getdents(20, /* 4 entries */, 32768)    = 192
-access("/home/mac/src/oe/.git/modules/sources/linux/objects/pack/pack-2711d98bc06e8caa9c8d8e10ee40e645e6d05f18.keep",
F_OK) = -1 ENOENT (No such file or directory)
-stat("/home/mac/src/oe/.git/modules/sources/linux/objects/pack/pack-2711d98bc06e8caa9c8d8e10ee40e645e6d05f18.pack",
{st_mode=S_IFREG|0444, st_size=148768254, ...}) = 0
-getdents(20, /* 0 entries */, 32768)    = 0
-close(20)                               = 0
-open("/home/mac/src/oe/.git/modules/sources/linux/objects/info/alternates",
O_RDONLY|O_NOATIME) = -1 ENOENT (No such file or directory)
-open("/home/mac/src/oe/.git/modules/sources/linux/objects/pack/pack-2711d98bc06e8caa9c8d8e10ee40e645e6d05f18.idx",
O_RDONLY|O_NOATIME) = 20
-fstat(20, {st_mode=S_IFREG|0444, st_size=1945504, ...}) = 0
-mmap(NULL, 1945504, PROT_READ, MAP_PRIVATE, 20, 0) = 0x7f22bea11000
-close(20)                               = 0
-getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=4*1024}) = 0
-open("/home/mac/src/oe/.git/modules/sources/linux/objects/pack/pack-2711d98bc06e8caa9c8d8e10ee40e645e6d05f18.pack",
O_RDONLY|O_NOATIME) = 20
-fstat(20, {st_mode=S_IFREG|0444, st_size=148768254, ...}) = 0
-fcntl(20, F_GETFD)                      = 0
-fcntl(20, F_SETFD, FD_CLOEXEC)          = 0
-read(20, "PACK\0\0\0\2\0\1\17D", 12)    = 12
-lseek(20, 148768234, SEEK_SET)          = 148768234
-read(20, "\226~C\235\340\255\221\354e't>\325p\340M\307\314j@", 20) = 20
-mmap(NULL, 148768254, PROT_READ, MAP_PRIVATE, 20, 0) = 0x7f22b5c30000

and at that point the diff that provides the correct exit status basically
gives up since it has found a change. The diff that provides the incorrect
exit status _does_not_ read this file that has changed and any other files
that have changed even though it reads all the unchanged files.

At the end the diff that provides the incorrect exit status appears to
rewrite the index and then:

+rename("/home/mac/src/oe/.git/modules/sources/linux/index.lock",
"/home/mac/src/oe/.git/modules/sources/linux/index") = 0
+fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 8), ...}) = 0
+close(1)                                = 0
+exit_group(0)                           = ?

I'm afraid that I don't know enough about Git's internals to understand why
it decided to look at the pack files and rebuild the index but it seems
that if this happens the exit status is correct. :(

(Full straces available on request by private email if required.)

Mike.
