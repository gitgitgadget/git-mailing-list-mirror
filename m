From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 5/7] http: init and cleanup separately from http-walker
Date: Sun, 21 Feb 2010 11:08:26 +0800
Message-ID: <1266721708-1060-6-git-send-email-rctay89@gmail.com>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Cc: "Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:59:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2Bt-0004jO-2t
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab0BUDI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:08:57 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:48037 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139Ab0BUDIx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:08:53 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so352982qyk.21
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 19:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=13NH+55kuc0qaZ8aQy3MVJiwZHy2gccOZashVgEJolU=;
        b=Wb1KWDiTaX8cRLkZZEyqJ/jILQPHXUKis5O4D7hcc3IUTIygfDlm5AYCz6/ShjTQRs
         llJaChKNXfIlpBFos0mgyrZL35XHvRVc3BaJxVxyAd3NzeKNRfaNb62AIvust4/czNeo
         P/99DYQtfCayzBzhq83a5NMVKIuAcVHxpCt7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vnUZftVTF1f08xvuo/mCSvlzkMOS38DZp7IRDu5MJAJdLaBMB8yfTIwTlAD7VmJzAe
         Ql3U7F1R+ndolTfbv+l5u0GWrsxXXlRi6ErUBl/u+CXKE+9HrtmP2fWehV6O05bruwyF
         L8GuypiJW4xJ0n1UQxeZ8gnckheSjdQIqDoXI=
Received: by 10.229.191.75 with SMTP id dl11mr196596qcb.16.1266721733554;
        Sat, 20 Feb 2010 19:08:53 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 22sm1412717qyk.14.2010.02.20.19.08.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 19:08:53 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140590>

Previously, all our http operations were done with http-walker. With the
new remote-curl helper, we find ourselves using http methods outside of
http-walker - for example, fetching info/refs.

Accomodate this by separating http_init() and http_cleanup() invocations
from http-walker.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-fetch.c  |    5 ++++-
 http-walker.c |    4 +---
 remote-curl.c |    7 ++++++-
 walker.h      |    2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index ffd0ad7..e05b23a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "exec_cmd.h"
+#include "http.h"
 #include "walker.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
@@ -69,7 +70,8 @@ int main(int argc, const char **argv)
 		url = rewritten_url;
 	}
 
-	walker = get_http_walker(url, NULL);
+	http_init(NULL);
+	walker = get_http_walker(url);
 	walker->get_tree = get_tree;
 	walker->get_history = get_history;
 	walker->get_all = get_all;
@@ -88,6 +90,7 @@ int main(int argc, const char **argv)
 "status code.  Suggest running 'git fsck'.\n");
 	}
 
+	http_cleanup();
 	walker_free(walker);
 
 	free(rewritten_url);
diff --git a/http-walker.c b/http-walker.c
index 508e355..bc39451 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -563,14 +563,12 @@ static void cleanup(struct walker *walker)
 	http_cleanup();
 }
 
-struct walker *get_http_walker(const char *url, struct remote *remote)
+struct walker *get_http_walker(const char *url)
 {
 	char *s;
 	struct walker_data *data = xmalloc(sizeof(struct walker_data));
 	struct walker *walker = xmalloc(sizeof(struct walker));
 
-	http_init(remote);
-
 	data->alt = xmalloc(sizeof(*data->alt));
 	data->alt->base = xmalloc(strlen(url) + 1);
 	strcpy(data->alt->base, url);
diff --git a/remote-curl.c b/remote-curl.c
index d388120..1e13fb5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -25,7 +25,7 @@ static struct options options;
 static void init_walker(void)
 {
 	if (!walker)
-		walker = get_http_walker(url, remote);
+		walker = get_http_walker(url);
 }
 
 static int set_option(const char *name, const char *value)
@@ -811,6 +811,8 @@ int main(int argc, const char **argv)
 		url = remote->url[0];
 	}
 
+	http_init(remote);
+
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF)
 			break;
@@ -856,5 +858,8 @@ int main(int argc, const char **argv)
 		}
 		strbuf_reset(&buf);
 	} while (1);
+
+	http_cleanup();
+
 	return 0;
 }
diff --git a/walker.h b/walker.h
index 8a149e1..95e5765 100644
--- a/walker.h
+++ b/walker.h
@@ -34,6 +34,6 @@ int walker_fetch(struct walker *impl, int targets, char **target,
 
 void walker_free(struct walker *walker);
 
-struct walker *get_http_walker(const char *url, struct remote *remote);
+struct walker *get_http_walker(const char *url);
 
 #endif /* WALKER_H */
-- 
1.7.0.26.gbfa16
