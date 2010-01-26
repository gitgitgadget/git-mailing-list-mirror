From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 1/4] Add xmallocz()
Date: Tue, 26 Jan 2010 20:24:12 +0200
Message-ID: <1264530255-4682-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 19:25:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZq6Y-0005Wt-2Z
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 19:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab0AZSYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 13:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792Ab0AZSYW
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 13:24:22 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:60242 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab0AZSYT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 13:24:19 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id A734E18D3BB
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:17 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03406A44BE; Tue, 26 Jan 2010 20:24:17 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 8808927D8C
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:16 +0200 (EET)
X-Mailer: git-send-email 1.6.6.1.439.gf06b6
In-Reply-To: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138062>

Add routine for allocating NUL-terminated memory block without risking
integer overflow in addition of +1 for NUL byte.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 git-compat-util.h |    1 +
 wrapper.c         |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 620a7c6..a3c4537 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -348,6 +348,7 @@ extern void release_pack_memory(size_t, int);
 
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
+extern void *xmallocz(size_t size);
 extern void *xmemdupz(const void *data, size_t len);
 extern char *xstrndup(const char *str, size_t len);
 extern void *xrealloc(void *ptr, size_t size);
diff --git a/wrapper.c b/wrapper.c
index c9be140..dd7b6ee 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -34,6 +34,16 @@ void *xmalloc(size_t size)
 	return ret;
 }
 
+void *xmallocz(size_t size)
+{
+	void *ret;
+	if (size + 1 < size)
+		die("Data too large to fit into virtual memory space.");
+	ret = xmalloc(size + 1);
+	((char*)ret)[size] = 0;
+	return ret;
+}
+
 /*
  * xmemdupz() allocates (len + 1) bytes of memory, duplicates "len" bytes of
  * "data" to the allocated memory, zero terminates the allocated memory,
@@ -42,7 +52,7 @@ void *xmalloc(size_t size)
  */
 void *xmemdupz(const void *data, size_t len)
 {
-	char *p = xmalloc(len + 1);
+	char *p = xmallocz(len);
 	memcpy(p, data, len);
 	p[len] = '\0';
 	return p;
-- 
1.6.6.1.439.gf06b6
