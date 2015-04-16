From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] utf8-bom: introduce skip_utf8_bom() helper
Date: Thu, 16 Apr 2015 11:39:06 -0700
Message-ID: <1429209548-32297-3-git-send-email-gitster@pobox.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
 <1429209548-32297-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 20:39:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yioh7-0006wt-QX
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbbDPSjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:39:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754663AbbDPSjN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:39:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 996F24A385;
	Thu, 16 Apr 2015 14:39:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JqJE
	9PQqXXeRJx5YMC4L3czj+Q8=; b=KbGHcM09IKHklaox3JwFdGPVQLlh/JkdqBK4
	CgLf1qiaRUtRnprjvspx0GE1LYFDPmEjNc8fu9URPk2nFg9UPfHzgQ9a2e3g0r3z
	Dyr+OZ4zVK9433geXFOIXDJ/tCbzBeC5D9+oK2ALpunbO+z9c5HAhHsFSzlChLTp
	P3wqU58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kAk28I
	+pJMXcqgw2DMqT2MJ8DvcxTuQNYJdqBna/UX3klAmkiMtJQNfd2hGeleDpXmz22G
	s1Y+uTxTR9yIbqsY2GTKMaiiW/llnw5HYMtRwLuUM2QcWzDQXHS/yUH2p2FaX4eJ
	Z68FDj3UXE03evzsm+YHQdeWIMoY6lAaimCPw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 911514A384;
	Thu, 16 Apr 2015 14:39:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09DFD4A383;
	Thu, 16 Apr 2015 14:39:11 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc2-171-g98ddf7f
In-Reply-To: <1429209548-32297-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E01A9F06-E467-11E4-97E4-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267323>

With the recent change to ignore the UTF8 BOM at the beginning of
.gitignore files, we now have two codepaths that do such a skipping
(the other one is for reading the configuration files).

Introduce utf8_bom[] constant string and skip_utf8_bom() helper
and teach .gitignore code how to use it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c  |  9 ++++-----
 utf8.c | 11 +++++++++++
 utf8.h |  3 +++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index b5bb389..4c4bf91 100644
--- a/dir.c
+++ b/dir.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "pathspec.h"
+#include "utf8.h"
 
 struct path_simplify {
 	int len;
@@ -538,7 +539,6 @@ int add_excludes_from_file_to_list(const char *fname,
 	struct stat st;
 	int fd, i, lineno = 1;
 	size_t size = 0;
-	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
 	char *buf, *entry;
 
 	fd = open(fname, O_RDONLY);
@@ -576,10 +576,9 @@ int add_excludes_from_file_to_list(const char *fname,
 
 	el->filebuf = buf;
 
-	if (size >= 3 && !memcmp(buf, utf8_bom, 3)) {
-		buf += 3;
-		size -= 3;
-	}
+	if (skip_utf8_bom(&buf, size))
+		size -= buf - el->filebuf;
+
 	entry = buf;
 
 	for (i = 0; i < size; i++) {
diff --git a/utf8.c b/utf8.c
index 520fbb4..28e6d76 100644
--- a/utf8.c
+++ b/utf8.c
@@ -633,3 +633,14 @@ int is_hfs_dotgit(const char *path)
 
 	return 1;
 }
+
+const char utf8_bom[] = "\357\273\277";
+
+int skip_utf8_bom(char **text, size_t len)
+{
+	if (len < strlen(utf8_bom) ||
+	    memcmp(*text, utf8_bom, strlen(utf8_bom)))
+		return 0;
+	*text += strlen(utf8_bom);
+	return 1;
+}
diff --git a/utf8.h b/utf8.h
index e4d9183..e7b2aa4 100644
--- a/utf8.h
+++ b/utf8.h
@@ -13,6 +13,9 @@ int same_encoding(const char *, const char *);
 __attribute__((format (printf, 2, 3)))
 int utf8_fprintf(FILE *, const char *, ...);
 
+extern const char utf8_bom[];
+extern int skip_utf8_bom(char **, size_t);
+
 void strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
 void strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
-- 
2.4.0-rc2-171-g98ddf7f
