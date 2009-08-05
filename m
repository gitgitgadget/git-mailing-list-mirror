From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 5/6] Teach --id to "git rm"
Date: Wed,  5 Aug 2009 17:51:45 +0800
Message-ID: <1249465906-3940-6-git-send-email-ayiehere@gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-3-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-4-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-5-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:56:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdE3-0005Ee-Rl
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934010AbZHEJzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933930AbZHEJzz
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:55:55 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:35171 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933246AbZHEJzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:55:54 -0400
Received: by pzk34 with SMTP id 34so3443641pzk.4
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UstrlSiiN0vlMrTn2ZjmWZ3uPgat0JAj9mpCjUqslm4=;
        b=GCDBYv/QZxl2LGCPVFrBmPH1Iyw9C1x/CDoh5Np+VpnlJAnuiPPLKqeRJmf+Ms740w
         4DSWJN/HMP4HENfpO51dG0GlFqBvZu7D+EGwaXeSuBd5iwQBqAUZsE2mJ/RZIsfQaUjK
         czuHTCKgbXk4u+rfQtQkb4BlZq0nwIwF4Mci8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T+t5MCb775i30CZtu5mSJTxxFfJBB0WF+snYECOSFzrFv4XLK6tcMexF5d/Bzr8F97
         QLGegKi1Tt7KKZiafZeWKWq3GHqnt9vKn1oWHt2VG6NX0wGeppr3o09kNkjk8KRq1yR0
         SF5xj2SbOg0p6/fQVmJDRLePD7LJYHTnDaXI8=
Received: by 10.114.166.11 with SMTP id o11mr11346459wae.210.1249465824481;
        Wed, 05 Aug 2009 02:50:24 -0700 (PDT)
Received: from localhost.localdomain ([115.132.128.228])
        by mx.google.com with ESMTPS id k14sm13017099waf.25.2009.08.05.02.50.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 02:50:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.13.ge6580
In-Reply-To: <1249465906-3940-5-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124887>

---
 builtin-rm.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 57975db..d2982a0 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -137,6 +137,7 @@ static struct lock_file lock_file;
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
 static int ignore_unmatch = 0;
+static const char *file_id;
 
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only),
@@ -146,6 +147,7 @@ static struct option builtin_rm_options[] = {
 	OPT_BOOLEAN('r', NULL,             &recursive,  "allow recursive removal"),
 	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
 				"exit with a zero status even if nothing matched"),
+	OPT_STRING('d', "id", &file_id, "FILE_ID", "file id"),
 	OPT_END(),
 };
 
@@ -154,11 +156,18 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	int i, newfd;
 	const char **pathspec;
 	char *seen;
+	char **new_argv;
 
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
 			     builtin_rm_usage, 0);
+
+	if (file_id)
+		new_argv = (char **) expand_file_ids(file_id, &argc, (char **) argv);
+	else
+		new_argv = (char **) argv;
+
 	if (!argc)
 		usage_with_options(builtin_rm_usage, builtin_rm_options);
 
@@ -171,7 +180,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		die("index file corrupt");
 	refresh_cache(REFRESH_QUIET);
 
-	pathspec = get_pathspec(prefix, argv);
+	pathspec = get_pathspec(prefix, (const char **) new_argv);
 	seen = NULL;
 	for (i = 0; pathspec[i] ; i++)
 		/* nothing */;
-- 
1.6.4.13.ge6580
