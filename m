From: David Rientjes <rientjes@google.com>
Subject: [PATCH 13/28] builtin-unpack-objects.c cleanup
Date: Mon, 14 Aug 2006 13:30:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141329070.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:30:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj4r-0008HH-5z
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWHNUaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbWHNUaT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:30:19 -0400
Received: from smtp-out.google.com ([216.239.45.12]:18580 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932725AbWHNUaR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:30:17 -0400
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id k7EKUFVP019760
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:30:15 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=sestpwmgkk2ezbsKmxVVM6TE8DuSUPA565114NxbeIB1x/DnXh+lT6CU2JfhFNAVd
	P2hcUARFgr4HUAFIGNykw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps77.corp.google.com with ESMTP id k7EKUDgQ007645
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:30:13 -0700
Received: by localhost (Postfix, from userid 24081)
	id C899487D71; Mon, 14 Aug 2006 13:30:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id C631887D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:30:13 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25393>

Makes resolve_delta, added_object, unpack_non_delta_entry, and 
unpack_delta_entry void.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-unpack-objects.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 63f4b8e..e65f80e 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -112,9 +112,9 @@ static void write_object(void *buf, unsi
 	added_object(sha1, type, buf, size);
 }
 
-static int resolve_delta(const char *type,
-	void *base, unsigned long base_size,
-	void *delta, unsigned long delta_size)
+static void resolve_delta(const char *type,
+			  void *base, unsigned long base_size,
+			  void *delta, unsigned long delta_size)
 {
 	void *result;
 	unsigned long result_size;
@@ -127,10 +127,10 @@ static int resolve_delta(const char *typ
 	free(delta);
 	write_object(result, result_size, type);
 	free(result);
-	return 0;
 }
 
-static void added_object(unsigned char *sha1, const char *type, void *data, unsigned long size)
+static void added_object(unsigned char *sha1, const char *type, void *data,
+			 unsigned long size)
 {
 	struct delta_info **p = &delta_list;
 	struct delta_info *info;
@@ -147,7 +147,7 @@ static void added_object(unsigned char *
 	}
 }
 
-static int unpack_non_delta_entry(enum object_type kind, unsigned long size)
+static void unpack_non_delta_entry(enum object_type kind, unsigned long size)
 {
 	void *buf = get_data(size);
 	const char *type;
@@ -162,16 +162,14 @@ static int unpack_non_delta_entry(enum o
 	if (!dry_run)
 		write_object(buf, size, type);
 	free(buf);
-	return 0;
 }
 
-static int unpack_delta_entry(unsigned long delta_size)
+static void unpack_delta_entry(unsigned long delta_size)
 {
 	void *delta_data, *base;
 	unsigned long base_size;
 	char type[20];
 	unsigned char base_sha1[20];
-	int result;
 
 	memcpy(base_sha1, fill(20), 20);
 	use(20);
@@ -179,19 +177,18 @@ static int unpack_delta_entry(unsigned l
 	delta_data = get_data(delta_size);
 	if (dry_run) {
 		free(delta_data);
-		return 0;
+		return;
 	}
 
 	if (!has_sha1_file(base_sha1)) {
 		add_delta_to_list(base_sha1, delta_data, delta_size);
-		return 0;
+		return;
 	}
 	base = read_sha1_file(base_sha1, type, &base_size);
 	if (!base)
 		die("failed to read delta-pack base object %s", sha1_to_hex(base_sha1));
-	result = resolve_delta(type, base, base_size, delta_data, delta_size);
+	resolve_delta(type, base, base_size, delta_data, delta_size);
 	free(base);
-	return result;
 }
 
 static void unpack_one(unsigned nr, unsigned total)
-- 
1.4.2.g89bb-dirty
