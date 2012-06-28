From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv3 01/10] git p4 test: wait longer for p4d to start and test
 its pid
Date: Wed, 27 Jun 2012 22:48:07 -0400
Message-ID: <20120628024807.GA16349@padd.com>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
 <1340798463-14499-2-git-send-email-pw@padd.com>
 <7vfw9g78w5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 04:48:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk4mF-0002Z5-S7
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 04:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757764Ab2F1CsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 22:48:12 -0400
Received: from honk.padd.com ([74.3.171.149]:35370 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab2F1CsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 22:48:11 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 410D02E87;
	Wed, 27 Jun 2012 19:48:10 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8966431383; Wed, 27 Jun 2012 22:48:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vfw9g78w5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200774>

Running tests at high parallelism on a slow machine, 5 sec is
not enough to wait for p4d to start.  Change it to 5 minutes,
adding an environment variable P4D_START_PATIENCE to shrink
that if needed in automated test environments.

Also check if the pid of the p4d that we started is still
around.  If not, quit waiting for it immediately.

Remove all the confusing && chaining and simplify the code.

Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

gitster@pobox.com wrote on Wed, 27 Jun 2012 14:16 -0700:
> In other words, I think it would make it much more clear to write
> this part like this:
[..]

Much nicer.  I think I got hung up on always &&-chaining
instead of writing the code so it works.  This version steals
your suggestions almost verbatim.  Tested under scenarios
where p4d was slow, hung or died, as well as when it works as
usual.

Just this patch changed; if it's easy to replace one in the
series?  Else I could resend all 10.

		-- Pete

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 121e380..eea46a4 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -33,17 +33,42 @@ pidfile="$TRASH_DIRECTORY/p4d.pid"
 
 start_p4d() {
 	mkdir -p "$db" "$cli" "$git" &&
+	rm -f "$pidfile" &&
 	(
 		p4d -q -r "$db" -p $P4DPORT &
 		echo $! >"$pidfile"
 	) &&
-	for i in 1 2 3 4 5 ; do
-		p4 info >/dev/null 2>&1 && break || true &&
-		echo waiting for p4d to start &&
+
+	# This gives p4d a long time to start up, as it can be
+	# quite slow depending on the machine.  Set this environment
+	# variable to something smaller to fail faster in, say,
+	# an automated test setup.  If the p4d process dies, that
+	# will be caught with the "kill -0" check below.
+	i=${P4D_START_PATIENCE:-300}
+	pid=$(cat "$pidfile")
+	ready=
+	while test $i -gt 0
+	do
+		# succeed when p4 client commands start to work
+		if p4 info >/dev/null 2>&1
+		then
+			ready=true
+			break
+		fi
+		# fail if p4d died
+		kill -0 $pid 2>/dev/null || break
+		echo waiting for p4d to start
 		sleep 1
-	done &&
-	# complain if it never started
-	p4 info >/dev/null &&
+		i=$(( $i - 1 ))
+	done
+
+	if test -z "$ready"
+	then
+		# p4d failed to start
+		return 1
+	fi
+
+	# build a client
 	(
 		cd "$cli" &&
 		p4 client -i <<-EOF
@@ -53,6 +78,7 @@ start_p4d() {
 		View: //depot/... //client/...
 		EOF
 	)
+	return 0
 }
 
 kill_p4d() {
-- 
1.7.11.1.69.g485c1e0
