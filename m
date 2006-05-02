From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] repo-config: trim white-space before comment
Date: Tue, 2 May 2006 16:58:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605021655220.8118@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 02 16:59:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FawKz-0006yj-34
	for gcvg-git@gmane.org; Tue, 02 May 2006 16:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWEBO6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 10:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWEBO6k
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 10:58:40 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:12718 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964860AbWEBO6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 10:58:39 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 576DB1317;
	Tue,  2 May 2006 16:58:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 4B96F1311;
	Tue,  2 May 2006 16:58:38 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 28A9DDEA;
	Tue,  2 May 2006 16:58:38 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19422>


Earlier, calling

	git-repo-config core.hello

on a .git/config like this:

	[core]
		hello = world ; a comment

would yield "world " (i.e. with a trailing space).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I wrote:
	> Strange thing I realized: A value is white-space-trimmed at the end
	> only if the line does not end with a comment. This fact is accounted
	> for in the new tests.

	It actually was a buglet in parse_value(), so it was not only 
	repo-config which was affected.

	Obviously, this patch comes on top of the --get-regexp patch, but
	feel free to apply without that.

 config.c               |   12 ++++++------
 t/t1300-repo-config.sh |    8 ++++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

bb874fdd7a55b7adc229ee9eb1b59e5852b41594
diff --git a/config.c b/config.c
index 4e1f0c2..253c48a 100644
--- a/config.c
+++ b/config.c
@@ -60,6 +60,12 @@ static char *parse_value(void)
 			space = 1;
 			continue;
 		}
+		if (!quote) {
+			if (c == ';' || c == '#') {
+				comment = 1;
+				continue;
+			}
+		}
 		if (space) {
 			if (len)
 				value[len++] = ' ';
@@ -93,12 +99,6 @@ static char *parse_value(void)
 			quote = 1-quote;
 			continue;
 		}
-		if (!quote) {
-			if (c == ';' || c == '#') {
-				comment = 1;
-				continue;
-			}
-		}
 		value[len++] = c;
 	}
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 52e8e33..e3ab661 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -247,8 +247,12 @@ EOF
 
 test_expect_success 'hierarchical section value' 'cmp .git/config expect'
 
+value="$(git-repo-config beta.noindent)"
+
+test_expect_success 'trim before comment' "test \"$value\" = sillyValue"
+
 cat > expect << EOF
-beta.noindent=sillyValue 
+beta.noindent=sillyValue
 nextsection.nonewline=wow2 for me
 123456.a123=987
 1.2.3.alpha=beta
@@ -258,7 +262,7 @@ test_expect_success 'working --list' \
 	'git-repo-config --list > output && cmp output expect'
 
 cat > expect << EOF
-beta.noindent sillyValue 
+beta.noindent sillyValue
 nextsection.nonewline wow2 for me
 EOF
 
-- 
1.3.1.g259f
