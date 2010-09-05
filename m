From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH/RFC] Restructure some of the checkout opts.
Date: Sun, 5 Sep 2010 08:09:06 -0400
Message-ID: <9f6f4947af20df9dc0ebd8915dcdb9b5f756d35d.1283688482.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 14:09:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsE2P-0000D7-BE
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 14:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab0IEMJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 08:09:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40321 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0IEMJL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 08:09:11 -0400
Received: by qwh6 with SMTP id 6so3164575qwh.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=WCjHRTEpN3YD4FuSUOrApgWTGNqpj16DwOP9tovH/ZU=;
        b=l1Nf8cYYc5ca7nGQWiBM1wGv3/oxUtjJCyMl7ATcwFUTfq1NSwuyDr1GIDES0w4JCW
         C2hBqzNUM9+uS51lL0tfYYZjQDZnmtJzdCsyXLlczewfF7yPbT/N7rrPYnCNxUDonik2
         FRWNdaTUWeG/KXE1M527OGjYnuBjqaHKqFk1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Tn+FiFgVK5aEO113FiWLFc9Fx4J5GQQRoTnP+K4sBJ5K2JqqNFQxHQPtE7qgpS08Iw
         e6K3HbGTJn0t+Ro9tHpriMMdjNWXvqFYU2EszkZr6AOAARKbxVUF8n1/rOpEom4ZYWci
         j12lMSE17fBT9ayX4VWJ2mZE7hZQLDpx9MIzs=
Received: by 10.224.19.205 with SMTP id c13mr941510qab.111.1283688550420;
        Sun, 05 Sep 2010 05:09:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-213-29.cinci.res.rr.com [174.101.213.29])
        by mx.google.com with ESMTPS id t18sm4378769qco.8.2010.09.05.05.09.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 05:09:09 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155452>

Previously, most opts in `builtin.checkout.c' had been an instance of
`struct checkout_opts'. It appears that some of the opts that were
perhaps added later were not in the struct. Move them into the struct
in order to maintain consistency.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---

 builtin/checkout.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7250e5c..3a35cde 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -31,6 +31,9 @@ struct checkout_opts {
 	int force;
 	int writeout_stage;
 	int writeout_error;
+	int patch_mode;
+	int dwim_new_local_branch;
+	char *conflict_style;
 
 	/* not set by parse_options */
 	int branch_exists;
@@ -660,9 +663,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	const char *arg;
 	struct branch_info new;
 	struct tree *source_tree = NULL;
-	char *conflict_style = NULL;
-	int patch_mode = 0;
-	int dwim_new_local_branch = 1;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
@@ -679,10 +679,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    3),
 		OPT_BOOLEAN('f', "force", &opts.force, "force"),
 		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
-		OPT_STRING(0, "conflict", &conflict_style, "style",
+		OPT_STRING(0, "conflict", &opts.conflict_style, "style",
 			   "conflict style (merge or diff3)"),
-		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
-		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
+		OPT_BOOLEAN('p', "patch", &opts.patch_mode, "select hunks interactively"),
+		{ OPTION_BOOLEAN, 0, "guess", &opts.dwim_new_local_branch, NULL,
 		  "second guess 'git checkout no-such-branch'",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		OPT_END(),
@@ -695,6 +695,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	git_config(git_checkout_config, NULL);
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
+	opts.dwim_new_local_branch = 1;
 
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
@@ -707,7 +708,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.new_branch_force)
 		opts.new_branch = opts.new_branch_force;
 
-	if (patch_mode && (opts.track > 0 || opts.new_branch
+	if (opts.patch_mode && (opts.track > 0 || opts.new_branch
 			   || opts.new_branch_log || opts.merge || opts.force))
 		die ("--patch is incompatible with all other options");
 
@@ -734,9 +735,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.new_branch = opts.new_orphan_branch;
 	}
 
-	if (conflict_style) {
+	if (opts.conflict_style) {
 		opts.merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+		git_xmerge_config("merge.conflictstyle", opts.conflict_style, NULL);
 	}
 
 	if (opts.force && opts.merge)
@@ -787,8 +788,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		if (get_sha1_mb(arg, rev)) {
 			if (has_dash_dash)          /* case (1) */
 				die("invalid reference: %s", arg);
-			if (!patch_mode &&
-			    dwim_new_local_branch &&
+			if (!opts.patch_mode &&
+			    opts.dwim_new_local_branch &&
 			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			    !opts.new_branch &&
 			    !check_filename(NULL, arg) &&
@@ -851,7 +852,7 @@ no_reference:
 		if (!pathspec)
 			die("invalid path specification");
 
-		if (patch_mode)
+		if (opts.patch_mode)
 			return interactive_checkout(new.name, pathspec, &opts);
 
 		/* Checkout paths */
@@ -869,7 +870,7 @@ no_reference:
 		return checkout_paths(source_tree, pathspec, &opts);
 	}
 
-	if (patch_mode)
+	if (opts.patch_mode)
 		return interactive_checkout(new.name, NULL, &opts);
 
 	if (opts.new_branch) {
-- 
1.7.2.2
