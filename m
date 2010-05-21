From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH 3/7] Add case insensitivity support for directories when using git status
Date: Thu, 20 May 2010 22:50:31 -0600
Message-ID: <1274417435-2344-4-git-send-email-jjensen@workspacewhiz.com>
References: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 06:50:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFKCD-0007X7-R3
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 06:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab0EUEut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 00:50:49 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39243 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab0EUEus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 00:50:48 -0400
Received: (qmail 28889 invoked by uid 399); 20 May 2010 22:50:47 -0600
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on jeltz.qwknetllc.net
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=14.0 tests=AWL,HELO_LH_LD,RDNS_NONE
	autolearn=disabled version=3.2.5
X-Virus-Scan: Scanned by ClamAV 0.95.2 (no viruses);
  Thu, 20 May 2010 22:50:46 -0600
Received: from unknown (HELO localhost.localdomain) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAMMMM; 20 May 2010 22:50:45 -0600
X-Originating-IP: 76.27.116.215
X-Mailer: git-send-email 1.7.1.1930.gcd3ce
In-Reply-To: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147434>

When using a case preserving but case insensitive file system, directory
case can differ but still refer to the same physical directory.  git
status reports the directory with the alternate case as an Untracked
file.  (That is, when mydir/filea.txt is added to the repository and
then the directory on disk is renamed from mydir/ to MyDir/, git status
shows MyDir/ as being untracked.)

Support has been added in name-hash.c for hashing directories with a
terminating slash into the name hash. When index_name_exists() is called
with a directory (a name with a terminating slash), the name is not
found via the normal cache_name_compare() call, but it is found in the
slow_same_name() function.

Additionally, in dir.c, directory_exists_in_index_icase() allows newly
added directories deeper in the directory chain to be identified.

Ultimately, it would be better if the file list was read in case
insensitive alphabetical order from disk, but this change seems to
suffice for now.

The end result is the directory is looked up in a case insensitive
manner and does not show in the Untracked files list.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
---
 dir.c       |   25 ++++++++++++++++++++++++-
 name-hash.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index a19b7ab..c861f3e 100644
--- a/dir.c
+++ b/dir.c
@@ -503,6 +503,24 @@ enum exist_status {
 	index_gitdir,
 };
 
+static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
+{
+	struct cache_entry *ce = index_name_exists(&the_index, dirname, len + 1, ignore_case);
+	if (!ce)
+		return index_nonexistent;
+
+	if (!strncmp_icase(ce->name, dirname, len)) {
+		unsigned char endchar = ce->name[len];
+		if (endchar <= '/') {
+			if (endchar == '/')
+				return index_directory;
+			if (!endchar && S_ISGITLINK(ce->ce_mode))
+				return index_gitdir;
+		}
+	}
+	return index_nonexistent;
+}
+
 /*
  * The index sorts alphabetically by entry name, which
  * means that a gitlink sorts as '\0' at the end, while
@@ -512,7 +530,12 @@ enum exist_status {
  */
 static enum exist_status directory_exists_in_index(const char *dirname, int len)
 {
-	int pos = cache_name_pos(dirname, len);
+	int pos;
+
+	if (ignore_case)
+		return directory_exists_in_index_icase(dirname, len);
+
+	pos = cache_name_pos(dirname, len);
 	if (pos < 0)
 		pos = -pos-1;
 	while (pos < active_nr) {
diff --git a/name-hash.c b/name-hash.c
index 0031d78..b10b5b1 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -32,6 +32,30 @@ static unsigned int hash_name(const char *name, int namelen)
 	return hash;
 }
 
+static void hash_index_entry_directories(struct index_state *istate, struct cache_entry *ce)
+{
+	/* throw each directory component in the hash for quick lookup during a git status */
+	unsigned int hash;
+	void **pos;
+
+	const char *ptr = ce->name;
+	while (*ptr) {
+		while (*ptr && *ptr != '/')
+			++ptr;
+		if (*ptr == '/') {
+			++ptr;
+			hash = hash_name(ce->name, ptr - ce->name);
+			if (!lookup_hash(hash, &istate->name_hash)) {
+				pos = insert_hash(hash, ce, &istate->name_hash);
+				if (pos) {
+					ce->next = *pos;
+					*pos = ce;
+				}
+			}
+		}
+	}
+}
+
 static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 {
 	void **pos;
@@ -47,6 +71,9 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		ce->next = *pos;
 		*pos = ce;
 	}
+
+	if (ignore_case)
+		hash_index_entry_directories(istate, ce);
 }
 
 static void lazy_init_name_hash(struct index_state *istate)
@@ -97,7 +124,22 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	if (len == namelen && !cache_name_compare(name, namelen, ce->name, len))
 		return 1;
 
-	return icase && slow_same_name(name, namelen, ce->name, len);
+	if (!icase)
+		return 0;
+
+	/*
+	 * If the entry we're comparing is a filename (no trailing slash), then compare
+	 * the lengths exactly.
+	 */
+	if (name[namelen - 1] != '/') {
+		return slow_same_name(name, namelen, ce->name, len);
+	}
+
+	/*
+	 * For a directory, we point to an arbitrary cache_entry filename.  Just
+	 * make sure the directory portion matches.
+	 */
+	return slow_same_name(name, namelen, ce->name, namelen < len ? namelen : len);
 }
 
 struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
-- 
1.7.1.1930.gca7dd4
