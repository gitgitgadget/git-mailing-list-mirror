From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 7/7] remote-curl: init walker only when needed
Date: Sun, 21 Feb 2010 11:08:28 +0800
Message-ID: <1266721708-1060-8-git-send-email-rctay89@gmail.com>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Cc: "Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:38:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2C8-0004kQ-Fg
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab0BUDJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:09:02 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:49688 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166Ab0BUDI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:08:59 -0500
Received: by qw-out-2122.google.com with SMTP id 8so262931qwh.37
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 19:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4v6o4omVbgd7fmyT1gvCZoMyrZ/rwqSD/j+T5UePXv4=;
        b=vjTZgLp0p6ai8tL9oYo16jkYGgG9AHxnhPap8vY6j6eqGwyBM4cIscVPWpQVLSrzMj
         OIEtuTDuOwhiJDE95z8QmBSuSF9W+uaiipJIA1sAtQMvPrWiiZDle5KIOudR9eCsM/jT
         gXMEXVDEfKA5o4KxLor+use6KyhLFsgTGDxwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kKvD6eXaUd+B7LLo72a4DJ3nTzTr9yshnxbX6zLZyd1NdvkPgs/7fAm2Zy55e6mTlg
         8c9KuWblWic8qemOfq6M/MfKaCWdCHgyKG4dicb/38/4CtWcIrLIY1nxC6w0TTS0EXjD
         oo6wGEI0VogPx0HJ9nHiJKh1AT/1OlONS4YMQ=
Received: by 10.224.18.168 with SMTP id w40mr4776958qaa.114.1266721739117;
        Sat, 20 Feb 2010 19:08:59 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 22sm1412717qyk.14.2010.02.20.19.08.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 19:08:58 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140585>

Invoke get_http_walker() only when fetching with the dumb protocol.
Additionally, add an invocation to walker_free() after we're done using
the walker.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 remote-curl.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 5ace99e..b76bfcb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -10,7 +10,6 @@
 
 static struct remote *remote;
 static const char *url;
-static struct walker *walker;
 
 struct options {
 	int verbosity;
@@ -22,12 +21,6 @@ struct options {
 };
 static struct options options;
 
-static void init_walker(void)
-{
-	if (!walker)
-		walker = get_http_walker(url);
-}
-
 static int set_option(const char *name, const char *value)
 {
 	if (!strcmp(name, "verbosity")) {
@@ -119,7 +112,6 @@ static struct discovery* discover_refs(const char *service)
 	}
 	refs_url = strbuf_detach(&buffer, NULL);
 
-	init_walker();
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
 
 	/* try again with "plain" url (no ? or & appended) */
@@ -501,7 +493,6 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	struct child_process client;
 	int err = 0;
 
-	init_walker();
 	memset(&client, 0, sizeof(client));
 	client.in = -1;
 	client.out = -1;
@@ -553,6 +544,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 
 static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 {
+	struct walker *walker;
 	char **targets = xmalloc(nr_heads * sizeof(char*));
 	int ret, i;
 
@@ -561,13 +553,14 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 	for (i = 0; i < nr_heads; i++)
 		targets[i] = xstrdup(sha1_to_hex(to_fetch[i]->old_sha1));
 
-	init_walker();
+	walker = get_http_walker(url);
 	walker->get_all = 1;
 	walker->get_tree = 1;
 	walker->get_history = 1;
 	walker->get_verbosely = options.verbosity >= 3;
 	walker->get_recover = 0;
 	ret = walker_fetch(walker, nr_heads, targets, NULL, NULL);
+	walker_free(walker);
 
 	for (i = 0; i < nr_heads; i++)
 		free(targets[i]);
-- 
1.7.0.26.gbfa16
