From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 8/9] Support more http features: https no cert, .netrc -> auth
Date: Fri, 22 Jul 2005 17:30:15 -0700
Message-ID: <7v1x5qbbzc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 02:34:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7y3-0001fQ-6S
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 02:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVGWAdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 20:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVGWAaw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 20:30:52 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:59353 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262258AbVGWAaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 20:30:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723003012.NZPP19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 20:30:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Darrin Thompson <darrint@progeny.com>
Date: 1121220760 -0500

Cause setting environment variable GIT_SSL_NO_VERIFY to turn off
curl's ssl peer verification.

Only use curl for http transfers, instead of curl and wget.

Make curl check ~/.netrc for credentials.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-fetch-script |    7 +++++--
 http-pull.c      |    6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

1041908edea29758af81ac9452484cfc652f455c
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -9,8 +9,11 @@ merge_store="$_remote_store"
 TMP_HEAD="$GIT_DIR/TMP_HEAD"
 
 case "$merge_repo" in
-http://*)
-	head=$(wget -q -O - "$merge_repo/$merge_head") || exit 1
+http://* | https://*)
+        if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+            curl_extra_args="-k"
+        fi
+	head=$(curl -ns $curl_extra_args "$merge_repo/$merge_head") || exit 1
 	echo Fetching "$merge_head" using http
 	git-http-pull -v -a "$head" "$merge_repo/"
 	;;
diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -16,6 +16,8 @@ static z_stream stream;
 static int local;
 static int zret;
 
+static int curl_ssl_verify;
+
 struct buffer
 {
         size_t posn;
@@ -173,6 +175,10 @@ int main(int argc, char **argv)
 
 	curl = curl_easy_init();
 
+	curl_ssl_verify = gitenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+
 	base = url;
 
 	if (pull(commit_id))
