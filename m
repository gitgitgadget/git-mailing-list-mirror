From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/1] cygwin test failures due to printf
Date: Sat, 15 Dec 2012 19:08:42 +0000
Message-ID: <50CCCABA.40406@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:28:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjxPC-0004Dv-CC
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 20:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab2LOT14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 14:27:56 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:41586 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2LOT14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 14:27:56 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 9F183384081;
	Sat, 15 Dec 2012 19:27:53 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 6311B384080;	Sat, 15 Dec 2012 19:27:52 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Sat, 15 Dec 2012 19:27:51 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211561>


Hi Junio,

Sorry for being a bit tardy on this; I noticed these test failures
on cygwin close to the start of this cycle, just before I went
into hospital, but have only just got around to looking into it...

In particular, the following tests fail: t0021, t0030, t1410, t3032,
t3304, t3404 and t4132. [The list of failing tests is not actually
all that interesting, because the fault is not actually with the
tests!]

These failures are provoked by commit 7bc0911d ("test-lib: Fix say_color ()
not to interpret \a\b\c in the message", 11-10-2012).

If we look at t0021 as a representative, then:

    $ ./t0021-conversion.sh
    ok 1 - setup
    ok 2 - check
    ok 3 - expanded_in_repo
          5 [sig] sh 2388 C:\cygwin\bin\sh.exe: *** fatal error - called with threadlist_ix -1
    ./test-lib.sh: line 207:  2388 Hangup                  \
        ( TERM=$ORIGINAL_TERM; export TERM; case "$1" in
        error)
            tput bold; tput setaf 1
        ;;
        skip)
            tput bold; tput setaf 4
        ;;
        warn)
            tput bold; tput setaf 3
        ;;
        pass)
            tput setaf 2
        ;;
        info)
            tput setaf 3
        ;;
        *)
            test -n "$quiet" && return
        ;;
    esac; shift; printf "%s" "$*"; tput sgr0; echo )
    ok 4 - filter shell-escaped filenames
    ok 5 - required filter success
    ok 6 - required filter smudge failure
    ok 7 - required filter clean failure
    # passed all 7 test(s)
    1..7
    $ 

We see that the "--color" version of say_color(), despite the bash builtin
printf function crashing the shell (sh.exe is actually bash for me), passes
just fine. Note that the message passed to say_color() is printed before
the shell is aborted (via SIGHUP), but that the "tput sgr0; echo" has been
skipped. This results in the occasional line of output in the wrong colour.

This has been happening for several years and, given that there are no
adverse consequences (ignoring the additional error message spew), I have
been happy to ignore this problem. :D

Note that the "--no-color" version of say_color() did not have this problem
since it used echo, rather than printf, until commit 7bc0911d ... 

    $ ./t0021-conversion.sh --no-color
    ok 1 - setup
    ok 2 - check
    ok 3 - expanded_in_repo
          6 [sig] sh 2740 C:\cygwin\bin\sh.exe: *** fatal error - called with threadlist_ix -1
    Hangup
    $ 

Note that, unlike the "--color" version of say_color(), the printf call is
not contained within a sub-shell. Indeed, a simple solution to this problem
would be to execute the body of the function from within a "(...)" sub-shell.
This actually works, since the extra error message spew does not cause a
TAP syntax error to confuse 'prove'. However, I would never suggest this
as a solution, given that it already takes over 3 hours to run the tests...

Also, note that another solution is to call the external version of printf
(e.g. via /usr/bin/printf) but, again, I would not suggest adding to the
fork-exec load by replacing a call to a shell builtin with an external
program...

Note that:

    $ cygcheck /bin/sh.exe
    C:/cygwin/bin/sh.exe
      C:/cygwin/bin\cygwin1.dll
        C:\WINDOWS\system32\ADVAPI32.DLL
          C:\WINDOWS\system32\KERNEL32.dll
            C:\WINDOWS\system32\ntdll.dll
          C:\WINDOWS\system32\RPCRT4.dll
            C:\WINDOWS\system32\Secur32.dll
      C:/cygwin/bin\cygintl-8.dll
        C:/cygwin/bin\cygiconv-2.dll
      C:/cygwin/bin\cygreadline6.dll
        C:/cygwin/bin\cygncurses-8.dll
        C:\WINDOWS\system32\USER32.dll
          C:\WINDOWS\system32\GDI32.dll
    $ 

    $ strings /bin/cygwin1.dll | grep 'called with'
    called with threadlist_ix %d
    called with invalid value %d
    openlog called with (%s, %d, %d)
    $

So, the error message is coming from the cygwin dll (no surprise there).
I have a fairly recent source snapshot of cygwin, but this message or the
code that uses it is not present. In order to debug this further, I would
need to find the source code for the version I am using (1.5.22). This does
not excite me too much. ;-)

As a simpler solution, the patch which follows allows me to customize
the function used to do the output. This allows me to revert to using
echo and, as a bonus, fixes the "--color" version of say_color() at the
same time.

I admit that I find this solution a bit ugly, but it has (at least) two
virtues:
   1. it works!
   2. it's not as ugly as some other solutions I had tried. :-P

ATB,
Ramsay Jones
