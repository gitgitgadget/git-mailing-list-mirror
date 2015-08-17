From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v8 8/8] notes: teach git-notes about notes.<ref>.mergeStrategy option
Date: Mon, 17 Aug 2015 01:46:31 -0700
Message-ID: <1439801191-3026-9-git-send-email-jacob.e.keller@intel.com>
References: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 10:47:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRG4s-0002pW-7H
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 10:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbbHQIr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 04:47:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:40512 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645AbbHQIrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 04:47:18 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 17 Aug 2015 01:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,693,1432623600"; 
   d="scan'208";a="770177876"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2015 01:47:16 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276042>

From: Jacob Keller <jacob.keller@gmail.com>

Add new option "notes.<ref>.mergeStrategy" option which specifies the merge
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
 builtin/notes.c                     | 14 ++++++++++++-
 t/t3309-notes-merge-auto-resolve.sh | 39 +++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 56e20446f587..a48c111d3ce0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1926,6 +1926,13 @@ notes.mergeStrategy::
 	STRATEGIES" section of linkgit:git-notes[1] for more information
 	on each strategy.
 
+notes.<localref>.mergeStrategy::
+	Which merge strategy to choose if the local ref for a notes merge
+	matches <localref>, overriding "notes.mergeStrategy". <localref> must
+	be the short name of a ref under refs/notes/. See the "NOTES MERGE
+	STRATEGIES" section in linkgit:git-notes[1] for more information on the
+	available strategies.
+
 notes.displayRef::
 	The (fully qualified) refname from which to show notes when
 	showing commit messages.  The value of this variable can be set
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 66b5017939c6..0167bc6e347b 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -328,6 +328,12 @@ notes.mergeStrategy::
 +
 This setting can be overridden by passing the `--strategy` option.
 
+notes.<localref>.mergeStrategy::
+	Which strategy to choose when merging into <localref>. The set of
+	allowed values is the same as "notes.mergeStrategy". <localref> must be
+	the short name of a ref under refs/notes/. See the "NOTES MERGE STRATEGIES"
+	section above for more information about each strategy.
+
 notes.displayRef::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
diff --git a/builtin/notes.c b/builtin/notes.c
index 91f7a6547b0f..3608c6478528 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -817,7 +817,19 @@ static int merge(int argc, const char **argv, const char *prefix)
 			usage_with_options(git_notes_merge_usage, options);
 		}
 	} else {
-		git_config_get_notes_strategy("notes.mergeStrategy", &o.strategy);
+		struct strbuf merge_key = STRBUF_INIT;
+		const char *short_ref = NULL;
+
+		if (!skip_prefix(o.local_ref, "refs/notes/", &short_ref))
+			die("BUG: local ref %s is outside of refs/notes/",
+			    o.local_ref);
+
+		strbuf_addf(&merge_key, "notes.%s.mergeStrategy", short_ref);
+
+		if (git_config_get_notes_strategy(merge_key.buf, &o.strategy))
+			git_config_get_notes_strategy("notes.mergeStrategy", &o.strategy);
+
+		strbuf_release(&merge_key);
 	}
 
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index 1bd71d947e60..44898ffba9fb 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -405,6 +405,17 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "ours" per-ref configuration option => Non-conflicting 3-way merge' '
+	git -c notes.y.mergeStrategy="ours" notes merge z &&
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
@@ -589,6 +600,34 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "union" strategy overriding per-ref configuration => Non-conflicting 3-way merge' '
+	git -c notes.y.mergeStrategy="theirs" notes merge --strategy=union z &&
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
+	git -c notes.y.mergeStrategy="union" -c notes.mergeStrategy="theirs" notes merge z &&
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
+	test_must_fail git -c notes.z.mergeStrategy="union" notes merge z &&
+	git notes merge --abort &&
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_union2
 d682107b8bf7a7aea1e537a8d5cb6a12b60135f1 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-- 
2.5.0.280.g4aaba03
