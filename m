From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Is there a reason the credential cache server cowardly refuses to delete/reuse the socket file?
Date: Sun, 15 Jun 2014 10:52:09 -0400
Organization: PD Inc
Message-ID: <7EDCFBB4F08F4A0EBB5D19A481BF7D5A@black>
References: <1EFC4B213D584B1EBAE78E6882705B6D@black> <20140615140800.GA6216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 16:52:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwBnG-0003Ra-L1
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 16:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbaFOOwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 10:52:22 -0400
Received: from mail.pdinc.us ([67.90.184.27]:47091 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbaFOOwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 10:52:20 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5FEq9M4004977;
	Sun, 15 Jun 2014 10:52:09 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20140615140800.GA6216@sigill.intra.peff.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Thread-Index: Ac+Ioz6zpghLbvklQn2L4ztFst3HgwABXK7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251679>

> -----Original Message-----
> From: Jeff King  
> Sent: Sunday, June 15, 2014 10:08
> 
> On Sun, Jun 15, 2014 at 09:48:24AM -0400, Jason Pyeron wrote:
> 
> > Whenever my computer crashes, I am left with a socket file. 
> On next git
> > invocation it tries to conenct to the file, but the daemon 
> is not running so it
> > barfs until I delete the file.
> 
> It's supposed to transparently handle this situation. The 
> server always
> runs unlink() before binding to clear it out. The client will 
> spawn the
> server when it tries to connect and gets either ENOENT or 
> ECONNREFUSED.
> 
> But:
> 
> > jpyeron@black /projects/dcarr/saar
> > $ git push
> > fatal: unable to connect to cache daemon: No error
> 
> Apparently your errno is 0 after returning an error from
> credential-cache.c:send_request?
> 
> Could this be a cygwin weirdness? I'd be interested to see the output
> of:
> 
>   echo url=https://example.com |

>   strace -f git credential-cache get

On cygwin things can git a bit weird, I changed it to the actual executable.

I marked the start of interest with lots of ***********

jpyeron@black /projects/dcarr
$ echo url=https://example.com | strace -f
/usr/lib/git-core/git-credential-cache get
    3       3 [main] git-credential-cache (4308)
**********************************************
  111     114 [main] git-credential-cache (4308) Program name:
C:\cygwin\lib\git-core\git-credential-cache.exe (windows pid 4308)
   53     167 [main] git-credential-cache (4308) OS version:   Windows NT-5.2
   50     217 [main] git-credential-cache (4308)
**********************************************
  138     355 [main] git-credential-cache (4308) sigprocmask: 0 = sigprocmask
(0, 0x0, 0x61276808)
  364     719 [main] git-credential-cache 4308 open_shared: name shared.5, n 5,
shared 0x60FF0000 (wanted 0x60FF0000), h 0x368, *m 6
   68     787 [main] git-credential-cache 4308 user_heap_info::init: heap base
0x80000000, heap top 0x80000000, heap size 0x18000000 (402653184)
   73     860 [main] git-credential-cache 4308 open_shared: name $$SID$$.1, n 1,
shared 0x60FE0000 (wanted 0x60FE0000), h 0x36C, *m 6
   53     913 [main] git-credential-cache 4308 user_info::create: opening user
shared for '$$SID$$' at 0x60FE0000
   64     977 [main] git-credential-cache 4308 user_info::create: user shared
version AB1FCCE8
   61    1038 [main] git-credential-cache 4308 wow64_eval_expected_main_stack:
expected allocbase: 0x30000, stackbase: 0x230000
   68    1106 [main] git-credential-cache 4308 fhandler_pipe::create: name
\\.\pipe\cygwin-c5e39b7a9d22bafb-4308-sigwait, size 164, mode PIPE_TYPE_MESSAGE
  110    1216 [main] git-credential-cache 4308 fhandler_pipe::create: pipe read
handle 0x354
   51    1267 [main] git-credential-cache 4308 fhandler_pipe::create:
CreateFile: name \\.\pipe\cygwin-c5e39b7a9d22bafb-4308-sigwait
   91    1358 [main] git-credential-cache 4308 fhandler_pipe::create: pipe write
handle 0x350
   62    1420 [main] git-credential-cache 4308 dll_crt0_0: finished dll_crt0_0
initialization
  708    2128 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\home\public\Desktop\projects\dcarr, no-keep-rel,
no-add-slash)
   69    2197 [main] git-credential-cache 4308 normalize_win32_path:
C:\home\public\Desktop\projects\dcarr = normalize_win32_path
(C:\home\public\Desktop\projects\dcarr)
   45    2242 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/home/public/Desktop/projects/dcarr = conv_to_posix_path
(C:\home\public\Desktop\projects\dcarr)
 -104    2138 [sig] git-credential-cache 4308 wait_sig: entering ReadFile loop,
my_readsig 0x354, my_sendsig 0x350
  267    2405 [main] git-credential-cache 4308 sigprocmask: 0 = sigprocmask (0,
0x0, 0x800180A8)
  237    2642 [main] git-credential-cache 4308 _cygwin_istext_for_stdio: fd 0:
not open
   60    2702 [main] git-credential-cache 4308 _cygwin_istext_for_stdio: fd 1:
not open
   37    2739 [main] git-credential-cache 4308 _cygwin_istext_for_stdio: fd 2:
not open
  147    2886 [main] git-credential-cache (4308) open_shared: name cygpid.4308,
n 4308, shared 0x60FD0000 (wanted 0x60FD0000), h 0x330, *m 2
   30    2916 [main] ? (4308) time: 1402843072 = time(0x0)
   42    2958 [main] git-credential-cache 4308 pinfo::thisproc: myself
dwProcessId 4308
  645    3603 [main] git-credential-cache 4308 environ_init:
