From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/6] merge-recursive: add -Xrenormalize option
Date: Tue, 3 Aug 2010 22:29:37 -0500
Message-ID: <20100804032937.GG19699@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 05:31:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgUh7-0002BK-Vf
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 05:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758004Ab0HDDa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 23:30:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55705 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298Ab0HDDaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 23:30:55 -0400
Received: by gyg10 with SMTP id 10so1806803gyg.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 20:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5UVZOSkgHgQYrFNz9Ci1baVS4MtKYIhcm8rbvFw/d68=;
        b=A0QQUuAgInSoaI1V+GbOKXhoG29AFbSZcIJhKYvGBNyfi5mDRreOCXDaHNcbTT0ubi
         K/W4Kry+HwCz+5l9S3IhP5MTWZM4R1W/lctqCZvtQuVsL90zQP5mHnpGtmv9sLcLXomE
         /8s4uLaI0I4k2xu6tIw3PgnT+aSlOn4mcyBUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=s5HnOBFApue6HzvWkWDT0D0PPnVoNNpgCsJV8fIRp+irfElGuKTg3UKrtOgdjCzzWY
         gfs/AEm+byNcI9ltEOPfku8mykSlhr/XsZOGhw7Fvs14Aucep+ChYCrIPKwBLuqXctcv
         a5lV3zYd19QUb/19b95XSMfL8UBBjV1PSqWbs=
Received: by 10.150.52.11 with SMTP id z11mr9472316ybz.160.1280892654951;
        Tue, 03 Aug 2010 20:30:54 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id t2sm427196yba.14.2010.08.03.20.30.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 20:30:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100804031935.GA19699@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152561>

This adds a -Xrenormalize option to override the
merge.renormalize configuration.  There is no way to override
it in the negative yet, but hopefully this suggests how.

The good part: this destroys the global merge_renormalize
variable.

The bad part: merge.renormalize is still not honored for
most commands.  And it reveals lots of places that -X has not
been plumbed in.

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
There you have it.  As I said, this is pretty rough.  Places I would
be happy to see this go:

 - add tests and documentation
 - -Xno-renormalize to override [merge] renormalize in the negative
 - checkout -X and rerere -X

I probably will not have time to work on this topic again for a while,
so I would be very happy if someone takes ideas from it and takes it
somewhere else before I get a chance.  If there are just minor
cleanups to do, I can maintain this series for a short while, though.

Thoughts?

 Documentation/merge-strategies.txt |    8 ++++++++
 builtin/checkout.c                 |    7 +++++++
 builtin/merge-recursive.c          |    2 ++
 builtin/merge.c                    |   19 +++++++++++++------
 builtin/revert.c                   |    7 +++++++
 cache.h                            |    1 -
 environment.c                      |    1 -
 merge-recursive.c                  |    2 +-
 8 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index a5bc1db..350c3c7 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -40,6 +40,14 @@ the other tree did, declaring 'our' history contains all that happened in it.
 theirs;;
 	This is opposite of 'ours'.
 
