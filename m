From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] rm: remove unneeded null pointer check
Date: Thu,  8 Aug 2013 19:52:41 +0200
Message-ID: <1375984361-2494-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 08 19:52:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7UOE-0001O3-4N
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966027Ab3HHRwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:52:42 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:42430 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965980Ab3HHRwl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:52:41 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so1596150eak.29
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Tuh1kDmG2Cz6PC12R45nZDDyMVvOXEveCnaIK+9/jas=;
        b=bnM7mrkmvqtS/vfTcqzOy8UmRmLi+X+mI12GTNqWTZOHGIP0gCDcdoa8Sx6YUeuxRo
         NB+2fVrqLaYEm+f+miD0UJ4CipMEElh6AmgXOmOLPHL/60QM+ioiNUELfMMh+kNR60DP
         5zZL0SgigHiCMDeUb9Vz7cL/mOeTTDYa3QX+kJ3qARAhwPf3oibYm96MjwPhcx6L1kvf
         ocfCoRd7qtNrqV2EjqY70NdRIBMW3gdeVR73N4TeCEyVj+/+tnMhN64+qIAvYj8ezlmd
         WYnD+a592gVh9/2mVC9KgRuYXQayyjtxKX6I1ICMdU1Qhfzk8frvy2lumLcz55IEoFXz
         xfVA==
X-Received: by 10.15.24.129 with SMTP id j1mr9501341eeu.17.1375984360590;
        Thu, 08 Aug 2013 10:52:40 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a1sm21132285eem.1.2013.08.08.10.52.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 10:52:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.25.gd121ba2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231912>

As of 7612a1efdb (2006-06-09 git-rm: honor -n flag.) the variable
'pathspec' seems to be assumed to be never NULL after calling get_pathspec
There was a NULL pointer check after the seen = NULL assignment, which
was removed by that commit. So if pathspec would be NULL now, we'd segfault
in the line accessing the pathspec:
	for (i = 0; pathspec[i] ; i++)

A few lines later, 'pathspec' still cannot be NULL, but that check was
overlooked, hence removing it now.

As the null pointer check was removed, it makes no sense to assign NULL
to seen and 3 lines later another value as there are no conditions in
between.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/rm.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 0df0b4d..d00eaf8 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -277,8 +277,8 @@ static struct option builtin_rm_options[] = {
 
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
-	int i, newfd;
-	const char **pathspec;
+	int i, newfd, seen_any;
+	const char **pathspec, *match;
 	char *seen;
 
 	git_config(git_default_config, NULL);
@@ -314,7 +314,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	pathspec = get_pathspec(prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
 
-	seen = NULL;
 	for (i = 0; pathspec[i] ; i++)
 		/* nothing */;
 	seen = xcalloc(i, 1);
@@ -328,27 +327,24 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		list.entry[list.nr++].is_submodule = S_ISGITLINK(ce->ce_mode);
 	}
 
-	if (pathspec) {
-		const char *match;
-		int seen_any = 0;
-		for (i = 0; (match = pathspec[i]) != NULL ; i++) {
-			if (!seen[i]) {
-				if (!ignore_unmatch) {
-					die(_("pathspec '%s' did not match any files"),
-					    match);
-				}
-			}
-			else {
-				seen_any = 1;
+
+	seen_any = 0;
+	for (i = 0; (match = pathspec[i]) != NULL ; i++) {
+		if (!seen[i]) {
+			if (!ignore_unmatch) {
+				die(_("pathspec '%s' did not match any files"),
+				    match);
 			}
-			if (!recursive && seen[i] == MATCHED_RECURSIVELY)
-				die(_("not removing '%s' recursively without -r"),
-				    *match ? match : ".");
 		}
-
-		if (! seen_any)
-			exit(0);
+		else {
+			seen_any = 1;
+		}
+		if (!recursive && seen[i] == MATCHED_RECURSIVELY)
+			die(_("not removing '%s' recursively without -r"),
+			    *match ? match : ".");
 	}
+	if (!seen_any)
+		exit(0);
 
 	/*
 	 * If not forced, the file, the index and the HEAD (if exists)
-- 
1.8.4.rc1.25.gd121ba2