GetEnvironmentStrings returned 0x494040
   50    3653 [main] git-credential-cache 4308 environ_init: 0x80028290: !::=::\
   54    3707 [main] git-credential-cache 4308 environ_init: 0x800282A0: !A:=A:\
   78    3785 [main] git-credential-cache 4308 environ_init: 0x800282B0: !B:=B:\
   83    3868 [main] git-credential-cache 4308 environ_init: 0x800282C0: !D:=D:\
   72    3940 [main] git-credential-cache 4308 environ_init: 0x800282D0: !E:=E:\
   56    3996 [main] git-credential-cache 4308 environ_init: 0x800282E0: !F:=F:\
   75    4071 [main] git-credential-cache 4308 environ_init: 0x800282F0: !G:=G:\
   72    4143 [main] git-credential-cache 4308 environ_init: 0x80028300: !H:=H:\
   72    4215 [main] git-credential-cache 4308 environ_init: 0x80028310: !I:=I:\
   83    4298 [main] git-credential-cache 4308 environ_init: 0x80028320: !J:=J:\
   72    4370 [main] git-credential-cache 4308 environ_init: 0x80028330: !K:=K:\
   85    4455 [main] git-credential-cache 4308 environ_init: 0x80028340: !L:=L:\
   44    4499 [main] git-credential-cache 4308 environ_init: 0x80028350: !M:=M:\
   77    4576 [main] git-credential-cache 4308 environ_init: 0x80028360: !N:=N:\
   82    4658 [main] git-credential-cache 4308 environ_init: 0x80028370: !O:=O:\
   56    4714 [main] git-credential-cache 4308 environ_init: 0x80028380: !P:=P:\
   62    4776 [main] git-credential-cache 4308 environ_init: 0x80028390: !Q:=Q:\
   72    4848 [main] git-credential-cache 4308 environ_init: 0x800283A0: !R:=R:\
   83    4931 [main] git-credential-cache 4308 environ_init: 0x800283B0: !S:=S:\
   72    5003 [main] git-credential-cache 4308 environ_init: 0x800283C0: !T:=T:\
   84    5087 [main] git-credential-cache 4308 environ_init: 0x800283D0: !U:=U:\
   72    5159 [main] git-credential-cache 4308 environ_init: 0x800283E0: !V:=V:\
   71    5230 [main] git-credential-cache 4308 environ_init: 0x800283F0: !W:=W:\
   69    5299 [main] git-credential-cache 4308 environ_init: 0x80028400: !X:=X:\
   43    5342 [main] git-credential-cache 4308 environ_init: 0x80028410: !Y:=Y:\
   44    5386 [main] git-credential-cache 4308 environ_init: 0x80028420: !Z:=Z:\
   77    5463 [main] git-credential-cache 4308 environ_init: 0x80028430:
ALLUSERSPROFILE=C:\Documents and Settings\All Users
   69    5532 [main] git-credential-cache 4308 environ_init: 0x80028470:
APPDATA=C:\Documents and Settings\jpyeron\Application Data
   75    5607 [main] git-credential-cache 4308 environ_init: 0x800284B0:
CLIENTNAME=Console
   54    5661 [main] git-credential-cache 4308 environ_init: 0x800284C8:
COMMONPROGRAMFILES=C:\Program Files (x86)\Common Files
   79    5740 [main] git-credential-cache 4308 environ_init: 0x80028508:
COMPUTERNAME=BLACK
   69    5809 [main] git-credential-cache 4308 environ_init: 0x80028520:
COMSPEC=C:\WINDOWS\system32\cmd.exe
 1581    7390 [main] git-credential-cache 4308 environ_init: 0x80028550:
CommonProgramFiles(x86)=C:\Program Files (x86)\Common Files
   48    7438 [main] git-credential-cache 4308 environ_init: 0x80028598:
CommonProgramW6432=C:\Program Files\Common Files
   48    7486 [main] git-credential-cache 4308 parse_options: glob (called func)
   43    7529 [main] git-credential-cache 4308 parse_options: returning
   22    7551 [main] git-credential-cache 4308 environ_init: 0x800285D0:
CYGWIN=noglob
   43    7594 [main] git-credential-cache 4308 environ_init: 0x800285F8:
DISPLAY=:0.0
   42    7636 [main] git-credential-cache 4308 environ_init: 0x80028610:
EDITOR=nano
   42    7678 [main] git-credential-cache 4308 environ_init: 0x80028628:
EXECIGNORE=*.dll
   43    7721 [main] git-credential-cache 4308 environ_init: 0x80028640:
FP_NO_HOST_CHECK=NO
   44    7765 [main] git-credential-cache 4308 getwinenv: can't set native for
HOME= since no environ yet
   25    7790 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\home\jpyeron, no-keep-rel, no-add-slash)
   24    7814 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\home\jpyeron = normalize_win32_path (C:\cygwin\home\jpyeron)
   25    7839 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/home/jpyeron = conv_to_posix_path (C:\cygwin\home\jpyeron)
   62    7901 [main] git-credential-cache 4308 win_env::add_cache: posix
/home/jpyeron
   22    7923 [main] git-credential-cache 4308 win_env::add_cache: native
HOME=C:\cygwin\home\jpyeron
   22    7945 [main] git-credential-cache 4308 posify_maybe: env var converted
to HOME=/home/jpyeron
   62    8007 [main] git-credential-cache 4308 environ_init: 0x800286C0:
HOME=/home/jpyeron
   43    8050 [main] git-credential-cache 4308 environ_init: 0x80028660:
HOMEDRIVE=C:
   45    8095 [main] git-credential-cache 4308 environ_init: 0x800286D8:
HOMEPATH=\Documents and Settings\jpyeron
   44    8139 [main] git-credential-cache 4308 environ_init: 0x80028708:
HOMESHARE=$$PROFILESERVER$$\jpyeron
   44    8183 [main] git-credential-cache 4308 environ_init: 0x80028730:
HOSTNAME=black
   44    8227 [main] git-credential-cache 4308 environ_init: 0x80028748:
INFOPATH=/usr/local/info:/usr/share/info:/usr/info
   43    8270 [main] git-credential-cache 4308 environ_init: 0x80028780:
JAVA_HOME=c:\programs.x86_64\Java\jdk1.7.0_25
   43    8313 [main] git-credential-cache 4308 environ_init: 0x800287B8:
KMP_DUPLICATE_LIB_OK=TRUE
   43    8356 [main] git-credential-cache 4308 environ_init: 0x800287D8:
LANG=en_US.UTF-8
   42    8398 [main] git-credential-cache 4308 environ_init: 0x800287F0:
LOGONSERVER=$$LOGONSERVER$$
   43    8441 [main] git-credential-cache 4308 environ_init: 0x80028810:
MAKE_MODE=unix
   46    8487 [main] git-credential-cache 4308 environ_init: 0x80028828:
NUMBER_OF_PROCESSORS=2
   45    8532 [main] git-credential-cache 4308 environ_init: 0x80028848:
OLDPWD=/projects/dcarr/saar
   46    8578 [main] git-credential-cache 4308 environ_init: 0x80028870:
OMP_NUM_THREADS=2
<snip/>
   50    8734 [main] git-credential-cache 4308 environ_init: 0x80028B58:
OS=Windows_NT
   57    8791 [main] git-credential-cache 4308 getwinenv: can't set native for
PATH= since no environ yet
   50    8841 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\usr\local\bin, keep-rel, no-add-slash)
  139    8980 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\usr\local\bin = normalize_win32_path (C:\cygwin\usr\local\bin)
   27    9007 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/usr/local/bin = conv_to_posix_path (C:\cygwin\usr\local\bin)
   25    9032 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\bin, keep-rel, no-add-slash)
   25    9057 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\bin = normalize_win32_path (C:\cygwin\bin)
   24    9081 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/usr/bin = conv_to_posix_path (C:\cygwin\bin)
   26    9107 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\bin, keep-rel, no-add-slash)
   24    9131 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\bin = normalize_win32_path (C:\cygwin\bin)
   24    9155 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/usr/bin = conv_to_posix_path (C:\cygwin\bin)
   25    9180 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\bin, keep-rel, no-add-slash)
   24    9204 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\bin = normalize_win32_path (C:\cygwin\bin)
   24    9228 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/usr/bin = conv_to_posix_path (C:\cygwin\bin)
   25    9253 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\usr\local\bin, keep-rel, no-add-slash)
   24    9277 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\usr\local\bin = normalize_win32_path (C:\cygwin\usr\local\bin)
   25    9302 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/usr/local/bin = conv_to_posix_path (C:\cygwin\usr\local\bin)
   25    9327 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\programs.x86_64\Java\jdk1.7.0_25\bin, keep-rel,
