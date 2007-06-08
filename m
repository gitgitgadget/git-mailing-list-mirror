From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix failed tag parsing when tag object has no body/message
 (and thus ends with a single '\n')
Date: Fri, 08 Jun 2007 02:08:14 +0200
Message-ID: <200706080208.14571.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <Pine.LNX.4.64.0706080023450.4046@racer.site>
 <200706080147.50207.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 02:08:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwS1i-0005CC-93
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 02:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966117AbXFHAIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 20:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966192AbXFHAIS
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 20:08:18 -0400
Received: from [84.208.20.33] ([84.208.20.33]:42882 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966117AbXFHAIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 20:08:17 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJA00801J1S2L00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 02:08:16 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA00MZOJ1RHD10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 02:08:15 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA001DNJ1QTT60@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 02:08:14 +0200 (CEST)
In-reply-to: <200706080147.50207.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49417>

Thanks to Johannes Schindelin <Johannes.Schindelin@gmx.de> for
discovering this.

Also add a testcase for this condition.

Signed-off-by: Johan Herland <johan@herland.net>
---

This patch should hopefully fix your problem.


...Johan

 t/t3800-mktag.sh |   15 +++++++++++++++
 tag.c            |    9 ++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index ac9008a..ac7cbbc 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -399,5 +399,20 @@ test_expect_success \
     'create valid tag #4' \
     'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
+############################################################
+# 24. create valid tag #4 (with empty message)
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+keywords note
+tagger a
+EOF
+
+test_expect_success \
+    'create valid tag #4' \
+    'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
+
 
 test_done
diff --git a/tag.c b/tag.c
index e371179..875145b 100644
--- a/tag.c
+++ b/tag.c
@@ -131,10 +131,6 @@ int parse_and_verify_tag_buffer(struct tag *item, const char *data, const unsign
 		header_end = memchr(tagger_line, '\n', end - tagger_line);
 		if (!header_end++)
 			return error("char" PD_FMT ": could not find \"\\n\" after \"tagger\"", tagger_line - data);
-		if (end - header_end < 1)
-			return error("char" PD_FMT ": premature end of data", header_end - data);
-		if (*header_end != '\n') /* header must end with "\n\n" */
-			return error("char" PD_FMT ": could not find blank line after header section", header_end - data);
 	}
 	else {
 		/* Treat tagger line as optional */
@@ -148,9 +144,8 @@ int parse_and_verify_tag_buffer(struct tag *item, const char *data, const unsign
 			header_end = tagger_line;
 	}
 
-	if (end - header_end < 1)
-		return error("char" PD_FMT ": premature end of data", header_end - data);
-	if (*header_end != '\n') /* header must end with "\n\n" */
+	/* header must end with "\n\n", but "\n" is acceptable if at EOF */
+	if (header_end < end - 1 && *header_end != '\n') /* not at EOF, and next char is not '\n' */
 		return error("char" PD_FMT ": could not find blank line after header section", header_end - data);
 
 	/*
-- 
1.5.2
