From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t5570: fix forwarding of git-daemon messages via cat
Date: Thu, 26 Apr 2012 23:00:39 +0200
Message-ID: <4F99B777.4020103@kdbg.org>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl> <20120414121358.GA26372@ecki> <20120414122127.GA31220@ecki> <4F8C3E0F.2040300@in.waw.pl> <20120416174230.GA19226@sigill.intra.peff.net> <20120416224424.GA10314@ecki> <20120419060326.GA13982@sigill.intra.peff.net> <4F8FB779.60004@viscovery.net> <20120426130129.GA27785@sigill.intra.peff.net> <4F999105.200@kdbg.org> <20120426195503.GA29526@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1T?= =?UTF-8?B?em1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Apr 26 23:00:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNVo2-0003QC-SK
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 23:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759391Ab2DZVAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 17:00:46 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:11737 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759154Ab2DZVAp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 17:00:45 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3938A13004F;
	Thu, 26 Apr 2012 23:00:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0BB8719F479;
	Thu, 26 Apr 2012 23:00:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <20120426195503.GA29526@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196413>

The shell function that starts git-daemon wants to read the first line of
the daemon's stderr to ensure that it started correctly. Subsequent daemon
errors should be redirected to fd 4 (which is the terminal in verbose mode
or /dev/null in quiet mode). To that end the shell script used 'read' to
get the first line of output, and then 'cat &' to forward everything else
in a background process.

The problem is, that 'cat >&4 &' does not produce any output because the
shell redirects a background process's stdin to /dev/null. To have this
command invocation do anything useful, we have to redirect its stdin
explicitly (which overrides the /dev/null redirection).

The shell function connects the daemon's stderr to its consumers via a
FIFO. We cannot just do this:

   read line <git_daemon_output
   cat <git_daemon_output >&4 &

because after the first redirection the pipe is closed and the daemon
could receive SIGPIPE if it writes at the wrong moment. Therefore, we open
the readable end of the FIFO only once on fd 7 in the shell and dup from
there to the stdin of the two consumers.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 26.04.2012 21:55, schrieb Clemens Buchacher:
> I won't pretend to understand why this works. I have to study this some
> more. But if this is 'correct', then it is obviously preferable to the
> comparatively complicated wrapper.
> 
> We should move the cat <&7 >&4 & and exec 7<&- part in front of the
> output check, otherwise output would be truncated in an error condition.
> This can be tested by passing an invalid argument to git daemon above,
> for example.

How about this?

 t/lib-git-daemon.sh |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index ef2d01f..87f0ad8 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -31,19 +31,19 @@ start_git_daemon() {
 		>&3 2>git_daemon_output &
 	GIT_DAEMON_PID=$!
 	{
-		read line
+		read line <&7
 		echo >&4 "$line"
-		cat >&4 &
+		cat <&7 >&4 &
+	} 7<git_daemon_output &&
 
-		# Check expected output
-		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
-		then
-			kill "$GIT_DAEMON_PID"
-			wait "$GIT_DAEMON_PID"
-			trap 'die' EXIT
-			error "git daemon failed to start"
-		fi
-	} <git_daemon_output
+	# Check expected output
+	if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
+	then
+		kill "$GIT_DAEMON_PID"
+		wait "$GIT_DAEMON_PID"
+		trap 'die' EXIT
+		error "git daemon failed to start"
+	fi
 }
 
 stop_git_daemon() {
-- 
1.7.10.4.g51807
