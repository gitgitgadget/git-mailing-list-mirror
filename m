From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/12] merge-recursive --renormalize
Date: Thu, 5 Aug 2010 06:32:41 -0500
Message-ID: <20100805113240.GN13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:34:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogyir-0003hz-7l
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174Ab0HELet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 07:34:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39236 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933159Ab0HELeq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:34:46 -0400
Received: by iwn33 with SMTP id 33so99637iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bEzVWnQ665jb7NjEFKjjmnpJUekgT4Gz+RfDr3JxwY4=;
        b=chgztxcp+ZOWXCtY29gl1GqhA9uYM2cHcq6LP7HMa7D7XiytuqZbBLayjIx3ZMoTO3
         cWjx6pwb47pQLzQoo2+gFS5rQrf8QkodjDJs/Kkt0WcEJTBUtjIb80OFPCpdMsO14u32
         /WLee+tDPgUcCD9kkzGoWSL0S7IU7QtHJ1/1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=COk/BjYa7YlW/K0rB4FyIatgv39NcGhn3+ing5/kBOiRp4l5nbViDfhhhVMCYoiHfC
         9aZtqlPAEYqpRD5rnDQTHi7fQqJA3F8wwZKR3A/Ir1QJc7PyvlJ+9Z7jEdjcYE1nmRyI
         GNURtUPc7XN9WNaa8KVizs1qD11vOXbv9ijKw=
Received: by 10.231.37.75 with SMTP id w11mr3927512ibd.45.1281008045893;
        Thu, 05 Aug 2010 04:34:05 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 34sm63575ibi.6.2010.08.05.04.34.05
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:34:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152644>

Teach "git merge-recursive" a --renormalize option to enable the
merge.renormalize configuration.  The --no-renormalize option can
be used to override it in the negative.

So in the future, you might be able to, e.g.:

	git checkout -m -Xrenormalize otherbranch

or

	git revert -Xrenormalize otherpatch

or

	git pull --rebase -Xrenormalize

The bad part: merge.renormalize is still not honored for most
commands.  And it reveals lots of places that -X has not been plumbed
in (so we get "git merge -Xrenormalize" but not much else).

NEEDSWORK: tests

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 - Commit message is rewritten
 - Introduce --no-renormalize, too
 - Adapt to rerere=E2=80=99s new lack of support for --renormalize

That=E2=80=99s it for this round.  Thanks again.

 Documentation/merge-strategies.txt |   12 ++++++++++++
 builtin/checkout.c                 |    7 +++++++
 builtin/merge-recursive.c          |    4 ++++
 builtin/merge.c                    |   19 ++++++++++++++-----
 builtin/revert.c                   |    7 +++++++
 cache.h                            |    1 -
 environment.c                      |    1 -
 merge-recursive.c                  |    2 +-
 8 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-s=
trategies.txt
index a5bc1db..049313d 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -40,6 +40,18 @@ the other tree did, declaring 'our' history contains=
 all that happened in it.
 theirs;;
 	This is opposite of 'ours'.
=20
+renormalize;;
+	This runs a virtual check-out and check-in of all three stages
+	of a file when resolving a three-way merge.  This option is
+	meant to be used when merging branches with different clean
+	filters or end-of-line normalization rules.  See "Merging
+	branches with differing checkin/checkout attributes" in
+	linkgit:gitattributes[5] for details.
+
+no-renormalize;;
+	Disables the `renormalize` option.  This overrides the
+	`merge.renormalize` configuration variable.
+
 subtree[=3Dpath];;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a0c00d3..24b67d5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -437,6 +437,13 @@ static int merge_working_tree(struct checkout_opts=
 *opts,
 			 */
=20
 			add_files_to_cache(NULL, NULL, 0);
+			/*
+			 * NEEDSWORK: carrying over local changes
+			 * when branches have different end-of-line
+			 * normalization (or clean+smudge rules) is
+			 * a pain; plumb in an option to set
+			 * o.renormalize?
+			 */
 			init_merge_options(&o);
 			o.verbosity =3D 0;
 			work =3D write_tree_from_memory(&o);
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index d8875d5..c2d4677 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -45,6 +45,10 @@ int cmd_merge_recursive(int argc, const char **argv,=
 const char *prefix)
 				o.subtree_shift =3D "";
 			else if (!prefixcmp(arg+2, "subtree=3D"))
 				o.subtree_shift =3D arg + 10;
+			else if (!strcmp(arg+2, "renormalize"))
+				o.renormalize =3D 1;
+			else if (!strcmp(arg+2, "no-renormalize"))
+				o.renormalize =3D 0;
 			else
 				die("Unknown option %s", arg);
 			continue;
diff --git a/builtin/merge.c b/builtin/merge.c
index b836e9c..037cd47 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -54,6 +54,7 @@ static size_t use_strategies_nr, use_strategies_alloc=
;
 static const char **xopts;
 static size_t xopts_nr, xopts_alloc;
 static const char *branch;
+static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
=20
@@ -503,9 +504,8 @@ static int git_merge_config(const char *k, const ch=
ar *v, void *cb)
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
 		option_log =3D git_config_bool(k, v);
-	else if (!strcmp(k, "merge.renormalize")) {
-		merge_renormalize =3D git_config_bool(k, v);
-	}
+	else if (!strcmp(k, "merge.renormalize"))
+		option_renormalize =3D git_config_bool(k, v);
 	return git_diff_ui_config(k, v, cb);
 }
