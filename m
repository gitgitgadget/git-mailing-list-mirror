From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Sat, 14 Apr 2012 14:13:58 +0200
Message-ID: <20120414121358.GA26372@ecki>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sat Apr 14 14:15:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ1tS-00009A-24
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 14:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab2DNMPR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 08:15:17 -0400
Received: from smtpout11.highway.telekom.at ([195.3.96.69]:4659 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755480Ab2DNMPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 08:15:17 -0400
Received: (qmail 20970 invoked from network); 14 Apr 2012 12:15:12 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL605.highway.telekom.at
X-Spam-Level: 
Received: from p5b22caa4.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.202.164])
          (envelope-sender <drizzd@aon.at>)
          by smarthub79.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <zbyszek@in.waw.pl>; 14 Apr 2012 12:15:11 -0000
Content-Disposition: inline
In-Reply-To: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195486>

On Sat, Apr 14, 2012 at 10:44:30AM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:
> git-daemon is not launched properly in t5570:
>=20
> $ GIT_TEST_GIT_DAEMON=3Dt ./t5570-git-daemon.sh
> ok 1 - setup repository
> ok 2 - create git-accessible bare repository
> not ok - 3 clone git repository
> not ok - 4 fetch changes via git protocol
> ...
>=20
> Current setup code to spawn git daemon (start_git_daemon() in
> lib-git-daemon.sh) redirects daemon output to a pipe, and then
> redirects input from this pipe to a different fd, which is in turn
> connected to a terminal:
>   mkfifo git_daemon_output
>   git daemon ... >&3 2>git_daemon_output
>   {
>       ...
>       cat >&4
>   } <git_daemon_output
>=20
> Unfortunately, it seems that the shell (at least bash 4.1-3 from
> debian) closes the pipe and cat doesn't really copy any messages. Thi=
s
> causes git-daemon to die.

And as a consequence, t5570 tests fail for you? I cannot reproduce with
bash 4.2.24(2). Which git version are you seeing this with?

> Running 'strace -o log cat' instead of just 'cat' shows that no input
> is read:
>   execve("/bin/cat", ...)   =3D 0
>   ...
>   read(0, "", 8192)         =3D 0
>   close(0)                  =3D 0
>   close(1)                  =3D 0
>   close(2)                  =3D 0
>   exit_group(0)             =3D ?

What do you expect it to read? If git-daemon exits without error, it
does not output anything.

> I guess that the shell closes the redirection when exiting the
> {}-delimited part.

I am not sure about that part myself, but it seems to work for me in al=
l
cases.

> It seems easiest to move the cat invocation outside of the
> {}-delimited part and provide a separate redirection which will not b=
e
> closed.

With your patch, only the first line of output will be read from
git-daemon, because the pipe is broken as soon as you close the fifo fo=
r
the first time. You can check this by passing an invalid argument to
git-daemon. Only the first line of the usage string will be printed.

In order to better understand the problem on your side, can you execute
this script and tell me what it does for you?

#!/bin/sh

mkfifo fd
yes >fd &
pid=3D$!
{
	read line
	echo $line
} <fd
cat <fd &
sleep 1
kill $pid
wait $pid
rm -f fd

If we cannot find a reliable solution using shell script, we should
probably write a test-git-daemon wrapper which implements the expected
output checking part in C.

Clemens
