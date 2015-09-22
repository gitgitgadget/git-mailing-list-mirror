From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2] notes: correct documentation of DWIMery for notes references
Date: Tue, 22 Sep 2015 15:15:03 -0700
Message-ID: <1442960103-22515-1-git-send-email-jacob.e.keller@intel.com>
Cc: Mike Hommey <mh@glandium.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 00:15:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeVqE-0000Z2-JD
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 00:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759654AbbIVWPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 18:15:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:60681 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759478AbbIVWPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 18:15:07 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP; 22 Sep 2015 15:15:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,574,1437462000"; 
   d="scan'208";a="566532678"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.123])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2015 15:15:05 -0700
X-Mailer: git-send-email 2.6.0.rc3.238.gc07a1e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278445>

From: Jacob Keller <jacob.keller@gmail.com>

expand_notes_ref is used by --ref from git-notes(1) and --notes from the
git log to find the full refname of a notes reference. Previously the
documentation of these options was not clear about what sorts of
expansions would be performed. Fix the documentation to clearly and
accurately describe the behavior of the expansions.

Add a test for this expansion when using git notes get-ref in order to
prevent future patches from changing this behavior.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-notes.txt      | 4 +++-
 Documentation/pretty-options.txt | 5 +++--
 t/t3301-notes.sh                 | 6 ++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index a9a916f360ec..8de349968a3b 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -162,7 +162,9 @@ OPTIONS
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	'GIT_NOTES_REF' and the "core.notesRef" configuration.  The ref
-	is taken to be in `refs/notes/` if it is not qualified.
+	specifies the full refname when it begins with `refs/notes/`; when it
+	begins with `notes/`, `refs/` and otherwise `refs/notes/` is prefixed
+	to form a full name of the ref.
 
 --ignore-missing::
 	Do not consider it an error to request removing notes from an
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 8d6c5cec4c5e..4b659ac1a6a6 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -55,8 +55,9 @@ By default, the notes shown are from the notes refs listed in the
 environment overrides). See linkgit:git-config[1] for more details.
 +
 With an optional '<ref>' argument, show this notes ref instead of the
-default notes ref(s). The ref is taken to be in `refs/notes/` if it
-is not qualified.
+default notes ref(s). The ref specifies the full refname when it begins
+with `refs/notes/`; when it begins with `notes/`, `refs/` and otherwise
+`refs/notes/` is prefixed to form a full name of the ref.
 +
 Multiple --notes options can be combined to control which notes are
 being displayed. Examples: "--notes=foo" will show only notes from
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 06b45847c147..2d200fdf36c6 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1132,6 +1132,12 @@ test_expect_success 'git notes copy diagnoses too many or too few parameters' '
 	test_must_fail git notes copy one two three
 '
 
+test_expect_success 'git notes get-ref expands refs/heads/master to refs/notes/refs/heads/master' '
+	test_unconfig core.notesRef &&
+	sane_unset GIT_NOTES_REF &&
+	test "$(git notes --ref=refs/heads/master get-ref)" = "refs/notes/refs/heads/master"
+'
+
 test_expect_success 'git notes get-ref (no overrides)' '
 	test_unconfig core.notesRef &&
 	sane_unset GIT_NOTES_REF &&
-- 
2.6.0.rc3.238.gc07a1e8
