From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: MinGW merge plans, was Re: [PATCH 1/2] Introduces xmkstemp()
Date: Fri, 31 Aug 2007 13:03:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708311123140.28586@racer.site>
References: <20070814164453.400b9c55@localhost> <46D7D0F7.1050302@trolltech.com>
 <46D7D284.30004@telecom.at> <46D7D48D.6000503@trolltech.com>
 <46D7D60C.8090608@telecom.at> <46D7D8A4.1060800@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@telecom.at>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 14:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR5ER-0004n6-Cu
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 14:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbXHaMD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 08:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbXHaMD5
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 08:03:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:43388 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932651AbXHaMD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 08:03:56 -0400
Received: (qmail invoked by alias); 31 Aug 2007 12:03:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 31 Aug 2007 14:03:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zbd4MXNrzqaKfQGNA9kUMC2o79E8W2tHaT7VHw3
	quAXyHckApiBoo
X-X-Sender: gene099@racer.site
In-Reply-To: <46D7D8A4.1060800@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57163>

Hi,

On Fri, 31 Aug 2007, Marius Storm-Olsen wrote:

> We really need to streamline the patches needed for MinGW, and get those 
> merged into upstream when 1.5.3 is released.

Okay, with 1.5.3 just about to break free, I think we can think about what 
to do to flood the mailing list with MinGW compatibility patches.

So I went through the diff between mingw.git and git.git (I did not use 
4msysgit.git as a reference yet).  There are many, many changes that are 
not really dependent on each other, so many, many people can participate 
;-)  (And of course, development on mingw.git and/or 4msysgit.git will not 
stall through that time.)

AFAICS these are the topics that need to be whipped into shape as 
individual patch series:

- NO_ST_BLOCKS (struct stat has no "blocks" member on MinGW)

- handle_line() in fmt-merge-msg.c should handle CRLF, too.  Maybe this 
  does not need to be special cased for MinGW at all.

- we have a special handling for relative template paths in MinGW.  I am 
  not sure if we need it any more.

- struct lock_file needs an "fd" member (assigned in lock_file()) so it 
  can close the fd before renaming in remove_lock_file(), 
  commit_lock_file() and commit_locked_index(), since Windows
  does not allow renaming of a still open file.  This does not need to be 
  special cased for MinGW IMHO.

- is_absolute_path() needs to be aware of <DRIVE>:/.  We should probably 
  do this for Windows in general, not just MinGW (as pointed out by Robin 
  in a recent mail, Cygwin suffers from this, too)

- For some reason, we use "/usr/bin/sort" instead of "sort" in 
  check-builtins.h, generate-cmdlist.sh, git-ls-remote.sh, 
  git-mergetool.sh and some tests.  It should be checked if this is still 
  necessary (AFAIR it was some Vista fsckup)

- A similar issue is /usr/bin/find in git-clone.sh, git-ls-remote.sh, 
  git-repack.sh, and some tests.

- fnmatch.[ch] were added to compat/.  IIRC these were "borrowed" from 
  GNU libc.

- A lot of functions were added to compat/mingw.c; someone should check 
  which are still needed, and which still need implementation (some 
  functions just return an error)

- regex.[ch] were added to compat/.  These were "borrowed" from GNU regex.

