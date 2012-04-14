From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] t5570: forward git-daemon messages in a different way
Date: Sat, 14 Apr 2012 10:44:30 +0200
Message-ID: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com,
	Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Apr 14 10:44:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIybE-00060Q-Gf
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 10:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab2DNIoq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 04:44:46 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34860 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab2DNIop (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 04:44:45 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SIyb3-0001XX-TI; Sat, 14 Apr 2012 10:44:42 +0200
X-Mailer: git-send-email 1.7.10.226.gfe575
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195481>

git-daemon is not launched properly in t5570:

$ GIT_TEST_GIT_DAEMON=3Dt ./t5570-git-daemon.sh
ok 1 - setup repository
ok 2 - create git-accessible bare repository
not ok - 3 clone git repository
not ok - 4 fetch changes via git protocol
=2E..

Current setup code to spawn git daemon (start_git_daemon() in
lib-git-daemon.sh) redirects daemon output to a pipe, and then
redirects input from this pipe to a different fd, which is in turn
connected to a terminal:
  mkfifo git_daemon_output
  git daemon ... >&3 2>git_daemon_output
  {
      ...
      cat >&4
  } <git_daemon_output

Unfortunately, it seems that the shell (at least bash 4.1-3 from
debian) closes the pipe and cat doesn't really copy any messages. This
causes git-daemon to die.

Running 'strace -o log cat' instead of just 'cat' shows that no input
is read:
  execve("/bin/cat", ...)   =3D 0
  ...
  read(0, "", 8192)         =3D 0
  close(0)                  =3D 0
  close(1)                  =3D 0
  close(2)                  =3D 0
  exit_group(0)             =3D ?

I guess that the shell closes the redirection when exiting the
{}-delimited part. It seems easiest to move the cat invocation outside
of the {}-delimited part and provide a separate redirection which will
not be closed.

While at it, print the address on which git-daemon is started, to make
debugging easier.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/lib-git-daemon.sh |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index ef2d01f..8f9c1b6 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -22,7 +22,7 @@ start_git_daemon() {
=20
 	trap 'code=3D$?; stop_git_daemon; (exit $code); die' EXIT
=20
-	say >&3 "Starting git daemon ..."
+	say >&3 "Starting git daemon on $GIT_DAEMON_URL ..."
 	mkfifo git_daemon_output
 	git daemon --listen=3D127.0.0.1 --port=3D"$LIB_GIT_DAEMON_PORT" \
 		--reuseaddr --verbose \
@@ -33,7 +33,6 @@ start_git_daemon() {
 	{
 		read line
 		echo >&4 "$line"
-		cat >&4 &
=20
 		# Check expected output
 		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" !=3D x"Ready to rum=
ble"
@@ -44,6 +43,8 @@ start_git_daemon() {
 			error "git daemon failed to start"
 		fi
 	} <git_daemon_output
+
+	cat <git_daemon_output >&4 &
 }
=20
 stop_git_daemon() {
--=20
1.7.10.226.gfe575