no-add-slash)
   24    9351 [main] git-credential-cache 4308 normalize_win32_path:
C:\programs.x86_64\Java\jdk1.7.0_25\bin = normalize_win32_path
(C:\programs.x86_64\Java\jdk1.7.0_25\bin)
   25    9376 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/programs.x86_64/Java/jdk1.7.0_25/bin = conv_to_posix_path
(C:\programs.x86_64\Java\jdk1.7.0_25\bin)
   25    9401 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\WINDOWS\system32, keep-rel, no-add-slash)
   25    9426 [main] git-credential-cache 4308 normalize_win32_path:
C:\WINDOWS\system32 = normalize_win32_path (C:\WINDOWS\system32)
   24    9450 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/WINDOWS/system32 = conv_to_posix_path (C:\WINDOWS\system32)
   25    9475 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\WINDOWS, keep-rel, no-add-slash)
   24    9499 [main] git-credential-cache 4308 normalize_win32_path: C:\WINDOWS
= normalize_win32_path (C:\WINDOWS)
   25    9524 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/WINDOWS = conv_to_posix_path (C:\WINDOWS)
   24    9548 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\WINDOWS\System32\Wbem, keep-rel, no-add-slash)
   25    9573 [main] git-credential-cache 4308 normalize_win32_path:
C:\WINDOWS\System32\Wbem = normalize_win32_path (C:\WINDOWS\System32\Wbem)
   25    9598 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/WINDOWS/System32/Wbem = conv_to_posix_path
(C:\WINDOWS\System32\Wbem)
   25    9623 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\programs.i386\teraterm, keep-rel, no-add-slash)
   24    9647 [main] git-credential-cache 4308 normalize_win32_path:
C:\programs.i386\teraterm = normalize_win32_path (C:\programs.i386\teraterm)
   25    9672 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/programs.i386/teraterm = conv_to_posix_path
(C:\programs.i386\teraterm)
   25    9697 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\Program Files\Common Files\Autodesk Shared, keep-rel,
no-add-slash)
<snip/>
   25   10000 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\Program Files\TortoiseGit\bin, keep-rel, no-add-slash)
   25   10025 [main] git-credential-cache 4308 normalize_win32_path: C:\Program
Files\TortoiseGit\bin = normalize_win32_path (C:\Program Files\TortoiseGit\bin)
   25   10050 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/Program Files/TortoiseGit/bin = conv_to_posix_path (C:\Program
Files\TortoiseGit\bin)
   28   10078 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\Program Files\TortoiseSVN\bin, keep-rel, no-add-slash)
   25   10103 [main] git-credential-cache 4308 normalize_win32_path: C:\Program
Files\TortoiseSVN\bin = normalize_win32_path (C:\Program Files\TortoiseSVN\bin)
   25   10128 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/Program Files/TortoiseSVN/bin = conv_to_posix_path (C:\Program
Files\TortoiseSVN\bin)
   25   10153 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\programs.x86_64\nodejs, keep-rel, no-add-slash)
   25   10178 [main] git-credential-cache 4308 normalize_win32_path:
C:\programs.x86_64\nodejs = normalize_win32_path (C:\programs.x86_64\nodejs)
   25   10203 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/programs.x86_64/nodejs = conv_to_posix_path
(C:\programs.x86_64\nodejs)
   25   10228 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\Documents and Settings\jpyeron\Application Data\npm,
keep-rel, no-add-slash)
   25   10253 [main] git-credential-cache 4308 normalize_win32_path:
C:\Documents and Settings\jpyeron\Application Data\npm = normalize_win32_path
(C:\Documents and Settings\jpyeron\Application Data\npm)
   26   10279 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/cygdrive/c/Documents and Settings/jpyeron/Application Data/npm =
conv_to_posix_path (C:\Documents and Settings\jpyeron\Application Data\npm)
   25   10304 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\lib\lapack, keep-rel, no-add-slash)
   24   10328 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\lib\lapack = normalize_win32_path (C:\cygwin\lib\lapack)
   25   10353 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/usr/lib/lapack = conv_to_posix_path (C:\cygwin\lib\lapack)
   70   10423 [main] git-credential-cache 4308 win_env::add_cache: posix
/usr/local/bin:/usr/bin:/usr/bin:/usr/bin:/usr/local/bin:/cygdrive/c/programs.x8
6_64/Java/jdk1.7.0_25/bin:/cygdrive/c/WINDOWS/system32:/cygdrive/c/WINDOWS:/cygd
rive/c/WINDOWS/System32/Wbem:/cygdrive/c/programs.i386/teraterm:/cygdrive/c/Prog
ram Files/Common Files/Autodesk Shared:/cygdrive/c/Program Files
(x86)/ActivIdentity/ActivClient:/cygdrive/c/oraclexe/app/oracle/product/10.2.0/s
erver/bin:/cygdrive/c/Program Files (x86)/HTMLDOC:/cygdrive/c/Program
Files/TortoiseGit/bin:/cygdrive/c/Program
Files/TortoiseSVN/bin:/cygdrive/c/programs.x86_64/nodejs:/cygdrive/c/Documents
and Settings/jpyeron/Application Data/npm:/usr/lib/lapack
   29   10452 [main] git-credential-cache 4308 win_env::add_cache: native
PATH=C:\cygwin\usr\local\bin;C:\cygwin\bin;C:\cygwin\bin;C:\cygwin\bin;C:\cygwin
\usr\local\bin;C:\programs.x86_64\Java\jdk1.7.0_25\bin;C:\WINDOWS\system32;C:\WI
NDOWS;C:\WINDOWS\System32\Wbem;C:\programs.i386\teraterm;C:\Program Files\Common
Files\Autodesk Shared;C:\Program Files
(x86)\ActivIdentity\ActivClient;C:\oraclexe\app\oracle\product\10.2.0\server\bin
;C:\Program Files (x86)\HTMLDOC;C:\Program Files\TortoiseGit\bin;C:\Program
Files\TortoiseSVN\bin;C:\programs.x86_64\nodejs;C:\Documents and
Settings\jpyeron\Application Data\npm;C:\cygwin\lib\lapack
   28   10480 [main] git-credential-cache 4308 posify_maybe: env var converted
