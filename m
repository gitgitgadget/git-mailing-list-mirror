From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/8] reflog_expire(): ignore --updateref for symbolic references
Date: Mon,  9 Feb 2015 10:12:42 +0100
Message-ID: <1423473164-6011-7-git-send-email-mhagger@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:20:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKkWN-0002Ml-EY
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060AbbBIJUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:20:42 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52470 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932379AbbBIJUl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 04:20:41 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2015 04:20:41 EST
X-AuditID: 1207440f-f792a6d000001284-e2-54d87a1c53da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.D7.04740.C1A78D45; Mon,  9 Feb 2015 04:13:00 -0500 (EST)
Received: from michael.fritz.box (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t199CnQc026231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 04:12:59 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqCtTdSPEYM80I4uuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZExd+ZS84KF3x8cQh5gbG76JdjJwcEgImEpPevmSHsMUkLtxbzwZi
	CwlcZpS4N0mni5ELyD7BJHFqz0FmkASbgK7Eop5mJhBbREBNYmLbIRYQm1lgNZPE1rtgzcIC
	ARJn+6+wdjFycLAIqEosPhYAEuYVcJbovH0AapecxPnjP8FGcgq4SLw7Nwdqr7PE7Mn7mCcw
	8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuil5tZopeaUrqJERJi/DsYu9bLHGIU4GBU
	4uGt+Hg9RIg1say4MvcQoyQHk5Io74LEGyFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHi/ZwDl
	eFMSK6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1MLUotgsjIcHEoSvHMqgBoFi1LTUyvSMnNK
	ENJMHJwgw7mkRIpT81JSixJLSzLiQXERXwyMDJAUD9DeHSDtvMUFiblAUYjWU4yKUuK8/SAJ
	AZBERmke3FhY4njFKA70pTAvZyVQFQ8w6cB1vwIazAQ0uKAAbHBJIkJKqoGx/sDWXOdk+5mN
	20pmZDpM+vZU3uKhpugl0SfFui7OTg/1Z4f8zuORC1m5PPancRtHn8iUHKfomZlbDWI52PeG
	Xt49/1DWOYt37st47Vd6CkRpbpFKa1Di9rjZf6zm3aW1Kn/+mzxYmcGkl+X5RfTB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263554>

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

Note: there are still other problems in this code that will be fixed
in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-reflog.txt |  3 ++-
 refs.c                       | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index f15a48e..9b87b46 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -85,7 +85,8 @@ them.
 
 --updateref::
 	Update the ref with the sha1 of the top reflog entry (i.e.
-	<ref>@\{0\}) after expiring or deleting.
+	<ref>@\{0\}) after expiring or deleting.  (This option is
+	ignored for symbolic references.)
 
 --rewrite::
 	While expiring or deleting, adjust each reflog entry to ensure
diff --git a/refs.c b/refs.c
index b083858..c0001da 100644
--- a/refs.c
+++ b/refs.c
@@ -4025,6 +4025,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
+	int type;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -4036,7 +4037,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, &type);
 	if (!lock)
 		return error("cannot lock ref '%s'", refname);
 	if (!reflog_exists(refname)) {
@@ -4073,10 +4074,18 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	(*cleanup_fn)(cb.policy_cb);
 
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+		/*
+		 * It doesn't make sense to adjust a reference pointed
+		 * to by a symbolic ref based on expiring entries in
+		 * the symbolic reference's reflog.
+		 */
+		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+			~(type & REF_ISSYMREF);
+
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+		} else if (update &&
 			(write_in_full(lock->lock_fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
@@ -4087,7 +4096,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
