From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/3] Add support for "local" packing
Date: Thu, 13 Oct 2005 14:26:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510131426390.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 13 23:28:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQAbZ-0005W1-GY
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 23:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVJMV1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 17:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVJMV1J
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 17:27:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964863AbVJMV1I (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 17:27:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9DLR04s023944
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 14:27:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9DLQxwc003037;
	Thu, 13 Oct 2005 14:27:00 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10091>


This adds the "--local" flag to git-pack-objects, which acts like
"--incremental", except that instead of ignoring all packed objects, it
only ignores objects that are packed and in an alternate object tree.

As a result, it effectively only does a local re-pack: any remote-packed
objects will stay in the alternate object directories.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/pack-objects.c b/pack-objects.c
index ef55cab..8a1ee74 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -5,7 +5,7 @@
 #include "pack.h"
 #include "csum-file.h"
 
-static const char pack_usage[] = "git-pack-objects [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
+static const char pack_usage[] = "git-pack-objects [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
 
 struct object_entry {
 	unsigned char sha1[20];
@@ -20,6 +20,7 @@ struct object_entry {
 
 static unsigned char object_list_sha1[20];
 static int non_empty = 0;
+static int local = 0;
 static int incremental = 0;
 static struct object_entry **sorted_by_sha, **sorted_by_type;
 static struct object_entry *objects = NULL;
@@ -195,8 +196,20 @@ static int add_object_entry(unsigned cha
 	unsigned int idx = nr_objects;
 	struct object_entry *entry;
 
-	if (incremental && has_sha1_pack(sha1))
-		return 0;
+	if (incremental || local) {
+		struct packed_git *p;
+
+		for (p = packed_git; p; p = p->next) {
+			struct pack_entry e;
+
+			if (find_pack_entry_one(sha1, &e, p)) {
+				if (incremental)
+					return 0;
+				if (local && !p->pack_local)
+					return 0;
+			}
+		}
+	}
 
 	if (idx >= nr_alloc) {
 		unsigned int needed = (idx + 1024) * 3 / 2;
@@ -404,6 +417,10 @@ int main(int argc, char **argv)
 				non_empty = 1;
 				continue;
 			}
+			if (!strcmp("--local", arg)) {
+				local = 1;
+				continue;
+			}
 			if (!strcmp("--incremental", arg)) {
 				incremental = 1;
 				continue;
@@ -436,6 +453,7 @@ int main(int argc, char **argv)
 	if (pack_to_stdout != !base_name)
 		usage(pack_usage);
 
+	prepare_packed_git();
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		unsigned int hash;
 		char *p;
