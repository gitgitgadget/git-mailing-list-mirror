From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/7] commit: move find_commit_subject() into commit.{h,c}
Date: Thu, 22 Jul 2010 15:18:32 +0200
Message-ID: <20100722131836.2148.80613.chriscool@tuxfamily.org>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 15:34:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObvvC-0005JP-8E
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 15:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759387Ab0GVNeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:34:23 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:58829 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759370Ab0GVNeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:34:21 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 8A53E800075B;
	Thu, 22 Jul 2010 15:34:20 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 7D19A80021FE;
	Thu, 22 Jul 2010 15:34:20 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 3F3D6800075B;
	Thu, 22 Jul 2010 15:34:18 +0200 (CEST)
X-ME-UUID: 20100722133418259.3F3D6800075B@mwinf2f18.orange.fr
X-git-sha1: 458adde712830fffa6051ec16f0887607ffbceb9 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151452>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   20 --------------------
 commit.c         |   19 +++++++++++++++++++
 commit.h         |    3 +++
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 44149b5..9215e66 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -99,26 +99,6 @@ struct commit_message {
 	const char *message;
 };
 
-/* Find beginning and length of commit subject. */
-static int find_commit_subject(const char *commit_buffer, const char **subject)
-{
-	const char *eol;
-	const char *p = commit_buffer;
-
-	while (*p && (*p != '\n' || p[1] != '\n'))
-		p++;
-	if (*p) {
-		p += 2;
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
-	} else
-		eol = p;
-
-	*subject = p;
-
-	return eol - p;
-}
-
 static int get_message(const char *raw_message, struct commit_message *out)
 {
 	const char *encoding;
diff --git a/commit.c b/commit.c
index e9b0750..0094ec1 100644
--- a/commit.c
+++ b/commit.c
@@ -315,6 +315,25 @@ int parse_commit(struct commit *item)
 	return ret;
 }
 
+int find_commit_subject(const char *commit_buffer, const char **subject)
+{
+	const char *eol;
+	const char *p = commit_buffer;
+
+	while (*p && (*p != '\n' || p[1] != '\n'))
+		p++;
+	if (*p) {
+		p += 2;
+		for (eol = p; *eol && *eol != '\n'; eol++)
+			; /* do nothing */
+	} else
+		eol = p;
+
+	*subject = p;
+
+	return eol - p;
+}
+
 struct commit_list *commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
 	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
diff --git a/commit.h b/commit.h
index eb2b8ac..9113bbe 100644
--- a/commit.h
+++ b/commit.h
@@ -41,6 +41,9 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 
 int parse_commit(struct commit *item);
 
+/* Find beginning and length of commit subject. */
+int find_commit_subject(const char *commit_buffer, const char **subject);
+
 struct commit_list * commit_list_insert(struct commit *item, struct commit_list **list_p);
 unsigned commit_list_count(const struct commit_list *l);
 struct commit_list * insert_by_date(struct commit *item, struct commit_list **list);
-- 
1.7.2.rc3.267.g400b3
