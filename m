From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] checkout: split off a function to peel away branchname
 arg
Date: Tue, 8 Feb 2011 04:29:09 -0600
Message-ID: <20110208102909.GB29660@elie>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
 <20110207220030.GA19357@elie>
 <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
 <20110207234526.GA28336@sigill.intra.peff.net>
 <20110208005238.GB24340@elie>
 <20110208102605.GA29660@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 11:29:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmkpH-0001DM-K9
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 11:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1BHK3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 05:29:17 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64152 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab1BHK3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 05:29:14 -0500
Received: by gxk9 with SMTP id 9so2139607gxk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 02:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uSWO59lDlsnOuuGRgBYCX4AtTBxatHTCY+Xf/uXkVnk=;
        b=QSXqA6O2tlLGSCPBm8IZH/rf0qUqd6LILj3eCcTgb3QL67buqJo5xciAou5IlqpGTz
         Vx8wWeIZR2nsFJwoSxW82WXDLB+36VtISC2SfLx3w8/hty1wE3LQK8MvqR0vlYB4j/3m
         dDigXGatRADYiXhdnelcKPzQqy3D4hJSXgHFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gVD1gmAS53a+ANK7GQQLj8lRN1fYPWPqUPGJ5Iae0Edd72xuTZ1P7KnGADuA1SEv7T
         S4U+ONIHudZJha8QxDATvWOR37bS7oIrS5hopEZMjci4McbifpL2KIpzQAe07dUHPAZg
         rnFjrBvviHWL09l9oi3dn9RuUGA5W1Acx1jVM=
Received: by 10.150.218.14 with SMTP id q14mr16466545ybg.313.1297160953400;
        Tue, 08 Feb 2011 02:29:13 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id k2sm1916292ybj.10.2011.02.08.02.29.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 02:29:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110208102605.GA29660@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166346>

The code to parse and consume the tree name and "--" in commands such
as "git checkout @{-1} -- '*.c'" is intimidatingly long.  Split it out
into a separate function and make it easier to skip on first reading
by making the data it uses and produces more explicit.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Just some code movement.

 builtin/checkout.c |  229 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 131 insertions(+), 98 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 953abdd..0e7a6a3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -675,11 +675,123 @@ static const char *unique_tracking_name(const char *name)
 	return NULL;
 }
 
+static int parse_branchname_arg(int argc, const char **argv,
+				int dwim_new_local_branch_ok,
+				struct branch_info *new,
+				struct tree **source_tree,
+				unsigned char rev[20],
+				const char **new_branch)
+{
+	int argcount = 0;
+	unsigned char branch_rev[20];
+	const char *arg;
+	int has_dash_dash;
+
+	/*
+	 * case 1: git checkout <ref> -- [<paths>]
+	 *
+	 *   <ref> must be a valid tree, everything after the '--' must be
+	 *   a path.
+	 *
+	 * case 2: git checkout -- [<paths>]
+	 *
+	 *   everything after the '--' must be paths.
+	 *
+	 * case 3: git checkout <something> [<paths>]
+	 *
+	 *   With no paths, if <something> is a commit, that is to
+	 *   switch to the branch or detach HEAD at it.  As a special case,
+	 *   if <something> is A...B (missing A or B means HEAD but you can
+	 *   omit at most one side), and if there is a unique merge base
+	 *   between A and B, A...B names that merge base.
+	 *
+	 *   With no paths, if <something> is _not_ a commit, no -t nor -b
+	 *   was given, and there is a tracking branch whose name is
+	 *   <something> in one and only one remote, then this is a short-hand
+	 *   to fork local <something> from that remote tracking branch.
+	 *
+	 *   Otherwise <something> shall not be ambiguous.
+	 *   - If it's *only* a reference, treat it like case (1).
+	 *   - If it's only a path, treat it like case (2).
+	 *   - else: fail.
+	 *
+	 */
+	if (!argc)
+		return 0;
+
+	if (!strcmp(argv[0], "--"))	/* case (2) */
+		return 1;
+
+	arg = argv[0];
+	has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
+
+	if (!strcmp(arg, "-"))
+		arg = "@{-1}";
+
+	if (get_sha1_mb(arg, rev)) {
+		if (has_dash_dash)          /* case (1) */
+			die("invalid reference: %s", arg);
+		if (dwim_new_local_branch_ok &&
+		    !check_filename(NULL, arg) &&
+		    argc == 1) {
+			const char *remote = unique_tracking_name(arg);
+			if (!remote || get_sha1(remote, rev))
+				return argcount;
+			*new_branch = arg;
+			arg = remote;
+			/* DWIMmed to create local branch */
+		} else {
+			return argcount;
+		}
+	}
+
+	/* we can't end up being in (2) anymore, eat the argument */
+	argcount++;
+	argv++;
+	argc--;
+
+	new->name = arg;
+	setup_branch_path(new);
+
+	if (check_ref_format(new->path) == CHECK_REF_FORMAT_OK &&
+	    resolve_ref(new->path, branch_rev, 1, NULL))
+		hashcpy(rev, branch_rev);
+	else
+		new->path = NULL; /* not an existing branch */
+
+	new->commit = lookup_commit_reference_gently(rev, 1);
+	if (!new->commit) {
+		/* not a commit */
+		*source_tree = parse_tree_indirect(rev);
+	} else {
+		parse_commit(new->commit);
+		*source_tree = new->commit->tree;
+	}
+
+	if (!*source_tree)                   /* case (1): want a tree */
+		die("reference is not a tree: %s", arg);
+	if (!has_dash_dash) {/* case (3 -> 1) */
+		/*
+		 * Do not complain the most common case
+		 *	git checkout branch
+		 * even if there happen to be a file called 'branch';
+		 * it would be extremely annoying.
+		 */
+		if (argc)
+			verify_non_filename(NULL, arg);
+	} else {
+		argcount++;
+		argv++;
+		argc--;
+	}
+
+	return argcount;
+}
+
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	unsigned char rev[20], branch_rev[20];
-	const char *arg;
+	unsigned char rev[20];
 	struct branch_info new;
 	struct tree *source_tree = NULL;
 	char *conflict_style = NULL;
