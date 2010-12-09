From: Anders Kaseorg <andersk@ksplice.com>
Subject: [PATCH v3 3/4] describe: Store commit_names in a hash table by commit
 SHA1
Date: Thu, 9 Dec 2010 01:46:08 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012090143440.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072344000.23348@dr-wily.mit.edu> <7v7hfjkhfm.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.02.1012081800540.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012090140390.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 07:46:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQaGf-0006oY-P4
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 07:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958Ab0LIGqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 01:46:13 -0500
Received: from mail-qy0-f170.google.com ([209.85.216.170]:43855 "EHLO
	mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab0LIGqM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 01:46:12 -0500
X-Greylist: delayed 25100 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2010 01:46:12 EST
Received: by qyk10 with SMTP id 10so6477255qyk.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 22:46:12 -0800 (PST)
Received: by 10.224.37.76 with SMTP id w12mr7808552qad.389.1291877170448;
        Wed, 08 Dec 2010 22:46:10 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id l14sm973088qck.17.2010.12.08.22.46.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 22:46:09 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <alpine.DEB.2.02.1012090140390.23348@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163270>

describe is currently forced to look up the commit at each tag in
order to store the struct commit_name pointers in struct commit.util.
For --exact-match queries, those lookups are wasteful.  In preparation
for removing them, put the commit_names into a hash table, indexed by
commit SHA1, that can be used to quickly check for exact matches.

Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
---

Change from v2.1: Use memcpy to avoid unaligned accesses in hash_sha1().

 builtin/describe.c |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 5b8461d..8149233 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "parse-options.h"
 #include "diff.h"
+#include "hash.h"
 
 #define SEEN		(1u<<0)
 #define MAX_TAGS	(FLAG_BITS - 1)
@@ -22,7 +23,7 @@ static int tags;	/* Allow lightweight tags */
 static int longformat;
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
-static int found_names;
+static struct hash_table names;
 static const char *pattern;
 static int always;
 static const char *dirty;
@@ -34,6 +35,8 @@ static const char *diff_index_args[] = {
 
 
 struct commit_name {
+	struct commit_name *next;
+	unsigned char peeled[20];
 	struct tag *tag;
 	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
 	unsigned name_checked:1;
@@ -44,6 +47,21 @@ static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
 };
 
+static inline unsigned int hash_sha1(const unsigned char *sha1)
+{
+	unsigned int hash;
+	memcpy(&hash, sha1, sizeof(hash));
+	return hash;
+}
+
+static inline struct commit_name *find_commit_name(const unsigned char *peeled)
+{
+	struct commit_name *n = lookup_hash(hash_sha1(peeled), &names);
+	while (n && !!hashcmp(peeled, n->peeled))
+		n = n->next;
+	return n;
+}
+
 static int replace_name(struct commit_name *e,
 			       int prio,
 			       const unsigned char *sha1,
@@ -82,12 +100,22 @@ static void add_to_known_names(const char *path,
 			       int prio,
 			       const unsigned char *sha1)
 {
-	struct commit_name *e = commit->util;
+	const unsigned char *peeled = commit->object.sha1;
+	struct commit_name *e = find_commit_name(peeled);
 	struct tag *tag = NULL;
 	if (replace_name(e, prio, sha1, &tag)) {
 		if (!e) {
+			void **pos;
 			e = xmalloc(sizeof(struct commit_name));
 			commit->util = e;
+			hashcpy(e->peeled, peeled);
+			pos = insert_hash(hash_sha1(peeled), e, &names);
+			if (pos) {
+				e->next = *pos;
+				*pos = e;
+			} else {
+				e->next = NULL;
+			}
 		}
 		e->tag = tag;
 		e->prio = prio;
@@ -95,7 +123,6 @@ static void add_to_known_names(const char *path,
 		hashcpy(e->sha1, sha1);
 		e->path = path;
 	}
-	found_names = 1;
 }
 
 static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
@@ -240,7 +267,7 @@ static void describe(const char *arg, int last_one)
 	if (!cmit)
 		die("%s is not a valid '%s' object", arg, commit_type);
 
-	n = cmit->util;
+	n = find_commit_name(cmit->object.sha1);
 	if (n && (tags || all || n->prio == 2)) {
 		/*
 		 * Exact match to an existing ref.
@@ -418,8 +445,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		return cmd_name_rev(i + argc, args, prefix);
 	}
 
+	init_hash(&names);
 	for_each_rawref(get_name, NULL);
-	if (!found_names && !always)
+	if (!names.nr && !always)
 		die("No names found, cannot describe anything.");
 
 	if (argc == 0) {
-- 
1.7.3.3
