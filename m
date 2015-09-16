From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 1/2] notes: don't expand qualified refs in expand_notes_ref
Date: Wed, 16 Sep 2015 15:06:33 -0700
Message-ID: <1442441194-5506-2-git-send-email-jacob.e.keller@intel.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
Cc: Mike Hommey <mh@glandium.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 00:06:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKqu-0000HA-Jp
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbbIPWGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:06:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:14404 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832AbbIPWGl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:06:41 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP; 16 Sep 2015 15:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,542,1437462000"; 
   d="scan'208";a="646257359"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.123])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2015 15:06:37 -0700
X-Mailer: git-send-email 2.6.0.rc2.248.g5b5be23
In-Reply-To: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278078>

From: Jacob Keller <jacob.keller@gmail.com>

The documentation for --refs says that it will treat unqualified refs as
under refs/notes. Current behavior is to prefix refs/notes to all
strings that do not start with refs/notes or notes/, resulting in
performing actions on refs such as "refs/notes/refs/foo/bar" instead of
attempting to perform actions on "refs/foo/bar". A future patch will
introduce the idea of performing non-writable actions to refs outside of
refs/notes. Change the behavior of expand_notes_ref to leave qualified
refs under refs/* alone.

In addition, fix git notes merge <ref> to prevent merges from refs which
are not under refs/notes, in a similar way to how we already check note
refs in init_notes_check. This is required in order to keep current
tests passing without change. A future patch will change the behavior of
git notes merge so that it can merge from a ref outside of refs/notes.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/notes.c | 4 ++++
 notes.c         | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 6371d536d164..0f55d38983f0 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -810,6 +810,10 @@ static int merge(int argc, const char **argv, const char *prefix)
 	o.local_ref = default_notes_ref();
 	strbuf_addstr(&remote_ref, argv[0]);
 	expand_notes_ref(&remote_ref);
+	if (!starts_with(remote_ref.buf, "refs/notes"))
+		die("Refusing to merge notes from %s (outside of refs/notes/)",
+		    remote_ref.buf);
+
 	o.remote_ref = remote_ref.buf;
 
 	t = init_notes_check("merge", NOTES_INIT_WRITABLE);
diff --git a/notes.c b/notes.c
index 6ef347ca3ac4..d49168fb3f01 100644
--- a/notes.c
+++ b/notes.c
@@ -1296,8 +1296,8 @@ int copy_note(struct notes_tree *t,
 
 void expand_notes_ref(struct strbuf *sb)
 {
-	if (starts_with(sb->buf, "refs/notes/"))
-		return; /* we're happy */
+	if (starts_with(sb->buf, "refs/"))
+		return; /* fully qualified, so we're happy */
 	else if (starts_with(sb->buf, "notes/"))
 		strbuf_insert(sb, 0, "refs/", 5);
 	else
-- 
2.6.0.rc2.248.g5b5be23