=20
@@ -627,6 +627,11 @@ static int try_merge_strategy(const char *strategy=
, struct commit_list *common,
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift =3D "";
=20
+		o.renormalize =3D option_renormalize;
+
+		/*
+		 * NEEDSWORK: merge with table in builtin/merge-recursive
+		 */
 		for (x =3D 0; x < xopts_nr; x++) {
 			if (!strcmp(xopts[x], "ours"))
 				o.recursive_variant =3D MERGE_RECURSIVE_OURS;
@@ -636,6 +641,10 @@ static int try_merge_strategy(const char *strategy=
, struct commit_list *common,
 				o.subtree_shift =3D "";
 			else if (!prefixcmp(xopts[x], "subtree=3D"))
 				o.subtree_shift =3D xopts[x]+8;
+			else if (!strcmp(xopts[x], "renormalize"))
+				o.renormalize =3D 1;
+			else if (!strcmp(xopts[x], "no-renormalize"))
+				o.renormalize =3D 0;
 			else
 				die("Unknown option for merge-recursive: -X%s", xopts[x]);
 		}
@@ -819,7 +828,7 @@ static int finish_automerge(struct commit_list *com=
mon,
 	return 0;
 }
=20
-static int suggest_conflicts(void)
+static int suggest_conflicts(int renormalizing)
 {
 	FILE *fp;
 	int pos;
@@ -1304,5 +1313,5 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 			"stopped before committing as requested\n");
 		return 0;
 	} else
-		return suggest_conflicts();
+		return suggest_conflicts(option_renormalize);
 }
diff --git a/builtin/revert.c b/builtin/revert.c
index 853e9e4..1113253 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -318,6 +318,13 @@ static void do_recursive_merge(struct commit *base=
, struct commit *next,
 	index_fd =3D hold_locked_index(&index_lock, 1);
=20
 	read_cache();
+
+	/*
+	 * NEEDSWORK: cherry-picking between branches with
+	 * different end-of-line normalization is a pain;
+	 * plumb in an option to set o.renormalize?
+	 * (or better: arbitrary -X options)
+	 */
 	init_merge_options(&o);
 	o.ancestor =3D base ? base_label : "(empty tree)";
 	o.branch1 =3D "HEAD";
diff --git a/cache.h b/cache.h
index ed73da8..aa725b0 100644
--- a/cache.h
+++ b/cache.h
@@ -551,7 +551,6 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
-extern int merge_renormalize;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/environment.c b/environment.c
index 81a3682..83d38d3 100644
--- a/environment.c
+++ b/environment.c
@@ -53,7 +53,6 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
-int merge_renormalize;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 23f7a4d..762b549 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1486,7 +1486,7 @@ void init_merge_options(struct merge_options *o)
 	o->buffer_output =3D 1;
 	o->diff_rename_limit =3D -1;
 	o->merge_rename_limit =3D -1;
-	o->renormalize =3D merge_renormalize;
+	o->renormalize =3D 0;
 	git_config(merge_recursive_config, o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =3D
--=20
1.7.2.1.544.ga752d.dirty
