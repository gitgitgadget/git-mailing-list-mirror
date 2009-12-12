From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC] ignore unknown color configuration
Date: Sat, 12 Dec 2009 07:25:24 -0500
Message-ID: <20091212122524.GA17547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 12 13:25:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJR2e-0004RM-Oc
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 13:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbZLLMZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 07:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbZLLMZa
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 07:25:30 -0500
Received: from peff.net ([208.65.91.99]:34535 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbZLLMZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 07:25:29 -0500
Received: (qmail 6363 invoked by uid 107); 12 Dec 2009 12:30:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Dec 2009 07:30:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Dec 2009 07:25:24 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135135>

When parsing the config file, if there is a value that is
syntactically correct but unused, we generally ignore it.
This lets non-core porcelains store arbitrary information in
the config file, and it means that configuration files can
be shared between new and old versions of git (the old
versions might simply ignore certain configuration).

The one exception to this is color configuration; if we
encounter a color.{diff,branch,status}.$slot variable, we
die if it is not one of the recognized slots (presumably as
a safety valve for user misconfiguration). This behavior
has existed since 801235c (diff --color: use
$GIT_DIR/config, 2006-06-24), but hasn't yet caused a
problem. No porcelain has wanted to store extra colors, and
we once a color area (like color.diff) has been introduced,
we've never changed the set of color slots.

However, that changed recently with the addition of
color.diff.func. Now a user with color.diff.func in their
config can no longer freely switch between v1.6.6 and older
versions; the old versions will complain about the existence
of the variable.

This patch loosens the check to match the rest of
git-config; unknown color slots are simply ignored. This
doesn't fix this particular problem, as the older version
(without this patch) is the problem, but it at least
prevents it from happening again in the future.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't know if it is worth trying to fix the problem for
color.diff.func. It would require renaming the variable to something
outside of the color.diff hierarchy, which is quite ugly. I don't know
how common a problem this is. Personally I switch between git versions a
lot doing git development (uncommon), but I also ran into it because I
share my ~/.gitconfig across several machines (which may be much more
common).

I suppose we could provide an undocumented alias of "color.difffunc",
and then only people who ran into this problem would have to be exposed
to the monstrosity. Normal people would use color.diff.func and be none
the wiser. But that feels awfully hack-ish to me.

 builtin-branch.c |    4 +++-
 builtin-commit.c |    4 +++-
 diff.c           |    4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 05e876e..c87e63b 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -65,7 +65,7 @@ static int parse_branch_color_slot(const char *var, int ofs)
 		return BRANCH_COLOR_LOCAL;
 	if (!strcasecmp(var+ofs, "current"))
 		return BRANCH_COLOR_CURRENT;
-	die("bad config variable '%s'", var);
+	return -1;
 }
 
 static int git_branch_config(const char *var, const char *value, void *cb)
@@ -76,6 +76,8 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 	}
 	if (!prefixcmp(var, "color.branch.")) {
 		int slot = parse_branch_color_slot(var, 13);
+		if (slot < 0)
+			return 0;
 		if (!value)
 			return config_error_nonbool(var);
 		color_parse(value, var, branch_colors[slot]);
diff --git a/builtin-commit.c b/builtin-commit.c
index e93a647..326cd63 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -890,7 +890,7 @@ static int parse_status_slot(const char *var, int offset)
 		return WT_STATUS_NOBRANCH;
 	if (!strcasecmp(var+offset, "unmerged"))
 		return WT_STATUS_UNMERGED;
-	die("bad config variable '%s'", var);
+	return -1;
 }
 
 static int git_status_config(const char *k, const char *v, void *cb)
@@ -910,6 +910,8 @@ static int git_status_config(const char *k, const char *v, void *cb)
 	}
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
 		int slot = parse_status_slot(k, 13);
+		if (slot < 0)
+			return -1;
 		if (!v)
 			return config_error_nonbool(k);
 		color_parse(v, k, s->color_palette[slot]);
diff --git a/diff.c b/diff.c
index d952686..08bbd3e 100644
--- a/diff.c
+++ b/diff.c
@@ -63,7 +63,7 @@ static int parse_diff_color_slot(const char *var, int ofs)
 		return DIFF_WHITESPACE;
 	if (!strcasecmp(var+ofs, "func"))
 		return DIFF_FUNCINFO;
-	die("bad config variable '%s'", var);
+	return -1;
 }
 
 static int git_config_rename(const char *var, const char *value)
@@ -122,6 +122,8 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 
 	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
+		if (slot < 0)
+			return 0;
 		if (!value)
 			return config_error_nonbool(var);
 		color_parse(value, var, diff_colors[slot]);
-- 
1.6.6.rc2.18.gbc86b8