to
PATH=/usr/local/bin:/usr/bin:/usr/bin:/usr/bin:/usr/local/bin:/cygdrive/c/progra
ms.x86_64/Java/jdk1.7.0_25/bin:/cygdrive/c/WINDOWS/system32:/cygdrive/c/WINDOWS:
/cygdrive/c/WINDOWS/System32/Wbem:/cygdrive/c/programs.i386/teraterm:/cygdrive/c
/Program Files/Common Files/Autodesk Shared:/cygdrive/c/Program Files
(x86)/ActivIdentity/ActivClient:/cygdrive/c/oraclexe/app/oracle/product/10.2.0/s
erver/bin:/cygdrive/c/Program Files (x86)/HTMLDOC:/cygdrive/c/Program
Files/TortoiseGit/bin:/cygdrive/c/Program
Files/TortoiseSVN/bin:/cygdrive/c/programs.x86_64/nodejs:/cygdrive/c/Documents
and Settings/jpyeron/Application Data/npm:/usr/lib/lapack
   72   10552 [main] git-credential-cache 4308 environ_init: 0x80039268:
PATH=/usr/local/bin:/usr/bin:/usr/bin:/usr/bin:/usr/local/bin:/cygdrive/c/progra
ms.x86_64/Java/jdk1.7.0_25/bin:/cygdrive/c/WINDOWS/system32:/cygdrive/c/WINDOWS:
/cygdrive/c/WINDOWS/System32/Wbem:/cygdrive/c/programs.i386/teraterm:/cygdrive/c
/Program Files/Common Files/Autodesk Shared:/cygdrive/c/Program Files
(x86)/ActivIdentity/ActivClient:/cygdrive/c/oraclexe/app/oracle/product/10.2.0/s
erver/bin:/cygdrive/c/Program Files (x86)/HTMLDOC:/cygdrive/c/Program
Files/TortoiseGit/bin:/cygdrive/c/Program
Files/TortoiseSVN/bin:/cygdrive/c/programs.x86_64/nodejs:/cygdrive/c/Documents
and Settings/jpyeron/Application Data/npm:/usr/lib/lapack
   54   10606 [main] git-credential-cache 4308 environ_init: 0x80028B70:
PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH
   50   10656 [main] git-credential-cache 4308 environ_init: 0x80028BB0:
PRINTER=HP LaserJet 3390 (E5A3E6)
   47   10703 [main] git-credential-cache 4308 environ_init: 0x80028BD8:
PROCESSOR_ARCHITECTURE=x86
   50   10753 [main] git-credential-cache 4308 environ_init: 0x80028BF8:
PROCESSOR_ARCHITEW6432=AMD64
   48   10801 [main] git-credential-cache 4308 environ_init: 0x80028C20:
PROCESSOR_IDENTIFIER=EM64T Family 6 Model 23 Stepping 10, GenuineIntel
   49   10850 [main] git-credential-cache 4308 environ_init: 0x80028C70:
PROCESSOR_LEVEL=6
   49   10899 [main] git-credential-cache 4308 environ_init: 0x80028C88:
PROCESSOR_REVISION=170a
   49   10948 [main] git-credential-cache 4308 environ_init: 0x80028CA8:
PROFILEREAD=true
   50   10998 [main] git-credential-cache 4308 environ_init: 0x80028CC0:
PROGRAMFILES=C:\Program Files (x86)
   50   11048 [main] git-credential-cache 4308 environ_init: 0x80028CF0:
PS1=\[\e]0;\h \w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$
<snip/>
   49   11197 [main] git-credential-cache 4308 environ_init: 0x80028D78:
PWD=/projects/dcarr
   50   11247 [main] git-credential-cache 4308 environ_init: 0x80039530:
ProgramFiles(x86)=C:\Program Files (x86)
   49   11296 [main] git-credential-cache 4308 environ_init: 0x80039560:
ProgramW6432=C:\Program Files
   48   11344 [main] git-credential-cache 4308 environ_init: 0x80039588:
SESSIONNAME=Console
   47   11391 [main] git-credential-cache 4308 environ_init: 0x800395A8:
SHELL=/bin/bash
   46   11437 [main] git-credential-cache 4308 environ_init: 0x80028678: SHLVL=1
   46   11483 [main] git-credential-cache 4308 environ_init: 0x800395C0:
SYSTEMDRIVE=C:
   51   11534 [main] git-credential-cache 4308 environ_init: 0x800395D8:
SYSTEMROOT=C:\WINDOWS
   47   11581 [main] git-credential-cache 4308 getwinenv: can't set native for
TEMP= since no environ yet
   24   11605 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\tmp, no-keep-rel, no-add-slash)
   26   11631 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\tmp = normalize_win32_path (C:\cygwin\tmp)
   25   11656 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/tmp = conv_to_posix_path (C:\cygwin\tmp)
   71   11727 [main] git-credential-cache 4308 win_env::add_cache: posix /tmp
   23   11750 [main] git-credential-cache 4308 win_env::add_cache: native
TEMP=C:\cygwin\tmp
   24   11774 [main] git-credential-cache 4308 posify_maybe: env var converted
to TEMP=/tmp
   67   11841 [main] git-credential-cache 4308 environ_init: 0x80039628:
TEMP=/tmp
   46   11887 [main] git-credential-cache 4308 environ_init: 0x800395F8:
TERM=vt100
   47   11934 [main] git-credential-cache 4308 getwinenv: can't set native for
TMP= since no environ yet
   24   11958 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\tmp, no-keep-rel, no-add-slash)
   25   11983 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\tmp = normalize_win32_path (C:\cygwin\tmp)
   24   12007 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/tmp = conv_to_posix_path (C:\cygwin\tmp)
   67   12074 [main] git-credential-cache 4308 win_env::add_cache: posix /tmp
   23   12097 [main] git-credential-cache 4308 win_env::add_cache: native
TMP=C:\cygwin\tmp
   24   12121 [main] git-credential-cache 4308 posify_maybe: env var converted
to TMP=/tmp
   66   12187 [main] git-credential-cache 4308 environ_init: 0x80039678:
TMP=/tmp
   47   12234 [main] git-credential-cache 4308 environ_init: 0x80039688:
TZ=America/New_York
   46   12280 [main] git-credential-cache 4308 environ_init: 0x80039638:
USER=jpyeron
<snip/>
   46   12372 [main] git-credential-cache 4308 environ_init: 0x800396C0:
USERNAME=jpyeron
   47   12419 [main] git-credential-cache 4308 environ_init: 0x800396D8:
USERPROFILE=C:\Documents and Settings\jpyeron
   46   12465 [main] git-credential-cache 4308 environ_init: 0x80039710:
VBOX_INSTALL_PATH=C:\Program Files\Oracle\VirtualBox\
   48   12513 [main] git-credential-cache 4308 environ_init: 0x80039750:
VS100COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio
10.0\Common7\Tools\
   47   12560 [main] git-credential-cache 4308 environ_init: 0x800397A8:
VS90COMNTOOLS=c:\Program Files (x86)\Microsoft Visual Studio 9.0\Common7\Tools\
   47   12607 [main] git-credential-cache 4308 environ_init: 0x80039800:
WCDHOME=/home/jpyeron/.wcd
   47   12654 [main] git-credential-cache 4308 environ_init: 0x80039820:
WINDIR=C:\WINDOWS
   47   12701 [main] git-credential-cache 4308 environ_init: 0x80039838:
WIX=C:\Program Files (x86)\WiX Toolset v3.6\
   47   12748 [main] git-credential-cache 4308 environ_init: 0x80039870:
