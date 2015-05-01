From: Jeff King <peff@peff.net>
Subject: [PATCH 12/12] for-each-ref: accept "%(push)" format
Date: Fri, 1 May 2015 18:56:45 -0400
Message-ID: <20150501225645.GL1534@peff.net>
References: <20150501224414.GA25551@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 00:56:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJrY-0005hb-4H
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbbEAW4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:56:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:53129 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750920AbbEAW4r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:56:47 -0400
Received: (qmail 24271 invoked by uid 102); 1 May 2015 22:56:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 17:56:47 -0500
Received: (qmail 21159 invoked by uid 107); 1 May 2015 22:57:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 18:57:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 18:56:45 -0400
Content-Disposition: inline
In-Reply-To: <20150501224414.GA25551@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268197>

Just as we have "%(upstream)" to report the "@{upstream}"
for each ref, this patch adds "%(push)" to match "@{push}".
It supports the same tracking format modifiers as upstream
(because you may want to know, for example, which branches
have commits to push).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-for-each-ref.txt |  6 ++++++
 builtin/for-each-ref.c             | 17 +++++++++++++++--
 t/t6300-for-each-ref.sh            | 13 ++++++++++++-
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 4240875..7f8d9a5 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -97,6 +97,12 @@ upstream::
 	or "=" (in sync).  Has no effect if the ref does not have
 	tracking information associated with it.
 
+push::
+	The name of a local ref which represents the `@{push}` location
+	for the displayed ref. Respects `:short`, `:track`, and
+	`:trackshort` options as `upstream` does. Produces an empty
+	string if no `@{push}` ref is configured.
+
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
 	otherwise.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 345d8dd..6847400 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -74,6 +74,7 @@ static struct {
 	{ "contents:body" },
 	{ "contents:signature" },
 	{ "upstream" },
+	{ "push" },
 	{ "symref" },
 	{ "flag" },
 	{ "HEAD" },
@@ -669,6 +670,16 @@ static void populate_value(struct refinfo *ref)
 			refname = branch_get_upstream(branch, NULL);
 			if (!refname)
 				continue;
+		} else if (starts_with(name, "push")) {
+			const char *branch_name;
+			if (!skip_prefix(ref->refname, "refs/heads/",
+					 &branch_name))
+				continue;
+			branch = branch_get(branch_name);
+
+			refname = branch_get_push(branch, NULL);
+			if (!refname)
+				continue;
 		} else if (starts_with(name, "color:")) {
 			char color[COLOR_MAXLEN] = "";
 
@@ -714,7 +725,8 @@ static void populate_value(struct refinfo *ref)
 				refname = shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
 			else if (!strcmp(formatp, "track") &&
-				 starts_with(name, "upstream")) {
+				 (starts_with(name, "upstream") ||
+				  starts_with(name, "push"))) {
 				char buf[40];
 
 				if (stat_tracking_info(branch, &num_ours,
@@ -736,7 +748,8 @@ static void populate_value(struct refinfo *ref)
 				}
 				continue;
 			} else if (!strcmp(formatp, "trackshort") &&
-				   starts_with(name, "upstream")) {
+				   (starts_with(name, "upstream") ||
+				    starts_with(name, "push"))) {
 				assert(branch);
 
 				if (stat_tracking_info(branch, &num_ours,
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c66bf79..24fc2ba 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -28,7 +28,10 @@ test_expect_success setup '
 	git update-ref refs/remotes/origin/master master &&
 	git remote add origin nowhere &&
 	git config branch.master.remote origin &&
-	git config branch.master.merge refs/heads/master
+	git config branch.master.merge refs/heads/master &&
+	git remote add myfork elsewhere &&
+	git config remote.pushdefault myfork &&
+	git config push.default current
 '
 
 test_atom() {
@@ -47,6 +50,7 @@ test_atom() {
 
 test_atom head refname refs/heads/master
 test_atom head upstream refs/remotes/origin/master
+test_atom head push refs/remotes/myfork/master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -83,6 +87,7 @@ test_atom head HEAD '*'
 
 test_atom tag refname refs/tags/testtag
 test_atom tag upstream ''
+test_atom tag push ''
 test_atom tag objecttype tag
 test_atom tag objectsize 154
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
@@ -347,6 +352,12 @@ test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	test_cmp expected actual
 '
 
+test_expect_success '%(push) supports tracking specifiers, too' '
+	echo "[ahead 1]" >expected &&
+	git for-each-ref --format="%(push:track)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 $(git rev-parse --short HEAD)
 EOF
-- 
2.4.0.rc3.477.gc25258d
