From: =?ISO-8859-1?Q?Bj=F6rn_Engelmann?= <BjEngelmann@gmx.de>
Subject: [PATCH 2/2] Again: add more informative error messages to git-mktag
Date: Tue, 23 May 2006 20:20:09 +0200
Message-ID: <44735259.5040107@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070305050204050509030902"
X-From: git-owner@vger.kernel.org Tue May 23 20:20:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FibUQ-0002Bt-Ix
	for gcvg-git@gmane.org; Tue, 23 May 2006 20:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWEWSUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 14:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWEWSUG
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 14:20:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:20870 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751168AbWEWSUD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 14:20:03 -0400
Received: (qmail invoked by alias); 23 May 2006 18:20:02 -0000
Received: from unknown (EHLO [10.79.42.1]) [62.206.42.234]
  by mail.gmx.net (mp001) with SMTP; 23 May 2006 20:20:02 +0200
X-Authenticated: #916101
User-Agent: Mail/News 1.5 (X11/20060228)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20617>

This is a multi-part message in MIME format.
--------------070305050204050509030902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------070305050204050509030902
Content-Type: text/plain;
 name*0="0002-add-more-informative-error-messages-to-git-mktag.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename*0="0002-add-more-informative-error-messages-to-git-mktag.txt"


Signed-off-by: Björn Engelmann <BjEngelmann@gmx.de>


---

51465a979a25c4363010cbab5798d95ac9f102e7
 mktag.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

51465a979a25c4363010cbab5798d95ac9f102e7
diff --git a/mktag.c b/mktag.c
index f1598db..6bd45df 100644
--- a/mktag.c
+++ b/mktag.c
@@ -46,41 +46,45 @@ static int verify_tag(char *buffer, unsi
 	const char *object, *type_line, *tag_line, *tagger_line;
 
 	if (size < 64)
-		return -1;
+		return error("wanna fool me ? you obviously got the size wrong !\n");
+
 	buffer[size] = 0;
 
 	/* Verify object line */
 	object = buffer;
 	if (memcmp(object, "object ", 7))
-		return -1;
+		return error("char%d: does not start with \"object \"\n", 0);
+
 	if (get_sha1_hex(object + 7, sha1))
-		return -1;
+		return error("char%d: could not get SHA1 hash\n", 7);
 
 	/* Verify type line */
 	type_line = object + 48;
 	if (memcmp(type_line - 1, "\ntype ", 6))
-		return -1;
+		return error("char%d: could not find \"\\ntype \"\n", 47);
 
 	/* Verify tag-line */
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line)
-		return -1;
+		return error("char%td: could not find next \"\\n\"\n", type_line - buffer);
 	tag_line++;
 	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return -1;
+		return error("char%td: no \"tag \" found\n", tag_line - buffer);
 
 	/* Get the actual type */
 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= sizeof(type))
-		return -1;
+		return error("char%d: type too long\n", (int)(type_line - buffer) + strlen("type \n"));
+
 	memcpy(type, type_line+5, typelen);
 	type[typelen] = 0;
 
 	/* Verify that the object matches */
 	if (get_sha1_hex(object + 7, sha1))
-		return -1;
+		return error("char%d: could not get SHA1 hash but this is really odd since i got it before !\n", 7);
+	
 	if (verify_object(sha1, type))
-		return -1;
+		return error("char%d: could not verify object %s\n", 7, sha1);
 
 	/* Verify the tag-name: we don't allow control characters or spaces in it */
 	tag_line += 4;
@@ -90,14 +94,14 @@ static int verify_tag(char *buffer, unsi
 			break;
 		if (c > ' ')
 			continue;
-		return -1;
+		return error("char%td: could not verify tag name\n", tag_line - buffer);
 	}
 
 	/* Verify the tagger line */
 	tagger_line = tag_line;
 
 	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
-		return -1;
+		return error("char%td: could not find \"tagger\"\n", tagger_line - buffer);
 
 	/* The actual stuff afterwards we don't care about.. */
 	return 0;
@@ -118,7 +122,7 @@ int main(int argc, char **argv)
 		free(buffer);
 		die("could not read from stdin");
 	}
-
+	
 	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype\ntagger "
 	if (verify_tag(buffer, size) < 0)
 		die("invalid tag signature file");
-- 
1.3.3.g4309-dirty


--------------070305050204050509030902--
