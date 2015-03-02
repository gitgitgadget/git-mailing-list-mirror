From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/7] reflog_expire(): ignore --updateref for symbolic references
Date: Mon,  2 Mar 2015 10:29:56 +0100
Message-ID: <1425288597-20547-7-git-send-email-mhagger@alum.mit.edu>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:30:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMgS-0007Nu-3X
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbbCBJaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:30:30 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64808 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744AbbCBJaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 04:30:25 -0500
X-AuditID: 12074413-f79f26d0000030e7-6d-54f42db09dc1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.F9.12519.0BD24F45; Mon,  2 Mar 2015 04:30:24 -0500 (EST)
Received: from michael.fritz.box (p5DDB2321.dip0.t-ipconnect.de [93.219.35.33])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t229U5HZ008921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 2 Mar 2015 04:30:22 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLtB90uIwZVzIhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3BnnPx1jKXgkXbFx0XXmBsYpYl2M
	nBwSAiYS3T+3MkLYYhIX7q1n62Lk4hASuMwo0b79GwtIQkjgGJPE0YkBIDabgK7Eop5mJhBb
	REBNYmLbIbAaZoEfTBKHVtR2MXJwCAsESyyeFQMSZhFQlbjd1MUOYvMKuEj8334eapecxPnj
	P5lBbE4BV4mfvxrZIVa5SMy6vpp5AiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5
	mSV6qSmlmxghgSi8g3HXSblDjAIcjEo8vAvmfQ4RYk0sK67MPcQoycGkJMp7XOdLiBBfUn5K
	ZUZicUZ8UWlOavEhRgkOZiUR3tfyQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILU
	IpisDAeHkgTvDpChgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aC4iC8GRgZIigdo
	712Qdt7igsRcoChE6ylGRSlx3m6QhABIIqM0D24sLL28YhQH+lKY9y9IFQ8wNcF1vwIazAQ0
	+JYi2OCSRISUVANjQZ7s9neGP5XmXDzVVXNqenHq3bRTmeZGO38F7wxdI9eysVz0lOGReV+X
	Z7z9pzTBhr1xm36u35n/jlnznzhLrdlqufRUp8eig3NYeq+JRZb+n9acG7f/vYDD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264582>

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
index 3af9422..d49db7c 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -89,7 +89,8 @@ Options for `expire` and/or `delete`
 
 --updateref::
 	Update the reference to the value of the top reflog entry (i.e.
-	<ref>@\{0\}) if the previous top entry was pruned.
+	<ref>@\{0\}) if the previous top entry was pruned.  (This
+	option is ignored for symbolic references.)
 
 --rewrite::
 	While expiring or deleting, adjust each reflog entry's "old"
diff --git a/refs.c b/refs.c
index f2e9883..bd47d23 100644
--- a/refs.c
+++ b/refs.c
@@ -4026,6 +4026,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
+	int type;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -4037,7 +4038,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, &type);
 	if (!lock)
 		return error("cannot lock ref '%s'", refname);
 	if (!reflog_exists(refname)) {
@@ -4074,10 +4075,18 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
@@ -4088,7 +4097,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