+renormalize;;
+	This runs a virtual check-out and check-in of all three stages
+	of a file when resolving a three-way merge.  This option is
+	meant to be used when merging branches with different clean
+	filters or end-of-line normalization rules.  See "Merging
+	branches with differing checkin/checkout attributes" in
+	linkgit:gitattributes[5] for details.
+
 subtree[=path];;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5a7ae03..00fd4cd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -437,6 +437,13 @@ static int merge_working_tree(struct checkout_opts *opts,
 			 */
 
 			add_files_to_cache(NULL, NULL, 0);
+			/*
+			 * NEEDSWORK: carrying over local changes
+			 * when branches have different end-of-line
+			 * normalization (or clean+smudge rules) is
+			 * a pain; plumb in an option to set
+			 * o.renormalize?
+			 */
 			init_merge_options(&o);
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index d8875d5..2cc84d9 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -45,6 +45,8 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 				o.subtree_shift = "";
 			else if (!prefixcmp(arg+2, "subtree="))
 				o.subtree_shift = arg + 10;
+			else if (!strcmp(arg+2, "renormalize"))
+				o.renormalize = 1;
 			else
 				die("Unknown option %s", arg);
 			continue;
diff --git a/builtin/merge.c b/builtin/merge.c
index 823b76b..ad0aa5a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -54,6 +54,7 @@ static size_t use_strategies_nr, use_strategies_alloc;
 static const char **xopts;
 static size_t xopts_nr, xopts_alloc;
 static const char *branch;
+static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 
@@ -503,9 +504,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
 		option_log = git_config_bool(k, v);
-	else if (!strcmp(k, "merge.renormalize")) {
-		merge_renormalize = git_config_bool(k, v);
-	}
+	else if (!strcmp(k, "merge.renormalize"))
+		option_renormalize = git_config_bool(k, v);
 	return git_diff_ui_config(k, v, cb);
 }
 
@@ -627,6 +627,11 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
+		o.renormalize = option_renormalize;
+
+		/*
+		 * NEEDSWORK: merge with table in builtin/merge-recursive
+		 */
 		for (x = 0; x < xopts_nr; x++) {
 			if (!strcmp(xopts[x], "ours"))
 				o.recursive_variant = MERGE_RECURSIVE_OURS;
@@ -636,6 +641,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				o.subtree_shift = "";
 			else if (!prefixcmp(xopts[x], "subtree="))
 				o.subtree_shift = xopts[x]+8;
+			else if (!strcmp(xopts[x], "renormalize"))
+				o.renormalize = 1;
 			else
 				die("Unknown option for merge-recursive: -X%s", xopts[x]);
 		}
@@ -819,7 +826,7 @@ static int finish_automerge(struct commit_list *common,
 	return 0;
 }
 
-static int suggest_conflicts(void)
+static int suggest_conflicts(int renormalizing)
 {
 	FILE *fp;
 	int pos, flag;
@@ -842,7 +849,7 @@ static int suggest_conflicts(void)
 	}
 	fclose(fp);
 	flag = allow_rerere_auto;
-	if (merge_renormalize)
+	if (renormalizing)
 		flag |= RERERE_RENORMALIZE;
 	rerere(flag);
 	printf("Automatic merge failed; "
@@ -1307,5 +1314,5 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			"stopped before committing as requested\n");
 		return 0;
 	} else
-		return suggest_conflicts();
+		return suggest_conflicts(option_renormalize);
 }
diff --git a/builtin/revert.c b/builtin/revert.c
index c694801..1999252 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -318,6 +318,13 @@ static void do_recursive_merge(struct commit *base, struct commit *next,
 	index_fd = hold_locked_index(&index_lock, 1);
 
 	read_cache();
+
+	/*
+	 * NEEDSWORK: cherry-picking between branches with
+	 * different end-of-line normalization is a pain;
+	 * plumb in an option to set o.renormalize?
+	 * (or better: arbitrary -X options)
+	 */
 	init_merge_options(&o);
 	o.ancestor = base ? base_label : "(empty tree)";
 	o.branch1 = "HEAD";
diff --git a/cache.h b/cache.h
index ed73da8..aa725b0 100644
--- a/cache.h
+++ b/cache.h
@@ -551,7 +551,6 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
-extern int merge_renormalize;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/environment.c b/environment.c
index 81a3682..83d38d3 100644
--- a/environment.c
+++ b/environment.c
@@ -53,7 +53,6 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
-int merge_renormalize;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 4838939..73f2768 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1485,7 +1485,7 @@ void init_merge_options(struct merge_options *o)
 	o->buffer_output = 1;
 	o->diff_rename_limit = -1;
 	o->merge_rename_limit = -1;
-	o->renormalize = merge_renormalize;
+	o->renormalize = 0;
 	git_config(merge_recursive_config, o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =
-- 
1.7.2.1.544.ga752d.dirty
