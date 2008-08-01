From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] builtin-name-rev: refactor stdin handling to its own function
Date: Fri,  1 Aug 2008 13:16:12 +0200
Message-ID: <1217589372-4151-1-git-send-email-pdebie@ai.rug.nl>
References: <alpine.DEB.1.00.0808011256330.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 13:17:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOsdN-00027i-8C
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 13:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbYHALQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 07:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbYHALQU
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 07:16:20 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:37454 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbYHALQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 07:16:20 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6212.online.nl (SMTP Server) with ESMTP id 1F78F1C00093;
	Fri,  1 Aug 2008 13:16:18 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6212.online.nl (SMTP Server) with ESMTP id 992381C0008D;
	Fri,  1 Aug 2008 13:16:13 +0200 (CEST)
X-ME-UUID: 20080801111617627.992381C0008D@mwinf6212.online.nl
X-Mailer: git-send-email 1.6.0.rc1.214.g5f0bd
In-Reply-To: <alpine.DEB.1.00.0808011256330.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91057>


Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

    On 1 aug 2008, at 09:23, Junio C Hamano wrote:
    >Is it just me to find that this part is getting indented too deeply to be
    >readable?

    How about something like this then?

 builtin-name-rev.c |   93 ++++++++++++++++++++++++++++------------------------
 1 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 0536af4..057172d 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -176,6 +176,52 @@ static char const * const name_rev_usage[] = {
 	NULL
 };
 
+static void handle_stdin_line(char *p_start, int name_only)
+{
+	int forty = 0;
+	char *p;
+	for (p = p_start; *p; p++) {
+#define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
+		if (!ishex(*p))
+			forty = 0;
+		else if (++forty == 40 && !ishex(*(p+1))) {
+			unsigned char sha1[40];
+			const char *name = NULL;
+			char c = *(p+1);
+
+			forty = 0;
+
+			*(p+1) = 0;
+			if (!get_sha1(p - 39, sha1)) {
+				struct object *o =
+					lookup_object(sha1);
+				if (o)
+					name = get_rev_name(o);
+			}
+			*(p+1) = c;
+
+			if (!name)
+				continue;
+
+			if (name_only) {
+				fwrite(p_start, p - p_start + 1 - 40,
+					1, stdout);sssss
+				printf(name);
+			}
+			else {
+				fwrite(p_start, p - p_start + 1, 1, stdout);
+				printf(" (%s)", name);
+			}
+			p_start = p + 1;
+		}
+	}
+
+	/* flush */
+	if (p != p_start)
+		fwrite(p_start, p - p_start, 1, stdout);
+
+}
+
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = { 0, 0, NULL };
@@ -234,53 +280,14 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	if (transform_stdin) {
 		char buffer[2048];
-		char *p, *p_start;
+		char *p_start;
 
 		while (!feof(stdin)) {
-			int forty = 0;
-			p = fgets(buffer, sizeof(buffer), stdin);
-			if (!p)
+			p_start = fgets(buffer, sizeof(buffer), stdin);
+			if (!p_start)
 				break;
 
-			for (p_start = p; *p; p++) {
-#define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
-				if (!ishex(*p))
-					forty = 0;
-				else if (++forty == 40 &&
-						!ishex(*(p+1))) {
-					unsigned char sha1[40];
-					const char *name = NULL;
-					char c = *(p+1);
-
-					forty = 0;
-
-					*(p+1) = 0;
-					if (!get_sha1(p - 39, sha1)) {
-						struct object *o =
-							lookup_object(sha1);
-						if (o)
-							name = get_rev_name(o);
-					}
-					*(p+1) = c;
-
-					if (!name)
-						continue;
-
-					if (data.name_only) {
-						fwrite(p_start, p - p_start + 1 - 40, 1, stdout);
-						printf(name);
-					}
-					else {
-						fwrite(p_start, p - p_start + 1, 1, stdout);
-						printf(" (%s)", name);
-					}
-					p_start = p + 1;
-				}
-			}
-
-			/* flush */
-			if (p_start != p)
-				fwrite(p_start, p - p_start, 1, stdout);
+			handle_stdin_line(p_start, data.name_only);
 		}
 	} else if (all) {
 		int i, max;
-- 
1.6.0.rc1.214.g5f0bd
