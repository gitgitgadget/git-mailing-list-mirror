From: darrint@progeny.com (Darrin Thompson)
Subject: [PATCH] Support more http features: https no cert, .netrc -> auth
Date: Tue, 12 Jul 2005 21:12:40 -0500 (EST)
Message-ID: <20050713021240.88AAD63780@morimoto.progeny.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 04:12:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsWju-000739-A8
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 04:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVGMCMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 22:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVGMCMm
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 22:12:42 -0400
Received: from zealot.progeny.com ([216.37.46.162]:26555 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S262896AbVGMCMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 22:12:41 -0400
Received: by morimoto.progeny.com (Postfix, from userid 10034)
	id 88AAD63780; Tue, 12 Jul 2005 21:12:40 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Cause setting environment variable GIT_SSL_NO_VERIFY to turn off
curl's ssl peer verification.

Only use curl for http transfers, instead of curl and wget.

Make curl check ~/.netrc for credentials.

---
commit 229718f5723f81304c7c038c18d1e1bd630026ae
tree 501594e7b424855f08d7bef6bd4f9721d40d4a3c
parent e30e814dbfef7a6e89418863e5d7291a2d53b18f
author Darrin Thompson <darrint@progeny.com> Tue, 12 Jul 2005 16:27:05 -0500

 git-fetch-script |    7 +++++--
 http-pull.c      |    6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -14,8 +14,11 @@ fi
 TMP_HEAD="$GIT_DIR/TMP_HEAD"
 
 case "$merge_repo" in
-http://*)
-	head=$(wget -q -O - "$merge_repo/$merge_name") || exit 1
+http://*|https://*)
+        if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+            curl_extra_args="-k"
+        fi
+	head=$(curl -ns $curl_extra_args "$merge_repo/$merge_name") || exit 1
 	echo Fetching $head using http
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