_=/usr/bin/strace
   41   12789 [main] git-credential-cache 4308 pinfo_init: Set nice to 0
   24   12813 [main] git-credential-cache 4308 pinfo_init: pid 4308, pgid 4308,
process_state 0x41
   28   12841 [main] git-credential-cache 4308 App version:  1007.10, api: 0.259
   25   12866 [main] git-credential-cache 4308 DLL version:  1007.30, api: 0.272
   25   12891 [main] git-credential-cache 4308 DLL build:    2014-05-23 10:36
   27   12918 [main] git-credential-cache 4308 dtable::extend: size 32, fds
0x612AD3DC
  267   13185 [main] git-credential-cache 4308 pwdgrp::load: \etc\passwd
curr_lines 19
   43   13228 [main] git-credential-cache 4308 pwdgrp::load: \etc\passwd load
succeeded
  232   13460 [main] git-credential-cache 4308 pwdgrp::load: \etc\group
curr_lines 18
   37   13497 [main] git-credential-cache 4308 pwdgrp::load: \etc\group load
succeeded
   28   13525 [main] git-credential-cache 4308 cygheap_user::ontherange: what 2,
pw 0x8003A0D0
   25   13550 [main] git-credential-cache 4308 cygheap_user::ontherange: HOME is
already in the environment /home/jpyeron
  358   13908 [main] git-credential-cache 4308 __get_lcid_from_locale:
LCID=0x0409
  106   14014 [main] git-credential-cache 4308 build_argv: argv[0] =
'C:\cygwin\lib\git-core\git-credential-cache'
   25   14039 [main] git-credential-cache 4308 build_argv: argv[1] = 'get'
   30   14069 [main] git-credential-cache 4308 build_argv: argc 2
   49   14118 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
conv_to_posix_path (C:\cygwin\lib\git-core\git-credential-cache, keep-rel,
no-add-slash)
   23   14141 [main] git-credential-cache 4308 normalize_win32_path:
C:\cygwin\lib\git-core\git-credential-cache = normalize_win32_path
(C:\cygwin\lib\git-core\git-credential-cache)
   24   14165 [main] git-credential-cache 4308 mount_info::conv_to_posix_path:
/usr/lib/git-core/git-credential-cache = conv_to_posix_path
(C:\cygwin\lib\git-core\git-credential-cache)
  143   14308 [main] git-credential-cache 4308 build_fh_pc: fh 0x612AD4D0, dev
000000C6
   32   14340 [main] git-credential-cache 4308 fhandler_base::set_flags: flags
0x10000, supplied_bin 0x0
   25   14365 [main] git-credential-cache 4308 fhandler_base::set_flags:
O_TEXT/O_BINARY set in flags 0x10000
   23   14388 [main] git-credential-cache 4308 fhandler_base::set_flags:
filemode set to binary
   23   14411 [main] git-credential-cache 4308 fhandler_base::init: created new
fhandler_base for handle 0x1F4, bin 1
  146   14557 [main] git-credential-cache 4308 build_fh_pc: created an archetype
(0x612AD988) for /dev/pty1(136/1)
   25   14582 [main] git-credential-cache 4308 build_fh_pc: fh 0x612AD740, dev
00880001
   29   14611 [main] git-credential-cache 4308 fhandler_pipe::create: name
\\.\pipe\cygwin-c5e39b7a9d22bafb-pty1-from-master, size 131072, mode
PIPE_TYPE_MESSAGE
   96   14707 [main] git-credential-cache 4308 fhandler_pipe::create: pipe busy
   25   14732 [main] git-credential-cache 4308 tty::exists: exists 1
   62   14794 [main] git-credential-cache 4308 alloc_sd: uid 12002, gid 10513,
attribute 0x2190
   28   14822 [main] git-credential-cache 4308 cygsid::debug_print: alloc_sd:
owner SID = $$SID$$ (+)
   26   14848 [main] git-credential-cache 4308 cygsid::debug_print: alloc_sd:
group SID = $$SID2$$ (+)
   25   14873 [main] git-credential-cache 4308 alloc_sd: ACL-Size: 124
   69   14942 [main] git-credential-cache 4308 alloc_sd: Created SD-Size: 200
   25   14967 [main] git-credential-cache 4308 fhandler_pty_slave::open: (440):
pty output_mutex (0x328): waiting -1 ms
   27   14994 [main] git-credential-cache 4308 fhandler_pty_slave::open: (440):
pty output_mutex: acquired
   31   15025 [main] git-credential-cache 4308 tty::create_inuse:
cygtty.slave_alive.1 0x31C
   26   15051 [main] git-credential-cache 4308 fhandler_pty_slave::open: (443):
pty output_mutex(0x328) released
   59   15110 [main] git-credential-cache 4308 open_shared: name cygpid.5588, n
5588, shared 0xAE0000 (wanted 0x0), h 0x318, *m 6
   31   15141 [main] git-credential-cache 4308 fhandler_pty_slave::open: dup
handles directly since I'm the owner
   33   15174 [main] git-credential-cache 4308 fhandler_pty_slave::open:
duplicated from_master 0x154->0x318 from pty_owner
   25   15199 [main] git-credential-cache 4308 fhandler_pty_slave::open:
duplicated to_master 0x15C->0x310 from pty_owner
   38   15237 [main] git-credential-cache 4308 fhandler_console::need_invisible:
invisible_console 0
   29   15266 [main] git-credential-cache 4308 fhandler_base::open_with_arch:
line 474:  /dev/pty1<0x612AD988> usecount + 1 = 1
   24   15290 [main] git-credential-cache 4308 fhandler_base::set_flags: flags
0x10002, supplied_bin 0x0
   23   15313 [main] git-credential-cache 4308 fhandler_base::set_flags:
O_TEXT/O_BINARY set in flags 0x10000
   23   15336 [main] git-credential-cache 4308 fhandler_base::set_flags:
filemode set to binary
   24   15360 [main] git-credential-cache 4308 _pinfo::set_ctty: old no ctty,
ctty device number 0xFFFFFFFF, tc.ntty device number 0x880001 flags & O_NOCTTY
0x0
   23   15383 [main] git-credential-cache 4308 _pinfo::set_ctty: cygheap->ctty
0x0, archetype 0x612AD988
   23   15406 [main] git-credential-cache 4308 _pinfo::set_ctty: ctty was NULL
   23   15429 [main] git-credential-cache 4308 _pinfo::set_ctty: line 482:
/dev/pty1<0x612AD988> usecount + 1 = 2
   23   15452 [main] git-credential-cache 4308 _pinfo::set_ctty: /dev/pty1 ctty,
usecount 2
   25   15477 [main] git-credential-cache 4308 _pinfo::set_ctty: attaching ctty
/dev/pty1 sid 4308, pid 4308, pgid 4308, tty->pgid 6032, tty->sid 2796
   24   15501 [main] git-credential-cache 4308 _pinfo::set_ctty: cygheap->ctty
now 0x612AD988, archetype 0x612AD988
   24   15525 [main] git-credential-cache 4308 fhandler_pty_slave::open_setup:
