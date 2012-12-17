From: Oren Held <oren@held.org.il>
Subject: [PATCH] Pretty formats: skip color codes if !want_color()
Date: Tue, 18 Dec 2012 00:57:03 +0200
Message-ID: <20121217225703.GC25103@orenhe-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 23:58:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkjdc-0006WL-QO
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 23:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab2LQW5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 17:57:51 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:42632 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab2LQW5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 17:57:48 -0500
Received: from homiemail-a34.g.dreamhost.com (caiajhbdccah.dreamhost.com [208.97.132.207])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 9C044AB9F
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 14:57:48 -0800 (PST)
Received: from homiemail-a34.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a34.g.dreamhost.com (Postfix) with ESMTP id D96D21005D
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 14:57:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=held.org.il; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=
	held.org.il; b=Dg/rbJaG0EF0wkvN/WzCqtIq/SzGJ184oBrZWkvjFTAxdHgDV
	hOnFgBvSfxlVc88325gdSh+6qIzB7DVDO+M+yzFE7fNtFSYaF2ZXfaNRhcouTRSW
	AqhzkKd9vuFq7rKXQtsDXSQcs97Zf84lwyEr+/u/2vV2DdmQWYWvn1e+6s=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=held.org.il; h=date:from
	:to:subject:message-id:mime-version:content-type; s=held.org.il;
	 bh=DSAJ/w73Jav1fe+LBY/upCbcdw4=; b=QiYxIsjojr9PhUuJ7NvJ/4yNa/aZ
	Q8W7cqlshX6FyLWeDg8xzjPVcQhuU6jZCGSR4ZUDlc9+2rW5C7IjPe8VkOZcMwfY
	5/5wflxiuBI2voUoWWOP93oNAmTIy+hHpEfLzyE/Mezue3FHmO+EfErdT76B1qMf
	DQ/eGLu4htkW3ng=
Received: from orenhe-laptop (85.65.7.156.dynamic.barak-online.net [85.65.7.156])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: oren@held.org.il)
	by homiemail-a34.g.dreamhost.com (Postfix) with ESMTPSA id B71F010049
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 14:57:07 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211716>

Avoid color escape codes if colors are disabled, just like the behavior of other git commands.
This solves the case of color escape codes in stdout when piping or redirecting, e.g.:
$ git log --format=%Cred%h > out

Signed-off-by: Oren Held <oren@held.org.il>
---
Would appreciate your help or comments :)

 pretty.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index 5bdc2e7..9637dfd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -947,6 +947,12 @@ static int format_reflog_person(struct strbuf *sb,
 	return format_person_part(sb, part, ident, strlen(ident), dmode);
 }
 
+static void conditional_strbuf_addstr(int conditional, struct strbuf *sb,
+				      const char *s) {
+	if (conditional)
+		strbuf_addstr(sb, s);
+}
+
 static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 				void *context)
 {
@@ -956,6 +962,8 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	struct commit_list *p;
 	int h1, h2;
 
+	int colors_enabled = want_color(GIT_COLOR_UNKNOWN);
+
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
@@ -967,20 +975,20 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			color_parse_mem(placeholder + 2,
 					end - (placeholder + 2),
 					"--pretty format", color);
-			strbuf_addstr(sb, color);
+			conditional_strbuf_addstr(colors_enabled, sb, color);
 			return end - placeholder + 1;
 		}
 		if (!prefixcmp(placeholder + 1, "red")) {
-			strbuf_addstr(sb, GIT_COLOR_RED);
+			conditional_strbuf_addstr(colors_enabled, sb, GIT_COLOR_RED);
 			return 4;
 		} else if (!prefixcmp(placeholder + 1, "green")) {
-			strbuf_addstr(sb, GIT_COLOR_GREEN);
+			conditional_strbuf_addstr(colors_enabled, sb, GIT_COLOR_GREEN);
 			return 6;
 		} else if (!prefixcmp(placeholder + 1, "blue")) {
-			strbuf_addstr(sb, GIT_COLOR_BLUE);
+			conditional_strbuf_addstr(colors_enabled, sb, GIT_COLOR_BLUE);
 			return 5;
 		} else if (!prefixcmp(placeholder + 1, "reset")) {
-			strbuf_addstr(sb, GIT_COLOR_RESET);
+			conditional_strbuf_addstr(colors_enabled, sb, GIT_COLOR_RESET);
 			return 6;
 		} else
 			return 0;
-- 
1.7.10.4