- We have git_etc_config() instead of ETC_GITCONFIG.  Probably this should 
  be changed to "#define ETC_GITCONFIG git_etc_config()" for MinGW only.  
  (AFAIR this is a workaround for setenv() on MinGW refreshing _all_ 
  environment variables, invalidating the previous getenv()ed addresses.

- Hannes implemented a spawn-pipe.h interface, to replace the fork() in 
  git_connect(), spawn_prog(), get_pack().  This is probably the most 
  difficult part to merge into git.git.  I am not clear about how much of 
  this should be moved into run-command.h instead, for example.

- We have a cpio "emulator" script, since MinGW lacks this tool.

- gettimeofday() in compat/mingw.c needs my_mktime() from date.c to be 
  public.  I did not form an opinion yet if compat/mingw.c should be 
  introduced in one go, or in incremental steps, implementing one function 
  at a time.

- In exec_cmd.c, we introduced a _function_ builtin_exec_path() to allow 
  determining the path from the executable name.  This is needed when 
  calling the git programs from cmd.exe, _without_ going through sh first.  
  IMHO this is wrong, since those programs can no longer call shell 
  scripts, as needed e.g. in hooks, merge drivers or git-gc.  So we 
  probably should get rid of this part (but I imagine before this, there 
  will be a fierce discussion about that), and force going through 
  /bin/sh.

- Many places do not call is_absolute_path() (because it was not there 
  earlier).  These have to be replaced.  (This patch is orthogonal to 
  MinGW.)

- We have a spawnv_git_cmd(), which is probably a duplication of the 
  run-command.h API.  We should get rid of that function, and adjust the 
  existing API if necessary.

- For some reason, support for side-band-64k and side-band is commented 
  out for MinGW.  Find out the reasoning, and if it still holds true, 
  introduce NO_SIDE_BAND into the Makefile and fetch-pack.c.

- In git-clone, we call "pwd -W" (which is utterly unportable...).  Find 
  out if it is still necessary.

- In git-compat-util.h, quite a bunch of header files have to be guarded 
  between #ifndef __MINGW32__ ... #endif.

- A bunch of #defines are in git-compat-util.h, which would have been 
  defined in the headers that do not exist on MinGW.  These should go into 
  an #else clause, and it should be documented which header would have had 
  those definitions.

- There are a couple of workarounds in git-compat-util.h, like a mkdir() 
  replacement which takes an "int mode" parameter, so that we do not need 
  a dozen special cases scattered throughout the source code (MinGW's 
  mkdir() does not take a "mode" parameter, since MSCRT's mkdir() doesn't)

- We have no "sync" on MinGW, and in git-repack.sh, this is worked around 
  by "sync 2> /dev/null".  This should be changed to something like

	test ! -z "@@NO_SYNC@@" || sync

- In prepend_to_path(), we need to replace the PATH delimiter ":" by ";"

- In run_command(), we return "status & 0xff", because Windows' version of 
  exit() apparently replaces all values outside of 0-0xff with 0!  We 
  probably need this in handle_internal_command(), too.

- In handle_internal_command(), we need to strip the extension ".exe".  
  This is done by defining STRIP_EXTENSION to ".exe" in the Makefile.

- In git.c's main(), we check for "\\" in addition to "/".  This is 
  probably not the only place needing this...  (For example, in setup.c we 
  roll an own version of it, limited to setup.c, which is bad.)

- In gitk, we still delete ~/.gitk everytime.  Check if this is still 
  necessary.

- help.c #includes <sys/ioctl.h>.  Why?

- We have NO_ETC_PASSWD, but this is a misnomer.  It would be more 
  appropriately named NEEDS_GECOS, and there should be a replacement 
  function "getpwuid()" in compat/mingw.c, which calls NetUserGetInfo()
  and fills a (custom) struct passwd.  The changes in ident.c and path.c
  should be undone.

- We have special pager handling in pager.c

- In path.c, we fall back to TMP or TEMP when TMPDIR is not set.  Since I 
  propose to always run in a shell, I am torn if we should keep this code.

- For some reason or other, we need some changes in perl/Makefile.

- We have special progress handling in progress.c

- In refs.c, we catch an erroneous errno (open can return EACCES when 
  EISDIR would be appropriate).  IMHO this should go into 
  git-compat-util.h, where the #define'd open() should be replaced by a 
  git_open() thing a la git_mkdir().

- In prefix_path(), we replace all "\\" to "/" in the path name.

- In prefix_path(), there is an #ifndef __MINGW32__, where the #else 
  clause uses is_absolute_path().  IMHO this is wrong, do not special case 
  that for MinGW.

- In setup_git_directory_gently(), there is special code for absolute 
  paths of the form <DRIVE>:/bla.  IMHO this should be changed so that 
  such paths are converted to /<DRIVE>/bla first.

- In sha1_file.c, we have yet another is_path_absolute() implementation.  
  Use is_absolute_path() here instead.

- In sha1_file.c, some fcntl()s are guarded (IIRC since MinGW does not 
  have fcntl() at all).  Make this a NO_FCNTL Makefile variable.

- Plenty of tests have to be adjusted for the fact that there are no 
  symlinks in MinGW.  This probably benefits from the recent addition of a 
  test for symlinks in git-init... (Needs adjusting, though, e.g. in 
  test-lib.sh).

- t0001 uses "pwd -W".

- t1002 implements a "sum" function if it was not found (this 
  is a patch which is independent of MinGW).

- t1003, t4109 and t4110 implement cmp via git diff.  Maybe change them 
  over to git diff?

- t1301 skips some tests.  Look into that.

- t3100 uses "diff" instead of "git diff".  Why?

- t3402m t3404, t4116 and t6200 sleep 1 second.  Probably because of 
  some file date granularity thing.

- t3404 replaces HEAD^ by HEAD~1, and something weird seems to happen 
  with "@" in the command line, when passed to scripts.

- t3800 replaces one egrep with grep, because egrep is not available.  
  IMHO egrep should not be used in git anyway.

- t3901 skips iconv tests (in msysgit, we recently added iconv, so this 
  might be worth fixing in MinGW).

- t3902 tests if funny filenames are allowed on the current filesystem 
  anyway.  If not, the tests are skipped.

- t5300 works around the lack of /dev/zero.  It also splits a big test 
  case into nice mouthfuls.

- t5301 works around the lack of /dev/random.

- t5302 just skips a few tests without a comment.  Find out why.

- t5502 works around a missing "git remote" (probably because we did not 
  have perl scripts running for quite some time).  Probably unnecessary.

- t5515 escapes curly brackets, but since git-tag is no longer a shell 
  script, this should not be necessary.

- t7500 is skipped.  Find out why "vi is not cooperating".

- t7501 uses an unportable "sed -i".  (Should be fixed in git.git anyway.)

- t7501 also skips tests without explanation.  Fix.

- t9001 says it cannot invoke fake.sendmail.  Fix.

- We have a NOEXECTEMPL to make up for the lack of chmod a+x in MinGW 
  (scripts are executable if and only if the first line starts with a #!). 
  Rename this to NOEXEC_SUFFIX.

- upload-pack.c works around the only fork() that does not exec() in 
  git.git, by defining a function and spawning a thread.  We should get 
  rid of all fork() calls outside run-command.c, and have something like 
  BEGINTHREAD=_beginthread in the Makefile.  This is a little involved.

- maybe_flush_or_die() special cases MinGW for returning EINVAL from 
  fflush() sometimes.  Either change this to _always_ check for EINVAL, or 
  do the git_fflush() trick in git-compat-util.h to replace errno with 
  EPIPE when it was set to EINVAL by fflush().

- imap-send is not built.

- convert-objects still is not built.  I think it is that date function 
  which we could replace by some call to date.c.

Phew.

Ciao,
Dscho