/dev/pty1 opened, usecount 2
   25   15550 [main] git-credential-cache 4308 fhandler_base::set_flags: flags
0x10002, supplied_bin 0x0
   23   15573 [main] git-credential-cache 4308 fhandler_base::set_flags:
O_TEXT/O_BINARY set in flags 0x10000
   23   15596 [main] git-credential-cache 4308 fhandler_base::set_flags:
filemode set to binary
   23   15619 [main] git-credential-cache 4308 _pinfo::set_ctty: old ctty
/dev/pty1, ctty device number 0x880001, tc.ntty device number 0x880001 flags &
O_NOCTTY 0x0
   25   15644 [main] git-credential-cache 4308 _pinfo::set_ctty: attaching ctty
/dev/pty1 sid 2796, pid 4308, pgid 6032, tty->pgid 6032, tty->sid 2796
   25   15669 [main] git-credential-cache 4308 _pinfo::set_ctty: cygheap->ctty
now 0x612AD988, archetype 0x612AD988
   23   15692 [main] git-credential-cache 4308 fhandler_pty_slave::open_setup:
/dev/pty1 opened, usecount 2
  133   15825 [main] git-credential-cache 4308 build_fh_pc: found an archetype
for (null)(136/1) io_handle 0x318
   26   15851 [main] git-credential-cache 4308 build_fh_pc: fh 0x612ADC08, dev
00880001
   30   15881 [main] git-credential-cache 4308 fhandler_base::open_with_arch:
line 494:  /dev/pty1<0x612AD988> usecount + 1 = 3
   24   15905 [main] git-credential-cache 4308 fhandler_base::set_flags: flags
0x10002, supplied_bin 0x0
   27   15932 [main] git-credential-cache 4308 fhandler_base::set_flags:
O_TEXT/O_BINARY set in flags 0x10000
   24   15956 [main] git-credential-cache 4308 fhandler_base::set_flags:
filemode set to binary
   23   15979 [main] git-credential-cache 4308 _pinfo::set_ctty: old ctty
/dev/pty1, ctty device number 0x880001, tc.ntty device number 0x880001 flags &
O_NOCTTY 0x0
   25   16004 [main] git-credential-cache 4308 _pinfo::set_ctty: attaching ctty
/dev/pty1 sid 2796, pid 4308, pgid 6032, tty->pgid 6032, tty->sid 2796
   25   16029 [main] git-credential-cache 4308 _pinfo::set_ctty: cygheap->ctty
now 0x612AD988, archetype 0x612AD988
   23   16052 [main] git-credential-cache 4308 fhandler_pty_slave::open_setup:
/dev/pty1 opened, usecount 3
   24   16076 [main] git-credential-cache 4308 fhandler_base::set_flags: flags
0x10002, supplied_bin 0x0
   24   16100 [main] git-credential-cache 4308 fhandler_base::set_flags:
O_TEXT/O_BINARY set in flags 0x10000
   22   16122 [main] git-credential-cache 4308 fhandler_base::set_flags:
filemode set to binary
   24   16146 [main] git-credential-cache 4308 _pinfo::set_ctty: old ctty
/dev/pty1, ctty device number 0x880001, tc.ntty device number 0x880001 flags &
O_NOCTTY 0x0
   25   16171 [main] git-credential-cache 4308 _pinfo::set_ctty: attaching ctty
/dev/pty1 sid 2796, pid 4308, pgid 6032, tty->pgid 6032, tty->sid 2796
   24   16195 [main] git-credential-cache 4308 _pinfo::set_ctty: cygheap->ctty
now 0x612AD988, archetype 0x612AD988
   23   16218 [main] git-credential-cache 4308 fhandler_pty_slave::open_setup:
/dev/pty1 opened, usecount 3
  451   16669 [main] git-credential-cache 4308 __set_errno: void
dll_crt0_1(void*):999 setting errno 0
  382   17051 [main] git-credential-cache 4308 read: read(0, 0x8003A92F, 8192)
blocking
   32   17083 [main] git-credential-cache 4308 fhandler_base::read: returning
24, binary mode
   25   17108 [main] git-credential-cache 4308 read: 24 = read(0, 0x8003A92F,
8192)
   45   17153 [main] git-credential-cache 4308 read: read(0, 0x8003A947, 12300)
blocking
   26   17179 [main] git-credential-cache 4308 fhandler_base::read: returning 0,
binary mode
   23   17202 [main] git-credential-cache 4308 read: 0 = read(0, 0x8003A947,
12300)
   30   17232 [main] git-credential-cache 4308 cygwin_socket: socket (1, 1
(flags 0x0), 0)
 3232   20464 [main] git-credential-cache 4308 wsock_init: res 0
   31   20495 [main] git-credential-cache 4308 wsock_init: wVersion 514
   24   20519 [main] git-credential-cache 4308 wsock_init: wHighVersion 514
   23   20542 [main] git-credential-cache 4308 wsock_init: szDescription WinSock
2.0
   23   20565 [main] git-credential-cache 4308 wsock_init: szSystemStatus
Running
   23   20588 [main] git-credential-cache 4308 wsock_init: iMaxSockets 0
   22   20610 [main] git-credential-cache 4308 wsock_init: iMaxUdpDg 0

********************************************************************************
*************************************************************


 9508   30118 [main] git-credential-cache 4308 build_fh_pc: fh 0x612ADE68, dev
001E0079
   83   30201 [main] git-credential-cache 4308 fhandler_base::set_flags: flags
0x10002, supplied_bin 0x0
   26   30227 [main] git-credential-cache 4308 fhandler_base::set_flags:
O_TEXT/O_BINARY set in flags 0x10000
   26   30253 [main] git-credential-cache 4308 fhandler_base::set_flags:
filemode set to binary
   24   30277 [main] git-credential-cache 4308 fdsock: fd 3, name '', soc 0x288
   43   30320 [main] git-credential-cache 4308 cygwin_socket: 3 = socket(1, 1
(flags 0x0), 0)
   35   30355 [main] git-credential-cache 4308 normalize_posix_path: src
/home/jpyeron/.git-credential-cache/socket
   26   30381 [main] git-credential-cache 4308 normalize_posix_path:
/home/jpyeron/.git-credential-cache/socket = normalize_posix_path
(/home/jpyeron/.git-credential-cache/socket)
   26   30407 [main] git-credential-cache 4308 mount_info::conv_to_win32_path:
conv_to_win32_path (/home/jpyeron/.git-credential-cache/socket)
   30   30437 [main] git-credential-cache 4308 set_flags: flags: binary (0x2)
   25   30462 [main] git-credential-cache 4308 mount_info::conv_to_win32_path:
src_path /home/jpyeron/.git-credential-cache/socket, dst
C:\cygwin\home\jpyeron\.git-credential-cache\socket, flags 0x3000A, rc 0
   56   30518 [main] git-credential-cache 4308 symlink_info::check: 0x0 =
NtCreateFile (\??\C:\cygwin\home\jpyeron\.git-credential-cache\socket)
  122   30640 [main] git-credential-cache 4308 symlink_info::check: not a
