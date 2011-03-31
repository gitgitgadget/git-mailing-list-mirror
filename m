From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/4] Use uint32_t for unpack-objects counters
Date: Wed, 30 Mar 2011 20:24:32 -0500
Message-ID: <1301534674-31981-2-git-send-email-dpmcgee@gmail.com>
References: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:25:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56dB-0007mz-O0
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933135Ab1CaBYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:24:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61114 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1CaBYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:24:41 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so783083gwa.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=64H4QJt+ArzNWXF9T4csD0m7u6BWyAfzULykDRUYl84=;
        b=xipuGm6MKnbngCCGY4gHe+5Jcnq6RM3aktRekSvnDrSipIfO4P7k9+GKsBzfEDPX/w
         255avKNhhzSGRxMM+OIL0hy+hDNY8ymW3v1xzjzUTpy80vYVUWDe/dBw0LtYvmvIUMZ+
         IX3w2Rt4EP2epQq2RlGyHTfKxJ7fILNdevcvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HJBXNG+R3TeMrTxUtizd0zHicixml6v9McCbbW2T8/5vMMkQahRXTfBEuXBSfAK5xu
         XsDCW10bYuJuF/gTRNBSJviI+o3WbfYTNTmPftlz0ENEUcExGnkkIxMSvZ7OmlMFwk4Z
         Xj99hGBqBspW/UrQtZpqPtt5zxSQN/PYhZ5OQ=
Received: by 10.90.18.23 with SMTP id 23mr2397711agr.34.1301534680947;
        Wed, 30 Mar 2011 18:24:40 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id r8sm654314ane.19.2011.03.30.18.24.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:24:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170437>

This is a follow-up to the very old commit 7cadf491c6d7a2. The fixes are
relatively simple (unsigned -> uint32_t) and we can also turn a static
global (nr_objects) into a passed variable since it is used in very few
places.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin/unpack-objects.c |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f63973c..a9e681e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -124,7 +124,7 @@ static void *get_data(unsigned long size)
 
 struct delta_info {
 	unsigned char base_sha1[20];
-	unsigned nr;
+	uint32_t nr;
 	off_t base_offset;
 	unsigned long size;
 	void *delta;
@@ -133,7 +133,7 @@ struct delta_info {
 
 static struct delta_info *delta_list;
 
-static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
+static void add_delta_to_list(uint32_t nr, unsigned const char *base_sha1,
 			      off_t base_offset,
 			      void *delta, unsigned long size)
 {
@@ -158,7 +158,6 @@ struct obj_info {
 #define FLAG_WRITTEN (1u<<21)
 
 static struct obj_info *obj_list;
-static unsigned nr_objects;
 
 /*
  * Called only from check_object() after it verified this object
@@ -206,16 +205,16 @@ static int check_object(struct object *obj, int type, void *data)
 	return 0;
 }
 
-static void write_rest(void)
+static void write_rest(uint32_t nr_objects)
 {
-	unsigned i;
+	uint32_t i;
 	for (i = 0; i < nr_objects; i++) {
 		if (obj_list[i].obj)
 			check_object(obj_list[i].obj, OBJ_ANY, NULL);
 	}
 }
 
-static void added_object(unsigned nr, enum object_type type,
+static void added_object(uint32_t nr, enum object_type type,
 			 void *data, unsigned long size);
 
 /*
@@ -223,7 +222,7 @@ static void added_object(unsigned nr, enum object_type type,
  * of it.  Under --strict, this buffers structured objects in-core,
  * to be checked at the end.
  */
-static void write_object(unsigned nr, enum object_type type,
+static void write_object(uint32_t nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
 	if (!strict) {
@@ -259,7 +258,7 @@ static void write_object(unsigned nr, enum object_type type,
 	}
 }
 
-static void resolve_delta(unsigned nr, enum object_type type,
+static void resolve_delta(uint32_t nr, enum object_type type,
 			  void *base, unsigned long base_size,
 			  void *delta, unsigned long delta_size)
 {
@@ -279,7 +278,7 @@ static void resolve_delta(unsigned nr, enum object_type type,
  * We now know the contents of an object (which is nr-th in the pack);
  * resolve all the deltified objects that are based on it.
  */
-static void added_object(unsigned nr, enum object_type type,
+static void added_object(uint32_t nr, enum object_type type,
 			 void *data, unsigned long size)
 {
 	struct delta_info **p = &delta_list;
@@ -300,7 +299,7 @@ static void added_object(unsigned nr, enum object_type type,
 }
 
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
-				   unsigned nr)
+				   uint32_t nr)
 {
 	void *buf = get_data(size);
 
@@ -310,7 +309,7 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 		free(buf);
 }
 
-static int resolve_against_held(unsigned nr, const unsigned char *base,
+static int resolve_against_held(uint32_t nr, const unsigned char *base,
 				void *delta_data, unsigned long delta_size)
 {
 	struct object *obj;
@@ -327,7 +326,7 @@ static int resolve_against_held(unsigned nr, const unsigned char *base,
 }
 
 static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
-			       unsigned nr)
+			       uint32_t nr)
 {
 	void *delta_data, *base;
 	unsigned long base_size;
@@ -356,7 +355,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		unsigned base_found = 0;
 		unsigned char *pack, c;
 		off_t base_offset;
-		unsigned lo, mid, hi;
+		uint32_t lo, mid, hi;
 
 		pack = fill(1);
 		c = *pack;
@@ -421,7 +420,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	free(base);
 }
 
-static void unpack_one(unsigned nr)
+static void unpack_one(uint32_t nr)
 {
 	unsigned shift;
 	unsigned char *pack;
@@ -464,9 +463,9 @@ static void unpack_one(unsigned nr)
 	}
 }
 
-static void unpack_all(void)
+static uint32_t unpack_all(void)
 {
-	int i;
+	uint32_t i, nr_objects;
 	struct progress *progress = NULL;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
 
@@ -490,11 +489,14 @@ static void unpack_all(void)
 
 	if (delta_list)
 		die("unresolved deltas left after unpacking");
+
+	return nr_objects;
 }
 
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	uint32_t nr_objects;
 	unsigned char sha1[20];
 
 	read_replace_refs = 0;
@@ -545,11 +547,11 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 		usage(unpack_usage);
 	}
 	git_SHA1_Init(&ctx);
-	unpack_all();
+	nr_objects = unpack_all();
 	git_SHA1_Update(&ctx, buffer, offset);
 	git_SHA1_Final(sha1, &ctx);
 	if (strict)
-		write_rest();
+		write_rest(nr_objects);
 	if (hashcmp(fill(20), sha1))
 		die("final sha1 did not match");
 	use(20);
-- 
1.7.4.2
