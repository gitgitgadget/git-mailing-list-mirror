From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 17/32] commit_lock_file(): die() if called for unlocked lockfile object
Date: Sat,  6 Sep 2014 09:50:31 +0200
Message-ID: <1409989846-22401-18-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnP-0000Kp-Rb
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbaIFHwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:25 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55668 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078AbaIFHwW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:22 -0400
X-AuditID: 1207440e-f79da6d0000002fc-7b-540abd369933
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.BD.00764.63DBA045; Sat,  6 Sep 2014 03:52:22 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHG006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:21 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqGu2lyvE4NkOEYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujJbWa0wF53kqFrx8ytTAOI+ri5GTQ0LAROLWg8WMELaYxIV769m6
	GLk4hAQuM0qc2n6RBcI5xiQxacETZpAqNgFdiUU9zUwgCRGBNkaJXRc3s4IkmAVSJDqed4ON
	EhaIklgzeRoTiM0ioCqx59gqNhCbV8BV4t/TY6wQ6+QkNuz+D1bPCRSf3tQJZgsJuEi0n+xn
	msDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSKjx7WBsXy9ziFGA
	g1GJh7fQgStEiDWxrLgy9xCjJAeTkihv3nKgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHejslA
	Od6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK/LHqBGwaLU9NSKtMyc
	EoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFB0xBcD4wMkxQO0lxWknbe4IDEXKArReopRl2Nd57d+
	JiGWvPy8VClxXiaQIgGQoozSPLgVsMTyilEc6GNhXjGQKh5gUoKb9ApoCRPQEvN0TpAlJYkI
	KakGRh223BMzKqKcDn8L6P90annw/furJl2/03LFb5ayYf+UTTLyxtHSJ5/yv2bwEAyu2vem
	KUajxz3Dq1tw6eL0upnV0a+XCM5cWCb8WXr54xUJE2V6mua8kkxfnLaqIk9c1PTd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256557>

It was previously a bug to call commit_lock_file() with a lock_file
object that was not active (an illegal access would happen within the
function).  It was presumably never done, but this would be an easy
programming error to overlook.  So before continuing, do a consistency
check that the lock_file object really is locked.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 4 +++-
 lockfile.c                               | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index b53e300..9a94ead 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -68,7 +68,9 @@ commit_lock_file::
 	with an earlier call to `hold_lock_file_for_update()`,
 	close the file descriptor and rename the lockfile to its
 	final destination.  Returns 0 upon success, a negative
-	value on failure to close(2) or rename(2).
+	value on failure to close(2) or rename(2).  It is a bug to
+	call `commit_lock_file()` for a `lock_file` object that is not
+	currently locked.
 
 rollback_lock_file::
 
diff --git a/lockfile.c b/lockfile.c
index d64cf6b..716b674 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -307,6 +307,9 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
 
+	if (!lk->filename[0])
+		die("BUG: attempt to commit unlocked object");
+
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 
-- 
2.1.0
