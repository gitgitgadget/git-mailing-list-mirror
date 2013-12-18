From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH 1/3] builtin/fetch.c: Add pretty_url() and print_url()
Date: Wed, 18 Dec 2013 15:22:54 -0600
Message-ID: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
Cc: Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 22:23:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtOaX-0005U0-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 22:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab3LRVXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 16:23:13 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:57913 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020Ab3LRVXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 16:23:11 -0500
Received: by mail-qc0-f173.google.com with SMTP id m20so204627qcx.18
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 13:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UGj4rnVTaY2ZZw7rKxhZku4mw4tcREOSbTz3VhhhotY=;
        b=YKjnvlaJQJRoU4sqCXA9K+dMhaGjAHOkQFkV/TN/XM36RQ5VMSlzVL308pxMi6sKo1
         rGvg4tAeqInwtBSH4v8/VwvMkWEnvDNjaXoQjXj0ixeUOwANm3IVYXBUn0eeP5V64ey2
         yVL5UgQdUQSLvDqbgmcne3sttXrj7q0DthHNwgQ0IiT4xidDMVWKwMrqacAN/xpIle3t
         IMOWykj0GqR+jUcgBq87k/Dccdjaj/89F6ufnpODbN74xWwcun7T5Y1t+ilKSxBVyDQ7
         n9BOkekYEY1NrrxG3FLWk5Lac9eigI48xH0SGuj2K81C1nkHiS0M/JQsLeIpSDo/xjZA
         p9tQ==
X-Received: by 10.224.121.140 with SMTP id h12mr6719614qar.41.1387401789175;
        Wed, 18 Dec 2013 13:23:09 -0800 (PST)
Received: from localhost.localdomain (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id 4sm3512957qak.11.2013.12.18.13.23.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 13:23:08 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.163.gd7aced9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239486>

In order to fix branchname DF conflicts during `fetch --prune`, the way
the header is output to the screen needs to be refactored. Here is an
exmaple of the output with the line in question denoted by '>':

	$ git fetch --prune --dry-run upstream
>	From https://github.com/git/git
	   a155a5f..5512ac5  maint      -> upstream/maint
	   d7aced9..7794a68  master     -> upstream/master
	   523f7c4..3e57c29  next       -> upstream/next
	 + 462f102...0937cdf pu         -> upstream/pu  (forced update)
	   e24105a..5d352bc  todo       -> upstream/todo
	 * [new tag]         v1.8.5.2   -> v1.8.5.2
	 * [new tag]         v1.8.5.2   -> v1.8.5.2

pretty_url():
This function when passed a transport url will anonymize the transport
of the url. It will strip a trailing '/'. It will also strip a trailing
'.git'. It will return the newly formated url for use. I do not believe
there is a need for stripping the trailing '/' and '.git' from a url,
but it was already there and I wanted to make as little changes as
possible.

print_url():
This function will convert a transport url to a pretty url using
pretty_url(). Then it will print out the pretty url to stderr as
indicated above in the example output. It uses a global variable
named "gshown_url' to prevent this header for being printed twice.

Signed-off-by: Tom Miller <jackerran@gmail.com>
---
 builtin/fetch.c | 60 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3d978eb..b3145f6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -44,6 +44,42 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
+static int gshown_url = 0;
+
+static char *pretty_url(const char *raw_url) {
+	if (raw_url) {
+		int url_len, i;
+		char *pretty_url, *url;
+
+		url = transport_anonymize_url(raw_url);
+
+		url_len = strlen(url);
+		for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
+			;
+		url_len = i + 1;
+		if (4 < i && !strncmp(".git", url + i - 3, 4))
+			url_len = i - 3;
+
+		pretty_url = xcalloc(1, 1 + url_len);
+		memcpy(pretty_url, url, url_len);
+
+		free(url);
+		return pretty_url;
+	}
+	return xstrdup("foreign");
+}
+
+static void print_url(const char *raw_url) {
+	if (!gshown_url) {
+		char *url = pretty_url(raw_url);
+
+		fprintf(stderr, _("From %s\n"), url);
+
+		gshown_url = 1;
+		free(url);
+	}
+}
+
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -535,7 +571,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 {
 	FILE *fp;
 	struct commit *commit;
-	int url_len, i, shown_url = 0, rc = 0;
+	int url_len, i, rc = 0;
 	struct strbuf note = STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
@@ -546,10 +582,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	if (!fp)
 		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
 
-	if (raw_url)
-		url = transport_anonymize_url(raw_url);
-	else
-		url = xstrdup("foreign");
+	url = pretty_url(raw_url);
+	url_len = strlen(url);
 
 	rm = ref_map;
 	if (check_everything_connected(iterate_ref_map, 0, &rm)) {
@@ -606,13 +640,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				what = rm->name;
 			}
 
-			url_len = strlen(url);
-			for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
-				;
-			url_len = i + 1;
-			if (4 < i && !strncmp(".git", url + i - 3, 4))
-				url_len = i - 3;
-
 			strbuf_reset(&note);
 			if (*what) {
 				if (*kind)
@@ -651,13 +678,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 					    REFCOL_WIDTH,
 					    *what ? what : "HEAD");
 			if (note.len) {
-				if (verbosity >= 0 && !shown_url) {
-					fprintf(stderr, _("From %.*s\n"),
-							url_len, url);
-					shown_url = 1;
-				}
-				if (verbosity >= 0)
+				if (verbosity >= 0) {
+					print_url(raw_url);
 					fprintf(stderr, " %s\n", note.buf);
+				}
 			}
 		}
 	}
-- 
1.8.5.1.163.gd7aced9
