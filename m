From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 5/5] builtin-remote: Make "remote -v" display push urls
Date: Tue,  9 Jun 2009 18:01:38 +0200
Message-ID: <1244563298-15479-6-git-send-email-git@drmicha.warpmail.net>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-4-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-5-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:02:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME3md-0000WM-MD
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbZFIQBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 12:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755897AbZFIQBy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:01:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54452 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755739AbZFIQBw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 12:01:52 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 4D1D835EB42;
	Tue,  9 Jun 2009 12:01:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 09 Jun 2009 12:01:54 -0400
X-Sasl-enc: jYwR56nIeJ0dheA8mvz+Z3k6wmbHoJw/qI6vmpqtITlF 1244563313
Received: from localhost (p54859AE3.dip0.t-ipconnect.de [84.133.154.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 23A862F080;
	Tue,  9 Jun 2009 12:01:52 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.278.gb6431.dirty
In-Reply-To: <1244563298-15479-5-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, "remote -v" simply lists all urls so that one has to remember
that only the first one is used for fetches, and all are used for
pushes.

Change this so that the role of an url is displayed in parentheses, and
also display push urls.

Example with "mjg" having 1 url and 1 pushurl, "origin" having 3 urls,
sb having 1 url:

mjg     git://repo.or.cz/git/mjg.git (fetch)
mjg     repoor:/srv/git/git/mjg.git (push)
origin  git://repo.or.cz/git.git (fetch)
origin  git://repo.or.cz/git.git (push)
origin  git://git2.kernel.org/pub/scm/git/git.git (push)
origin  git://repo.or.cz/alt-git.git (push)
sb      git://repo.or.cz/git/sbeyer.git (fetch)
sb      git://repo.or.cz/git/sbeyer.git (push)

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
1.6.3.2.278.gb6431.dirty
