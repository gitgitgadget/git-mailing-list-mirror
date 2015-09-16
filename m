From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/67] mailsplit: make PATH_MAX buffers dynamic
Date: Wed, 16 Sep 2015 06:25:24 -0400
Message-ID: <20150916102524.GA28002@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152806.GJ29753@sigill.intra.peff.net>
 <CAPig+cQ+TvT2_ZrbbYFQOdjDNs+b-ADJb+EbKVTP-HaCghjCow@mail.gmail.com>
 <20150916101418.GD13966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 12:25:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc9uI-0006xp-VY
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 12:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbbIPKZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 06:25:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:59847 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754533AbbIPKZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 06:25:33 -0400
Received: (qmail 15928 invoked by uid 102); 16 Sep 2015 10:25:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:25:33 -0500
Received: (qmail 16576 invoked by uid 107); 16 Sep 2015 10:25:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 06:25:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 06:25:24 -0400
Content-Disposition: inline
In-Reply-To: <20150916101418.GD13966@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278015>

On Wed, Sep 16, 2015 at 06:14:18AM -0400, Jeff King wrote:

> I guess we could get away with always calling free() right before
> assigning (the equivalent of strbuf_reset()), and then rely on exiting
> the loop to "out" to do the final free. And then the result (versus the
> original code, not my patch) would look like:

And here is the whole patch converted to that style. I'm planning to go
with this, as the resulting diff is much smaller and much more clear
that we are touching only the allocations.

I _hope_ the result is pretty easy to understand. There is some subtlety
to the loop assumptions:

 - on entering, the pointer is NULL or an allocated buffer to be
   recycled; either way, free() is OK

 - on leaving, the pointer is either NULL (if we never ran the loop) or
   a buffer to be freed. The free() at the end is necessary to handle
   this.

That is not too complicated, but it is not an idiom we use elsewhere
(whereas recycled strbufs are). I can switch the whole thing to strbufs
if that's the direction we want to go.

-- >8 --
Subject: [PATCH] mailsplit: make PATH_MAX buffers dynamic

There are several static PATH_MAX-sized buffers in
mailsplit, along with some questionable uses of sprintf.
These are not really of security interest, as local
mailsplit pathnames are not typically under control of an
attacker, and you could generally only overflow a few
numbers at the end of a path that approaches PATH_MAX (a
longer path would choke mailsplit long before). But it does
not hurt to be careful, and as a bonus we lift some limits
for systems with too-small PATH_MAX varibles.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mailsplit.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 9de06e3..104277a 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -98,30 +98,37 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 {
 	DIR *dir;
 	struct dirent *dent;
-	char name[PATH_MAX];
+	char *name = NULL;
 	char *subs[] = { "cur", "new", NULL };
 	char **sub;
+	int ret = -1;
 
 	for (sub = subs; *sub; ++sub) {
-		snprintf(name, sizeof(name), "%s/%s", path, *sub);
+		free(name);
+		name = xstrfmt("%s/%s", path, *sub);
 		if ((dir = opendir(name)) == NULL) {
 			if (errno == ENOENT)
 				continue;
 			error("cannot opendir %s (%s)", name, strerror(errno));
-			return -1;
+			goto out;
 		}
 
 		while ((dent = readdir(dir)) != NULL) {
 			if (dent->d_name[0] == '.')
 				continue;
-			snprintf(name, sizeof(name), "%s/%s", *sub, dent->d_name);
+			free(name);
+			name = xstrfmt("%s/%s", *sub, dent->d_name);
 			string_list_insert(list, name);
 		}
 
 		closedir(dir);
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	free(name);
+	return ret;
 }
 
 static int maildir_filename_cmp(const char *a, const char *b)
@@ -148,8 +155,7 @@ static int maildir_filename_cmp(const char *a, const char *b)
 static int split_maildir(const char *maildir, const char *dir,
 	int nr_prec, int skip)
 {
-	char file[PATH_MAX];
-	char name[PATH_MAX];
+	char *file = NULL;
 	FILE *f = NULL;
 	int ret = -1;
 	int i;
@@ -161,7 +167,11 @@ static int split_maildir(const char *maildir, const char *dir,
 		goto out;
 
 	for (i = 0; i < list.nr; i++) {
-		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].string);
+		char *name;
+
+		free(file);
+		file = xstrfmt("%s/%s", maildir, list.items[i].string);
+
 		f = fopen(file, "r");
 		if (!f) {
 			error("cannot open mail %s (%s)", file, strerror(errno));
@@ -173,8 +183,9 @@ static int split_maildir(const char *maildir, const char *dir,
 			goto out;
 		}
 
-		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
 		split_one(f, name, 1);
+		free(name);
 
 		fclose(f);
 		f = NULL;
@@ -184,6 +195,7 @@ static int split_maildir(const char *maildir, const char *dir,
 out:
 	if (f)
 		fclose(f);
+	free(file);
 	string_list_clear(&list, 1);
 	return ret;
 }
@@ -191,7 +203,6 @@ out:
 static int split_mbox(const char *file, const char *dir, int allow_bare,
 		      int nr_prec, int skip)
 {
-	char name[PATH_MAX];
 	int ret = -1;
 	int peek;
 
@@ -218,8 +229,9 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	}
 
 	while (!file_done) {
-		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		char *name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
 		file_done = split_one(f, name, allow_bare);
+		free(name);
 	}
 
 	if (f != stdin)
-- 
2.6.0.rc2.408.ga2926b9
