From: Jeff King <peff@peff.net>
Subject: [PATCH 43/67] merge-recursive: convert malloc / strcpy to strbuf
Date: Tue, 15 Sep 2015 11:58:35 -0400
Message-ID: <20150915155834.GQ29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:58:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsd0-0005kB-De
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbbIOP6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:58:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:59407 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753923AbbIOP6h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:58:37 -0400
Received: (qmail 13401 invoked by uid 102); 15 Sep 2015 15:58:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:58:37 -0500
Received: (qmail 7616 invoked by uid 107); 15 Sep 2015 15:58:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:58:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:58:35 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277946>

This would be a fairly routine use of xstrfmt, except that
we need to remember the length of the result to pass to
cache_name_pos. So just use a strbuf, which makes this
simple.

As a bonus, this gets rid of confusing references to
"pathlen+1". The "1" is for the trailing slash we added, but
that is automatically accounted for in the strbuf's len
parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-recursive.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 44d85be..a5e74d8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -630,25 +630,24 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 
 static int dir_in_way(const char *path, int check_working_copy)
 {
-	int pos, pathlen = strlen(path);
-	char *dirpath = xmalloc(pathlen + 2);
+	int pos;
+	struct strbuf dirpath = STRBUF_INIT;
 	struct stat st;
 
-	strcpy(dirpath, path);
-	dirpath[pathlen] = '/';
-	dirpath[pathlen+1] = '\0';
+	strbuf_addstr(&dirpath, path);
+	strbuf_addch(&dirpath, '/');
 
-	pos = cache_name_pos(dirpath, pathlen+1);
+	pos = cache_name_pos(dirpath.buf, dirpath.len);
 
 	if (pos < 0)
 		pos = -1 - pos;
 	if (pos < active_nr &&
-	    !strncmp(dirpath, active_cache[pos]->name, pathlen+1)) {
-		free(dirpath);
+	    !strncmp(dirpath.buf, active_cache[pos]->name, dirpath.len)) {
+		strbuf_release(&dirpath);
 		return 1;
 	}
 
-	free(dirpath);
+	strbuf_release(&dirpath);
 	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode);
 }
 
-- 
2.6.0.rc2.408.ga2926b9
