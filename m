From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [CLEANUP PATCH] show <tag>: reuse pp_user_info() instead of duplicating
 code
Date: Fri, 2 Jan 2009 19:08:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021717350.27818@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 02 19:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIoTI-0002tl-3s
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088AbZABSIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756951AbZABSIW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:08:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:32947 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759285AbZABSIU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:08:20 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:08:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 02 Jan 2009 19:08:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184ijVNxbE4zjARorXbz0EYcnC24vlg0e8m25n4I4
	p0mvoGgsG83miS
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104396>


We used to extract the tagger information "by hand" in "git show <tag>",
but the function pp_user_info() already does that.  Even better:
it respects the commit_format and date_format specified by the user.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Just a little cleanup, as I tripped over that part of Git's source.

 builtin-log.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 99d1137..bc4e1e9 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -249,22 +249,13 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 
 static void show_tagger(char *buf, int len, struct rev_info *rev)
 {
-	char *email_end, *p;
-	unsigned long date;
-	int tz;
+	struct strbuf out = STRBUF_INIT;
 
-	email_end = memchr(buf, '>', len);
-	if (!email_end)
-		return;
-	p = ++email_end;
-	while (isspace(*p))
-		p++;
-	date = strtoul(p, &p, 10);
-	while (isspace(*p))
-		p++;
-	tz = (int)strtol(p, NULL, 10);
-	printf("Tagger: %.*s\nDate:   %s\n", (int)(email_end - buf), buf,
-	       show_date(date, tz, rev->date_mode));
+	pp_user_info("Tagger", rev->commit_format, &out, buf, rev->date_mode,
+		git_log_output_encoding ?
+		git_log_output_encoding: git_commit_encoding);
+	printf("%s\n", out.buf);
+	strbuf_release(&out);
 }
 
 static int show_object(const unsigned char *sha1, int show_tag_object,
-- 
1.6.1.rc3.224.g95ac9
