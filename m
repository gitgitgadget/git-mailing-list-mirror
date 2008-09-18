From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] make "git remote" report multiple URLs
Date: Thu, 18 Sep 2008 18:11:02 +0200
Message-ID: <1221754262-15772-1-git-send-email-git@drmicha.warpmail.net>
References: <7v4p4e0zpg.fsf@gitster.siamese.dyndns.org>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 18:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgM7F-0001eF-Ja
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909AbYIRQLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 12:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756899AbYIRQLS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:11:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48736 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755918AbYIRQLR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Sep 2008 12:11:17 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id CAEE516327E
	for <git@vger.kernel.org>; Thu, 18 Sep 2008 12:11:16 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 18 Sep 2008 12:11:16 -0400
X-Sasl-enc: YPs+WdahN7zDTtYJKN5BDwkLKUubHeoVQVKB+Npw7vxl 1221754276
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 10B86228B9;
	Thu, 18 Sep 2008 12:11:15 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.249.g97d7f
In-Reply-To: <7v4p4e0zpg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96209>

This patch makes "git remote -v" and "git remote show" report multiple URLs
rather than warn about them. Multiple URLs are OK for pushing into
multiple repos simultaneously.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin-remote.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

This passes all tests, so I think the new output does not break anything.

diff --git a/builtin-remote.c b/builtin-remote.c
index 01945a8..ae560e7 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -652,10 +652,13 @@ static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
 
-	string_list_append(remote->name, list)->util = remote->url_nr ?
-		(void *)remote->url[0] : NULL;
-	if (remote->url_nr > 1)
-		warning("Remote %s has more than one URL", remote->name);
+	if (remote->url_nr > 0) {
+		int i;
+
+		for (i = 0; i < remote->url_nr; i++)
+			string_list_append(remote->name, list)->util = (void *)remote->url[i];
+	} else
+		string_list_append(remote->name, list)->util = NULL;
 
 	return 0;
 }
-- 
1.6.0.2.249.g97d7f
