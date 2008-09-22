From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2] make "git remote" report multiple URLs
Date: Mon, 22 Sep 2008 10:57:51 +0200
Message-ID: <1222073871-495-1-git-send-email-git@drmicha.warpmail.net>
References: <7vej3fswwe.fsf@gitster.siamese.dyndns.org>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 10:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhhGP-0005I0-Br
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 10:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbYIVI6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 04:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYIVI6M
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 04:58:12 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47350 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648AbYIVI6L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2008 04:58:11 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 9BD391632AA
	for <git@vger.kernel.org>; Mon, 22 Sep 2008 04:58:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 22 Sep 2008 04:58:10 -0400
X-Sasl-enc: TjV5kCHeIQuy46jvOlAtueWPw+mEp0pSBkutQdKaLjNm 1222073889
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B9E462E890;
	Mon, 22 Sep 2008 04:58:09 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.287.g3791f
In-Reply-To: <7vej3fswwe.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96461>

This patch makes "git remote -v" and "git remote show" report multiple URLs
rather than warn about them. Multiple URLs are OK for pushing into
multiple repos simultaneously. Without "-v" each repo is shown once only.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin-remote.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

Change in v2: report each repo once only if "-v" is not used (i.e. URL is not shown),
as requested by JC.

JC wrote:
> MJG wrote:
>> This passes all tests, so I think the new output does not break anything.

> Or just there is no existing tests that verify the output from this command.

JC, sounds as if you're a mathematician, as well ;)

diff --git a/builtin-remote.c b/builtin-remote.c
index 01945a8..1e2edc2 100644
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
@@ -671,10 +674,14 @@ static int show_all(void)
 		sort_string_list(&list);
 		for (i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
-			printf("%s%s%s\n", item->string,
-				verbose ? "\t" : "",
-				verbose && item->util ?
-					(const char *)item->util : "");
+			if (verbose)
+				printf("%s\t%s\n", item->string,
+					item->util ? (const char *)item->util : "");
+			else {
+				if (i && !strcmp((item - 1)->string, item->string))
+					continue;
+				printf("%s\n", item->string);
+			}
 		}
 	}
 	return result;
-- 
1.6.0.2.287.g3791f
