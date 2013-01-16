From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-remote: distinguish between default and configured URLs
Date: Wed, 16 Jan 2013 11:14:48 +0100
Message-ID: <a5bf3511b3ecf4e9243d550d11ab977f95ecea30.1358331096.git.git@drmicha.warpmail.net>
References: <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 11:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvQ1o-0006yO-VO
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 11:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758805Ab3APKO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 05:14:57 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36037 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758759Ab3APKOs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 05:14:48 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C49A020BD0;
	Wed, 16 Jan 2013 05:14:47 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 16 Jan 2013 05:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=0GsZlMnS9lXe+K1yiv/QypXP2
	rc=; b=DYwGOMSgn1ZXeWFUXWW3uyOKzhybfR8hm+CuV7UkAHND0F+SE7PZ+ZJaZ
	dZAGXCOeqkTjI69DIAv8GcCqJrHcLzNiJfy1+H2NL/9kT4/5FKTrR8bpEwszbWbY
	S1qFLhL7qrKtNqlPQXiJavCBzSiNYDs3LHaY5JO+ZzYxLd5Mqs=
X-Sasl-enc: UCP8qoydY2j1AUNfjSxk4bkQIxjb+BKolaOChDGj++JH 1358331287
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4B95A482584;
	Wed, 16 Jan 2013 05:14:47 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.456.g93e7b0a
In-Reply-To: <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213742>

The current output of "git remote -v" does not distinguish between
explicitly configured push URLs and those coming from fetch lines.

Revise the output so so that URLs are distinguished by their labels:

(fetch): fetch config used for fetching only
(fetch/push): fetch config used for fetching and pushing
(fetch fallback/push): fetch config used for pushing only
(fetch fallback): fetch config which is unused
(push): push config used for pushing

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Maybe something like this? It even seems to make the code in get_one_entry
clearer.

I yet have to look at the tests, doc and other git-remote invocations.

 builtin/remote.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 937484d..ec07109 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1509,25 +1509,28 @@ static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
 	struct strbuf url_buf = STRBUF_INIT;
-	const char **url;
-	int i, url_nr;
+	char *fetchurl0, *fetchurl1;
+	int i;
+
+	if (remote->pushurl_nr > 0) {
+		fetchurl0 = "fetch";
+		fetchurl1 = "fetch fallback";
+	} else {
+		fetchurl0 = "fetch/push";
+		fetchurl1 = "fetch fallback/push";
+	}
 
-	if (remote->url_nr > 0) {
-		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
+	for (i = 0; i < remote->url_nr; i++) {
+		strbuf_addf(&url_buf, "%s (%s)", remote->url[0], i ? fetchurl1 : fetchurl0);
 		string_list_append(list, remote->name)->util =
 				strbuf_detach(&url_buf, NULL);
-	} else
+	} /* else */
+	if (remote->url_nr == 0)
 		string_list_append(list, remote->name)->util = NULL;
-	if (remote->pushurl_nr) {
-		url = remote->pushurl;
-		url_nr = remote->pushurl_nr;
-	} else {
-		url = remote->url;
-		url_nr = remote->url_nr;
-	}
-	for (i = 0; i < url_nr; i++)
+
+	for (i = 0; i < remote->pushurl_nr; i++)
 	{
-		strbuf_addf(&url_buf, "%s (push)", url[i]);
+		strbuf_addf(&url_buf, "%s (push)", remote->pushurl[i]);
 		string_list_append(list, remote->name)->util =
 				strbuf_detach(&url_buf, NULL);
 	}
-- 
1.8.1.1.456.g93e7b0a
