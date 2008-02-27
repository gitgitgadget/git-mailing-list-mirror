From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 00/40] MinGW port
Date: Wed, 27 Feb 2008 19:54:23 +0100
Message-ID: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 19:56:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURRV-0000Km-MG
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbYB0SzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755670AbYB0SzM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:12 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40411 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbYB0SzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:06 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 0A5B69725F;
	Wed, 27 Feb 2008 19:55:04 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75250>

So here it is, the MinGW port of git.
This series is also available from

git://repo.or.cz/git/mingw/j6t.git upstream
http://repo.or.cz/w/git/mingw/j6t.git?a=shortlog;h=upstream

Junio, please do *not* pull/apply this series into your tree(s) until we
have verified that forks on repo.or.cz do not lose objects anymore when
branches are rewound.


What this series achieves:

- An almost complete set of git tools running natively on Windows.

- Functional git-gui and gitk.


What is missing:

- perl scripts don't work. We have a hack in the port tree, but I haven't
  yet taken the time to clean it up enough.

- The test suite does not pass because of missing features like symbolic
  links. Again we have adjusted the tests in the port tree so that the
  test suite can be completed unattended.


I've arranged the patches in a few subsets. They are different from what
Dscho had proposed some weeks ago when I announced the series for the
first time because I felt this topical partitioning makes more sense.


* Part 1: Get it going
01/40 Add compat/regex.[ch] and compat/fnmatch.[ch].
02/40 Compile some programs only conditionally.
03/40 Add target architecture MinGW.

With these patches we have a working git.exe that can successfully run
those builtins that need only read-access of the repository, like
git log, git diff, etc.

 7 files changed, 6222 insertions(+), 5 deletions(-)


* Part 2: Working locally is possible
04/40 Windows: Use the Windows style PATH separator ';'.
05/40 Windows: Strip ".exe" from the program name.
06/40 Windows: Implement a wrapper of the open() function.
07/40 Windows: A minimal implemention of getpwuid().
08/40 Windows: always chmod(, 0666) before unlink().
09/40 Windows: Work around misbehaved rename().
10/40 Windows: Treat Windows style path names.
11/40 Windows: Handle absolute paths in safe_create_leading_directories().
12/40 Windows: Implement gettimeofday().
13/40 Windows: Fix PRIuMAX definition.
14/40 Windows: Implement setitimer() and sigaction().
15/40 Windows: A work-around for a misbehaved vsnprintf.

Now builtins that write to the repository work as long as they don't need
to spawn secondary processes.

 10 files changed, 347 insertions(+), 20 deletions(-)


* Part 3: Shell scripts and start_command()
16/40 Windows: Wrap execve so that shell scripts can be invoked.
17/40 Windows: A pipe() replacement whose ends are not inherited to children.
18/40 Windows: Implement start_command().
19/40 Windows: Change the name of hook scripts to make them not executable.

Now scripted tools and the builtins and standalone programs work that
depend on start_command().

 5 files changed, 391 insertions(+), 16 deletions(-)


* Part 4: Remote connections
20/40 Windows: A rudimentary poll() emulation.
21/40 Windows: Disambiguate DOS style paths from SSH URLs.
22/40 Windows: Implement asynchronous functions as threads.
23/40 Windows: Local clone must use the drive letter in absolute paths.
24/40 Windows: Work around incompatible sort and find.
25/40 Windows: Implement a cpio emulation in git-clone.sh.
26/40 Windows: Implement wrappers for gethostbyname(), socket(), and connect().

Remote connections, both push and fetch, using local transport as well as
connections via ssh and native git protocol work.

 9 files changed, 233 insertions(+), 3 deletions(-)


* Part 5: Optimizations
27/40 Windows: Implement a custom spawnve().
28/40 Windows: Add a new lstat and fstat implementation based on Win32 API.
29/40 Windows: Use a customized struct stat that also has the st_blocks member.

 3 files changed, 370 insertions(+), 10 deletions(-)


* Part 6: Tie up loose ends
30/40 Turn builtin_exec_path into a function.
31/40 Compute the ultimate fallback for exec_path from the program invocation.
32/40 Windows: Use a relative default template_dir and ETC_GITCONFIG
33/40 When installing, be prepared that template_dir may be relative.
34/40 Windows: Make the pager work.
35/40 Windows: Work around an oddity when a pipe with no reader is written to.
36/40 Avoid the "dup dance" in wt_status_print_verbose() when possible.
37/40 Windows: Make 'git help -a' work.
38/40 Windows: TMP and TEMP environment variables specify a temporary directory.
39/40 Windows: Fix ntohl() related warnings about printf formatting
40/40 compat/pread.c: Add foward decl to fix warning

This fixes some final remaining oddities, minor missing features, and
works around differences between POSIX and Windows.

 11 files changed, 154 insertions(+), 21 deletions(-)


* Diffstat excluding 01/40 (which adds 5989 lines)

 Documentation/git.txt |    6 +-
 Makefile              |   48 +++-
 cache.h               |    4 +
 compat/mingw.c        | 1018 +++++++++++++++++++++++++++++++++++++++++++++++++
 connect.c             |    8 +-
 date.c                |    2 +-
 exec_cmd.c            |   43 ++-
 git-clone.sh          |   52 +++-
 git-compat-util.h     |  221 +++++++++++-
 git-sh-setup.sh       |   17 +
 git.c                 |   14 +
 gitk-git/Makefile     |    4 +
 gitk-git/gitk         |    1 +
 help.c                |   38 ++-
 pager.c               |   40 ++-
 path.c                |    7 +
 run-command.c         |  118 ++++++-
 run-command.h         |    5 +
 setup.c               |   59 +++-
 sha1_file.c           |   18 +-
 t/test-lib.sh         |   13 +
 templates/Makefile    |   16 +-
 upload-pack.c         |    2 +
 write_or_die.c        |    7 +-
 wt-status.c           |   12 +-
 25 files changed, 1713 insertions(+), 60 deletions(-)

-- Hannes
