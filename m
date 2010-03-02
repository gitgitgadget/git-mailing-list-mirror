From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 7/7] remote-curl: init walker only when needed
Date: Tue,  2 Mar 2010 18:49:31 +0800
Message-ID: <1267526971-5552-8-git-send-email-rctay89@gmail.com>
References: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 11:50:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmPg8-0003k4-OY
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 11:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab0CBKuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 05:50:08 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:40254 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab0CBKuD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 05:50:03 -0500
Received: by mail-yx0-f182.google.com with SMTP id 12so38910yxe.33
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 02:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4v6o4omVbgd7fmyT1gvCZoMyrZ/rwqSD/j+T5UePXv4=;
        b=eGel3TPu7gTxT+lH2cXo2993G58KGL79GqTxab6lwtXWuZkmN2xPqgamGLWEioxwDP
         6QmyxnZW00P5f8uq4iVxlheAQ/KPx8Ge/odRZRiyfasXKKImnHPKsq4YFZNj0vEBjbVL
         elmq3+agEo4F1vOMlUclo6WiOogZzTX90Ku0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q5qwSeUFFbxHInhWz1oUxJt0vz0sOubQQzcSLmiV2+HVD1twnt0NeBcFZ/oDzl+AZr
         08QOlB9SaLtElNl39PTkIiCXyuEvotdkJ3iIkCHRkYS2gLlpSxB7gJpoYOT3MF4UuLsx
         vKvBOkqMCxGu7wZnJLrZSzRgRjn7oBdKc0XcI=
Received: by 10.91.50.9 with SMTP id c9mr4741030agk.116.1267527003082;
        Tue, 02 Mar 2010 02:50:03 -0800 (PST)
Received: from localhost.localdomain (cm212.zeta152.maxonline.com.sg [116.87.152.212])
        by mx.google.com with ESMTPS id 13sm2393991gxk.12.2010.03.02.02.50.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 02:50:02 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141385>

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
