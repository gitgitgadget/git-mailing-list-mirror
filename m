From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] write_idx_file: need_large_offset() helper function
Date: Mon, 28 Feb 2011 01:49:42 -0800
Message-ID: <1298886583-30965-5-git-send-email-gitster@pobox.com>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 10:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptzk9-0000zy-D5
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab1B1JuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:50:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1B1JuI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 04:50:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FBA2354B;
	Mon, 28 Feb 2011 04:51:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uLxd
	YGsX2XkSGH7v7J0j/JQfVqI=; b=Loi1eMp6q6WFB8Z7Ps/1jK8qDHjFmP1+G6uO
	JzwOYw37LCiCPHe+KcC9y0PznCIxvIOWEbcidIt7i5WUvghDsOdJ7H2SdovV6ZcY
	FbM+JNEHnJaTCKeUCrg6JxPcu+EMnI1TYWfxQYCYeDE5kPQQwAH/6oR/7RHQsbR/
	IZt20QE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	VjJaejcau1NdSTC1Z6yUAyh47AR/FzBGKLfg2d62//YLXeZEz0FJqzXB6JeLxnrJ
	cpRWWgUkvzD911yrCzIeiHzv2myIoQiOPdfKAlTD7BIlui2of5Lki6a1+msbGdsP
	w8nZ8mAGnKEohFPwEvvOTgsOOc4St88HgUXy4EbBrr4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1CDFE354A;
	Mon, 28 Feb 2011 04:51:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 466D63548; Mon, 28 Feb 2011
 04:51:22 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.249.g4aa72
In-Reply-To: <1298886583-30965-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4D95F1A4-4320-11E0-A696-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168090>

Extract the logic to determine if a given "offset" value needs to be
represented as a large offset in the .idx file into a separate helper
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This incidentally "fixes" the initial determination of index_version.
   Earlier it didn't take the off32-limit given from the command line into
   account when inspecting the offset of the last object in the pack, but
   this version does.  As off32-limit is primarily a debugging feature,
   this does not matter much, but as long as we are touching the
   surrounding code, it would be better to fix it.

 pack-write.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 16529c3..92e7eef 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -16,6 +16,11 @@ static int sha1_compare(const void *_a, const void *_b)
 	return hashcmp(a->sha1, b->sha1);
 }
 
+static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
+{
+	return (offset >> 31) || (opts->off32_limit < offset);
+}
+
 /*
  * On entry *sha1 contains the pack content SHA1 hash, on exit it is
  * the SHA1 hash of sorted object names. The objects array passed in
@@ -65,7 +70,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	}
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = (last_obj_offset >> 31) ? 2 : opts->version;
+	index_version = need_large_offset(last_obj_offset, opts) ? 2 : opts->version;
 
 	/* index versions 2 and above need a header */
 	if (index_version >= 2) {
@@ -125,8 +130,11 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		list = sorted_by_sha;
 		for (i = 0; i < nr_objects; i++) {
 			struct pack_idx_entry *obj = *list++;
-			uint32_t offset = (obj->offset <= opts->off32_limit) ?
-				obj->offset : (0x80000000 | nr_large_offset++);
+			uint32_t offset;
+
+			offset = (need_large_offset(obj->offset, opts)
+				  ? (0x80000000 | nr_large_offset++)
+				  : obj->offset);
 			offset = htonl(offset);
 			sha1write(f, &offset, 4);
 		}
@@ -136,13 +144,14 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		while (nr_large_offset) {
 			struct pack_idx_entry *obj = *list++;
 			uint64_t offset = obj->offset;
-			if (offset > opts->off32_limit) {
-				uint32_t split[2];
-				split[0] = htonl(offset >> 32);
-				split[1] = htonl(offset & 0xffffffff);
-				sha1write(f, split, 8);
-				nr_large_offset--;
-			}
+			uint32_t split[2];
+
+			if (!need_large_offset(offset, opts))
+				continue;
+			split[0] = htonl(offset >> 32);
+			split[1] = htonl(offset & 0xffffffff);
+			sha1write(f, split, 8);
+			nr_large_offset--;
 		}
 	}
 
-- 
1.7.4.1.249.g4aa72
