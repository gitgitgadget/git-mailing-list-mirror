From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 2/3] git add -u: give an error if pathspec unmatched
Date: Tue,  9 Feb 2010 17:30:49 -0500
Message-ID: <1265754650-25438-3-git-send-email-judge.packham@gmail.com>
References: <a038bef51002091417o1048c098x898517596115ed90@mail.gmail.com>
 <1265754650-25438-1-git-send-email-judge.packham@gmail.com>
 <1265754650-25438-2-git-send-email-judge.packham@gmail.com>
Cc: peff@peff.net, szeder@ira.uka.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 23:33:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neydt-0001yP-4W
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 23:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab0BIWdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 17:33:08 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53221 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab0BIWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 17:33:04 -0500
Received: by mail-vw0-f46.google.com with SMTP id 12so445535vws.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 14:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7eQqzieE9xcZQpgniJgQ0xCzpV6cb8VxplshNTalfm0=;
        b=LM+GnpnZ9gyV3mGdGUHuceCEEIbwXI+CXo2stvj/ouGKHE1UcBborhqay4P0bLu5Fi
         5Oy4j3csuNhNjwy3GHhpCh/ogppdJS87MujQ02NGYujpq5ykHD1il02G48faNO318/da
         R86/zdjAWIOKTvgygSUDKsmEx6qnLzze1a9OM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IC4hgyeB7za1git1vGVKZLbnkE+pnrj7ThaSTLO32B2d1pr7D1+asjkSP7ikQnEOX7
         oOGbAYQ6KeDAqZV+zKzl0UYws+JtP69CDG0fCJT6DUE3QBactCupenGdpfhiD8Uo/SQf
         pOEeLqpRS7+8WpfPW1lJLK/H6lcXiO/3O0q7o=
Received: by 10.220.126.194 with SMTP id d2mr1007929vcs.138.1265754784422;
        Tue, 09 Feb 2010 14:33:04 -0800 (PST)
Received: from localhost.localdomain ([66.193.66.34])
        by mx.google.com with ESMTPS id 26sm4516876vws.21.2010.02.09.14.33.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 14:33:03 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1265754650-25438-2-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139452>

From: Junio C Hamano <gitster@pobox.com>

If a pathspec is supplied to 'git add -u' and no matching path is
matched, fail with an approriate error message and exit code.

Tested-by: Chris Packham <judge.packham@gmail.com>
---
 builtin-add.c |   38 +++++++++++++++++++++++++++++---------
 1 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 2705f8d..87d2980 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -117,7 +117,19 @@ static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 	}
 }
 
-static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
+static char *find_used_pathspec(const char **pathspec)
+{
+	char *seen;
+	int i;
+
+	for (i = 0; pathspec[i];  i++)
+		; /* just counting */
+	seen = xcalloc(i, 1);
+	fill_pathspec_matches(pathspec, seen, i);
+	return seen;
+}
+
+static char *prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
 	char *seen;
 	int i, specs;
@@ -137,13 +149,7 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 	}
 	dir->nr = dst - dir->entries;
 	fill_pathspec_matches(pathspec, seen, specs);
-
-	for (i = 0; i < specs; i++) {
-		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]))
-			die("pathspec '%s' did not match any files",
-					pathspec[i]);
-	}
-        free(seen);
+	return seen;
 }
 
 static void treat_gitlinks(const char **pathspec)
@@ -359,6 +365,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int flags;
 	int add_new_files;
 	int require_pathspec;
+	char *seen = NULL;
 
 	git_config(add_config, NULL);
 
@@ -418,7 +425,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		/* This picks up the paths that are not tracked */
 		baselen = fill_directory(&dir, pathspec);
 		if (pathspec)
-			prune_directory(&dir, pathspec, baselen);
+			seen = prune_directory(&dir, pathspec, baselen);
 	}
 
 	if (refresh_only) {
@@ -426,6 +433,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		goto finish;
 	}
 
+	if (pathspec) {
+		int i;
+		if (!seen)
+			seen = find_used_pathspec(pathspec);
+		for (i = 0; pathspec[i]; i++) {
+			if (!seen[i] && pathspec[i][0]
+			    && !file_exists(pathspec[i]))
+				die("pathspec '%s' did not match any files",
+				    pathspec[i]);
+		}
+		free(seen);
+	}
+
 	exit_status |= add_files_to_cache(prefix, pathspec, flags);
 
 	if (add_new_files)
-- 
1.6.4.2
