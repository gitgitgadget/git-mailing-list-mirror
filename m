From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Tue, 11 Aug 2015 13:57:21 -0700
Message-ID: <1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 22:57:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPGcC-0003uD-Ap
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 22:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbbHKU5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 16:57:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:25468 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932871AbbHKU5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 16:57:31 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP; 11 Aug 2015 13:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,655,1432623600"; 
   d="scan'208";a="782214977"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2015 13:57:31 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
In-Reply-To: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275728>

From: Jacob Keller <jacob.keller@gmail.com>

Add new option "notes.<ref>.merge" option which specifies the merge
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
 Documentation/config.txt            |  6 ++++++
 Documentation/git-notes.txt         |  6 ++++++
 builtin/notes.c                     |  7 +++++--
 t/t3309-notes-merge-auto-resolve.sh | 39 +++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 488c2e8eec1b..2c283ebc309e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1912,6 +1912,12 @@ notes.merge::
 	STRATEGIES" section of linkgit:git-notes[1] for more information
 	on each strategy.
 
+notes.<localref>.merge::
+	Which merge strategy to choose if the local ref for a notes merge
+	matches <localref>, overriding "notes.merge". <localref> just be a
+	fully qualified refname. See "NOTES MERGE STRATEGIES" section in
+	linkgit:git-notes[1] for more information on the available strategies.
+
 notes.displayRef::
 	The (fully qualified) refname from which to show notes when
 	showing commit messages.  The value of this variable can be set
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 9c4f8536182f..68fae8d22555 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -322,6 +322,12 @@ notes.merge::
 +
 This setting can be overridden by passing the `--strategy` option.
 
+notes.<localref>.merge::
+	Which strategy to choose when merging into <localref>. The set of
+	allowed values is the same as "notes.merge". <localref> must be a fully
+	qualified refname. See "NOTES MERGE STRATEGIES" section above for more
+	information about each strategy.
+
 notes.displayRef::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
diff --git a/builtin/notes.c b/builtin/notes.c
index 3c705f5e26ff..2f2d7e87ef47 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -757,7 +757,7 @@ static int parse_notes_strategy(const char *arg, enum notes_merge_strategy *stra
 
 static int merge(int argc, const char **argv, const char *prefix)
 {
-	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
+	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT, merge_key = STRBUF_INIT;
 	unsigned char result_sha1[20];
 	struct notes_tree *t;
 	struct notes_merge_options o;
@@ -813,7 +813,10 @@ static int merge(int argc, const char **argv, const char *prefix)
 	expand_notes_ref(&remote_ref);
 	o.remote_ref = remote_ref.buf;
 
-	git_config_get_string_const("notes.merge", &configured_strategy);
+	strbuf_addf(&merge_key, "notes.%s.merge", o.local_ref);
+
+	if (git_config_get_string_const(merge_key.buf, &configured_strategy))
+		git_config_get_string_const("notes.merge", &configured_strategy);
 
 	if (configured_strategy &&
 	    parse_notes_strategy(configured_strategy, &o.strategy))
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index a773b01b73db..b0bbc0a6bac2 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -383,6 +383,17 @@ test_expect_success 'reset to pre-merge state (y)' '
 	verify_notes y y
 '
 
+test_expect_success 'merge z into y with "ours" per-ref configuration option => Non-conflicting 3-way merge' '
+	git -c notes.refs/notes/y.merge="ours" notes merge z &&
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
+	git -c notes.refs/notes/y.merge="theirs" notes merge --strategy=union z &&
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
+	git -c notes.refs/notes/y.merge="union" -c notes.merge="theirs" notes merge z &&
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
+	test_must_fail git -c notes.refs/notes/z.merge="union" notes merge z &&
+	git notes merge --abort &&
+	verify_notes y y
+'
+
 cat <<EOF | sort >expect_notes_union2
 d682107b8bf7a7aea1e537a8d5cb6a12b60135f1 $commit_sha15
 5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-- 
2.5.0.482.gfcd5645
