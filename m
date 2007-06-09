From: Johan Herland <johan@herland.net>
Subject: [PATCH 09/21] Remove unneeded code from mktag.c
Date: Sat, 09 Jun 2007 02:16:18 +0200
Message-ID: <200706090216.18823.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:16:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwocz-0004Ag-7l
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030800AbXFIAQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969960AbXFIAQY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:16:24 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33705 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969905AbXFIAQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:16:23 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903E39RG00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:16:22 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000MZE37CO20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:16:19 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009UGE36AH00@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:16:19 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49536>

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c |   94 ---------------------------------------------------------------
 1 files changed, 0 insertions(+), 94 deletions(-)

diff --git a/mktag.c b/mktag.c
index 5780f33..4f226ab 100644
--- a/mktag.c
+++ b/mktag.c
@@ -14,100 +14,6 @@
  * shortest single-character-tag line.
  */
 
-/*
- * We refuse to tag something we can't verify. Just because.
- */
-static int verify_object(unsigned char *sha1, const char *expected_type)
-{
-	int ret = -1;
-	enum object_type type;
-	unsigned long size;
-	void *buffer = read_sha1_file(sha1, &type, &size);
-
-	if (buffer) {
-		if (type == type_from_string(expected_type))
-			ret = check_sha1_signature(sha1, buffer, size, expected_type);
-		free(buffer);
-	}
-	return ret;
-}
-
-static int verify_tag(char *data, unsigned long size)
-{
-#ifdef NO_C99_FORMAT
-#define PD_FMT "%d"
-#else
-#define PD_FMT "%td"
-#endif
-
-	unsigned char sha1[20];
-	char type[20];
-	const char *type_line, *tag_line, *tagger_line;
-	unsigned long type_len;
-
-	if (size < 64)
-		return error("wanna fool me ? you obviously got the size wrong !");
-
-	/* Verify object line */
-	if (memcmp(data, "object ", 7))
-		return error("char%d: does not start with \"object \"", 0);
-
-	if (get_sha1_hex(data + 7, sha1))
-		return error("char%d: could not get SHA1 hash", 7);
-
-	/* Verify type line */
-	type_line = data + 48;
-	if (memcmp(type_line - 1, "\ntype ", 6))
-		return error("char%d: could not find \"\\ntype \"", 47);
-
-	/* Verify tag-line */
-	tag_line = strchr(type_line, '\n');
-	if (!tag_line++)
-		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - data);
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char" PD_FMT ": no \"tag \" found", tag_line - data);
-
-	/* Verify the tagger line */
-	tagger_line = strchr(tag_line, '\n');
-	if (!tagger_line++)
-		return error("char" PD_FMT ": could not find next \"\\n\"", tag_line - data);
-	if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
-		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - data);
-
-	/* Get the actual type */
-	type_len = tag_line - type_line - strlen("type \n");
-	if (type_len >= sizeof(type))
-		return error("char" PD_FMT ": type too long", type_line + 5 - data);
-	memcpy(type, type_line + 5, type_len);
-	type[type_len] = '\0';
-
-	{
-		unsigned long i;
-
-		/* Verify that the object matches */
-		if (verify_object(sha1, type))
-			return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
-
-		/* Verify the tag-name: we don't allow control characters or spaces in it */
-		for (i = 4;;) {
-			unsigned char c = tag_line[i++];
-			if (c == '\n')
-				break;
-			if (c > ' ')
-				continue;
-			return error("char" PD_FMT ": could not verify tag name", tag_line + i - data);
-		}
-	}
-
-	/* TODO: check for committer info + blank line? */
-	/* Also, the minimum length is probably + "tagger .", or 63+8=71 */
-
-	/* The actual stuff afterwards we don't care about.. */
-	return 0;
-
-#undef PD_FMT
-}
-
 int main(int argc, char **argv)
 {
 	unsigned long size = 4096;
-- 
1.5.2
