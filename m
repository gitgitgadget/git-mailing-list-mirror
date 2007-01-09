From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Auto-quote config values in config.c:store_write_pair()
Date: Tue, 9 Jan 2007 00:27:41 -0500
Message-ID: <20070109052741.GB27927@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 06:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H49WV-0007l6-T7
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 06:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbXAIF1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 00:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbXAIF1n
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 00:27:43 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:48330 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbXAIF1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 00:27:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id E84841FFD296
	for <git@vger.kernel.org>; Tue,  9 Jan 2007 05:27:42 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36311>

Suggested by Jakub Narebski <jnareb@gmail.com> on the list.

When we send a value to store_write_pair(), make sure that the value
that gets read out matches the one passed in.  This means that for any
value that contains leading or trailing whitespace or any comment
character (# and ;), we need to surround it in quotes.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 config.c               |   14 ++++++++++++++
 t/t1300-repo-config.sh |   17 +++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index 5cbd130..e99681a 100644
--- a/config.c
+++ b/config.c
@@ -496,11 +496,23 @@ static void store_write_section(int fd, const char* key)
 static void store_write_pair(int fd, const char* key, const char* value)
 {
 	int i;
+	int quote = 0;
+
+	/* Check to see if the value needs to be quoted. */
+	if (value[0] == ' ')
+		quote = 1;
+	for (i = 0; value[i]; i++)
+		if (value[i] == ';' || value[i] == '#')
+			quote = 1;
+	if (value[i-1] == ' ')
+		quote = 1;
 
 	write(fd, "\t", 1);
 	write(fd, key+store.baselen+1,
 		strlen(key+store.baselen+1));
 	write(fd, " = ", 3);
+	if (quote)
+		write(fd, "\"", 1);
 	for (i = 0; value[i]; i++)
 		switch (value[i]) {
 		case '\n': write(fd, "\\n", 2); break;
@@ -508,6 +520,8 @@ static void store_write_pair(int fd, const char* key, const char* value)
 		case '"': case '\\': write(fd, "\\", 1);
 		default: write(fd, value+i, 1);
 	}
+	if (quote)
+		write(fd, "\"", 1);
 	write(fd, "\n", 1);
 }
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index a29caa0..60acdd3 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -401,5 +401,22 @@ test_expect_success numbers '
 	test z1048576 = "z$m"
 '
 
+rm .git/config
+
+git-repo-config quote.leading " test"
+git-repo-config quote.ending "test "
+git-repo-config quote.semicolon "test;test"
+git-repo-config quote.hash "test#test"
+
+cat > expect << EOF
+[quote]
+	leading = " test"
+	ending = "test "
+	semicolon = "test;test"
+	hash = "test#test"
+EOF
+
+test_expect_success 'quoting' 'cmp .git/config expect'
+
 test_done
 
-- 
1.4.4.4.g4083
