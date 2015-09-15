From: Jeff King <peff@peff.net>
Subject: [PATCH 02/67] mailsplit: fix FILE* leak in split_maildir
Date: Tue, 15 Sep 2015 11:23:32 -0400
Message-ID: <20150915152331.GB29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:23:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbs5E-0006GI-1q
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbbIOPXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:23:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:59269 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752196AbbIOPXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:23:34 -0400
Received: (qmail 11068 invoked by uid 102); 15 Sep 2015 15:23:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:23:34 -0500
Received: (qmail 6750 invoked by uid 107); 15 Sep 2015 15:23:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:23:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:23:32 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277904>

If we encounter an error while splitting a maildir, we exit
the function early, leaking the open filehandle. This isn't
a big deal, since we exit the program soon after, but it's
easy enough to be careful.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mailsplit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 8e02ea1..9de06e3 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -150,6 +150,7 @@ static int split_maildir(const char *maildir, const char *dir,
 {
 	char file[PATH_MAX];
 	char name[PATH_MAX];
+	FILE *f = NULL;
 	int ret = -1;
 	int i;
 	struct string_list list = STRING_LIST_INIT_DUP;
@@ -160,7 +161,6 @@ static int split_maildir(const char *maildir, const char *dir,
 		goto out;
 
 	for (i = 0; i < list.nr; i++) {
-		FILE *f;
 		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].string);
 		f = fopen(file, "r");
 		if (!f) {
@@ -177,10 +177,13 @@ static int split_maildir(const char *maildir, const char *dir,
 		split_one(f, name, 1);
 
 		fclose(f);
+		f = NULL;
 	}
 
 	ret = skip;
 out:
+	if (f)
+		fclose(f);
 	string_list_clear(&list, 1);
 	return ret;
 }
-- 
2.6.0.rc2.408.ga2926b9
