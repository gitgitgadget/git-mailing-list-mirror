From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/8] commit_ref_update(): new function, extracted from write_ref_sha1()
Date: Sun, 10 May 2015 04:45:33 +0200
Message-ID: <1431225937-10456-5-git-send-email-mhagger@alum.mit.edu>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 10 04:46:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrHFw-0001a1-FQ
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 04:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbbEJCqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 22:46:04 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47708 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752119AbbEJCp7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 22:45:59 -0400
X-AuditID: 1207440d-f79976d000005643-18-554ec663a6df
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B2.10.22083.366CE455; Sat,  9 May 2015 22:45:55 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3166.dip0.t-ipconnect.de [93.219.49.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4A2jkxc015925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 9 May 2015 22:45:54 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqJt8zC/UYGOPjEXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLxZk3jYwObB5/339g8liwqdTjWe8eRo+Ll5Q9Fj/w8vi8SS6ALYrb
	JimxpCw4Mz1P3y6BO+PNtGmsBb/4Kya97WFuYLzC08XIySEhYCKx5dspdghbTOLCvfVsXYxc
	HEIClxklZnTMYIVwjjNJLL25iQ2kik1AV2JRTzNTFyMHh4iAl0TbzGKQGmaBXkaJR4tfMYLU
	CAtESSycvYcZxGYRUJXYdv8fM0g9r4CLxMZ9uhDL5CTOH/8JVsIp4Cpx+8xcMFsIqKRxaRPL
	BEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFCQox3B+P/dTKHGAU4
	GJV4eGds8QsVYk0sK67MPcQoycGkJMprsxAoxJeUn1KZkVicEV9UmpNafIhRgoNZSYT35Hqg
	HG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgvfCEaBGwaLU9NSKtMyc
	EoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBkxBcDYwMkxQO01+YoyN7igsRcoChE6ylGRSlx3ukg
	cwVAEhmleXBjYYnjFaM40JfCvLdAqniASQeu+xXQYCagwX+LfUAGlyQipKQaGJM8aidYtk5y
	MhPMUD027bpQR+vWys09k45dZu9yefPGNOHyh6qG15+k9iSv4A2Lbz6x6lcP59Mv7xetzXl1
	yfR/8YrdtzbIaEmcSRHiKr4cdOpR0q6tXhmViyo2HZK4LqThNWt/5pGmVxFv/ogE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268720>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 9e40c35..7661db9 100644
--- a/refs.c
+++ b/refs.c
@@ -3085,24 +3085,13 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 }
 
 /*
- * Write sha1 into the ref specified by the lock. Make sure that errno
- * is sane on error.
+ * Commit a change to a loose reference that has already been written
+ * to the loose reference lockfile. Also update the reflogs if
+ * necessary, using the specified lockmsg (which can be NULL).
  */
-static int write_ref_sha1(struct ref_lock *lock,
-	const unsigned char *sha1, const char *logmsg)
+static int commit_ref_update(struct ref_lock *lock,
+			     const unsigned char *sha1, const char *logmsg)
 {
-	if (!lock) {
-		errno = EINVAL;
-		return -1;
-	}
-	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
-		unlock_ref(lock);
-		return 0;
-	}
-
-	if (write_ref_to_lockfile(lock, sha1))
-		return -1;
-
 	clear_loose_ref_cache(&ref_cache);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
@@ -3141,6 +3130,30 @@ static int write_ref_sha1(struct ref_lock *lock,
 	return 0;
 }
 
+/*
+ * Write sha1 as the new value of the reference specified by the
+ * (open) lock. On error, roll back the lockfile and set errno
+ * appropriately.
+ */
+static int write_ref_sha1(struct ref_lock *lock,
+			  const unsigned char *sha1, const char *logmsg)
+{
+	if (!lock) {
+		errno = EINVAL;
+		return -1;
+	}
+	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
+		unlock_ref(lock);
+		return 0;
+	}
+
+	if (write_ref_to_lockfile(lock, sha1) ||
+	    commit_ref_update(lock, sha1, logmsg))
+		return -1;
+
+	return 0;
+}
+
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-- 
2.1.4
