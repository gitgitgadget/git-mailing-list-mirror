From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 2/2] count-objects: add -H option to humanize sizes
Date: Wed, 10 Apr 2013 21:03:24 +0200
Message-ID: <1365620604-17851-2-git-send-email-apelisse@gmail.com>
References: <7vli8svgyo.fsf@alter.siamese.dyndns.org>
 <1365620604-17851-1-git-send-email-apelisse@gmail.com>
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:04:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0JM-0004li-2J
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759774Ab3DJTDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:03:53 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62165 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759380Ab3DJTDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:03:51 -0400
Received: by mail-wi0-f172.google.com with SMTP id hr17so5168655wib.5
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=A4r+SAz4fpRc+nDtvgCh7aQSNPgoC1eUMTaZ6ZtLWvs=;
        b=CtB+S+eQ2aPqQ4FkdoEYiAA3EFaURU3ZoSR5dC9RXZ7y5rSTX52L6HFz1520YhisO4
         vAIPWjoX0GaVGW3LLPJDCxodAqJPgw6TzV48tpdqVz2VV59lXEJs9LegUTbfUX8SOrNZ
         WWFmA/UezFKxN66cdA5gnp9Om5/NolcuayyKEHGeaWdKUaGfPZpm3dOK/kIzdocRwwHK
         O5HdaVrbRFlbwWzSIM0p6491Tv3xJe7pg4/OP6Q5iMIJvGNAkyk7sRQuy9Dygg5/xuYZ
         7spmK8HMzr6MYUVD/SCAnDd1asulRKbc6m3pDBoeUPyuYcLnySFkBeTnETkln1rzknh/
         pFYw==
X-Received: by 10.194.178.9 with SMTP id cu9mr5667542wjc.39.1365620630113;
        Wed, 10 Apr 2013 12:03:50 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id g9sm1805788wix.1.2013.04.10.12.03.48
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 12:03:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1365620604-17851-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220726>

Use the new humanize() function to print loose objects size, pack size,
and garbage size in verbose mode, or loose objects size in regular mode.
This patch doesn't change the way anything is displayed when the option
is not used.

Also update the documentation.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 Documentation/git-count-objects.txt |   14 ++++++++---
 builtin/count-objects.c             |   46 +++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index da6e72e..b300e84 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -8,7 +8,7 @@ git-count-objects - Count unpacked number of objects and their disk consumption
 SYNOPSIS
 --------
 [verse]
-'git count-objects' [-v]
+'git count-objects' [-v] [-H | --human-readable]
 
 DESCRIPTION
 -----------
@@ -24,11 +24,11 @@ OPTIONS
 +
 count: the number of loose objects
 +
-size: disk space consumed by loose objects, in KiB
+size: disk space consumed by loose objects, in KiB (unless -H is specified)
 +
 in-pack: the number of in-pack objects
 +
-size-pack: disk space consumed by the packs, in KiB
+size-pack: disk space consumed by the packs, in KiB (unless -H is specified)
 +
 prune-packable: the number of loose objects that are also present in
 the packs. These objects could be pruned using `git prune-packed`.
@@ -36,7 +36,13 @@ the packs. These objects could be pruned using `git prune-packed`.
 garbage: the number of files in object database that are not valid
 loose objects nor valid packs
 +
-size-garbage: disk space consumed by garbage files, in KiB
+size-garbage: disk space consumed by garbage files, in KiB (unless -H is
+specified)
+
+-H::
+--human-readable::
+
+Print sizes in human readable format
 
 GIT
 ---
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 0343e35..935ad9e 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -79,13 +79,13 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 }
 
 static char const * const count_objects_usage[] = {
-	N_("git count-objects [-v]"),
+	N_("git count-objects [-v] [-H | --human-readable]"),
 	NULL
 };
 
 int cmd_count_objects(int argc, const char **argv, const char *prefix)
 {
-	int i, verbose = 0;
+	int i, verbose = 0, human_readable = 0;
 	const char *objdir = get_object_directory();
 	int len = strlen(objdir);
 	char *path = xmalloc(len + 50);
@@ -93,6 +93,8 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	off_t loose_size = 0;
 	struct option opts[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_BOOLEAN('H', "human-readable", &human_readable,
+			    N_("print sizes in human readable format")),
 		OPT_END(),
 	};
 
@@ -119,6 +121,9 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		struct packed_git *p;
 		unsigned long num_pack = 0;
 		off_t size_pack = 0;
+		struct strbuf loose_buf = STRBUF_INIT;
+		struct strbuf pack_buf = STRBUF_INIT;
+		struct strbuf garbage_buf = STRBUF_INIT;
 		if (!packed_git)
 			prepare_packed_git();
 		for (p = packed_git; p; p = p->next) {
@@ -130,17 +135,42 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			size_pack += p->pack_size + p->index_size;
 			num_pack++;
 		}
+
+		if (human_readable) {
+			strbuf_humanize(&loose_buf, loose_size);
+			strbuf_humanize(&pack_buf, size_pack);
+			strbuf_humanize(&garbage_buf, size_garbage);
+		}
+		else {
+			strbuf_addf(&loose_buf, "%lu",
+				    (unsigned long)(loose_size / 1024));
+			strbuf_addf(&pack_buf, "%lu",
+				    (unsigned long)(size_pack / 1024));
+			strbuf_addf(&garbage_buf, "%lu",
+				    (unsigned long)(size_garbage / 1024));
+		}
+
 		printf("count: %lu\n", loose);
-		printf("size: %lu\n", (unsigned long) (loose_size / 1024));
+		printf("size: %s\n", loose_buf.buf);
 		printf("in-pack: %lu\n", packed);
 		printf("packs: %lu\n", num_pack);
-		printf("size-pack: %lu\n", (unsigned long) (size_pack / 1024));
+		printf("size-pack: %s\n", pack_buf.buf);
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
-		printf("size-garbage: %lu\n", (unsigned long) (size_garbage / 1024));
+		printf("size-garbage: %s\n", garbage_buf.buf);
+		strbuf_release(&loose_buf);
+		strbuf_release(&pack_buf);
+		strbuf_release(&garbage_buf);
+	}
+	else {
+		struct strbuf buf = STRBUF_INIT;
+		if (human_readable)
+			strbuf_humanize(&buf, loose_size);
+		else
+			strbuf_addf(&buf, "%lu KiB",
+				    (unsigned long)(loose_size / 1024));
+		printf("%lu objects, %s\n", loose, buf.buf);
+		strbuf_release(&buf);
 	}
-	else
-		printf("%lu objects, %lu KiB\n",
-		       loose, (unsigned long) (loose_size / 1024));
 	return 0;
 }
-- 
1.7.9.5
