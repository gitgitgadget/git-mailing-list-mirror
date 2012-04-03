From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] varint: make it available outside the context of pack
Date: Tue,  3 Apr 2012 15:53:08 -0700
Message-ID: <1333493596-14202-2-git-send-email-gitster@pobox.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbM-0006ha-Jc
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab2DCWxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab2DCWxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3FBA7F63
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zuGw
	LUWUQacKpgBg5NCR9W5x9Yw=; b=EfsqUNtjgPxEkRiV+4elkSduqhI2vSkC05/s
	30aJd989VGqtdY47l9ue8C+WfBCXuTt/cIpGWn0UJfh2t8Vzaaizy47zdGyQ/67t
	49rrmojDSu0GgmPL9enk5GlOqNq0iudehV1RMcnmPAUdkNRZiL+DVDYLMhR/H8An
	HcNZCcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gakWuo
	R47aAjqZvRaNV43D+62lRzVqF34UJgSeC4X7kb63Pei69h1cM3S6FEboIxY90erE
	FuyV6XVjindlGOdUFo5Rp2vAF+ibS39cJP1yQVfg1kLIjFpb2UZCPHiaDTE2Lc0U
	0ProZCKg2uildlNjpTQS3o6yFcJxn0ShkixBc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C557F62
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 605367F61 for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CE885DF6-7DDF-11E1-BB06-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194661>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This was taken from the bottom of my jc/split-blob topic, which made it
   available across "pack" related machinery, but it is useful outside the
   context of "pack".

 Makefile |    2 ++
 varint.c |   29 +++++++++++++++++++++++++++++
 varint.h |    9 +++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 varint.c
 create mode 100644 varint.h

diff --git a/Makefile b/Makefile
index be1957a..0f26c87 100644
--- a/Makefile
+++ b/Makefile
@@ -627,6 +627,7 @@ LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
+LIB_H += varint.h
 LIB_H += xdiff-interface.h
 LIB_H += xdiff/xdiff.h
 
@@ -752,6 +753,7 @@ LIB_OBJS += url.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
+LIB_OBJS += varint.o
 LIB_OBJS += walker.o
 LIB_OBJS += wrapper.o
 LIB_OBJS += write_or_die.o
diff --git a/varint.c b/varint.c
new file mode 100644
index 0000000..4ed7729
--- /dev/null
+++ b/varint.c
@@ -0,0 +1,29 @@
+#include "varint.h"
+
+uintmax_t decode_varint(const unsigned char **bufp)
+{
+	const unsigned char *buf = *bufp;
+	unsigned char c = *buf++;
+	uintmax_t val = c & 127;
+	while (c & 128) {
+		val += 1;
+		if (!val || MSB(val, 7))
+			return 0; /* overflow */
+		c = *buf++;
+		val = (val << 7) + (c & 127);
+	}
+	*bufp = buf;
+	return val;
+}
+
+int encode_varint(uintmax_t value, unsigned char *buf)
+{
+	unsigned char varint[16];
+	unsigned pos = sizeof(varint) - 1;
+	varint[pos] = value & 127;
+	while (value >>= 7)
+		varint[--pos] = 128 | (--value & 127);
+	if (buf)
+		memcpy(buf, varint + pos, sizeof(varint) - pos);
+	return sizeof(varint) - pos;
+}
diff --git a/varint.h b/varint.h
new file mode 100644
index 0000000..0321195
--- /dev/null
+++ b/varint.h
@@ -0,0 +1,9 @@
+#ifndef VARINT_H
+#define VARINT_H
+
+#include "git-compat-util.h"
+
+extern int encode_varint(uintmax_t, unsigned char *);
+extern uintmax_t decode_varint(const unsigned char **);
+
+#endif /* VARINT_H */
-- 
1.7.10.rc4.54.g1d5dd3
