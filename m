From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] revisions: split out handle_revision_pseudo_opt function
Date: Thu, 21 Apr 2011 05:45:07 -0500
Message-ID: <20110421104507.GB16260@elie>
References: <20110421102241.GA16185@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 12:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCrNx-0000n0-OJ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 12:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab1DUKpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 06:45:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42353 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab1DUKpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 06:45:12 -0400
Received: by iyb14 with SMTP id 14so1290689iyb.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mlsqg/pspA81d6jSydnTQl0ixRCNwlfUwc74kisGAOw=;
        b=rLuJkyzFeRWBYbfLwhmDwwtGspb2gUM8dG6zio5zayL2mb+9+KGxwPXLxROOz4n9Wz
         QLSFp9C6GWZgNPpsKDfPXMcc0mZBDbsAjl0OrxQyteoEE4DsTWsapONgfvxsGvN2jTcO
         OCLbMyddQlI5wYnyDALi9YOaHUtwG/I5alQ6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=clQrBolnCgFGgMNFNTpsEaVcOGsdqzKYQJZ0BlbN6B+6IMi6H570fe6mDSujuzco2f
         iDBB9069TstBeOsUo8E82HRpgVtFiY6vN5vikeAhYVJERr005Jgyy+DUKYksHxxqBcDf
         hMHTINabkAv5tfHevGYvHTfGZWcCtAXz5UnYA=
Received: by 10.42.131.69 with SMTP id y5mr6093974ics.418.1303382711896;
        Thu, 21 Apr 2011 03:45:11 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id ww2sm655981icb.3.2011.04.21.03.45.10
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 03:45:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110421102241.GA16185@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171899>

As v1.6.0-rc2~42 (Allow "non-option" revision options in
parse_option-enabled commands, 2008-07-31) explains, options handled
by setup_revisions fall into two categories:

 1. global options like --topo-order handled by parse_revision_opt,
    which can take detached arguments and can be parsed in advance;

 2. pseudo-options that must be parsed in order with their revision
    counterparts, like --not and --all.

The global options are taken care of by handle_revision_opt; the
pseudo-options are currently in a deeply indented portion of
setup_revisions.  Give them their own function for easier reading.

The only goal is to make setup_revisions easier to read straight
through.  No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Continuing without patch 1.

 revision.c |  123 +++++++++++++++++++++++++++++-------------------------------
 1 files changed, 59 insertions(+), 64 deletions(-)

diff --git a/revision.c b/revision.c
index 0f38364..c9b1e32 100644
--- a/revision.c
+++ b/revision.c
@@ -1526,6 +1526,59 @@ static void append_prune_data(const char ***prune_data, const char **av)
 	*prune_data = prune;
 }
 
+static int handle_revision_pseudo_opt(const char *submodule,
+				struct rev_info *revs,
+				int argc, const char **argv, int *flags)
+{
+	const char *arg = argv[0];
+	const char *optarg;
+	int argcount;
+
+	if (!strcmp(arg, "--all")) {
+		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
+		handle_refs(submodule, revs, *flags, head_ref_submodule);
+	} else if (!strcmp(arg, "--branches")) {
+		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
+	} else if (!strcmp(arg, "--bisect")) {
+		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
+		handle_refs(submodule, revs, *flags ^ UNINTERESTING, for_each_good_bisect_ref);
+		revs->bisect = 1;
+	} else if (!strcmp(arg, "--tags")) {
+		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
+	} else if (!strcmp(arg, "--remotes")) {
+		handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
+	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
+		struct all_refs_cb cb;
+		init_all_refs_cb(&cb, revs, *flags);
+		for_each_glob_ref(handle_one_ref, optarg, &cb);
+		return argcount;
+	} else if (!prefixcmp(arg, "--branches=")) {
+		struct all_refs_cb cb;
+		init_all_refs_cb(&cb, revs, *flags);
+		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+	} else if (!prefixcmp(arg, "--tags=")) {
+		struct all_refs_cb cb;
+		init_all_refs_cb(&cb, revs, *flags);
+		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+	} else if (!prefixcmp(arg, "--remotes=")) {
+		struct all_refs_cb cb;
+		init_all_refs_cb(&cb, revs, *flags);
+		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
+	} else if (!strcmp(arg, "--reflog")) {
+		handle_reflog(revs, *flags);
+	} else if (!strcmp(arg, "--not")) {
+		*flags ^= UNINTERESTING;
+	} else if (!strcmp(arg, "--no-walk")) {
+		revs->no_walk = 1;
+	} else if (!strcmp(arg, "--do-walk")) {
+		revs->no_walk = 0;
+	} else {
+		return 0;
+	}
+
+	return 1;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -1538,8 +1591,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0;
 	const char **prune_data = NULL;
 	const char *submodule = NULL;
-	const char *optarg;
-	int argcount;
 
 	if (opt)
 		submodule = opt->submodule;
@@ -1566,70 +1617,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		if (*arg == '-') {
 			int opts;
 
-			if (!strcmp(arg, "--all")) {
-				handle_refs(submodule, revs, flags, for_each_ref_submodule);
-				handle_refs(submodule, revs, flags, head_ref_submodule);
-				continue;
-			}
-			if (!strcmp(arg, "--branches")) {
-				handle_refs(submodule, revs, flags, for_each_branch_ref_submodule);
-				continue;
-			}
-			if (!strcmp(arg, "--bisect")) {
-				handle_refs(submodule, revs, flags, for_each_bad_bisect_ref);
-				handle_refs(submodule, revs, flags ^ UNINTERESTING, for_each_good_bisect_ref);
-				revs->bisect = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--tags")) {
-				handle_refs(submodule, revs, flags, for_each_tag_ref_submodule);
-				continue;
-			}
-			if (!strcmp(arg, "--remotes")) {
-				handle_refs(submodule, revs, flags, for_each_remote_ref_submodule);
-				continue;
-			}
-			if ((argcount = parse_long_opt("glob", argv + i, &optarg))) {
-				struct all_refs_cb cb;
-				i += argcount - 1;
-				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref(handle_one_ref, optarg, &cb);
-				continue;
-			}
-			if (!prefixcmp(arg, "--branches=")) {
-				struct all_refs_cb cb;
-				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
-				continue;
-			}
-			if (!prefixcmp(arg, "--tags=")) {
-				struct all_refs_cb cb;
-				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
-				continue;
-			}
-			if (!prefixcmp(arg, "--remotes=")) {
-				struct all_refs_cb cb;
-				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
-				continue;
-			}
-			if (!strcmp(arg, "--reflog")) {
-				handle_reflog(revs, flags);
-				continue;
-			}
-			if (!strcmp(arg, "--not")) {
-				flags ^= UNINTERESTING;
-				continue;
-			}
-			if (!strcmp(arg, "--no-walk")) {
-				revs->no_walk = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--do-walk")) {
-				revs->no_walk = 0;
+			opts = handle_revision_pseudo_opt(submodule,
+						revs, argc - i, argv + i,
+						&flags);
+			if (opts > 0) {
+				i += opts - 1;
 				continue;
 			}
+
 			if (!strcmp(arg, "--stdin")) {
 				if (revs->disable_stdin) {
 					argv[left++] = arg;
-- 
1.7.5.rc3
