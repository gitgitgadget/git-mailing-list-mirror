From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/6] remote-curl: don't retry auth failures with dumb protocol
Date: Fri, 14 Oct 2011 09:40:37 +0200
Message-ID: <28d0c1017a10a93ce165a2d4e9fb6a691a933bd3.1318577792.git.git@drmicha.warpmail.net>
References: <4E9692BF.8040705@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 09:41:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcO9-0006DO-C0
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613Ab1JNHku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:40:50 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:42095 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932327Ab1JNHkt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 03:40:49 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A02E120B93;
	Fri, 14 Oct 2011 03:40:48 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 14 Oct 2011 03:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=7M
	vV3O924MGPUgIBZEIOi/KPm+Q=; b=cbSJtHbLCUcoXldv3yV7dHRU+mqq6JRWTD
	6gRi+M0f0YBJF/APN4piEaF+ys65JcnjyA/nk3dcEtqQB8IqKWX/tpcUbUdvwDfJ
	vX4pgKDQcHZVSnz1LkU/cbyCJYxuhVJrd1akwBsqtKs2jZ0NLmigFE7OYaZq6AlA
	OwB//6ykQ=
X-Sasl-enc: IAORNhYnAzywdbgoG3DJIFwsibQmj0XEDUnUMOTHAbXM 1318578048
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1E595404987;
	Fri, 14 Oct 2011 03:40:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.338.g0156b
In-Reply-To: <4E9692BF.8040705@drmicha.warpmail.net>
In-Reply-To: <cover.1318577792.git.git@drmicha.warpmail.net>
References: <cover.1318577792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183549>

From: Jeff King <peff@peff.net>

When fetching an http URL, we first try fetching info/refs
with an extra "service" parameter. This will work for a
smart-http server, or a dumb server which ignores extra
parameters when fetching files. If that fails, we retry
without the extra parameter to remain compatible with dumb
servers which didn't like our first request.

If the server returned a "401 Unauthorized", indicating that
the credentials we provided were not good, there is not much
point in retrying. With the current code, we just waste an
extra round trip to the HTTP server before failing.

But as the http code becomes smarter about throwing away
rejected credentials and re-prompting the user for new ones
(which it will later in this series), this will become more
confusing. At some point we will stop asking for credentials
to retry smart http, and will be asking for credentials to
retry dumb http. So now we're not only wasting an extra HTTP
round trip for something that is unlikely to work, but we're
making the user re-type their password for it.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-curl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index faaeda4..6c24ab1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -115,7 +115,7 @@ static struct discovery* discover_refs(const char *service)
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
 
 	/* try again with "plain" url (no ? or & appended) */
-	if (http_ret != HTTP_OK) {
+	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
 		free(refs_url);
 		strbuf_reset(&buffer);
 
-- 
1.7.7.338.g0156b
