From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v7 4/4] notes: teach git-notes about notes.<ref>.mergestrategy option
Date: Fri, 14 Aug 2015 14:13:55 -0700
Message-ID: <1439586835-15712-5-git-send-email-jacob.e.keller@intel.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 23:14:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQMIx-0005z1-JV
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbbHNVOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:14:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:41144 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbbHNVOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:14:18 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 14 Aug 2015 14:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,680,1432623600"; 
   d="scan'208";a="784359585"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2015 14:13:57 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275957>

From: Jacob Keller <jacob.keller@gmail.com>

Add new option "notes.<ref>.mergestrategy" option which specifies the merge
strategy for merging into a given notes ref. This option enables
selection of merge strategy for particular notes refs, rather than all
notes ref merges, as user may not want cat_sort_uniq for all refs, but
only some. Note that the <ref> is the local reference we are merging
into, not the remote ref we merged from. The assumption is that users
will mostly want to configure separate local ref merge strategies rather
than strategies depending on which remote ref they merge from. Also,
notes.<ref>.merge overrides the general behavior as it is more specific.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config.txt            |  7 +++++++
 Documentation/git-notes.txt         |  6 ++++++
 builtin/notes.c                     | 13 ++++++++++---
 t/t3309-notes-merge-auto-resolve.sh | 39 +++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5e3e03459de7..47478311367e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1926,6 +1926,13 @@ notes.mergestrategy::
 	STRATEGIES" section of linkgit:git-notes[1] for more information
 	on each strategy.
 
+notes.<localref>.mergestrategy::
+	Which merge strategy to choose if the local ref for a notes merge
+	matches <localref>, overriding "notes.mergestrategy". <localref> must
+	be the short name of a ref under refs/notes/. See "NOTES MERGE
+	STRATEGIES" section in linkgit:git-notes[1] for more information on the
+	available strategies.
+
 notes.displayRef::
 	The (fully qualified) refname from which to show notes when
 	showing commit messages.  The value of this variable can be set
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 89c8829a0543..b99809fc81a6 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -322,6 +322,12 @@ notes.mergestrategy::
 +
 This setting can be overridden by passing the `--strategy` option.
 
+notes.<localref>.mergestrategy::
+	Which strategy to choose when merging into <localref>. The set of
+	allowed values is the same as "notes.mergestrategy". <localref> must be
+	the short name of a ref under refs/notes/. See "NOTES MERGE STRATEGIES"
+	section above for more information about each strategy.
+
 notes.displayRef::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
diff --git a/builtin/notes.c b/builtin/notes.c
index 12a42b583f98..bdfd9c7d29b4 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -771,13 +771,13 @@ static int git_config_get_notes_strategy(const char *key,
 
 static int merge(int argc, const char **argv, const char *prefix)
 {
-	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
+	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT, merge_key = STRBUF_INIT;
 	unsigned char result_sha1[20];
 	struct notes_tree *t;
 	struct notes_merge_options o;
 	int do_merge = 0, do_commit = 0, do_abort = 0;
 	int verbosity = 0, result;
-	const char *strategy = NULL;
+	const char *strategy = NULL, *short_ref = NULL;
 	struct option options[] = {
 		OPT_GROUP(N_("General options")),
 		OPT__VERBOSITY(&verbosity),
@@ -833,7 +833,14 @@ static int merge(int argc, const char **argv, const char *prefix)
 			usage_with_options(git_notes_merge_usage, options);
 		}
 	} else {
-		git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);
+		if (!skip_prefix(o.local_ref, "refs/notes/", &short_ref))
+			die("Refusing to merge notes into %s (outside of refs/notes/)",
+			    o.local_ref);
+
+		strbuf_addf(&merge_key, "notes.%s.mergestrategy", short_ref);
+
+		if (git_config_get_notes_strategy(merge_key.buf, &o.strategy))
+			git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);
 	}
 
 	t = init_notes_check("merge");
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index 476b9f5306f1..560e75259798 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -383,6 +383,17 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "ours" per-ref configuration option => Non-conflicting 3-way merge' '
+	git -c notes.y.mergestrategy="ours" notes merge z &&
+	verify_notes y ours
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_theirs
 9b4b2c61f0615412da3c10f98ff85b57c04ec765 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
@@ -534,6 +545,34 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "union" strategy overriding per-ref configuration => Non-conflicting 3-way merge' '
+	git -c notes.y.mergestrategy="theirs" notes merge --strategy=union z &&
+	verify_notes y union
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
+test_expect_success 'merge z into y with "union" per-ref overriding general configuration => Non-conflicting 3-way merge' '
+	git -c notes.y.mergestrategy="union" -c notes.mergestrategy="theirs" notes merge z &&
+	verify_notes y union
+'
+
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
+test_expect_success 'merge z into y with "manual" per-ref only checks specific ref configuration => Conflicting 3-way merge' '
+	test_must_fail git -c notes.z.mergestrategy="union" notes merge z &&
+	git notes merge --abort &&
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_union2
 d682107b8bf7a7aea1e537a8d5cb6a12b60135f1 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-- 
2.5.0.280.g4aaba03
