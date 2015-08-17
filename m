From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v9 6/6] notes: teach git-notes about notes.<name>.mergeStrategy option
Date: Mon, 17 Aug 2015 14:33:34 -0700
Message-ID: <1439847214-2980-7-git-send-email-jacob.e.keller@intel.com>
References: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 23:33:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRS2V-0003aM-II
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 23:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbbHQVdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 17:33:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:43514 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbbHQVdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 17:33:38 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,697,1432623600"; 
   d="scan'208";a="785910993"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276095>

From: Jacob Keller <jacob.keller@gmail.com>

Teach notes about a new "notes.<name>.mergeStrategy" option for
configuring the notes merge strategy when merging into
refs/notes/<name>. This option allows for the selection of merge
strategy for particular notes refs, rather than all notes ref merges, as
user may not want cat_sort_uniq for all refs, but only some. Note that
the <name> is the local reference we are merging into, not the remote
ref we merged from. The assumption is that users will mostly want to
configure separate local ref merge strategies rather than strategies
depending on which remote ref they merge from.

notes.<name>.mergeStrategy overrides the general behavior as it is more
specific.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config.txt            |  6 ++++++
 Documentation/git-notes.txt         |  6 ++++++
 builtin/notes.c                     | 14 ++++++++++++-
 t/t3309-notes-merge-auto-resolve.sh | 39 +++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2ff3ed64a4d4..f60a9101df31 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1925,6 +1925,12 @@ notes.mergeStrategy::
 	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
 	section of linkgit:git-notes[1] for more information on each strategy.
 
+notes.<name>.mergeStrategy::
+	Which merge strategy to choose when doing a notes merge into
+	refs/notes/<name>.  This overrides the more general
+	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section in
+	linkgit:git-notes[1] for more information on the available strategies.
+
 notes.displayRef::
 	The (fully qualified) refname from which to show notes when
 	showing commit messages.  The value of this variable can be set
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 71453d4a700f..a9a916f360ec 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -322,6 +322,12 @@ notes.mergeStrategy::
 +
 This setting can be overridden by passing the `--strategy` option.
 
+notes.<name>.mergeStrategy::
+	Which merge strategy to choose when doing a notes merge into
+	refs/notes/<name>.  This overrides the more general
+	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section above
+	for more information on each available strategy.
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
index 1cd047f8d75f..14c2adf970d7 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -383,6 +383,17 @@ test_expect_success 'reset to pre-merge state (y)' '
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
@@ -534,6 +545,34 @@ test_expect_success 'reset to pre-merge state (y)' '
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
