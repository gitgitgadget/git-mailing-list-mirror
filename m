From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/6] avoid use of pkill
Date: Wed,  4 Jan 2012 16:55:36 +0100
Message-ID: <1325692539-26748-4-git-send-email-drizzd@aon.at>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 17:04:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiTKI-0001z4-BL
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 17:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197Ab2ADQES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 11:04:18 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:51905 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756137Ab2ADQED (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 11:04:03 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id CF3AA2C4012;
	Wed,  4 Jan 2012 17:04:55 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1325692539-26748-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187931>

---
 t/lib-daemon.sh |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/t/lib-daemon.sh b/t/lib-daemon.sh
index 30a89ea..5edced5 100644
--- a/t/lib-daemon.sh
+++ b/t/lib-daemon.sh
@@ -31,6 +31,24 @@ start_daemon() {
 	DAEMON_PID=$!
 }
 
+kill_children() {
+	parent=$1
+
+	ps -A -o ppid,pid |
+	(
+		# skip header
+		read
+		while read ppid pid
+		do
+			if test x"$ppid" = x"$parent"
+			then
+				echo "$pid"
+			fi
+		done
+	) |
+	xargs kill
+}
+
 stop_daemon() {
 	if test -z "$DAEMON_PID"
 	then
@@ -41,7 +59,7 @@ stop_daemon() {
 
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
-	pkill -P "$DAEMON_PID"
+	kill_children "$DAEMON_PID"
 	wait "$DAEMON_PID"
 	ret=$?
 	if test $ret -ne 143
-- 
1.7.8
