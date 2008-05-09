From: drafnel@gmail.com
Subject: [PATCH 1/5] mktag.c: adjust verify_tag parameters
Date: Thu,  8 May 2008 21:19:45 -0500
Message-ID: <3712867.1210299524581.JavaMail.teamon@b301.teamon.com>
References: <1210299589-10448-1-git-send-email-drafnel@example.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Brandon Casey <casey@nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:34:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuIRA-00059u-Mj
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbYEICdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 22:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755459AbYEICdP
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:33:15 -0400
Received: from mailproxy01.teamon.com ([64.85.68.137]:18864 "EHLO
	b301.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754788AbYEICdL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 22:33:11 -0400
X-Greylist: delayed 866 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 22:33:07 EDT
Received: from b301.teamon.com (localhost [127.0.0.1])
	by b301.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m492IiG10328;
	Fri, 9 May 2008 02:18:44 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <1210299589-10448-1-git-send-email-drafnel@example.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81591>

From: Brandon Casey <casey@nrlssc.navy.mil>

The size parameter should be a size_t since it is a string length.

There is no reason that the buffer argument should not be constant except
for the nul termination that is performed in the first few lines of this
function. This is not necessary, since a valid c string must always be
nul terminated and we can check whether we have exceeded the caller's
size parameter at the end of parsing the buffer.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 mktag.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mktag.c b/mktag.c
index 0b34341..5489ad6 100644
--- a/mktag.c
+++ b/mktag.c
@@ -39,7 +39,7 @@ static int verify_object(unsigned char *sha1, const char *expected_type)
 #define PD_FMT "%td"
 #endif
 
-static int verify_tag(char *buffer, unsigned long size)
+static int verify_tag(const char *buffer, size_t size)
 {
 	int typelen;
 	char type[20];
@@ -50,8 +50,6 @@ static int verify_tag(char *buffer, unsigned long size)
 	if (size < 84)
 		return error("wanna fool me ? you obviously got the size wrong !");
 
-	buffer[size] = 0;
-
 	/* Verify object line */
 	object = buffer;
 	if (memcmp(object, "object ", 7))
@@ -145,6 +143,13 @@ static int verify_tag(char *buffer, unsigned long size)
 		return error("char" PD_FMT ": trailing garbage in tag header",
 			tagger_line - buffer);
 
+	/*
+	 * Make sure we haven't advanced past what the caller said the
+	 * buffer size was.
+	 */
+	if (tagger_line - buffer >= size)
+		return error("char" PD_FMT ": tag truncated", size);
+
 	/* The actual stuff afterwards we don't care about.. */
 	return 0;
 }
-- 
1.5.5.67.g9a49
