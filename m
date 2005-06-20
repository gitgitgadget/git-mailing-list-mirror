From: Darrin Thompson <darrint@progeny.com>
Subject: [PATCH] Add more curl options to git-http-pull
Date: Mon, 20 Jun 2005 18:48:31 -0500
Message-ID: <1119311311.3926.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 21 01:47:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkVyv-00042N-BB
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 01:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVFTXvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 19:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVFTXrN
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 19:47:13 -0400
Received: from zealot.progeny.com ([216.37.46.162]:31463 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S261850AbVFTXnf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 19:43:35 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP id 4EDA863783
	for <git@vger.kernel.org>; Mon, 20 Jun 2005 18:43:30 -0500 (EST)
To: GIT Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

All,

This patch makes git-http-pull work with basic http auth and ssl when
you aren't using a real cert.

Also, it makes curl's verbose output available, which is useful for
debugging.

Apologies as I expect my mail client is munging this patch slightly.

Signed-off-by: Darrin Thompson <darrint at progeny com>
---

Create option to turn off ssl peer verification.
Create option to provide username:password to curl.
Make -v additive.
When -v is specified twice, turn on CURLOPT_VERBOSE.

diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -15,6 +15,8 @@ static z_stream stream;

 static int local;
 static int zret;
+static int curl_ssl_verify_enabled = 1;
+static char *curl_user_pwd = NULL;

 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
                               void *data) {
@@ -117,12 +119,17 @@ int main(int argc, char **argv)
                        get_tree = 1;
                        get_history = 1;
                } else if (argv[arg][1] == 'v') {
-                       get_verbosely = 1;
+                       get_verbosely += 1;
+               } else if (argv[arg][1] == 'S') {
+                        curl_ssl_verify_enabled = 0;
+               } else if (argv[arg][1] == 'u') {
+                        arg++;
+                        curl_user_pwd = argv[arg];
                }
                arg++;
        }
        if (argc < arg + 2) {
-               usage("git-http-pull [-c] [-t] [-a] [-d] [-v]
[--recover] commit-id url");
+               usage("git-http-pull [-u] user:passwd [-S] [-c] [-t]
[-a] [-d] [-v] [--recover] commit-id url");
                return 1;
        }
        commit_id = argv[arg];
@@ -131,6 +138,13 @@ int main(int argc, char **argv)
        curl_global_init(CURL_GLOBAL_ALL);

        curl = curl_easy_init();
+        if (curl_user_pwd) {
+                curl_easy_setopt(curl, CURLOPT_USERPWD, curl_user_pwd);
+        }
+        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER,
curl_ssl_verify_enabled);
+        if (get_verbosely >= 2) {
+                curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);
+        }

        base = url;



