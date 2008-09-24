From: Johan Herland <johan@herland.net>
Subject: [PATCH] for-each-ref: Fix --format=%(subject) for log message without
 newlines
Date: Thu, 25 Sep 2008 01:10:54 +0200
Message-ID: <200809250110.54229.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 01:12:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KidWi-0000p8-9b
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 01:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbYIXXK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 19:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbYIXXK6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 19:10:58 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54867 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbYIXXK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 19:10:57 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K7Q00401328F300@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 25 Sep 2008 01:10:56 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7Q00EMJ3261A00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 25 Sep 2008 01:10:54 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7Q00B2T326FB56@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 25 Sep 2008 01:10:54 +0200 (CEST)
Content-disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96709>

'git for-each-ref --format=%(subject)' currently returns an empty string
if the log message does not contain a newline.

This patch teaches 'git for-each-ref' to return the entire log message
(instead of an empty string) if there is no newline in the log message.

Signed-off-by: Johan Herland <johan@herland.net>
---

Normally, log messages in git have trailing newlines. However, it seems the
"tag fixup commits" manufactured by cvs2svn/cvs2git (via git-fast-import)
have single-line log message without trailing newlines.

I have checked the other callers of copy_line(), and AFAICS they are not
affected by this change, since that would violate the git object format.


Have fun! :)

...Johan


 builtin-for-each-ref.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 9b44092..e59bd80 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -321,8 +321,8 @@ static const char *find_wholine(const char *who, int wholen, const char *buf, un
 static const char *copy_line(const char *buf)
 {
 	const char *eol = strchr(buf, '\n');
-	if (!eol)
-		return "";
+	if (!eol) // simulate strchrnul()
+		eol = buf + strlen(buf);
 	return xmemdupz(buf, eol - buf);
 }
 
-- 
1.6.0.2.463.g7f0eb
