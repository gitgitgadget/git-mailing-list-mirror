From: Mike Crowe <mac@mcrowe.com>
Subject: [PATCH v2] describe: Add --first-parent option
Date: Fri, 17 May 2013 21:56:18 +0100
Message-ID: <1368824178-15596-1-git-send-email-mac@mcrowe.com>
Cc: Mike Crowe <mac@mcrowe.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 22:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdRhY-0002mY-5i
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 22:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783Ab3EQU41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 16:56:27 -0400
Received: from cpc6-cmbg17-2-0-cust487.5-4.cable.virginmedia.com ([86.30.57.232]:49462
	"EHLO elite.brightsigndigital.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755361Ab3EQU41 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 May 2013 16:56:27 -0400
Received: from lander.brightsign ([172.30.1.6])
	by elite.brightsigndigital.co.uk with esmtp (Exim 4.72)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1UdRhP-0001cY-Jz; Fri, 17 May 2013 21:56:23 +0100
Received: from mac by lander.brightsign with local (Exim 4.72)
	(envelope-from <mac@lander.brightsign>)
	id 1UdRhP-000489-1S; Fri, 17 May 2013 21:56:23 +0100
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224737>

Only consider the first parent commit when walking the commit history. This
is useful if you only wish to match tags on your branch after a merge.

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---
 Documentation/git-describe.txt |    9 ++++++++-
 builtin/describe.c             |    5 +++++
 t/t6120-describe.sh            |    3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 28e5ec0..9439cd6 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -88,6 +88,11 @@ OPTIONS
 --always::
 	Show uniquely abbreviated commit object as fallback.
 
+--first-parent::
+	Follow only the first parent commit upon seeing a merge commit.
+	This is useful when you wish to not match tags on branches merged
+	in the history of the target commit.
+
 EXAMPLES
 --------
 
@@ -149,7 +154,9 @@ is found, its name will be output and searching will stop.
 If an exact match was not found, 'git describe' will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
-abbreviation of the input committish's SHA-1.
+abbreviation of the input committish's SHA-1. If '--first-parent' was
+specified then the walk will only consider the first parent of each
+commit.
 
 If multiple tags were found during the walk then the tag which
 has the fewest commits different from the input committish will be
diff --git a/builtin/describe.c b/builtin/describe.c
index 6636a68..ad84716 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -21,6 +21,7 @@ static int debug;	/* Display lots of verbose info */
 static int all;	/* Any valid ref can be used */
 static int tags;	/* Allow lightweight tags */
 static int longformat;
+static int first_parent;
 static int abbrev = -1; /* unspecified */
 static int max_candidates = 10;
 static struct hash_table names;
@@ -336,6 +337,9 @@ static void describe(const char *arg, int last_one)
 				commit_list_insert_by_date(p, &list);
 			p->object.flags |= c->object.flags;
 			parents = parents->next;
+
+			if (first_parent)
+				break;
 		}
 	}
 
@@ -404,6 +408,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "all",        &all, N_("use any ref")),
 		OPT_BOOLEAN(0, "tags",       &tags, N_("use any tag, even unannotated")),
 		OPT_BOOLEAN(0, "long",       &longformat, N_("always use long format")),
+		OPT_BOOLEAN(0, "first-parent", &first_parent, N_("only follow first parent")),
 		OPT__ABBREV(&abbrev),
 		OPT_SET_INT(0, "exact-match", &max_candidates,
 			    N_("only output exact matches"), 0),
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index f67aa6f..a25729f 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -110,6 +110,9 @@ check_describe tags/e --all HEAD^^^
 check_describe B-0-* --long HEAD^^2^
 check_describe A-3-* --long HEAD^^2
 
+check_describe c-7-* --tags
+check_describe e-3-* --first-parent --tags
+
 : >err.expect
 check_describe A --all A^0
 test_expect_success 'no warning was displayed for A' '
-- 
1.7.10.4
