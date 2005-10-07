From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Set the parallel HTTP request limit via an environment variable
Date: Fri, 7 Oct 2005 08:59:54 -0700
Message-ID: <20051007155954.GJ15593@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 07 18:02:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENudm-0006h3-7O
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 18:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbVJGQAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVJGQAG
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 12:00:06 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:47889 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030455AbVJGQAB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 12:00:01 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j97Fxsml002442
	for <git@vger.kernel.org>; Fri, 7 Oct 2005 08:59:54 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j97FxsAP002440
	for git@vger.kernel.org; Fri, 7 Oct 2005 08:59:54 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9804>

Use an environment variable rather than a command-line argument to set the
parallel HTTP request limit.  This allows the setting to work whether
git-http-fetch is run directly or via git-fetch.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

a508fd4ba7300476e6ad029fca10371ca869af1e
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1034,22 +1034,11 @@ int main(int argc, char **argv)
 			arg++;
 		} else if (!strcmp(argv[arg], "--recover")) {
 			get_recover = 1;
-#ifdef USE_CURL_MULTI
-		} else if (argv[arg][1] == 'r') {
-			max_requests = atoi(argv[arg + 1]);
-			if (max_requests < 1)
-				max_requests = DEFAULT_MAX_REQUESTS;
-			arg++;
-#endif
 		}
 		arg++;
 	}
 	if (argc < arg + 2) {
-#ifdef USE_CURL_MULTI
-		usage("git-http-fetch [-c] [-t] [-a] [-d] [-v] [-r concurrent-request-limit] [--recover] [-w ref] commit-id url");
-#else
 		usage("git-http-fetch [-c] [-t] [-a] [-d] [-v] [--recover] [-w ref] commit-id url");
-#endif
 		return 1;
 	}
 	commit_id = argv[arg];
@@ -1058,6 +1047,12 @@ int main(int argc, char **argv)
 	curl_global_init(CURL_GLOBAL_ALL);
 
 #ifdef USE_CURL_MULTI
+	char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
+	if (http_max_requests != NULL)
+		max_requests = atoi(http_max_requests);
+	if (max_requests < 1)
+		max_requests = DEFAULT_MAX_REQUESTS;
+
 	curlm = curl_multi_init();
 	if (curlm == NULL) {
 		fprintf(stderr, "Error creating curl multi handle.\n");
