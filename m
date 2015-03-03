From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 6/7] reflog_expire(): ignore --updateref for symbolic references
Date: Tue,  3 Mar 2015 12:43:16 +0100
Message-ID: <1425382997-24984-7-git-send-email-mhagger@alum.mit.edu>
References: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSlEp-0003qK-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbbCCLnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:43:43 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61132 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756413AbbCCLnm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 06:43:42 -0500
X-AuditID: 1207440f-f792a6d000001284-11-54f59e6d89fd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F9.4F.04740.D6E95F45; Tue,  3 Mar 2015 06:43:41 -0500 (EST)
Received: from michael.fritz.box (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23BhJqJ016748
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 06:43:39 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqJs772uIwdGtYhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3Bl98zezFFyUrmh7O5WlgbFFrIuR
	k0NCwETiw7EfbBC2mMSFe+uBbC4OIYHLjBInL99mh3COMUmcObGcFaSKTUBXYlFPMxOILSKg
	JjGx7RALiM0s8INJ4tCKWhBbWCBYoqnrJthUFgFViRmXFoHV8Aq4SOx9NpsZYpucxPnjP8Fs
	TgFXiZVrtwLN5wBa5iJx60PFBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0
	UlNKNzFCQpF/B2PXeplDjAIcjEo8vBPYv4YIsSaWFVfmHmKU5GBSEuWVnw0U4kvKT6nMSCzO
	iC8qzUktPsQowcGsJMLLPBcox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh
	4FCS4J0E0ihYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioz4YmBsgKR4gPb+nAOy
	t7ggMRcoCtF6ilFRSpxXFmSuAEgiozQPbiwswbxiFAf6Upg3HqSKB5ic4LpfAQ1mAhp8S/EL
	yOCSRISUVAOjy7Um1gBXKc+VMtfl1j3i7RcXeO8tbl+/rPhUYMjTANs/cTHOtS6HdxcqLujv
	fNyZcXF6+sdbsYYPMp9lWdQoWaRN/T01oosl1nWhAfOk2fzu744IXTJT8A96d2Xv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264653>

If we are expiring reflog entries for a symbolic reference, then how
should --updateref be handled if the newest reflog entry is expired?

Option 1: Update the referred-to reference. (This is what the current
code does.) This doesn't make sense, because the referred-to reference
has its own reflog, which hasn't been rewritten.

Option 2: Update the symbolic reference itself (as in, REF_NODEREF).
This would convert the symbolic reference into a non-symbolic
reference (e.g., detaching HEAD), which is surely not what a user
would expect.

Option 3: Error out. This is plausible, but it would make the
following usage impossible:

    git reflog expire ... --updateref --all

Option 4: Ignore --updateref for symbolic references.

We choose to implement option 4.

Note: another problem in this code will be fixed in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-reflog.txt |  3 ++-
 refs.c                       | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 730106c..5e7908e 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -88,7 +88,8 @@ Options for `expire`
 
 --updateref::
 	Update the reference to the value of the top reflog entry (i.e.
-	<ref>@\{0\}) if the previous top entry was pruned.
+	<ref>@\{0\}) if the previous top entry was pruned.  (This
+	option is ignored for symbolic references.)
 
 --rewrite::
 	If a reflog entry's predecessor is pruned, adjust its "old"
diff --git a/refs.c b/refs.c
index 7a2f53f..48bb9e8 100644
--- a/refs.c
+++ b/refs.c
@@ -4028,6 +4028,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
+	int type;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -4039,7 +4040,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, &type);
 	if (!lock)
 		return error("cannot lock ref '%s'", refname);
 	if (!reflog_exists(refname)) {
@@ -4076,10 +4077,18 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	(*cleanup_fn)(cb.policy_cb);
 
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+		/*
+		 * It doesn't make sense to adjust a reference pointed
+		 * to by a symbolic ref based on expiring entries in
+		 * the symbolic reference's reflog.
+		 */
+		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+			!(type & REF_ISSYMREF);
+
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+		} else if (update &&
 			(write_in_full(lock->lock_fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
@@ -4090,7 +4099,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		} else if (commit_lock_file(&reflog_lock)) {
 			status |= error("unable to commit reflog '%s' (%s)",
 					log_file, strerror(errno));
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
+		} else if (update && commit_ref(lock)) {
 			status |= error("couldn't set %s", lock->ref_name);
 		}
 	}
-- 
2.1.4
