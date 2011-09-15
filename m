From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/22] resolve_ref(): turn buffer into a proper string as soon as possible
Date: Thu, 15 Sep 2011 23:10:34 +0200
Message-ID: <1316121043-29367-14-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:19:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JL4-0001Bv-RR
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935025Ab1IOVTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:19:12 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40220 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934943Ab1IOVTL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:19:11 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8v-00019o-5c; Thu, 15 Sep 2011 23:06:45 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181516>

Immediately strip off trailing spaces and null-terminate the string
holding the contents of the reference file; this allows the use of
string functions and avoids the need to keep separate track of the
string's length.  (get_sha1_hex() fails automatically if the string is
too short.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 8f0b871..79ab0eb 100644
--- a/refs.c
+++ b/refs.c
@@ -546,25 +546,25 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 			return NULL;
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
 		close(fd);
+		if (len < 0)
+			return NULL;
+		while (len && isspace(buffer[len-1]))
+			len--;
+		buffer[len] = '\0';
 
 		/*
 		 * Is it a symbolic ref?
 		 */
-		if (len < 4 || memcmp("ref:", buffer, 4))
+		if (prefixcmp(buffer, "ref:"))
 			break;
 		buf = buffer + 4;
-		len -= 4;
-		while (len && isspace(*buf))
-			buf++, len--;
-		while (len && isspace(buf[len-1]))
-			len--;
-		buf[len] = 0;
-		memcpy(ref_buffer, buf, len + 1);
-		ref = ref_buffer;
+		while (isspace(*buf))
+			buf++;
+		ref = strcpy(ref_buffer, buf);
 		if (flag)
 			*flag |= REF_ISSYMREF;
 	}
-	if (len < 40 || get_sha1_hex(buffer, sha1))
+	if (get_sha1_hex(buffer, sha1))
 		return NULL;
 	return ref;
 }
-- 
1.7.6.8.gd2879
