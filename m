From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PULL] Pull request from msysGit
Date: Thu, 07 Oct 2010 18:17:57 +0100
Message-ID: <4CAE00C5.1050509@ramsay1.demon.co.uk>
References: <87ocb9zfbf.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, pharris@opentext.com,
	sschuberth@gmail.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 19:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3u7l-0000aY-4J
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 19:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab0JGRTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 13:19:10 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:62817 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542Ab0JGRTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 13:19:09 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1P3u7X-0004Lj-hl; Thu, 07 Oct 2010 17:19:08 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <87ocb9zfbf.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158409>

Pat Thoyts wrote:
> The following changes since commit 1e633418479926bc85ed21a4f91c845a3dd3ad66:
> 
>   Merge branch 'maint' (2010-09-30 14:59:53 -0700)
> 
> are available in the git repository at:
> 
>   git://repo.or.cz/git/mingw/4msysgit.git work/pt/for-junio
> or alternatively
>   http://repo.or.cz/w/git/mingw/4msysgit.git/shortlog/refs/heads/work/pt/for-junio
> 
> 5debf9a Add MinGW-specific execv() override.
> 77df1f1 Fix Windows-specific macro redefinition warning.
> b248e95 Fix 'clone' failure at DOS root directory.
> 1a40420 mingw: do not crash on open(NULL, ...)
> 5e9677c git-am: fix detection of absolute paths for windows
> 36e035f Side-step MSYS-specific path "corruption" leading to t5560 failure.
> ca02ad3 Side-step sed line-ending "corruption" leading to t6038 failure.
> 97f2c33 Skip 'git archive --remote' test on msysGit
> a94114a Do not strip CR when grepping HTTP headers.
> 3ba9ba8 Skip t1300.70 and 71 on msysGit.
> 4e57baf merge-octopus: Work around environment issue on Windows
> 442dada MinGW: Report errors when failing to launch the html browser.
> 9b9784c MinGW: fix stat() and lstat() implementations for handling symlinks
> 4091bfc MinGW: Add missing file mode bit defines

This commit (4091bfc) may well introduce logic errors into the msvc
build; I haven't checked (it depends on what the msvc compiler does
when a macro is redefined - does the new definition replace the old?).
However, no matter what else may be wrong, this commit introduces a
shed load of new warnings, thus:

    $ make clean
    $ make MSVC=1 >out 2>&1
    $ grep warning out | grep S_I | wc -l
    1000
    $ 

so 1000 additional warnings which, looking at the start of the out
file, look like this:

GIT_VERSION = 1.7.3.dirty
    * new build flags or prefix
    CC fast-import.o
fast-import.c
c:\cygwin\home\ramsay\git\compat/mingw.h(16) : warning C4005: 'S_IRUSR' : macro redefinition
        compat/vcbuild/include\unistd.h(85) : see previous definition of 'S_IRUSR'
c:\cygwin\home\ramsay\git\compat/mingw.h(17) : warning C4005: 'S_IWUSR' : macro redefinition
        compat/vcbuild/include\unistd.h(84) : see previous definition of 'S_IWUSR'
c:\cygwin\home\ramsay\git\compat/mingw.h(18) : warning C4005: 'S_IXUSR' : macro redefinition
        compat/vcbuild/include\unistd.h(83) : see previous definition of 'S_IXUSR'
c:\cygwin\home\ramsay\git\compat/mingw.h(19) : warning C4005: 'S_IRWXU' : macro redefinition
        compat/vcbuild/include\unistd.h(82) : see previous definition of 'S_IRWXU'

Now, Peter Harris has already submitted a fix for this, which is
currently on the work/msvc-fixes branch, which contains:

    358f1be Modify MSVC wrapper script
    38bd27d Fix MSVC build

The suggested fix is given in commit 38bd27d. However, I prefer a
different solution, which is given below:

--- >8 ---
diff --git a/compat/mingw.h b/compat/mingw.h
index afedf3a..445d1a1 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -12,12 +12,6 @@ typedef int pid_t;
 #define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
 #define S_ISSOCK(x) 0
 
-#ifndef _STAT_H_
-#define S_IRUSR 0
-#define S_IWUSR 0
-#define S_IXUSR 0
-#define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
-#endif
 #define S_IRGRP 0
 #define S_IWGRP 0
 #define S_IXGRP 0
--- 8< ---

Note that, for *both* MinGW and MSVC, the deleted #defines
are not wanted, pointless and just plain wrong! :-D

If you squash the above into 4091bfc then we find:

    $ make clean
    $ make MSVC=1 >out1 2>&1
    $ grep warning out1 | grep S_I | wc -l
    0
    $ 

and there is also no chance of introducing a logic error.

Although I'm not recommending you use one of the commits on
the work/msvc-fixes branch, can I request, once again, that
you include:

    358f1be Modify MSVC wrapper script

If it makes any difference, you can add:

    Acked-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

ATB,
Ramsay Jones
