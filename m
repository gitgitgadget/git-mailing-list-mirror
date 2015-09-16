From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 2/2] notes: allow non-writable actions on refs outside of refs/notes
Date: Wed, 16 Sep 2015 15:06:34 -0700
Message-ID: <1442441194-5506-3-git-send-email-jacob.e.keller@intel.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
Cc: Mike Hommey <mh@glandium.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 00:06:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKqo-00007K-7b
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbbIPWGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:06:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:41186 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbbIPWGl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:06:41 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP; 16 Sep 2015 15:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,542,1437462000"; 
   d="scan'208";a="646257360"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.123])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2015 15:06:37 -0700
X-Mailer: git-send-email 2.6.0.rc2.248.g5b5be23
In-Reply-To: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278077>

From: Jacob Keller <jacob.keller@gmail.com>

Allow non-destructive notes actions which do not require write
permission to be performed on refs outside of refs/notes/. The primary
advantage of this is to allow fetching remote refs to such location as
"refs/remote-notes/<remote>/foo" and then performing merges into
refs/notes/

It is not reasonable to put remote notes inside refs/notes as users may
already have conflicting names inside the notes namespace.

Remove one test case regarding merge from refs/heads/master, which will
now pass under current code. It may be worth looking how to prevent
some of these more obviously wrong merges.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/notes.c        | 13 +++++--------
 t/t3308-notes-merge.sh |  1 -
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 0f55d38983f0..ff056014d953 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -333,14 +333,14 @@ static struct notes_tree *init_notes_check(const char *subcommand,
 					   int flags)
 {
 	struct notes_tree *t;
-	const char *ref;
 	init_notes(NULL, NULL, NULL, flags);
 	t = &default_notes_tree;
 
-	ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t->ref;
-	if (!starts_with(ref, "refs/notes/"))
-		die("Refusing to %s notes in %s (outside of refs/notes/)",
-		    subcommand, ref);
+	if (flags & NOTES_INIT_WRITABLE) {
+		if (!starts_with(t->update_ref, "refs/notes"))
+			die("Refusing to %s notes in %s (outside of refs/notes/)",
+			    subcommand, t->update_ref);
+	}
 	return t;
 }
 
@@ -810,9 +810,6 @@ static int merge(int argc, const char **argv, const char *prefix)
 	o.local_ref = default_notes_ref();
 	strbuf_addstr(&remote_ref, argv[0]);
 	expand_notes_ref(&remote_ref);
-	if (!starts_with(remote_ref.buf, "refs/notes"))
-		die("Refusing to merge notes from %s (outside of refs/notes/)",
-		    remote_ref.buf);
 
 	o.remote_ref = remote_ref.buf;
 
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 24d82b49bbea..f0feb64bae6e 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -90,7 +90,6 @@ test_expect_success 'fail to merge various non-note-trees' '
 	test_must_fail git notes merge refs/notes/ &&
 	test_must_fail git notes merge refs/notes/dir &&
 	test_must_fail git notes merge refs/notes/dir/ &&
-	test_must_fail git notes merge refs/heads/master &&
 	test_must_fail git notes merge x: &&
 	test_must_fail git notes merge x:foo &&
 	test_must_fail git notes merge foo^{bar
-- 
2.6.0.rc2.248.g5b5be23
