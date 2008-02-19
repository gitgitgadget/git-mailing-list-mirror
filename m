From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/4] Fix format.headers not ending with a newline
Date: Tue, 19 Feb 2008 02:40:31 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802190239440.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRN6j-0006Rf-T9
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760020AbYBSHkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759875AbYBSHkc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:40:32 -0500
Received: from iabervon.org ([66.92.72.58]:33330 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759866AbYBSHkc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:40:32 -0500
Received: (qmail 16206 invoked by uid 1000); 19 Feb 2008 07:40:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 07:40:31 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74383>

Now each value of format.headers will always be treated as a single
valid header, and newlines will be inserted between them as needed.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-log.c           |    8 ++++++--
 t/t4014-format-patch.sh |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index a67b463..73b6d53 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -425,10 +425,14 @@ static int git_format_config(const char *var, const char *value)
 		if (!value)
 			die("format.headers without value");
 		len = strlen(value);
-		extra_headers_size += len + 1;
+		while (value[len - 1] == '\n')
+			len--;
+		extra_headers_size += len + 2;
 		extra_headers = xrealloc(extra_headers, extra_headers_size);
-		extra_headers[extra_headers_size - len - 1] = 0;
+		extra_headers[extra_headers_size - len - 2] = 0;
 		strcat(extra_headers, value);
+		extra_headers[extra_headers_size - 2] = '\n';
+		extra_headers[extra_headers_size - 1] = 0;
 		return 0;
 	}
 	if (!strcmp(var, "format.suffix")) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 28ab7b9..755fe6d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -101,7 +101,7 @@ test_expect_success 'extra headers' '
 	
 '
 
-test_expect_failure 'extra headers without newlines' '
+test_expect_success 'extra headers without newlines' '
 
 	git config --replace-all format.headers "To: R. E. Cipient <rcipient@example.com>" &&
 	git config --add format.headers "Cc: S. E. Cipient <scipient@example.com>" &&
-- 
1.5.4.1.192.g8ea3a
