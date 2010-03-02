From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 5/7] http: init and cleanup separately from http-walker
Date: Tue,  2 Mar 2010 18:49:29 +0800
Message-ID: <1267526971-5552-6-git-send-email-rctay89@gmail.com>
References: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 11:50:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmPg7-0003k4-Ku
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 11:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666Ab0CBKuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 05:50:03 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59584 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab0CBKt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 05:49:59 -0500
Received: by gwb15 with SMTP id 15so33072gwb.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 02:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7t10e1maM0x0kFGw2WIaCZqO4AfxJTBwJv5d3/G3E9g=;
        b=qO6IMW+a7BCGxKKocZ4TzCwIqF79H7extU4+R6kjSBUJ2FxjLFCYq3Rk6W3QmOGV+P
         +VsFP2hqlEkNk4SDnAbrs8fbvXYWNyC3WV9TP7iEWoZ73UQSygFcmxnwNqtrbfXLaql/
         gA4C8UDryUWCCtiohK5RgyawotW/6fpMVa3R4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YQhoRNH7PwroGXlTUjWBrbBMxDztxng75OqpCVLHb6xohUWvUWZJSQll/K6GE/gora
         ZpYSV7voErspjhWrKwhMCDZTBkggIFbc1iiBkFlEbHzsoPEm3EV9QmwZ2OVBcwSoQplE
         eUxvWT25rZVL6+UmUsrJTIuU1YuzcDZOjL4FQ=
Received: by 10.101.4.28 with SMTP id g28mr360346ani.68.1267526998008;
        Tue, 02 Mar 2010 02:49:58 -0800 (PST)
Received: from localhost.localdomain (cm212.zeta152.maxonline.com.sg [116.87.152.212])
        by mx.google.com with ESMTPS id 13sm2393991gxk.12.2010.03.02.02.49.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 02:49:57 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141387>

Previously, all our http operations were done with http-walker. With the
new remote-curl helper, we find ourselves using http methods outside of
http-walker - for example, fetching info/refs.

Accomodate this by separating http_init() and http_cleanup() invocations
from http-walker.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-fetch.c  |    5 ++++-
 http-walker.c |    6 +-----
 remote-curl.c |    7 ++++++-
 walker.h      |    2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index ffd0ad7..762c750 100644
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
@@ -89,6 +91,7 @@ int main(int argc, const char **argv)
 	}
 
 	walker_free(walker);
+	http_cleanup();
 
 	free(rewritten_url);
 
diff --git a/http-walker.c b/http-walker.c
index 508e355..ef99ae6 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -559,18 +559,14 @@ static void cleanup(struct walker *walker)
 		free(data);
 		walker->data = NULL;
 	}
-
-	http_cleanup();
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