symlink
   40   30680 [main] git-credential-cache 4308 symlink_info::check: 0 =
symlink.check(C:\cygwin\home\jpyeron\.git-credential-cache\socket, 0x228118)
(0x4003000A)
   57   30737 [main] git-credential-cache 4308 path_conv::check:
this->path(C:\cygwin\home\jpyeron\.git-credential-cache\socket), has_acls(1)
1053395 1084132 [main] git-credential-cache 4308 __set_errno: void
__set_winsock_errno(const char*, int):230 setting errno 0
   88 1084220 [main] git-credential-cache 4308 __set_winsock_errno: connect:1118
- winsock error 0 -> errno 0
   46 1084266 [main] git-credential-cache 4308 getpid: 4308 = getpid()
   37 1084303 [main] git-credential-cache 4308 cygwin_connect: -1 = connect(3,
0x22A5A2, 110), errno 0
   38 1084341 [main] git-credential-cache 4308 close: close(3)
   87 1084428 [main] git-credential-cache 4308 fhandler_socket::close: 0 =
fhandler_socket::close()
   31 1084459 [main] git-credential-cache 4308 close: 0 = close(3)
  237 1084696 [main] git-credential-cache 4308 fhandler_pty_slave::write: pty1,
write(0x463170, 7)
   28 1084724 [main] git-credential-cache 4308 fhandler_pty_slave::write: (656):
pty output_mutex (0x328): waiting -1 ms
   27 1084751 [main] git-credential-cache 4308 fhandler_pty_slave::write: (656):
pty output_mutex: acquired
fatal: 
   55 1084806 [main] git-credential-cache 4308 fhandler_pty_slave::write: (671):
pty output_mutex(0x328) released
   61 1084867 [main] git-credential-cache 4308 write: 7 = write(2, 0x463170, 7)
   59 1084926 [main] git-credential-cache 4308 fhandler_pty_slave::write: pty1,
write(0x229500, 43)
   49 1084975 [main] git-credential-cache 4308 fhandler_pty_slave::write: (656):
pty output_mutex (0x328): waiting -1 ms
   41 1085016 [main] git-credential-cache 4308 fhandler_pty_slave::write: (656):
pty output_mutex: acquired 
unable to connect to cache daemon: No error
   27 1085043 [main] git-credential-cache 4308 fhandler_pty_slave::write: (671):
pty output_mutex(0x328) released
   42 1085085 [main] git-credential-cache 4308 write: 43 = write(2, 0x229500,
43)
   61 1085146 [main] git-credential-cache 4308 fhandler_pty_slave::write: pty1,
write(0x46315C, 1)
   56 1085202 [main] git-credential-cache 4308 fhandler_pty_slave::write: (656):
pty output_mutex (0x328): waiting -1 ms
   38 1085240 [main] git-credential-cache 4308 fhandler_pty_slave::write: (656):
pty output_mutex: acquired
   26 1085266 [main] git-credential-cache 4308 fhandler_pty_slave::write: (671):
pty output_mutex(0x328) released
   39 1085305 [main] git-credential-cache 4308 write: 1 = write(2, 0x46315C, 1)
  618 1085923 [main] git-credential-cache 4308 do_exit: do_exit (32768),
exit_state 1
   35 1085958 [main] git-credential-cache 4308 void: 0x0 = signal (20, 0x1)
   26 1085984 [main] git-credential-cache 4308 void: 0x0 = signal (1, 0x1)
   53 1086037 [main] git-credential-cache 4308 void: 0x0 = signal (2, 0x1)
   36 1086073 [main] git-credential-cache 4308 void: 0x0 = signal (3, 0x1)
   33 1086106 [main] git-credential-cache 4308 fhandler_base::close: closing ''
handle 0x1F4
   30 1086136 [main] git-credential-cache 4308 fhandler_base::close_with_arch:
line 1140:  /dev/pty1<0x612AD988> usecount + -1 = 2
   24 1086160 [main] git-credential-cache 4308 fhandler_base::close_with_arch:
not closing archetype
   56 1086216 [main] git-credential-cache 4308 fhandler_base::close_with_arch:
line 1140:  /dev/pty1<0x612AD988> usecount + -1 = 1
   33 1086249 [main] git-credential-cache 4308 fhandler_base::close_with_arch:
not closing archetype
   40 1086289 [main] git-credential-cache 4308 init_cygheap::close_ctty: closing
cygheap->ctty 0x612AD988
   35 1086324 [main] git-credential-cache 4308 fhandler_base::close_with_arch:
closing passed in archetype 0x0, usecount 0
   26 1086350 [main] git-credential-cache 4308 fhandler_pty_slave::cleanup:
/dev/pty1 closed, usecount 0
   38 1086388 [main] git-credential-cache 4308 fhandler_pty_slave::close:
closing last open /dev/pty1 handle
   97 1086485 [main] git-credential-cache 4308 fhandler_console::free_console:
freed console, res 1
   33 1086518 [main] git-credential-cache 4308 fhandler_pty_common::close: pty1
<0x318,0x310> closing
   44 1086562 [main] git-credential-cache 4308 dtable::delete_archetype:
deleting element 0 for /dev/pty1(136/1)
   36 1086598 [main] git-credential-cache 4308 getpid: 4308 = getpid()
   28 1086626 [main] git-credential-cache 4308 proc_terminate: nprocs 0
   38 1086664 [main] git-credential-cache 4308 proc_terminate: leaving
   51 1086715 [main] git-credential-cache 4308 pinfo::exit: Calling ExitProcess
n 0x8000, exitcode 0x80





An now to delete the socket file.

jpyeron@black /projects/dcarr
$ rm -f ~/.git-credential-cache/socket

jpyeron@black /projects/dcarr
$ echo url=https://example.com | strace -f
/usr/lib/git-core/git-credential-cache get
<snip/>
   23   20000 [main] git-credential-cache 3456 fhandler_pty_slave::open_setup:
/dev/pty1 opened, usecount 3
  457   20457 [main] git-credential-cache 3456 __set_errno: void
dll_crt0_1(void*):999 setting errno 0
  381   20838 [main] git-credential-cache 3456 read: read(0, 0x8003A92F, 8192)
blocking
   32   20870 [main] git-credential-cache 3456 fhandler_base::read: returning
24, binary mode
   24   20894 [main] git-credential-cache 3456 read: 24 = read(0, 0x8003A92F,
8192)
   45   20939 [main] git-credential-cache 3456 read: read(0, 0x8003A947, 12300)
blocking
   25   20964 [main] git-credential-cache 3456 fhandler_base::read: returning 0,
binary mode
   23   20987 [main] git-credential-cache 3456 read: 0 = read(0, 0x8003A947,
12300)
   30   21017 [main] git-credential-cache 3456 cygwin_socket: socket (1, 1
(flags 0x0), 0)
 3227   24244 [main] git-credential-cache 3456 wsock_init: res 0
   35   24279 [main] git-credential-cache 3456 wsock_init: wVersion 514
   24   24303 [main] git-credential-cache 3456 wsock_init: wHighVersion 514
   23   24326 [main] git-credential-cache 3456 wsock_init: szDescription WinSock
