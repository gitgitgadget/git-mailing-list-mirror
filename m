From: Andreas Krey <a.krey@gmx.de>
Subject: [PATCH 2/3] connect.c: save symref info from server capabilities
Date: Fri, 6 Sep 2013 17:56:55 +0200
Message-ID: <20130906155655.GG12966@inner.h.apk.li>
References: <20130906155204.GE12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 17:57:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHyPL-0000mY-2C
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 17:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab3IFP5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 11:57:11 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51630 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab3IFP5K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 11:57:10 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r86Futq01031;
	Fri, 6 Sep 2013 17:56:55 +0200
Content-Disposition: inline
In-Reply-To: <20130906155204.GE12966@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234054>

Signed-off-by: Andreas Krey <a.krey@gmx.de>
---
 connect.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index a0783d4..98c4868 100644
--- a/connect.c
+++ b/connect.c
@@ -72,8 +72,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	for (;;) {
 		struct ref *ref;
 		unsigned char old_sha1[20];
-		char *name;
-		int len, name_len;
+		char *name, *symref;
+		int len, name_len, symref_len;
 		char *buffer = packet_buffer;
 
 		len = packet_read(in, &src_buf, &src_len,
@@ -94,9 +94,12 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		name = buffer + 41;
 
 		name_len = strlen(name);
+		symref = 0;
 		if (len != name_len + 41) {
 			free(server_capabilities);
 			server_capabilities = xstrdup(name + name_len + 1);
+			symref = parse_feature_value(server_capabilities,
+						     "symref", &symref_len);
 		}
 
 		if (extra_have &&
@@ -108,6 +111,10 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		if (!check_ref(name, name_len, flags))
 			continue;
 		ref = alloc_ref(buffer + 41);
+		if (symref) {
+			ref->symref = xcalloc(symref_len + 1, 1);
+			strncpy(ref->symref, symref, symref_len);
+		}
 		hashcpy(ref->old_sha1, old_sha1);
 		*list = ref;
 		list = &ref->next;
-- 
1.8.3.1.485.g9704416.dirty
