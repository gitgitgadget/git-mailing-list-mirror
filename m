From: David Barr <davidbarr@google.com>
Subject: [RFC/PATCH 1/3] protobuf: minimal implementation for compact in-memory structures
Date: Wed, 22 Jun 2011 00:33:30 -0700
Message-ID: <1308728011-14136-2-git-send-email-davidbarr@google.com>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
Cc: David Barr <davidbarr@google.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 09:34:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZHxd-0005HD-B0
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 09:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513Ab1FVHeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 03:34:44 -0400
Received: from smtp-out.google.com ([216.239.44.51]:5630 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab1FVHem (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 03:34:42 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id p5M7Ygxf021535
	for <git@vger.kernel.org>; Wed, 22 Jun 2011 00:34:42 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1308728082; bh=IMQQxQvy4g/P9ugnLwA/LEZqJBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
	b=VoJvKVOyF5kzmJ07pUz2RsFqfiLD53KqeGmN2zn+tyvttmJtibjG9yANMPQ0ien6c
	 N4mkm7a3fZI6+9FPW8d/A==
Received: from pvc21 (pvc21.prod.google.com [10.241.209.149])
	by wpaz37.hot.corp.google.com with ESMTP id p5M7YehR004526
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 22 Jun 2011 00:34:41 -0700
Received: by pvc21 with SMTP id 21so469996pvc.11
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=E9Bbwd2uwfBP38SdJmq4YYq++EJtD/XjoAnyW0MGx4U=;
        b=H3OJH9+3ni2CaKSCv1Bx2RE9kPlafURm8wbxhrngCVgCFPCeJHzysvNs1uOX4iFgZH
         PNZgtzGRuJrKLhMCjW6w==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Kg7UOOfRAlOa2Yk7uBDLlSFL1cLX584y1Ohh1Z8/dijZ/2OLibGvs7y+gd+C6bGX2/
         sBFVangAontyT4jUeh1w==
Received: by 10.68.17.234 with SMTP id r10mr153103pbd.98.1308728080213;
        Wed, 22 Jun 2011 00:34:40 -0700 (PDT)
Received: from localhost.localdomain (173-167-127-66-sfba.hfc.comcastbusiness.net [173.167.127.66])
        by mx.google.com with ESMTPS id p5sm248637pbd.92.2011.06.22.00.34.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 00:34:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308728011-14136-1-git-send-email-davidbarr@google.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176224>

One struct to capture all types, just 4 methods:
decode_message, encode_message, sizeof_message, hash_field.

Signed-off-by: David Barr <davidbarr@google.com>
---

 This is the first in a series of small patches to introduce some higher-level
 constructs into the git toolbag.
 The motivation is to empower a libfastimport implementation that is frugal
 with memory, fast and scalable.

 This version lacks any driver or tests.

 Soon to come are:
 * an efficient allocator that provides a mapping from an integer handle to
  pointer and length
 * a hash table that is time and memory effective for very numerous entries

 protobuf.c |  193 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 protobuf.h |   70 ++++++++++++++++++++++
 varint.h   |   59 ++++++++++++++++++
 3 files changed, 322 insertions(+), 0 deletions(-)
 create mode 100644 protobuf.c
 create mode 100644 protobuf.h
 create mode 100644 varint.h

diff --git a/protobuf.c b/protobuf.c
new file mode 100644
index 0000000..09223dd
--- /dev/null
+++ b/protobuf.c
@@ -0,0 +1,193 @@
+#include "git-compat-util.h"
+#include "protobuf.h"
+#include "varint.h"
+
+static int decode_binary(const char **buf, const char *end, const char **result, size_t len)
+{
+	if (end && *buf + len > end)
+		return 1;
+	*result = *buf;
+	*buf += len;
+	return 0;
+}
+
+static int encode_binary(char **buf, const char *end, const char *value, size_t len)
+{
+	if (end && *buf + len > end)
+		return 1;
+	memcpy(*buf, value, len);
+	*buf += len;
+	return 0;
+}
+
+static int decode_field(const char **buf, const char *end, struct protobuf_field *field)
+{
+	uint32_t u32;
+	uint64_t key;
+	bzero(field, sizeof(struct protobuf_field));
+	if (decode_varint(buf, end, &key))
+		return 1;
+	field->tag = key >> WT_BITS,
+	field->type = key & WT_MASK;
+	switch (field->type) {
+	case WT_VARINT:
+		if (decode_varint(buf, end, &field->val.num))
+			return 1;
+		return 0;
+	case WT_64BIT:
+		field->val.bin.len = sizeof(uint64_t);
+		break;
+	case WT_STRING:
+		if (decode_varint(buf, end, &field->val.bin.len))
+			return 1;
+		break;
+	case WT_SHA1:
+		field->val.bin.len = 20;
+		break;
+	case WT_32BIT:
+		field->val.bin.len = sizeof(uint32_t);
+		break;
+	default:
+		return 1;
+	}
+	if (decode_binary(buf, end, &field->val.bin.ptr, field->val.bin.len))
+		return 1;
+	switch (field->type) {
+	case WT_64BIT:
+		memcpy(&field->val.num, field->val.bin.ptr, field->val.bin.len);
+		break;
+	case WT_32BIT:
+		memcpy(&u32, field->val.bin.ptr, field->val.bin.len);
+		field->val.num = u32;
+	}
+	return 0;
+}
+
+int decode_message(const char **buf, const char *end, struct protobuf_field *message, size_t fields)
+{
+	struct protobuf_field current;
+	bzero(message, fields * sizeof(struct protobuf_field));
+	while (*buf != end) {
+		if (decode_field(buf, end, &current))
+			return 1;
+		if (current.tag < fields)
+			message[current.tag] = current;
+	}
+	return 0;
+}
+
+static size_t sizeof_field(const struct protobuf_field *field)
+{
+	size_t sizeof_key = sizeof_varint(field->tag << WT_BITS | field->type);
+	switch (field->type) {
+	case WT_VARINT:
+		if (field->val.num)
+			return sizeof_key + sizeof_varint(field->val.num);
+		break;
+	case WT_64BIT:
+		if (field->val.num)
+			return sizeof_key + sizeof(uint64_t);
+		break;
+	case WT_STRING:
+		if (field->val.bin.len && field->val.bin.ptr)
+			return sizeof_key + sizeof_varint(field->val.bin.len)
+			       + field->val.bin.len;
+		break;
+	case WT_SHA1:
+		if (field->val.bin.ptr)
+			return sizeof_key + 20;
+		break;
+	case WT_32BIT:
+		if (field->val.num)
+			return sizeof_key + sizeof(uint32_t);
+		break;
+	}
+	return 0;
+}
+
+uint64_t sizeof_message(const struct protobuf_field *message, size_t fields)
+{
+	uint64_t size = 0;
+	while (fields--)
+		size += sizeof_field(message++);
+	return size;
+}
+
+static int encode_field(char **buf, const struct protobuf_field *field, char *end)
+{
+	uint32_t u32;
+	uint64_t len;
+	const char *ptr;
+	uint64_t key = (field->tag << WT_BITS) | field->type;
+	if (!sizeof_field(field))
+		return 0;
+	if (encode_varint(buf, end, key))
+		return 1;
+	switch (field->type) {
+	case WT_VARINT:
+		if (encode_varint(buf, end, field->val.num))
+			return 1;
+		return 0;
+	case WT_64BIT:
+		ptr = (const char *)&field->val.num;
+		len = sizeof(uint64_t);
+		break;
+	case WT_STRING:
+		if (encode_varint(buf, end, field->val.bin.len))
+			return 1;
+		ptr = field->val.bin.ptr;
+		len = field->val.bin.len;
+		break;
+	case WT_SHA1:
+		ptr = field->val.bin.ptr;
+		len = 20;
+		break;
+	case WT_32BIT:
+		u32 = field->val.num;
+		ptr = (const char *)&u32;
+		len = sizeof(uint64_t);
+		break;
+	default:
+		return 1;
+	}
+	if (encode_binary(buf, end, ptr, len))
+		return 1;
+	return 0;
+}
+
+int encode_message(char **buf, char *end, const struct protobuf_field *message, size_t fields)
+{
+	while (*buf != end && fields--)
+		if (encode_field(buf, message++, end))
+			return 1;
+	return 0;
+}
+
+static uint32_t x65599(const char *s, uint64_t len)
+{
+	uint32_t r = 0;
+	while (len--)
+		r = *s++ + (r << 6) + (r << 16) - r;
+	return r;
+}
+
+uint32_t hash_field(const struct protobuf_field *field)
+{
+	uint32_t hc = 0;
+	switch (field->type) {
+	case WT_VARINT:
+	case WT_64BIT:
+		hc = (0x9e3779b97f4a7c15ull * field->val.num) >> 32;
+		break;
+	case WT_SHA1:
+		memcpy(&hc, field->val.bin.ptr, sizeof(hc));
+		break;
+	case WT_STRING:
+		hc = x65599(field->val.bin.ptr, field->val.bin.len);
+		break;
+	case WT_32BIT:
+		hc = 0x9e3779b9ul * (uint32_t)field->val.num;
+		break;
+	}
+	return hc;
+}
diff --git a/protobuf.h b/protobuf.h
new file mode 100644
index 0000000..89b70a4
--- /dev/null
+++ b/protobuf.h
@@ -0,0 +1,70 @@
+#ifndef PROTOBUF_H_
+#define PROTOBUF_H_
+
+#define WT_BITS 3
+#define WT_MASK 0x7
+
+enum wire_type {
+	WT_VARINT = 0,
+	WT_64BIT  = 1,
+	WT_STRING = 2,
+	/* Custom wire type */
+	WT_SHA1   = 3,
+	WT_32BIT  = 5
+};
+
+struct protobuf_field
+{
+	uint64_t tag : 64 - WT_BITS,
+		 type : WT_BITS;
+	union protobuf_value {
+		uint64_t num;
+		struct protobuf_binary {
+			uint64_t len;
+			const char *ptr;
+		} bin;
+	} val;
+};
+
+#define PROTOBUF_KEY(p, f, wt) do { \
+	(p)->f.tag = &((p)->f) - (struct protobuf_field*)(p); \
+	(p)->f.type = wt; \
+} while(0)
+
+#define WT_VARINT(p, f, v) do { \
+	PROTOBUF_KEY(p, f, WT_VARINT); \
+	(p)->f.val.num = v; \
+} while(0)
+
+#define WT_64BIT(p, f, v) do { \
+	PROTOBUF_KEY(p, f, WT_64BIT); \
+	(p)->f.val.num = v; \
+} while(0)
+
+#define WT_STRING(p, f, s, l) do { \
+	PROTOBUF_KEY(p, f, WT_STRING); \
+	(p)->f.val.bin.ptr = s; \
+	(p)->f.val.bin.len = l; \
+} while(0)
+
+#define WT_SHA1(p, f, v) do { \
+	PROTOBUF_KEY(p, f, WT_SHA1); \
+	(p)->f.val.bin.ptr = s; \
+	(p)->f.val.bin.len = 20; \
+} while(0)
+
+#define WT_32BIT(p, f, v) do { \
+	PROTOBUF_KEY(p, f, WT_32BIT); \
+	(p)->f.val.num = v; \
+} while(0)
+
+#define PROTOBUF_CAST(p) \
+	(struct protobuf_field*)(p), \
+	sizeof(*(p)) / sizeof(struct protobuf_field)
+
+int decode_message(const char **buf, const char *end, struct protobuf_field *message, size_t fields);
+uint64_t sizeof_message(const struct protobuf_field *message, size_t fields);
+int encode_message(char **buf, char *end, const struct protobuf_field *message, size_t fields);
+uint32_t hash_field(const struct protobuf_field *field);
+
+#endif
diff --git a/varint.h b/varint.h
new file mode 100644
index 0000000..48a3547
--- /dev/null
+++ b/varint.h
@@ -0,0 +1,59 @@
+#ifndef VARINT_H_
+#define VARINT_H_
+
+#define VLI_CONTINUE	0x80
+#define VLI_DIGIT_MASK	0x7f
+#define VLI_BITS_PER_DIGIT 7
+
+static int decode_varint(const char **buf, const char *end, uint64_t *result)
+{
+	uint64_t rv = 0;
+	int shift = 0;
+	const char *pos;
+	for (pos = *buf; pos != end && shift < 64; pos++) {
+		unsigned char ch = *pos;
+
+		rv |= (ch & VLI_DIGIT_MASK) << shift;
+		shift += VLI_BITS_PER_DIGIT;
+		if (ch & VLI_CONTINUE)
+			continue;
+
+		*result = rv;
+		*buf = pos + 1;
+		return 0;
+	}
+	return 1;
+}
+
+static int encode_varint(char **buf, const char *end, uint64_t value)
+{
+	char *pos;
+	for (pos = *buf; pos != end; pos++) {
+		unsigned char ch = value & VLI_DIGIT_MASK;
+
+		value >>= VLI_BITS_PER_DIGIT;
+		if (value)
+			ch |= VLI_CONTINUE;
+		*pos = ch;
+		if (ch & VLI_CONTINUE)
+			continue;
+
+		*buf = pos + 1;
+		return 0;
+	}
+	return 1;
+}
+
+static size_t sizeof_varint(uint64_t value) {
+	size_t size = 0;
+	int shift = VLI_BITS_PER_DIGIT;
+	while (shift < 64) {
+		size++;
+		if (value < (1ull << shift))
+			break;
+		shift += VLI_BITS_PER_DIGIT;
+	}
+	return size;
+}
+
+#endif
-- 
1.7.5.1
