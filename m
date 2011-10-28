From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] write_pack_header(): a helper function
Date: Fri, 28 Oct 2011 16:54:08 -0700
Message-ID: <1319846051-462-2-git-send-email-gitster@pobox.com>
References: <1319846051-462-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 01:54:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJwFl-0002Xd-Aq
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 01:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933871Ab1J1XyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 19:54:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab1J1XyP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 19:54:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 521D46ADA
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=A1O7
	uYiWuH96JC7WzcgFoB3jBnU=; b=uEO2dts3YOZx+hW+pfWh15pxvpJs8Oul5Bnt
	kcn067ZgAtYn+NdW1p0yFukyeT0S0zpAdO6fpk7sM1acviI6VufATHsIDIKabZ32
	kBRH2JTjhTxCItz5rwgEgWIy63Vh02ftg9rhtZt1NyirNAWwfiZVGHU7qTm8XzPW
	01ojVGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=OrnaFc
	eUnGDyBTFWoffYldRyMNu1yZpHKLMXbBbi79whl4n1T9PpZnfRK2jjKM0B29HZPH
	n804D3KSCwv2j8u6qwjdn0tZYtWB3RnDU7LxtRcVL5+K+urYKsxjmfoow6J/K5iV
	inQWUrPkrZDBQ/u4tY5FaVOJT8TkvjGnHW2w8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 498E26AD9
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 999926AD8 for
 <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.1.573.ga40d2
In-Reply-To: <1319846051-462-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 23F4567E-01C0-11E1-80FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184442>

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
1.7.7.1.573.ga40d2
