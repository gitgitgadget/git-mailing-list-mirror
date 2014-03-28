From: "Gerhard Grimm" <gerhard.grimm@detec.com>
Subject: Problems with git 1.8.5.3 on HP-UX 11.11
Date: Fri, 28 Mar 2014 11:09:14 -0000
Message-ID: <8FDD21D28EC16844948E2A773083574A03363EBC@m4ukex08.intranet.macro4.com>
References: <9D24AD27564FAE4CB8D0C15D080DEFCB0106A89226@m4ukex08.intranet.macro4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 12:09:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTUf6-0002VG-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 12:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbaC1LJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2014 07:09:18 -0400
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:45343 "HELO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751119AbaC1LJR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 07:09:17 -0400
Received: from m4ukex01.intranet.macro4.com ([217.32.206.41]) by eu1sys200aob113.postini.com ([207.126.147.11]) with SMTP
	ID DSNKUzVYW3tqsJz4cnns5ai9XBZJzjJGMBgN@postini.com; Fri, 28 Mar 2014 11:09:16 UTC
Received: from m4ukex08.intranet.macro4.com ([10.0.24.51]) by m4ukex01.intranet.macro4.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 28 Mar 2014 11:09:15 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <9D24AD27564FAE4CB8D0C15D080DEFCB0106A89226@m4ukex08.intranet.macro4.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with git 1.8.5.3 on HP-UX 11.11
Thread-Index: Ac9J5Hlf9BjLdD4LRz6lQa2SJjlKfQAkOjug
X-OriginalArrivalTime: 28 Mar 2014 11:09:15.0424 (UTC) FILETIME=[27F8B200:01CF4A76]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245379>

In order to set up automated builds and tests of the CMake toolchain (w=
ww.cmake.org) on HP-UX 11.11 (hppa) and 11.23 (ia64), I needed to insta=
ll git on those platforms.
The latest binary package available from hpux.connect.org.uk is version=
 1.8.5.3, which I installed with all of its dependencies.
When trying to set up the CMake build, I ran into the first problem:

$ git pull origin
error: cannot create thread: Function is not available
fatal: fetch-pack: unable to fork off sideband demultiplexer

So I examined the git source package and found that the author of the H=
P-UX port forgot to set

PTHREAD_CFLAGS=3D-mt

in config.mak.autogen to enable threading. I added this setting and reb=
uilt git. On 11.23, everything was fine now - no further issues.
On 11.11 though, git now crashed with a Bus Error. Some debugging showe=
d that this was due to a multithreading issue - obviously some dependen=
cy library has not been built as reentrant code. To fix this, I disable=
d threading by setting

PTHREAD_CFLAGS=3D
NO_PTHREADS=3DYesPlease

in config.mak.autogen and rebuilt git again. After that, "git pull" and=
 "git fetch" worked correctly and I could proceed to set up the CMake b=
uild and test.
Alas, the CMake tests include a test case "CTest.UpdateGIT" that create=
s a git repository, creates a submodule, imports some content and attem=
pts to check out a revision. At that point, the command

git submodule init

fails with the output

=A0=A0=A0 Assertion failed: err =3D=3D REG_ESPACE, file compat/regex/re=
gexec.c, line 1096
=A0=A0=A0 No submodule mapping found in .gitmodules for path 'module'

and the stacktrace of the resulting core dump is

#0=A0 0xc020ced0 in kill+0x10 () from /usr/lib/libc.2
#1=A0 0xc01a7f84 in raise+0x24 () from /usr/lib/libc.2
#2=A0 0xc01e9308 in abort_C+0x160 () from /usr/lib/libc.2
#3=A0 0xc01e9364 in abort+0x1c () from /usr/lib/libc.2
#4=A0 0xc0176998 in _assert+0x178 () from /usr/lib/libc.2
#5=A0 0x205fa0 in check_matching+0x290 ()
#6=A0 0x2053b8 in re_search_internal+0x128 ()
#7=A0 0x204ac0 in regexec+0xc8 ()
#8=A0 0x4da40 in collect_config+0x60 ()
#9=A0 0x108b30 in get_value+0xd8 ()
#10 0x108efc in git_parse_source+0x1bc ()
#11 0x10ac70 in do_config_from+0x70 ()
#12 0x10ad3c in git_config_from_file+0x8c ()
#13 0x10b274 in git_config_with_options+0x84 ()
#14 0x4dd6c in get_value+0x224 ()
#15 0x4eed4 in cmd_config+0x744 ()
#16 0x17150 in run_builtin+0x110 ()
#17 0x1739c in handle_internal_command+0xcc ()
#18 0x174fc in run_argv+0x2c ()
#19 0x17724 in main+0x194 ()

Since I'm no git expert (I'm not even a regular git user in fact), ther=
e's nothing left for me to do except asking for help...
Please CC me (gerhard dot grimm at detec dot com) with any replies sinc=
e I'm not subscribed to the list. Thank you!

Best regards,

Gerhard
This e-mail message has been scanned and cleared by Postini / Google Me=
ssage Security and the UNICOM Global security systems. This message is =
for the named person's use only. If you receive this message in error, =
please delete it and notify the sender.=20
=0D
