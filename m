From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH 2/4] Extract function trim_url and optimize calls of it.
Date: Sun, 13 Feb 2011 00:38:29 +0200
Message-ID: <1297550311-17723-3-git-send-email-vvavrychuk@gmail.com>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Cc: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 12 23:39:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoO7J-00033k-OL
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 23:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab1BLWir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 17:38:47 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34759 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab1BLWim (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 17:38:42 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so3929984fxm.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JUPSHQuAy+5y9WwdP7jMyFHWBTdhOVjHzEcuc8Izgkw=;
        b=u3QQMIFClnESKwwFr9380/UqJU3zYhGIeuOSHHUgLZnA4h2Lx6djwwBn3ZCp7jQwy4
         H0XBXgpK97SSLGzasXD+dKCNhJ48wWswWXGoojL9w+XK4Zv0dXMnSCWS7drmXAQ7mC8a
         PlvFuzfAO0Q7ilywgGCwuEyjH/JvR1ZPY/Ric=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BTUyBLzSdJkTn6NJNkD1MxhP5ynccKDiQCxK2/CHjFWtkQqBbd2p424XYqAAkZpv81
         R3u/3GrLk0tSicYLPsQ0raaYOPdM7CIV9KomE/kyYY/iLqMfkcIEOwVA+Is961c1JhLZ
         Y3PERl6tFfwjFNGfcK4IFrJxKt8FfHyaeCTt8=
Received: by 10.223.112.79 with SMTP id v15mr22148565fap.143.1297550322222;
        Sat, 12 Feb 2011 14:38:42 -0800 (PST)
Received: from localhost.localdomain ([91.200.115.239])
        by mx.google.com with ESMTPS id n7sm369494fam.35.2011.02.12.14.38.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 14:38:41 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.30.ga83dc
In-Reply-To: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166625>

Extract compact code into trim_url. Dont call it every iteration in the loop since no reason.

Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
---
 builtin/fetch.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2b0b11e..46d8fd6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -89,6 +89,19 @@ static void unlock_pack_on_signal(int signo)
 	raise(signo);
 }
 
+static void trim_url(char *url)
+{
+	int i, url_len;
+
+	url_len = strlen(url);
+	for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
+		;
+	url_len = i + 1;
+	if (4 < i && !strncmp(".git", url + i - 3, 4))
+		url_len = i - 3;
+	url[url_len] = '\0';
+}
+
 static void add_merge_config(struct ref **head,
 			   const struct ref *remote_refs,
 		           struct branch *branch,
@@ -329,7 +342,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 {
 	FILE *fp;
 	struct commit *commit;
-	int url_len, i, note_len, shown_url = 0, rc = 0;
+	int i, note_len, shown_url = 0, rc = 0;
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
@@ -339,10 +352,12 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	if (!fp)
 		return error("cannot open %s: %s\n", filename, strerror(errno));
 
-	if (raw_url)
+	if (raw_url) {
 		url = transport_anonymize_url(raw_url);
-	else
+		trim_url(url);
+	} else {
 		url = xstrdup("foreign");
+	}
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
 
@@ -379,14 +394,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			what = rm->name;
 		}
 
-		url_len = strlen(url);
-		for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
-			;
-		url_len = i + 1;
-		if (4 < i && !strncmp(".git", url + i - 3, 4))
-			url_len = i - 3;
-		url[url_len] = '\0';
-
 		note_len = 0;
 		if (*what) {
 			if (*kind)
-- 
1.7.1
