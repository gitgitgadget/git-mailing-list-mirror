From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v0 2/3] index_fd(): split into two helper functions
Date: Sun,  8 May 2011 01:47:34 -0700
Message-ID: <1304844455-23570-3-git-send-email-gitster@pobox.com>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 10:47:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIzeZ-0004V0-NS
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 10:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab1EHIro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 04:47:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab1EHIrm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 04:47:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2ECB54E00
	for <git@vger.kernel.org>; Sun,  8 May 2011 04:49:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tAJT
	X28akWcRrhlVlCENL2A5V1M=; b=Wa+PbnD8zeI0TDA7zHsPtMf24fd2HZPtAyMG
	H+twA4flDJQmyFk626glh3oHtDMQRtMZjax0SKTlf9xX7700Nzicyi5xv0BK5VwO
	PDXfLPQ88jO+Mvl2p0mEShTpb3JV7gXOEEqpiJWCO15wNhxQrcTJRXOAFxlrH2dA
	1OSyslQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xj5Vfu
	M7NF7Yn6vofyMPvAuxmmskf5NI2y0aES0F9xVsWb8LGXE1WAYqzkdhWEnlpzPv6b
	2OQgx/6pr5+fmYpZDnEb3lr5IZhJGURMp92r1yRHom503LRJKpN7H4pUquxEVrwb
	Q98/VQUtI4HqJXxJpFg7yp6Gd24I8pfIvnuBM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 280414DFF
	for <git@vger.kernel.org>; Sun,  8 May 2011 04:49:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8CF6E4DFE for
 <git@vger.kernel.org>; Sun,  8 May 2011 04:49:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.268.gce5bd
In-Reply-To: <1304844455-23570-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1FE56CF6-7950-11E0-8E40-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173082>

Split out the case where we do not know the size of the input (hence we
read everything into a strbuf before doing anything) to index_pipe(), and
the other case where we mmap or read the whole data to index_bulk().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |   42 +++++++++++++++++++++++++++++++-----------
 1 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 17c179c..49416b0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2619,22 +2619,29 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	return ret;
 }
 
+static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
+		      const char *path, unsigned flags)
+{
+	struct strbuf sbuf = STRBUF_INIT;
+	int ret;
+
+	if (strbuf_read(&sbuf, fd, 4096) >= 0)
+		ret = index_mem(sha1, sbuf.buf, sbuf.len, type,	path, flags);
+	else
+		ret = -1;
+	strbuf_release(&sbuf);
+	return ret;
+}
+
 #define SMALL_FILE_SIZE (32*1024)
 
-int index_fd(unsigned char *sha1, int fd, struct stat *st,
-	     enum object_type type, const char *path, unsigned flags)
+static int index_core(unsigned char *sha1, int fd, size_t size,
+		      enum object_type type, const char *path,
+		      unsigned flags)
 {
 	int ret;
-	size_t size = xsize_t(st->st_size);
 
-	if (!S_ISREG(st->st_mode)) {
-		struct strbuf sbuf = STRBUF_INIT;
-		if (strbuf_read(&sbuf, fd, 4096) >= 0)
-			ret = index_mem(sha1, sbuf.buf, sbuf.len, type,	path, flags);
-		else
-			ret = -1;
-		strbuf_release(&sbuf);
-	} else if (!size) {
+	if (!size) {
 		ret = index_mem(sha1, NULL, size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
@@ -2648,6 +2655,19 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 		ret = index_mem(sha1, buf, size, type, path, flags);
 		munmap(buf, size);
 	}
+	return ret;
+}
+
+int index_fd(unsigned char *sha1, int fd, struct stat *st,
+	     enum object_type type, const char *path, unsigned flags)
+{
+	int ret;
+	size_t size = xsize_t(st->st_size);
+
+	if (!S_ISREG(st->st_mode))
+		ret = index_pipe(sha1, fd, type, path, flags);
+	else
+		ret = index_core(sha1, fd, size, type, path, flags);
 	close(fd);
 	return ret;
 }
-- 
1.7.5.1.268.gce5bd
