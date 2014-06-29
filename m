From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 1/2] sha1_file: replace PATH_MAX buffer wirh strbuf in,
 prepare_packed_git_one()
Date: Sun, 29 Jun 2014 07:43:17 +0200
Message-ID: <53AFA775.1090900@web.de>
References: <53AED59B.1020209@web.de> <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 07:54:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1846-0006de-GE
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 07:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbaF2Fo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 01:44:29 -0400
Received: from mout.web.de ([212.227.17.11]:49936 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbaF2Fo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 01:44:28 -0400
Received: from [192.168.178.27] ([79.250.179.75]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MQNeK-1X6fI23uJA-00Tnec; Sun, 29 Jun 2014 07:44:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
X-Provags-ID: V03:K0:MsDYfO/HmbdLRhfLreecLdPQy1rKnZQK18tIvzS5XToNE51MBF4
 FQrJh0ItLnycuIiPgq/Ei/YzdmzY7WuwLfnTe1b3c80Q9iGrnlghn8KV83oJySQVJa4Nxsv
 aQGZ0BCC/42VMuDdE7J+fzy0U+pfF4S4B3g3IwdCvnzhHcH+SbiVU6fPP8Ga1wMht7czBNH
 eHicLWpVvH92dS17OJD+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252628>

Instead of using strbuf to create a message string in case a path is
too long for our fixed-size buffer, replace that buffer with a strbuf
and thus get rid of the limitation.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
@Duy: Thanks for catching the missing strbuf_release in the opendir
error case.

 sha1_file.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 34d527f..394fa45 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1177,48 +1177,37 @@ static void report_pack_garbage(struct string_list *list)
 
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
+		strbuf_release(&path);
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
@@ -1226,7 +1215,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 			     * See if it really is a valid .idx file with
 			     * corresponding .pack file that we can map.
 			     */
-			    (p = add_packed_git(path, len + namelen, local)) != NULL)
+			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
 				install_packed_git(p);
 		}
 
@@ -1237,13 +1226,14 @@ static void prepare_packed_git_one(char *objdir, int local)
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
