From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 1/2] sha1_file: replace PATH_MAX buffer wirh strbuf in prepare_packed_git_one()
Date: Sat, 28 Jun 2014 16:47:55 +0200
Message-ID: <53AED59B.1020209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 16:53:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0u08-0007l9-QW
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 16:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbaF1OtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 10:49:10 -0400
Received: from mout.web.de ([212.227.17.12]:63177 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbaF1OtI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 10:49:08 -0400
Received: from [192.168.178.27] ([79.250.182.181]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lm4lR-1WRq641gSP-00ZjZ3; Sat, 28 Jun 2014 16:48:49
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:h4qI3weZOUnCJqBVx8SpQxIh95h+b5XRXlAwb8SCS9X4kn9MzWn
 bmXRYAFzYB1ZdJAqJPSyt+iDl15NBQowYw2bxM1kHUZlAJtFDMi92+nRvNeIcRGxo385RNR
 HQNWuk72kinHXe748LasajDKErH3Rb3G1P4lEI794gqJ//z3SYY/5CjQoTVQBRb9amxL0fx
 8Q4TDLjiMZ8+a0EQDSJeQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252607>

Instead of using strbuf to create a message string in case a path is
too long for our fixed-size buffer, replace that buffer with a strbuf
and thus get rid of the limitation.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 34d527f..0c3cada 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1177,48 +1177,36 @@ static void report_pack_garbage(struct string_list *list)
 
 static void prepare_packed_git_one(char *objdir, int local)
 {
-	/* Ensure that this buffer is large enough so that we can
-	   append "/pack/" without clobbering the stack even if
-	   strlen(objdir) were PATH_MAX.  */
-	char path[PATH_MAX + 1 + 4 + 1 + 1];
-	int len;
+	struct strbuf path = STRBUF_INIT;
+	size_t dirnamelen;
 	DIR *dir;
 	struct dirent *de;
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 
-	sprintf(path, "%s/pack", objdir);
-	len = strlen(path);
-	dir = opendir(path);
+	strbuf_addstr(&path, objdir);
+	strbuf_addstr(&path, "/pack");
+	dir = opendir(path.buf);
 	if (!dir) {
 		if (errno != ENOENT)
 			error("unable to open object pack directory: %s: %s",
-			      path, strerror(errno));
+			      path.buf, strerror(errno));
 		return;
 	}
-	path[len++] = '/';
+	strbuf_addch(&path, '/');
+	dirnamelen = path.len;
 	while ((de = readdir(dir)) != NULL) {
-		int namelen = strlen(de->d_name);
 		struct packed_git *p;
 
-		if (len + namelen + 1 > sizeof(path)) {
-			if (report_garbage) {
-				struct strbuf sb = STRBUF_INIT;
-				strbuf_addf(&sb, "%.*s/%s", len - 1, path, de->d_name);
-				report_garbage("path too long", sb.buf);
-				strbuf_release(&sb);
-			}
-			continue;
-		}
-
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
-		strcpy(path + len, de->d_name);
+		strbuf_setlen(&path, dirnamelen);
+		strbuf_addstr(&path, de->d_name);
 
 		if (has_extension(de->d_name, ".idx")) {
 			/* Don't reopen a pack we already have. */
 			for (p = packed_git; p; p = p->next) {
-				if (!memcmp(path, p->pack_name, len + namelen - 4))
+				if (!memcmp(path.buf, p->pack_name, path.len - 4))
 					break;
 			}
 			if (p == NULL &&
@@ -1226,7 +1214,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 			     * See if it really is a valid .idx file with
 			     * corresponding .pack file that we can map.
 			     */
-			    (p = add_packed_git(path, len + namelen, local)) != NULL)
+			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
 				install_packed_git(p);
 		}
 
@@ -1237,13 +1225,14 @@ static void prepare_packed_git_one(char *objdir, int local)
 		    has_extension(de->d_name, ".pack") ||
 		    has_extension(de->d_name, ".bitmap") ||
 		    has_extension(de->d_name, ".keep"))
-			string_list_append(&garbage, path);
+			string_list_append(&garbage, path.buf);
 		else
-			report_garbage("garbage found", path);
+			report_garbage("garbage found", path.buf);
 	}
 	closedir(dir);
 	report_pack_garbage(&garbage);
 	string_list_clear(&garbage, 0);
+	strbuf_release(&path);
 }
 
 static int sort_pack(const void *a_, const void *b_)
-- 
2.0.0
