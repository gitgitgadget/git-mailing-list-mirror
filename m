From: mhagger@alum.mit.edu
Subject: [PATCH 05/15] repack_without_ref(): reimplement using do_for_each_ref_in_array()
Date: Tue, 10 Apr 2012 07:30:17 +0200
Message-ID: <1334035827-20331-6-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTfe-0002Gn-IF
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab2DJFbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:03 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59203 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab2DJFax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:30:53 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXdw000870;
	Tue, 10 Apr 2012 07:30:45 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195062>

From: Michael Haggerty <mhagger@alum.mit.edu>

It costs a bit of boilerplate, but it means that the function can be
ignorant of how cached refs are stored.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index f9a1b57..78dbda6 100644
--- a/refs.c
+++ b/refs.c
@@ -1333,36 +1333,45 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 	return lock_ref_sha1_basic(refname, old_sha1, flags, NULL);
 }
 
+struct repack_without_ref_sb {
+	const char *refname;
+	int fd;
+};
+
+static int repack_without_ref_fn(const char *refname, const unsigned char *sha1,
+				 int flags, void *cb_data)
+{
+	struct repack_without_ref_sb *data = cb_data;
+	char line[PATH_MAX + 100];
+	int len;
+
+	if (!strcmp(data->refname, refname))
+		return 0;
+	len = snprintf(line, sizeof(line), "%s %s\n",
+		       sha1_to_hex(sha1), refname);
+	/* this should not happen but just being defensive */
+	if (len > sizeof(line))
+		die("too long a refname '%s'", refname);
+	write_or_die(data->fd, line, len);
+	return 0;
+}
+
 static struct lock_file packlock;
 
 static int repack_without_ref(const char *refname)
 {
-	struct ref_array *packed;
-	int fd, i;
-
-	packed = get_packed_refs(get_ref_cache(NULL));
+	struct repack_without_ref_sb data;
+	struct ref_array *packed = get_packed_refs(get_ref_cache(NULL));
+	sort_ref_array(packed);
 	if (search_ref_array(packed, refname) == NULL)
 		return 0;
-	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-	if (fd < 0) {
+	data.refname = refname;
+	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
+	if (data.fd < 0) {
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-
-	for (i = 0; i < packed->nr; i++) {
-		char line[PATH_MAX + 100];
-		int len;
-		struct ref_entry *ref = packed->refs[i];
-
-		if (!strcmp(refname, ref->name))
-			continue;
-		len = snprintf(line, sizeof(line), "%s %s\n",
-			       sha1_to_hex(ref->sha1), ref->name);
-		/* this should not happen but just being defensive */
-		if (len > sizeof(line))
-			die("too long a refname '%s'", ref->name);
-		write_or_die(fd, line, len);
-	}
+	do_for_each_ref_in_array(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
 	return commit_lock_file(&packlock);
 }
 
-- 
1.7.10
