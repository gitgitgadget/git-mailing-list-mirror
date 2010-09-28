From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Tue, 28 Sep 2010 22:52:25 +0200
Message-ID: <201009282252.25688.j6t@kdbg.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 22:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hAD-0000Bu-HY
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 22:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab0I1Uwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 16:52:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:57312 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab0I1Uwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 16:52:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 40A14A7EE9;
	Tue, 28 Sep 2010 22:52:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id F2D4719F5C4;
	Tue, 28 Sep 2010 22:52:25 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <87ocbitd33.fsf@fox.patthoyts.tk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157469>

On Dienstag, 28. September 2010, Pat Thoyts wrote:
> Junio,
>
> The msysGit tree currently tracks some 50+ patches on top of 'next'. I
> have gathered 42 of these that look good to move upstream.
> Please pull from
>   git://repo.or.cz/git/mingw/4msysgit.git work/pt/for-junio
> also visible for inspection at
>  
> http://repo.or.cz/w/git/mingw/4msysgit.git/shortlog/refs/heads/work/pt/for-
>junio

Thanks for picking up the baton.

I've browsed through the list, and I'll annotate my opinion below. When I 
say 'OK', then this means that the patch looks good, but it doesn't imply 
that I have tested it.

> Eric Sunshine (6):
>       Fix 'clone' failure at DOS root directory.
>       Fix Windows-specific macro redefinition warning.
>       Add MinGW-specific execv() override.
>       Side-step MSYS-specific path "corruption" leading to t5560 failure.
>       Side-step sed line-ending "corruption" leading to t6038 failure.

These 5 are OK.

>       Side-step line-ending corruption leading to t3032 failures.

This one has non-portable 'export foo=bar', but it is in a MinGW specific 
path, so it should be fine. But why do we need to export GREP_OPTIONS, but 
not SED_OPTIONS?

> Erik Faye-Lund (6):
>       core.hidedotfiles: hide '.git' dir by default

This one was heavily disputed. Contrary to the subject line, the patch hides 
not only .git, but all dot-files. I'm not exactly a friend of this behavior. 
To hide only .git is OK, but every dot-file? The default setting of 
core.hidedotfiles should be different, IMO.

The subject line must be fixed, and unlike Erik's claim in a post earlier this 
week on the msysgit list, mingw_freopen blows up if filename ever happens to 
be NULL when core.hidedotfiles is true.

>       mingw: do not hide bare repositories

OK if it is decided that the above goes in; but could also be squashed.

>       mingw: fix st_mode for symlink dirs

This is a fix of Pat's "fix mingw stat...for handling symlinks" and should be 
squashed into that one.

>       send-email: accept absolute path even on Windows

I'm neutral. I don't use send-email.

>       config.c: trivial fix for compile-time warning

This is a fix for Dscho's getenv("HOME") patch and must be squashed - 
otherwise the commit message references a non-existent commit.

>       mingw: do not crash on open(NULL, ...)

This one is bogus, and as it stands, it must have my Ack removed. :) Needs the 
same fix in mingw_fopen as mingw_freopen. (There remains an unprotected 
dereference of filename.)

> Heiko Voigt (4):
>       mingw: move unlink wrapper to mingw.c

OK, whether or not the next patch goes in.

>       mingw: work around irregular failures of unlink on windows

The workaround is to retry the unlink() after a delay when it failed with 
EACCES. What happens if the EACCES is for a good reason? Doesn't this delay 
the process by 71ms per unlink() invocation? Can't this become a problem if 
many unlink()s are tried by git code?

>       mingw: make failures to unlink or move raise a question

Gaah! But people seem to like it. Since the question is only triggered after 
all retries fail, I can live with this.

But isn't the implementation a bit sloppy? Can strlen(answer)-2 be negative? 
What happens if the user typed more than 4 characters? Wouldn't it leave data 
in the buffer for the next question?

>       mingw: add fallback for rmdir in case directory is in use

Depends on the previous patch. OK.

> Johannes Schindelin (11):
>       Avoid TAGS/tags warning from GNU Make

OK.

>       When initializing .git/, record the current setting of
> core.hideDotFiles

I'm neutral on this one. The commit message does not say why the change is 
needed.

>       git-am: fix absolute path logic on Windows 

This mistakes a file that has a colon in the second position as absolute, even 
on non-Windows. IIUC, this patch is not intended for upstream git.

>       mingw_rmdir: set errno=ENOTEMPTY when appropriate

OK. Good catch!

>       Add a Windows-specific fallback to getenv("HOME");

Introduces get_home_directory(). I'm a bit worried that it leaks the string 
that it constructed.

>       Tests: make sure that $DIFF is non-empty

Hasn't this been fixed in upstream already?

>       merge-octopus: Work around environment issue on Windows

This works around MSYS DLL's "feature" to uppercase all environment variables. 
This destroys the original names GITHEAD_$SHA1.

There is a small typo in the second range argument of the tr invocation: it 
should be: tr a-z A-Z

>       Make sure that git_getpass() never returns NULL

This is not Windows specific. OK.

>       Give commit message reencoding for output on MinGW a chance

This is a change in log-tree.c, but has an effect only on Windows. OK.

>       Fix typo in pack-objects' usage

OK.

>       Fix compile error on MinGW

This has been fixed in a different way in upstream. Please eject this patch.

> Johannes Sixt (1):
>       criss cross rename failure workaround

The patch text is OK, but I should really write a better commit message...

> Karsten Blees (4):
>       Enable color output in Windows cmd.exe

This makes it so that "winansi" is return by getenv("TERM") when TERM is not 
set in the environment. What are the implications? It won't affect me because 
I've set TERM=cygwin. I'm neutral.

>       Support Unicode console output on Windows

I'm negative on this one because I think it will be a regression for me.

It assumes that all text written to the console is UTF8. I don't think that 
this is a generally valid assumption. It might be for msysgit, but not when 
git on Windows is used outside the msysgit bash or without the git.cmd 
wrapper.

>       Detect console streams more reliably on Windows

Looks good. OK.

>       Warn if the Windows console font doesn't support Unicode

Might be a good idea. The warning appears only when multi-byte characters are 
printed. I can't tell how this behaves in non-western locales.

Depends on the Unicode console output patch above.

> Pat Thoyts (6):
>       Skip t1300.70 and 71 on msysGit.
>       fix mingw stat() and lstat() implementations for handling symlinks
>       Report errors when failing to launch the html browser in mingw.

These 3 are OK.

>       mingw: add tests for the hidden attribute on the git directory

The tests of the non-bare repository should be marked expect_failure or be 
squashed into the core.hidedotfiles patch.

>       Do not strip CR when grepping HTTP headers.

export foo=bar again. Is it necessary to export GREP_OPTIONS?

>       Skip 'git archive --remote' test on msysGit

OK, though the failure is not due missing git daemon support, but because we 
do not have fork().

> Sebastian Schuberth (2):
>       MinGW: Use pid_t more consequently, introduce uid_t for greater
> compatibility

OK.

>       MinGW: Add missing file mode bit defines 

OK, why not. It is not strictly necessary, I think, otherwise I would observe 
build failures, but I do not.

> bert Dvornik (2):
>       mingw: Don't ask the user yes/no questions if they can't see the
> question.

Should be squashed into the ask-yes-no patch.

>       send-email: handle Windows paths for display just like we do for 
> processing

I'm neutral. The solution is analogous to the git-am patch above, but slightly 
more restrictive.

-- Hannes
