From: mhagger@alum.mit.edu
Subject: [PATCH v2 09/12] repack_without_ref(): reimplement using do_for_each_ref_in_array()
Date: Fri, 28 Oct 2011 13:28:01 +0200
Message-ID: <1319801284-15625-10-git-send-email-mhagger@alum.mit.edu>
References: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkc6-0002WA-CY
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398Ab1J1L2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:28:32 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:54961 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435Ab1J1L2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:28:14 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkVI-0007Cx-La; Fri, 28 Oct 2011 13:21:40 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184367>

From: Michael Haggerty <mhagger@alum.mit.edu>


It costs a bit of boilerplate, but it means that the function can be
ignorant of how cached refs are stored.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   46 ++++++++++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index ad7538a..d56f265 100644
--- a/refs.c
+++ b/refs.c
@@ -1305,36 +1305,46 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
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
+	struct repack_without_ref_sb data;
 	struct ref_array *packed;
-	int fd, i;
 
 	packed = get_packed_refs(get_ref_cache(NULL));
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
1.7.7
