From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 5/5] builtin-remote: Make "remote -v" display push urls
Date: Sat, 13 Jun 2009 18:29:11 +0200
Message-ID: <1244910551-4420-3-git-send-email-git@drmicha.warpmail.net>
References: <7vtz2pmf98.fsf@alter.siamese.dyndns.org>
 <1244910551-4420-1-git-send-email-git@drmicha.warpmail.net>
 <1244910551-4420-2-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 18:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFW7q-0006Kh-Mg
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 18:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760569AbZFMQaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760172AbZFMQaR
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 12:30:17 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37468 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759442AbZFMQaL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 12:30:11 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id C8EB535E1C9;
	Sat, 13 Jun 2009 12:30:13 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sat, 13 Jun 2009 12:30:13 -0400
X-Sasl-enc: z96xLDJu0+reOssYFPhbcRu10UmdMYQz5wY8YKznSstS 1244910612
Received: from localhost (p5485A135.dip0.t-ipconnect.de [84.133.161.53])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E98C939C02;
	Sat, 13 Jun 2009 12:30:12 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
In-Reply-To: <1244910551-4420-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121509>

Currently, "remote -v" simply lists all urls so that one has to remember
that only the first one is used for fetches, and all are used for
pushes.

Change this so that the role of an url is displayed in parentheses, and
also display push urls.

Example with "one" having one url, "two" two urls, "three" one url and
one pushurl:

one     hostone.com:/somepath/repoone.git (fetch)
one     hostone.com:/somepath/repoone.git (push)
three   http://hostthree.com/otherpath/repothree.git (fetch)
three   hostthree.com:/pathforpushes/repothree.git (push)
two     hosttwo.com:/somepath/repotwo.git (fetch)
two     hosttwo.com:/somepath/repotwo.git (push)
two     hosttwobackup.com:/somewheresafe/repotwo.git (push)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin-remote.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index b350b18..80b2536 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1276,14 +1276,31 @@ static int update(int argc, const char **argv)
 static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
+	const char **url;
+	int i, url_nr;
+	void **utilp;
 
 	if (remote->url_nr > 0) {
-		int i;
-
-		for (i = 0; i < remote->url_nr; i++)
-			string_list_append(remote->name, list)->util = (void *)remote->url[i];
+		utilp = &(string_list_append(remote->name, list)->util);
+		*utilp = malloc(strlen(remote->url[0])+strlen(" (fetch)")+1);
+		strcpy((char *) *utilp, remote->url[0]);
+		strcat((char *) *utilp, " (fetch)");
 	} else
 		string_list_append(remote->name, list)->util = NULL;
+	if (remote->pushurl_nr) {
+		url = remote->pushurl;
+		url_nr = remote->pushurl_nr;
+	} else {
+		url = remote->url;
+		url_nr = remote->url_nr;
+	}
+	for (i = 0; i < url_nr; i++)
+	{
+		utilp = &(string_list_append(remote->name, list)->util);
+		*utilp = malloc(strlen(url[i])+strlen(" (push)")+1);
+		strcpy((char *) *utilp, url[i]);
+		strcat((char *) *utilp, " (push)");
+	}
 
 	return 0;
 }
@@ -1291,6 +1308,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 static int show_all(void)
 {
 	struct string_list list = { NULL, 0, 0 };
+	list.strdup_strings = 1;
 	int result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
@@ -1309,6 +1327,7 @@ static int show_all(void)
 			}
 		}
 	}
+	string_list_clear(&list, 1);
 	return result;
 }
 
-- 
1.6.3.2.367.gf0de
