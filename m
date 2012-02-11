From: mhagger@alum.mit.edu
Subject: [PATCH 5/7] everything_local(): mark alternate refs as complete
Date: Sat, 11 Feb 2012 07:20:59 +0100
Message-ID: <1328941261-29746-6-git-send-email-mhagger@alum.mit.edu>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 07:21:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw6L7-0001rt-Rp
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 07:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab2BKGV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 01:21:29 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50485 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2BKGV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 01:21:27 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED675.dip.t-dialin.net [84.190.214.117])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B6L6CF019131;
	Sat, 11 Feb 2012 07:21:19 +0100
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190491>

From: Michael Haggerty <mhagger@alum.mit.edu>

Objects in an alternate object database are already available to the
local repository and therefore don't need to be fetched.  So mark them
as complete in everything_local().

This fixes a test in t5700.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c       |    6 ++++++
 t/t5700-clone-reference.sh |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbe9acb..0e8560f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -581,6 +581,11 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	*refs = newlist;
 }
 
+static void mark_alternate_complete(const struct ref *ref, void *unused)
+{
+	mark_complete(NULL, ref->old_sha1, 0, NULL);
+}
+
 static int everything_local(struct ref **refs, int nr_match, char **match)
 {
 	struct ref *ref;
@@ -609,6 +614,7 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 
 	if (!args.depth) {
 		for_each_ref(mark_complete, NULL);
+		for_each_alternate_ref(mark_alternate_complete, NULL);
 		if (cutoff)
 			mark_recent_complete_commits(cutoff);
 	}
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 2dafee8..783f988 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -167,7 +167,7 @@ test_expect_success 'prepare branched repository' '
 
 rm -f "$U.K"
 
-test_expect_failure 'fetch with incomplete alternates' '
+test_expect_success 'fetch with incomplete alternates' '
 	git init K &&
 	echo "$base_dir/A/.git/objects" >K/.git/objects/info/alternates &&
 	(
-- 
1.7.9
