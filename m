From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 9/7] Make git-add behave more sensibly in a case-insensitive
 environment
Date: Sat, 22 Mar 2008 14:22:44 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221419400.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221038320.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221417430.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 22:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdBBd-0005kQ-Jd
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 22:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbYCVVWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 17:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754317AbYCVVWw
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 17:22:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58035 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754235AbYCVVWw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 17:22:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MLMjC1017904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 14:22:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MLMihK027182;
	Sat, 22 Mar 2008 14:22:44 -0700
In-Reply-To: <alpine.LFD.1.00.0803221417430.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.755 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77852>



From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Subject: [PATCH 2/2] Make git-add behave more sensibly in a case-insensitive environment

This expands on the previous patch, and allows "git add" to sanely handle 
a filename that has changed case, keeping the case in the index constant, 
and avoiding aliases.

In particular, if you have an index entry called "File", but the
checked-out tree is case-corrupted and has an entry called "file"
instead, doing a

	git add .

(or naming "file" explicitly) will automatically notice that we have an
alias, and will replace the name "file" with the existing index
capitalization (ie "File").

However, if we actually have *both* a file called "File" and one called
"file", and they don't have the same lstat() information (ie we're on a
case-sensitive filesystem but have the "core.ignorecase" flag set), we
will error out if we try to add them both.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

The previous patch handled the "nothing changed" case, this one actually 
handles the case of the data needing to be updated.

The CE_ADDED flag is an in-memory flag that just protects a single "git 
add" invocation from changing the same alias twice. That would not be 
right, but if you do separate

	git add File
	git add file

commands, the second one will happily update the information that the 
first one added even if it was different - but

	git add File file

would be an error if they don't have the same stat() information.

 cache.h      |    1 +
 read-cache.c |   37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 9bce723..81727e4 100644
--- a/cache.h
+++ b/cache.h
@@ -133,6 +133,7 @@ struct cache_entry {
 #define CE_UPDATE    (0x10000)
 #define CE_REMOVE    (0x20000)
 #define CE_UPTODATE  (0x40000)
+#define CE_ADDED     (0x80000)
 
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
diff --git a/read-cache.c b/read-cache.c
index 8c57adf..26ed644 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -429,6 +429,38 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 	return pos;
 }
 
+static int different_name(struct cache_entry *ce, struct cache_entry *alias)
+{
+	int len = ce_namelen(ce);
+	return ce_namelen(alias) != len || memcmp(ce->name, alias->name, len);
+}
+
+/*
+ * If we add a filename that aliases in the cache, we will use the
+ * name that we already have - but we don't want to update the same
+ * alias twice, because that implies that there were actually two
+ * different files with aliasing names!
+ *
+ * So we use the CE_ADDED flag to verify that the alias was an old
+ * one before we accept it as 
+ */
+static struct cache_entry *create_alias_ce(struct cache_entry *ce, struct cache_entry *alias)
+{
+	int len;
+	struct cache_entry *new;
+
+	if (alias->ce_flags & CE_ADDED)
+		die("Will not add file alias '%s' ('%s' already exists in index)", ce->name, alias->name);
+
+	/* Ok, create the new entry using the name of the existing alias */
+	len = ce_namelen(alias);
+	new = xcalloc(1, cache_entry_size(len));
+	memcpy(new->name, alias->name, len);
+	copy_cache_entry(new, ce);
+	free(ce);
+	return new;
+}
+
 int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 {
 	int size, namelen;
@@ -471,11 +503,14 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 		/* Nothing changed, really */
 		free(ce);
 		ce_mark_uptodate(alias);
+		alias->ce_flags |= CE_ADDED;
 		return 0;
 	}
-
 	if (index_path(ce->sha1, path, &st, 1))
 		die("unable to index file %s", path);
+	if (ignore_case && alias && different_name(ce, alias))
+		ce = create_alias_ce(ce, alias);
+	ce->ce_flags |= CE_ADDED;
 	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
 		die("unable to add %s to index",path);
 	if (verbose)
-- 
1.5.5.rc0.31.gdcfd.dirty