2.0
   23   24349 [main] git-credential-cache 3456 wsock_init: szSystemStatus
Running
   23   24372 [main] git-credential-cache 3456 wsock_init: iMaxSockets 0
   23   24395 [main] git-credential-cache 3456 wsock_init: iMaxUdpDg 0
 8770   33165 [main] git-credential-cache 3456 build_fh_pc: fh 0x612ADE68, dev
001E0079
   82   33247 [main] git-credential-cache 3456 fhandler_base::set_flags: flags
0x10002, supplied_bin 0x0
   31   33278 [main] git-credential-cache 3456 fhandler_base::set_flags:
O_TEXT/O_BINARY set in flags 0x10000
   25   33303 [main] git-credential-cache 3456 fhandler_base::set_flags:
filemode set to binary
   26   33329 [main] git-credential-cache 3456 fdsock: fd 3, name '', soc 0x288
   50   33379 [main] git-credential-cache 3456 cygwin_socket: 3 = socket(1, 1
(flags 0x0), 0)
   35   33414 [main] git-credential-cache 3456 normalize_posix_path: src
/home/jpyeron/.git-credential-cache/socket
   31   33445 [main] git-credential-cache 3456 normalize_posix_path:
/home/jpyeron/.git-credential-cache/socket = normalize_posix_path
(/home/jpyeron/.git-credential-cache/socket)
   26   33471 [main] git-credential-cache 3456 mount_info::conv_to_win32_path:
conv_to_win32_path (/home/jpyeron/.git-credential-cache/socket)
   30   33501 [main] git-credential-cache 3456 set_flags: flags: binary (0x2)
   29   33530 [main] git-credential-cache 3456 mount_info::conv_to_win32_path:
src_path /home/jpyeron/.git-credential-cache/socket, dst
C:\cygwin\home\jpyeron\.git-credential-cache\socket, flags 0x3000A, rc 0
   56   33586 [main] git-credential-cache 3456 symlink_info::check: 0xC0000034 =
NtCreateFile (\??\C:\cygwin\home\jpyeron\.git-credential-cache\socket)
   28   33614 [main] git-credential-cache 3456 symlink_info::check: 0xC0000034 =
NtQueryInformationFile (\??\C:\cygwin\home\jpyeron\.git-credential-cache\socket)
   49   33663 [main] git-credential-cache 3456 symlink_info::check: 0xC0000034 =
NtCreateFile (\??\C:\cygwin\home\jpyeron\.git-credential-cache\socket.lnk)
   34   33697 [main] git-credential-cache 3456 symlink_info::check: 0xC0000034 =
NtQueryInformationFile
(\??\C:\cygwin\home\jpyeron\.git-credential-cache\socket.lnk)
   33   33730 [main] git-credential-cache 3456 symlink_info::check: 0 =
symlink.check(C:\cygwin\home\jpyeron\.git-credential-cache\socket, 0x228118)
(0x3000A)
   33   33763 [main] git-credential-cache 3456 mount_info::conv_to_win32_path:
conv_to_win32_path (/home/jpyeron/.git-credential-cache)
   25   33788 [main] git-credential-cache 3456 set_flags: flags: binary (0x2)
   25   33813 [main] git-credential-cache 3456 mount_info::conv_to_win32_path:
src_path /home/jpyeron/.git-credential-cache, dst
C:\cygwin\home\jpyeron\.git-credential-cache, flags 0x3000A, rc 0
   50   33863 [main] git-credential-cache 3456 symlink_info::check: 0x0 =
NtCreateFile (\??\C:\cygwin\home\jpyeron\.git-credential-cache)
   50   33913 [main] git-credential-cache 3456 symlink_info::check: not a
symlink
   37   33950 [main] git-credential-cache 3456 symlink_info::check: 0 =
symlink.check(C:\cygwin\home\jpyeron\.git-credential-cache, 0x228118) (0x3000A)
   30   33980 [main] git-credential-cache 3456 path_conv::check:
this->path(C:\cygwin\home\jpyeron\.git-credential-cache\socket), has_acls(1)
   26   34006 [main] git-credential-cache 3456 __set_errno: int
get_inet_addr(const sockaddr*, int, sockaddr_storage*, int*, int*, int*):129
setting errno 2
   26   34032 [main] git-credential-cache 3456 cygwin_connect: -1 = connect(3,
0x22A5A2, 110), errno 2
   33   34065 [main] git-credential-cache 3456 close: close(3)
   53   34118 [main] git-credential-cache 3456 fhandler_socket::close: 0 =
fhandler_socket::close()
   33   34151 [main] git-credential-cache 3456 close: 0 = close(3)
  366   34517 [main] git-credential-cache 3456 do_exit: do_exit (0), exit_state
1
   25   34542 [main] git-credential-cache 3456 void: 0x0 = signal (20, 0x1)
   26   34568 [main] git-credential-cache 3456 void: 0x0 = signal (1, 0x1)
   24   34592 [main] git-credential-cache 3456 void: 0x0 = signal (2, 0x1)
   26   34618 [main] git-credential-cache 3456 void: 0x0 = signal (3, 0x1)
   33   34651 [main] git-credential-cache 3456 fhandler_base::close: closing ''
handle 0x1E8
   33   34684 [main] git-credential-cache 3456 fhandler_base::close_with_arch:
line 1140:  /dev/pty1<0x612AD988> usecount + -1 = 2
   25   34709 [main] git-credential-cache 3456 fhandler_base::close_with_arch:
not closing archetype
   29   34738 [main] git-credential-cache 3456 fhandler_base::close_with_arch:
line 1140:  /dev/pty1<0x612AD988> usecount + -1 = 1
   30   34768 [main] git-credential-cache 3456 fhandler_base::close_with_arch:
not closing archetype
   25   34793 [main] git-credential-cache 3456 init_cygheap::close_ctty: closing
cygheap->ctty 0x612AD988
   26   34819 [main] git-credential-cache 3456 fhandler_base::close_with_arch:
closing passed in archetype 0x0, usecount 0
   24   34843 [main] git-credential-cache 3456 fhandler_pty_slave::cleanup:
/dev/pty1 closed, usecount 0
   26   34869 [main] git-credential-cache 3456 fhandler_pty_slave::close:
closing last open /dev/pty1 handle
   50   34919 [main] git-credential-cache 3456 fhandler_console::free_console:
freed console, res 1
   33   34952 [main] git-credential-cache 3456 fhandler_pty_common::close: pty1
<0x318,0x310> closing
   34   34986 [main] git-credential-cache 3456 dtable::delete_archetype:
deleting element 0 for /dev/pty1(136/1)
   33   35019 [main] git-credential-cache 3456 getpid: 3456 = getpid()
   33   35052 [main] git-credential-cache 3456 proc_terminate: nprocs 0
   25   35077 [main] git-credential-cache 3456 proc_terminate: leaving
   42   35119 [main] git-credential-cache 3456 pinfo::exit: Calling ExitProcess
n 0x0, exitcode 0x0










--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
