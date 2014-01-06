From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/17] safe_create_leading_directories(): add new error value SCLD_VANISHED
Date: Mon,  6 Jan 2014 14:45:27 +0100
Message-ID: <1389015935-21936-10-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AVk-0005xc-PY
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbaAFNq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:27 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50966 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754557AbaAFNq0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:26 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-4b-52cab3b126d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id AF.39.19161.1B3BAC25; Mon,  6 Jan 2014 08:46:25 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfPA021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:23 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLtx86kgg093OSy6rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzNl75x1RwQKzi44MlbA2MbwS7GDk5JARMJJ5OuMIIYYtJXLi3nq2LkYtDSOAyo8TV
	yXdYQBJCAseYJLquR4DYbAK6Eot6mplAbBEBNYmJbYdYQBqYBRYzSnRN+wY2SVggTmJL43Jm
	EJtFQFXi885LrCA2r4CrxLynr4A2cABtU5BYfV0IJMwJFJ427TAbxC4XiTWHHrFMYORdwMiw
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkpPh2MLavlznEKMDBqMTD++Hx
	ySAh1sSy4srcQ4ySHExKorycq08FCfEl5adUZiQWZ8QXleakFh9ilOBgVhLh5VoAlONNSays
	Si3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfBu2ATUKFiUmp5akZaZU4KQZuLg
	BBFcIBt4gDZcASnkLS5IzC3OTIcoOsWoKCXOex4kIQCSyCjNgxsAi/5XjOJA/wjzbgGp4gEm
	DrjuV0CDmYAGh8aBDS5JREhJNTAaX+ixzees8pm+VrNYZ3tp4d99MXo1K1VnvVi7+MLeS2I/
	b/474B36foHYs1l/2Q7svD/dol/A9FiA36Pb2oLzFHZrTJ7JX3Vh7YFrFw1bfs09sGXKlN2R
	RjmbVj9fVppu037M2qFsm76YqVRicttEk/qk55pmdjPdwgodb/szppxVy7Z6dotT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239996>

Add a new possible error result that can be returned by
safe_create_leading_directories() and
safe_create_leading_directories_const(): SCLD_VANISHED.  This value
indicates that a file or directory on the path existed at one point
(either it already existed or the function created it), but then it
disappeared.  This probably indicates that another process deleted the
directory while we were working.  If SCLD_VANISHED is returned, the
caller might want to retry the function call, as there is a chance
that a new attempt will succeed.

Why doesn't safe_create_leading_directories() do the retrying
internally?  Because an empty directory isn't really ever safe until
it holds a file.  So even if safe_create_leading_directories() were
absolutely sure that the directory existed before it returned, there
would be no guarantee that the directory still existed when the caller
tried to write something in it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h     | 10 +++++++++-
 sha1_file.c | 11 +++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index c6a4157..f34c0a7 100644
--- a/cache.h
+++ b/cache.h
@@ -741,12 +741,20 @@ int adjust_shared_perm(const char *path);
  * Create the directory containing the named path, using care to be
  * somewhat safe against races.  Return one of the scld_error values
  * to indicate success/failure.
+ *
+ * SCLD_VANISHED indicates that one of the ancestor directories of the
+ * path existed at one point during the function call and then
+ * suddenly vanished, probably because another process pruned the
+ * directory while we were working.  To be robust against this kind of
+ * race, callers might want to try invoking the function again when it
+ * returns SCLD_VANISHED.
  */
 enum scld_error {
 	SCLD_OK = 0,
 	SCLD_FAILED = -1,
 	SCLD_PERMS = -2,
-	SCLD_EXISTS = -3
+	SCLD_EXISTS = -3,
+	SCLD_VANISHED = -4
 };
 enum scld_error safe_create_leading_directories(char *path);
 enum scld_error safe_create_leading_directories_const(const char *path);
diff --git a/sha1_file.c b/sha1_file.c
index 5594f11..69a4e95 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -132,6 +132,17 @@ enum scld_error safe_create_leading_directories(char *path)
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
 				; /* somebody created it since we checked */
+			else if (errno == ENOENT)
+				/*
+				 * Either mkdir() failed because
+				 * somebody just pruned the containing
+				 * directory, or stat() failed because
+				 * the file that was in our way was
+				 * just removed.  Either way, inform
+				 * the caller that it might be worth
+				 * trying again:
+				 */
+				ret = SCLD_VANISHED;
 			else
 				ret = SCLD_FAILED;
 		} else if (adjust_shared_perm(path)) {
-- 
1.8.5.2