@@ -709,7 +821,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		OPT_END(),
 	};
-	int has_dash_dash;
 
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
@@ -766,108 +877,30 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		die("git checkout: -f and -m are incompatible");
 
 	/*
-	 * case 1: git checkout <ref> -- [<paths>]
-	 *
-	 *   <ref> must be a valid tree, everything after the '--' must be
-	 *   a path.
-	 *
-	 * case 2: git checkout -- [<paths>]
-	 *
-	 *   everything after the '--' must be paths.
-	 *
-	 * case 3: git checkout <something> [<paths>]
-	 *
-	 *   With no paths, if <something> is a commit, that is to
-	 *   switch to the branch or detach HEAD at it.  As a special case,
-	 *   if <something> is A...B (missing A or B means HEAD but you can
-	 *   omit at most one side), and if there is a unique merge base
-	 *   between A and B, A...B names that merge base.
-	 *
-	 *   With no paths, if <something> is _not_ a commit, no -t nor -b
-	 *   was given, and there is a tracking branch whose name is
-	 *   <something> in one and only one remote, then this is a short-hand
-	 *   to fork local <something> from that remote tracking branch.
-	 *
-	 *   Otherwise <something> shall not be ambiguous.
-	 *   - If it's *only* a reference, treat it like case (1).
-	 *   - If it's only a path, treat it like case (2).
-	 *   - else: fail.
-	 *
+	 * Extract branch name from command line arguments, so
+	 * all that is left is pathspecs.
+	 *
+	 * Handle
+	 *
+	 *  1) git checkout <tree> -- [<paths>]
+	 *  2) git checkout -- [<paths>]
+	 *  3) git checkout <something> [<paths>]
+	 *
+	 * including "last branch" syntax and DWIM-ery for names of
+	 * remote branches, erroring out for invalid or ambiguous cases.
 	 */
 	if (argc) {
-		if (!strcmp(argv[0], "--")) {       /* case (2) */
-			argv++;
-			argc--;
-			goto no_reference;
-		}
-
-		arg = argv[0];
-		has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
-
-		if (!strcmp(arg, "-"))
-			arg = "@{-1}";
-
-		if (get_sha1_mb(arg, rev)) {
-			if (has_dash_dash)          /* case (1) */
-				die("invalid reference: %s", arg);
-			if (!patch_mode &&
-			    dwim_new_local_branch &&
-			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
-			    !opts.new_branch &&
-			    !check_filename(NULL, arg) &&
-			    argc == 1) {
-				const char *remote = unique_tracking_name(arg);
-				if (!remote || get_sha1(remote, rev))
-					goto no_reference;
-				opts.new_branch = arg;
-				arg = remote;
-				/* DWIMmed to create local branch */
-			}
-			else
-				goto no_reference;
-		}
-
-		/* we can't end up being in (2) anymore, eat the argument */
-		argv++;
-		argc--;
-
-		new.name = arg;
-		setup_branch_path(&new);
-
-		if (check_ref_format(new.path) == CHECK_REF_FORMAT_OK &&
-		    resolve_ref(new.path, branch_rev, 1, NULL))
-			hashcpy(rev, branch_rev);
-		else
-			new.path = NULL; /* not an existing branch */
-
-		if (!(new.commit = lookup_commit_reference_gently(rev, 1))) {
-			/* not a commit */
-			source_tree = parse_tree_indirect(rev);
-		} else {
-			parse_commit(new.commit);
-			source_tree = new.commit->tree;
-		}
-
-		if (!source_tree)                   /* case (1): want a tree */
-			die("reference is not a tree: %s", arg);
-		if (!has_dash_dash) {/* case (3 -> 1) */
-			/*
-			 * Do not complain the most common case
-			 *	git checkout branch
-			 * even if there happen to be a file called 'branch';
-			 * it would be extremely annoying.
-			 */
-			if (argc)
-				verify_non_filename(NULL, arg);
-		}
-		else {
-			argv++;
-			argc--;
-		}
+		int dwim_ok =
+			!patch_mode &&
+			dwim_new_local_branch &&
+			opts.track == BRANCH_TRACK_UNSPECIFIED &&
+			!opts.new_branch;
+		int n = parse_branchname_arg(argc, argv, dwim_ok,
+				&new, &source_tree, rev, &opts.new_branch);
+		argv += n;
+		argc -= n;
 	}
 
-no_reference:
-
 	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
 		opts.track = git_branch_track;
 
-- 
1.7.4
