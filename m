From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/17] lock_ref_sha1_basic(): on SCLD_VANISHED, retry
Date: Sat, 18 Jan 2014 23:48:54 +0100
Message-ID: <1390085341-2553-11-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiG-0005CE-Ii
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbaARWtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:50 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50653 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751755AbaARWtl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:41 -0500
X-AuditID: 1207440f-b7f306d000006d99-e1-52db050499dd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 63.EB.28057.4050BD25; Sat, 18 Jan 2014 17:49:40 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN93030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:39 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqMvCejvI4Gm7rkXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGdcurGauWAGb8XNnk62Bsbr
	XF2MHBwSAiYSN7ZWdTFyApliEhfurWfrYuTiEBK4zChxft0GdpCEkMAJJokd33VBbDYBXYlF
	Pc1MILaIgJrExLZDLCA2s4CDxObPjYwgtrCAh8SKfUfYQGwWAVWJ/RdPgtXzCrhIHFo/mQVi
	r4LE6utCIGFOoPCR+ReYIFY5S9x8/YR9AiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	Jnq5mSV6qSmlmxghYcK/g7FrvcwhRgEORiUe3oNMt4OEWBPLiitzDzFKcjApifIqg4T4kvJT
	KjMSizPii0pzUosPMUpwMCuJ8AZvuBUkxJuSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpa
	kFoEk5Xh4FCS4PVmARoqWJSanlqRlplTgpBm4uAEEVwgG3hANoAU8hYXJOYWZ6ZDFJ1iVJQS
	5w0HSQiAJDJK8+AGwCL6FaM40D/CEFU8wGQA1/0KaDAT0GCR2Jsgg0sSEVJSDYzSWrXRf4Qi
	l77YcpSrYaGqc92WH/fEw7QE196WSNPZcfJvwrzTQQWyc01eCSz+7CRZZsRcdctH+/XWZ9e6
	Gmblna7gPBRyRfeKcEDdxOdX0ycVFUeLf3DkCWExzHDRuveLpU7wz8qEsh06L2Ye/KKxXi36
	moJuzdlc12A+pXNrOBxK1z15PVWJpTgj0VCLuag4EQAWtz6ZwwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240661>

If safe_create_leading_directories() fails because a file along the
path unexpectedly vanished, try again (up to 3 times).

This can occur if another process is deleting directories at the same
time as we are trying to make them.  For example, "git pack-refs
--all" tries to delete the loose refs and any empty directories that
are left behind.  If a pack-refs process is running, then it might
delete a directory that we need to put a new loose reference in.

If safe_create_leading_directories() thinks this might have happened,
then take its advice and try again (maximum three attempts).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 490b57b..9ae184d 100644
--- a/refs.c
+++ b/refs.c
@@ -2039,6 +2039,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int missing = 0;
+	int attempts_remaining = 3;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
@@ -2093,7 +2094,15 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
 		lock->force_write = 1;
 
-	if (safe_create_leading_directories(ref_file)) {
+ retry:
+	switch (safe_create_leading_directories(ref_file)) {
+	case SCLD_OK:
+		break; /* success */
+	case SCLD_VANISHED:
+		if (--attempts_remaining > 0)
+			goto retry;
+		/* fall through */
+	default:
 		last_errno = errno;
 		error("unable to create directory for %s", ref_file);
 		goto error_return;
-- 
1.8.5.2
