From: Johan Herland <johan@herland.net>
Subject: [PATCH 10/21] Free mktag's buffer before dying
Date: Sat, 09 Jun 2007 02:16:41 +0200
Message-ID: <200706090216.41856.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwodL-0004D8-6p
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969988AbXFIAQq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969960AbXFIAQp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:16:45 -0400
Received: from smtp.getmail.no ([84.208.20.33]:48489 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969905AbXFIAQp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:16:45 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903E3WX800@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:16:44 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000O1E3UZL30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:16:42 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009WUE3TAH00@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:16:42 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49537>

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/mktag.c b/mktag.c
index 4f226ab..31eadd8 100644
--- a/mktag.c
+++ b/mktag.c
@@ -21,7 +21,7 @@ int main(int argc, char **argv)
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
-		usage("git-mktag < signaturefile");
+		usage("git-mktag < tag_data_file");
 
 	setup_git_directory();
 
@@ -32,14 +32,17 @@ int main(int argc, char **argv)
 	buffer[size] = 0;
 
 	/* Verify tag object data */
-	if (parse_and_verify_tag_buffer(0, buffer, size, 1))
-		die("invalid tag signature file");
+	if (parse_and_verify_tag_buffer(0, buffer, size, 1)) {
+		free(buffer);
+		die("invalid tag data file");
+	}
 
-	if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0)
+	if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0) {
+		free(buffer);
 		die("unable to write tag file");
+	}
 
 	free(buffer);
-
 	printf("%s\n", sha1_to_hex(result_sha1));
 	return 0;
 }
-- 
1.5.2
