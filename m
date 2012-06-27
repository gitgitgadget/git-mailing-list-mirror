From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 01/10] git p4 test: wait longer for p4d to start and test its pid
Date: Wed, 27 Jun 2012 08:00:54 -0400
Message-ID: <1340798463-14499-2-git-send-email-pw@padd.com>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 14:01:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjqw6-0003DF-VC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 14:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab2F0MB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 08:01:27 -0400
Received: from honk.padd.com ([74.3.171.149]:52764 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686Ab2F0MB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 08:01:26 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 529E5D02;
	Wed, 27 Jun 2012 05:01:26 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BCEF531383; Wed, 27 Jun 2012 08:01:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.130.gb957a79
In-Reply-To: <1340798463-14499-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200714>

Running tests at high parallelism on a slow machine, 5 sec is
not enough to wait for p4d to start.  Change it to 5 minutes,
adding an environment variable P4D_START_PATIENCE to shrink
that if needed in automated test environments.

Also check if the pid of the p4d that we started is still
around.  If not, quit waiting for it immediately.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 121e380..2e3706a 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -33,14 +33,27 @@ pidfile="$TRASH_DIRECTORY/p4d.pid"
 
 start_p4d() {
 	mkdir -p "$db" "$cli" "$git" &&
+	rm -f "$pidfile" &&
 	(
 		p4d -q -r "$db" -p $P4DPORT &
 		echo $! >"$pidfile"
 	) &&
-	for i in 1 2 3 4 5 ; do
+	# This gives p4d a long time to start up, as it can be
+	# quite slow depending on the machine.  Set this environment
+	# variable to something smaller to fail faster in, say,
+	# an automated test setup.
+	i=${P4D_START_PATIENCE:-300} &&
+	while [ $i -gt 0 ]; do
+		# succeed when p4 client commands start to work
 		p4 info >/dev/null 2>&1 && break || true &&
+		# fail if pid goes away
+		if [ -f "$pidfile" ] ; then
+		    kill -0 $(cat "$pidfile") || break
+		fi &&
+		# else keep waiting
 		echo waiting for p4d to start &&
-		sleep 1
+		sleep 1 &&
+		i=$(($i - 1))
 	done &&
 	# complain if it never started
 	p4 info >/dev/null &&
-- 
1.7.11.1.69.gd505fd2
