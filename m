From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 2/6] Teach --id to "git add"
Date: Wed,  5 Aug 2009 17:51:42 +0800
Message-ID: <1249465906-3940-3-git-send-email-ayiehere@gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdDX-00051k-SE
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933953AbZHEJzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933930AbZHEJzV
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:55:21 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:58512 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933228AbZHEJzT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:55:19 -0400
Received: by wa-out-1112.google.com with SMTP id j5so710330wah.21
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9ChEGlo05uzBCb/IblB9FzYwVPe9VO9mbHfjrsfrt3k=;
        b=fC7gYEUOYaLFgtPUZrYcvIs++2PkAb95AAKoK29zGrPD006SALENw1IUojzCgiVoO8
         QrdTR3P+jqzJu8IhPATMUn617ijSJwl2VWX5SccnaYIQ+jclt1tXhXcymaeflPA8iVxi
         I12BOG1plgR09rrPSUUZvaOPtBf9lZVk6qtuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CInUH9YxDiz7QL/+lgIVfB5Twcvq//N39EWxFt+pCBipmUKpiz2M1NTnunotLW8C71
         3c9c/jZJ5fZze89fSBo+WWkPLAuhd61X/kcalkNuriMNnfO4HLD14BH43F8xM0MhsLTk
         z+1+QzaHjk//SkxmS+Essv77rO0+hasGgrYBE=
Received: by 10.114.12.19 with SMTP id 19mr11434275wal.36.1249465815524;
        Wed, 05 Aug 2009 02:50:15 -0700 (PDT)
Received: from localhost.localdomain ([115.132.128.228])
        by mx.google.com with ESMTPS id k14sm13017099waf.25.2009.08.05.02.50.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 02:50:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.13.ge6580
In-Reply-To: <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124886>

---
 builtin-add.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 581a2a1..1ed95d5 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -212,6 +212,7 @@ static const char ignore_error[] =
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
 static int ignore_add_errors, addremove, intent_to_add;
+static const char *file_id;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only),
@@ -226,6 +227,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('A', "all", &addremove, "add all, noticing removal of tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
+	OPT_STRING('d', "id", &file_id, "FILE_ID", "file id"),
 	OPT_END(),
 };
 
@@ -268,27 +270,34 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int flags;
 	int add_new_files;
 	int require_pathspec;
+	char **new_argv;
 
 	git_config(add_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
+
+	if (file_id)
+		new_argv = (char **) expand_file_ids(file_id, &argc, (char **) argv);
+	else
+		new_argv = (char **) argv;
+
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
-		exit(interactive_add(argc - 1, argv + 1, prefix));
+		exit(interactive_add(argc - 1, (const char **) (new_argv + 1), prefix));
 
 	if (edit_interactive)
-		return(edit_patch(argc, argv, prefix));
+		return(edit_patch(argc, (const char **) new_argv, prefix));
 	argc--;
-	argv++;
+	new_argv++;
 
 	if (addremove && take_worktree_changes)
 		die("-A and -u are mutually incompatible");
 	if ((addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] = { ".", NULL };
 		argc = 1;
-		argv = here;
+		new_argv = (char **) here;
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
@@ -308,7 +317,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
 		return 0;
 	}
-	pathspec = validate_pathspec(argc, argv, prefix);
+	pathspec = validate_pathspec(argc, (const char **) new_argv, prefix);
 
 	if (read_cache() < 0)
 		die("index file corrupt");
-- 
1.6.4.13.ge6580
