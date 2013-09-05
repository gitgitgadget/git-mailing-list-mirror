From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 09/38] introduce get_sha1_lowhex()
Date: Thu, 05 Sep 2013 02:19:32 -0400
Message-ID: <1378362001-1738-10-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSwq-0008QP-Sw
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761976Ab3IEGVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:21:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757223Ab3IEGUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:17 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3W2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:14 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id D05512DA0673	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:14 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233921>

This is like get_sha1_hex() but stricter in accepting lowercase letters
only.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 cache.h |  3 +++
 hex.c   | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/cache.h b/cache.h
index b6634c4..4231dfa 100644
--- a/cache.h
+++ b/cache.h
@@ -850,8 +850,11 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
  * Return 0 on success.  Reading stops if a NUL is encountered in the
  * input, so it is safe to pass this function an arbitrary
  * null-terminated string.
+ *
+ * The "low" version accepts numbers and lowercase letters only.
  */
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
+extern int get_sha1_lowhex(const char *hex, unsigned char *sha1);
 
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref_full(const char *refname, unsigned char *sha1,
diff --git a/hex.c b/hex.c
index 9ebc050..1d7eae1 100644
--- a/hex.c
+++ b/hex.c
@@ -56,6 +56,17 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 	return 0;
 }
 
+int get_sha1_lowhex(const char *hex, unsigned char *sha1)
+{
+	int i;
+
+	/* uppercase letters (as well as '\0') have bit 5 clear */
+	for (i = 0; i < 20; i++)
+		if (!(hex[i] & 0x20))
+			return -1;
+	return get_sha1_hex(hex, sha1);
+}
+
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
-- 
1.8.4.38.g317e65b
