From: Johan Herland <johan@herland.net>
Subject: [PATCH 08/21] Switch from verify_tag() to
 parse_and_verify_tag_buffer() for verifying tag objects in git-mktag
Date: Sat, 09 Jun 2007 02:15:54 +0200
Message-ID: <200706090215.54494.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwoca-00047O-28
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030728AbXFIAP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969960AbXFIAP6
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:15:58 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33503 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969900AbXFIAP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:15:58 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903E2LQ500@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:15:57 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000MJE2ICO20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:15:54 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC00FTBE2IRBF0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:15:54 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49535>

This involves exposing parse_and_verify_tag_buffer() in the tag API
(tag.h).

Also synchronize selftest with change in error message.

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c          |    5 ++---
 t/t3800-mktag.sh |    2 +-
 tag.c            |    2 +-
 tag.h            |    2 ++
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/mktag.c b/mktag.c
index 2e70504..5780f33 100644
--- a/mktag.c
+++ b/mktag.c
@@ -125,9 +125,8 @@ int main(int argc, char **argv)
 	}
 	buffer[size] = 0;
 
-	/* Verify it for some basic sanity: it needs to start with
-	   "object <sha1>\ntype\ntagger " */
-	if (verify_tag(buffer, size) < 0)
+	/* Verify tag object data */
+	if (parse_and_verify_tag_buffer(0, buffer, size, 1))
 		die("invalid tag signature file");
 
 	if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0)
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index b4edb4d..0e87d2a 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -34,7 +34,7 @@ too short for a tag
 EOF
 
 cat >expect.pat <<EOF
-^error: .*size wrong.*$
+^error: .*size.*$
 EOF
 
 check_verify_failure 'Tag object length check'
diff --git a/tag.c b/tag.c
index 3896e45..e12b9fc 100644
--- a/tag.c
+++ b/tag.c
@@ -51,7 +51,7 @@ static int verify_object(unsigned char *sha1, const char *expected_type)
 	return ret;
 }
 
-static int parse_and_verify_tag_buffer(struct tag *item,
+int parse_and_verify_tag_buffer(struct tag *item,
 		const char *data, const unsigned long size, int thorough_verify)
 {
 #ifdef NO_C99_FORMAT
diff --git a/tag.h b/tag.h
index 7a0cb00..f341b7f 100644
--- a/tag.h
+++ b/tag.h
@@ -13,6 +13,8 @@ struct tag {
 };
 
 extern struct tag *lookup_tag(const unsigned char *sha1);
+extern int parse_and_verify_tag_buffer(struct tag *item,
+	const char *data, const unsigned long size, int thorough_verify);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
-- 
1.5.2
