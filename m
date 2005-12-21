From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] off-by-one bugs found by valgrind
Date: Wed, 21 Dec 2005 15:35:48 -0500
Message-ID: <1135197348.3046.7.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Dec 21 21:38:26 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpAiC-0002PT-Ay
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 21:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVLUUgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 15:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLUUgw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 15:36:52 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:16030 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964819AbVLUUgv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 15:36:51 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EpAfY-0001co-9g
	for git@vger.kernel.org; Wed, 21 Dec 2005 15:34:41 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EpAge-0001vk-Sv
	for git@vger.kernel.org; Wed, 21 Dec 2005 15:35:48 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13895>

Insufficient memory is allocated in index-pack.c to hold the *.idx name.
One more byte should be allocated to hold the terminating 0.

quote_c_style_counted() in quote.c uses a dangerous construct, when a
variable is incremented once and used twice in the same expression.
Convert this construct to a more traditional form of the for loop.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/index-pack.c b/index-pack.c
index 785fe71..d4ce3af 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -440,7 +440,7 @@ int main(int argc, char **argv)
 		if (len < 5 || strcmp(pack_name + len - 5, ".pack"))
 			die("packfile name '%s' does not end with '.pack'",
 			    pack_name);
-		index_name_buf = xmalloc(len - 1);
+		index_name_buf = xmalloc(len);
 		memcpy(index_name_buf, pack_name, len - 5);
 		strcpy(index_name_buf + len - 5, ".idx");
 		index_name = index_name_buf;
diff --git a/quote.c b/quote.c
index 76eb144..00297b5 100644
--- a/quote.c
+++ b/quote.c
@@ -126,8 +126,10 @@ static int quote_c_style_counted(const c
 
 	if (!no_dq)
 		EMIT('"');
-	for (sp = name; (ch = *sp++) && (sp - name) <= namelen; ) {
-
+	for (sp = name; sp < name + namelen; sp++) {
+		ch = *sp;
+		if (!ch)
+			break;
 		if ((ch < ' ') || (ch == '"') || (ch == '\\') ||
 		    (ch == 0177)) {
 			needquote = 1;


-- 
Regards,
Pavel Roskin
