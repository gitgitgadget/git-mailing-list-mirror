From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 5/5] git-daemon tests: wait until daemon is ready
Date: Sat,  7 Jan 2012 12:42:47 +0100
Message-ID: <1325936567-3136-6-git-send-email-drizzd@aon.at>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 12:51:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjUoE-0003Hb-Il
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 12:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab2AGLvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 06:51:19 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:36279 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752180Ab2AGLvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 06:51:15 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id A757ACDF83;
	Sat,  7 Jan 2012 12:52:09 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1325936567-3136-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188071>

In start_daemon, git-daemon is started as a background process.  In
theory, the tests may try to connect before the daemon had a chance
to open a listening socket. Avoid this race condition by waiting
for it to output "Ready to rumble". Any other output is considered
an error and the test is aborted.

Should git-daemon produce no output at all, lib-git-daemon would
block forever. This could be fixed by introducing a timeout.  On
the other hand, we have no timeout for other git commands which
could suffer from the same problem. Since such a mechanism adds
some complexity, I have decided against it.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/lib-git-daemon.sh |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 5e81a25..ef2d01f 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -23,12 +23,27 @@ start_git_daemon() {
 	trap 'code=$?; stop_git_daemon; (exit $code); die' EXIT
 
 	say >&3 "Starting git daemon ..."
+	mkfifo git_daemon_output
 	git daemon --listen=127.0.0.1 --port="$LIB_GIT_DAEMON_PORT" \
 		--reuseaddr --verbose \
 		--base-path="$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
 		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
-		>&3 2>&4 &
+		>&3 2>git_daemon_output &
 	GIT_DAEMON_PID=$!
+	{
+		read line
+		echo >&4 "$line"
+		cat >&4 &
+
+		# Check expected output
+		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
+		then
+			kill "$GIT_DAEMON_PID"
+			wait "$GIT_DAEMON_PID"
+			trap 'die' EXIT
+			error "git daemon failed to start"
+		fi
+	} <git_daemon_output
 }
 
 stop_git_daemon() {
@@ -50,4 +65,5 @@ stop_git_daemon() {
 		error "git daemon exited with status: $ret"
 	fi
 	GIT_DAEMON_PID=
+	rm -f git_daemon_output
 }
-- 
1.7.8
