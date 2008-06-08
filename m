From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: [PATCH] progress.c: avoid use of dynamic-sized array
Date: Sun, 8 Jun 2008 15:37:40 -0600
Message-ID: <Pine.LNX.4.64.0806081536450.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
 <m3prqsvsiq.fsf@localhost.localdomain> <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
 <7vhcc3kbdw.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806081443130.18454@xenau.zenez.com>
 <7v8wxfiq01.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:38:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Sax-0008VA-Nc
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbYFHVhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 17:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756179AbYFHVhm
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:37:42 -0400
Received: from zenez.com ([166.70.62.2]:13265 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127AbYFHVhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 17:37:41 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 7DED5E60B1; Sun,  8 Jun 2008 15:37:40 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 71CBCE5F46;
	Sun,  8 Jun 2008 15:37:40 -0600 (MDT)
In-Reply-To: <7v8wxfiq01.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84328>


Dynamically sized arrays are gcc and C99 construct.  Using them hurts
portability to older compilers, although using them is nice in this case
it is not desirable.  This patch removes the only use of the construct
in stop_progress_msg(); the function is about writing out a single line
of a message, and the existing callers of this function feed messages
of only bounded size anyway, so use of dynamic array is simply overkill.

This is with suggestions from

Daniel Barkalow <barkalow@iabervon.org>
Junio C Hamano <gitster@pobox.com>
Thomas Harning <harningt@gmail.com>
Jeremy Maitin-Shepard <jbms@cmu.edu>

Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047

---
        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

---
progress.c

Changes for older OS's that do not support the current methods for
allocation of memory.

diff --git a/progress.c b/progress.c
index d19f80c..55a8687 100644
--- a/progress.c
+++ b/progress.c
@@ -241,16 +241,21 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
-		char buf[strlen(msg) + 5];
+		char buf[128], *bufp;
+		size_t len = strlen(msg) + 5;
 		struct throughput *tp = progress->throughput;
+
+		bufp = (len < sizeof(buf)) ? buf : xmalloc(len + 1);
 		if (tp) {
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
 			throughput_string(tp, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		sprintf(buf, ", %s.\n", msg);
-		display(progress, progress->last_value, buf);
+		sprintf(bufp, ", %s.\n", msg);
+		display(progress, progress->last_value, bufp);
+		if (buf != bufp)
+			free(bufp);
 	}
 	clear_progress_signal();
 	free(progress->throughput);
-- 
1.5.2.4
