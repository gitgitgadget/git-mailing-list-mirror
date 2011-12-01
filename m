From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] write_pack_header(): a helper function
Date: Wed, 30 Nov 2011 16:27:39 -0800
Message-ID: <1322699263-14475-2-git-send-email-gitster@pobox.com>
References: <1322699263-14475-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 01:27:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVuVG-0003qv-8Q
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 01:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271Ab1LAA1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 19:27:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab1LAA1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 19:27:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C2AD5D82
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=echX
	Tis76tnuQE1yNudwdO0HRe4=; b=NPb8yK+SXcb3vejKptefIKAN/cyAvLXKhC9g
	2lgyt7gkoKQzlcj9B1wLpk/wgWJyesC4SbmDVYm0S72HGo2/EeOmeM/TwM2seeDo
	+79ARK6nRi+ODEmq9MJMozQ9xSMrwqGGAWiw7Tj2gL1N/jcg8jP0yv5tZPOci0SK
	Xe2Zr1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kodL6c
	L8kAf7St36jUvOOn3Rl1RTxVneT+7stCmBCONAxX1a4YmtDElpQwBrlCNaFcxc2J
	ybT4GYC5CJS7TGjiu/TtRbq8gCeXkIIJa50mpWU+FBaIrwC7qperqG4ofAYieQl3
	9WKXe5NVaCSscZwqol+3Mnw5SREOQlQkzonv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 948B25D81
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA9F65D80 for
 <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:46 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322699263-14475-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4B07890E-1BB3-11E1-8321-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186147>

Factor out a small logic out of the private write_pack_file() function
in builtin/pack-objects.c

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |    9 +++------
 pack-write.c           |   12 ++++++++++++
 pack.h                 |    2 ++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba3705d..6643c16 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -571,7 +571,6 @@ static void write_pack_file(void)
 	uint32_t i = 0, j;
 	struct sha1file *f;
 	off_t offset;
-	struct pack_header hdr;
 	uint32_t nr_remaining = nr_result;
 	time_t last_mtime = 0;
 	struct object_entry **write_order;
@@ -596,11 +595,9 @@ static void write_pack_file(void)
 			f = sha1fd(fd, pack_tmp_name);
 		}
 
-		hdr.hdr_signature = htonl(PACK_SIGNATURE);
-		hdr.hdr_version = htonl(PACK_VERSION);
-		hdr.hdr_entries = htonl(nr_remaining);
-		sha1write(f, &hdr, sizeof(hdr));
-		offset = sizeof(hdr);
+		offset = write_pack_header(f, nr_remaining);
+		if (!offset)
+			die_errno("unable to write pack header");
 		nr_written = 0;
 		for (; i < nr_objects; i++) {
 			struct object_entry *e = write_order[i];
diff --git a/pack-write.c b/pack-write.c
index 9cd3bfb..46f3f84 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -178,6 +178,18 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	return index_name;
 }
 
+off_t write_pack_header(struct sha1file *f, uint32_t nr_entries)
+{
+	struct pack_header hdr;
+
+	hdr.hdr_signature = htonl(PACK_SIGNATURE);
+	hdr.hdr_version = htonl(PACK_VERSION);
+	hdr.hdr_entries = htonl(nr_entries);
+	if (sha1write(f, &hdr, sizeof(hdr)))
+		return 0;
+	return sizeof(hdr);
+}
+
 /*
  * Update pack header with object_count and compute new SHA1 for pack data
  * associated to pack_fd, and write that SHA1 at the end.  That new SHA1
diff --git a/pack.h b/pack.h
index 722a54e..d429d8a 100644
--- a/pack.h
+++ b/pack.h
@@ -2,6 +2,7 @@
 #define PACK_H
 
 #include "object.h"
+#include "csum-file.h"
 
 /*
  * Packed object header
@@ -74,6 +75,7 @@ extern const char *write_idx_file(const char *index_name, struct pack_idx_entry
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *);
+extern off_t write_pack_header(struct sha1file *f, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned char *);
-- 
1.7.8.rc4.177.g4d64
