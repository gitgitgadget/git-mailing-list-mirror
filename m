From: Jeff King <peff@peff.net>
Subject: [PATCH] archive: add archive.restrictRemote option
Date: Wed, 26 Feb 2014 23:05:05 -0500
Message-ID: <20140227040504.GA2242@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Scott J. Goldman" <scottjg@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 05:05:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIsDj-0000VC-Va
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 05:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbaB0EFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 23:05:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:57767 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751700AbaB0EFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 23:05:08 -0500
Received: (qmail 28313 invoked by uid 102); 27 Feb 2014 04:05:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 22:05:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 23:05:05 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242784>

From: Scott J. Goldman <scottjg@github.com>

In commit ee27ca4, we started restricting remote git-archive
invocations to only accessing reachable commits. This
matches what upload-pack allows, but does restrict some
useful cases (e.g., HEAD:foo). We loosened this in 0f544ee,
which allows `foo:bar` as long as `foo` is a ref tip.
However, that still doesn't allow many useful things, like:

  1. Commits accessible from a ref, like `foo^:bar`, which
     is reachable

  2. Arbitrary sha1s, even if they are reachable.

We can do a full object-reachability check for these cases,
but it can be quite expensive if the client has sent us the
sha1 of a tree; we have to visit every sub-tree of every
commit in the worst case.

Let's instead give site admins an escape hatch, in case they
prefer the more liberal behavior.  For many sites, the full
object database is public anyway (e.g., if you allow dumb
walker access), or the site admin may simply decide the
security/convenience tradeoff is not worth it.

This patch adds a new config option to turn off the
restrictions added in ee27ca4. It defaults to on, meaning
there is no change in behavior by default.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-archive.txt |  7 +++++++
 archive.c                     | 13 +++++++++++--
 t/t5000-tar-tree.sh           |  9 +++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index b97aaab..486cb08 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -121,6 +121,13 @@ tar.<format>.remote::
 	user-defined formats, but true for the "tar.gz" and "tgz"
 	formats.
 
+archive.restrictRemote::
+	If true, archives can only be requested by refnames. If false,
+	allows remote archive requests from arbitrary revisions. This
+	can be a security hazard, as archives could be requested for
+	unreachable commits that have been pruned from the repository.
+	Defaults to true.
+
 [[ATTRIBUTES]]
 ATTRIBUTES
 ----------
diff --git a/archive.c b/archive.c
index 346f3b2..13eb23a 100644
--- a/archive.c
+++ b/archive.c
@@ -17,6 +17,7 @@ static char const * const archive_usage[] = {
 static const struct archiver **archivers;
 static int nr_archivers;
 static int alloc_archivers;
+static int git_archive_restrict_remote = 1;
 
 void register_archiver(struct archiver *ar)
 {
@@ -257,7 +258,7 @@ static void parse_treeish_arg(const char **argv,
 	unsigned char sha1[20];
 
 	/* Remotes are only allowed to fetch actual refs */
-	if (remote) {
+	if (remote && git_archive_restrict_remote) {
 		char *ref = NULL;
 		const char *colon = strchr(name, ':');
 		int refnamelen = colon ? colon - name : strlen(name);
@@ -401,6 +402,14 @@ static int parse_archive_args(int argc, const char **argv,
 	return argc;
 }
 
+static int git_default_archive_config(const char *var, const char *value,
+				      void *cb)
+{
+	if (!strcmp(var, "archive.restrictremote"))
+		git_archive_restrict_remote = git_config_bool(var, value);
+	return git_default_config(var, value, cb);
+}
+
 int write_archive(int argc, const char **argv, const char *prefix,
 		  int setup_prefix, const char *name_hint, int remote)
 {
@@ -411,7 +420,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	if (setup_prefix && prefix == NULL)
 		prefix = setup_git_directory_gently(&nongit);
 
-	git_config(git_default_config, NULL);
+	git_config(git_default_archive_config, NULL);
 	init_tar_archiver();
 	init_zip_archiver();
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 05f011d..eba285f 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -213,6 +213,15 @@ test_expect_success 'clients cannot access unreachable commits' '
 	test_must_fail git archive --remote=. $sha1 >remote.tar
 '
 
+test_expect_success 'clients can access unreachable commits' '
+	test_commit unreachable1 &&
+	sha1=`git rev-parse HEAD` &&
+	git reset --hard HEAD^ &&
+	git archive $sha1 >remote.tar &&
+	test_config archive.restrictRemote false &&
+	git archive --remote=. $sha1 >remote.tar
+'
+
 test_expect_success 'setup tar filters' '
 	git config tar.tar.foo.command "tr ab ba" &&
 	git config tar.bar.command "tr ab ba" &&
-- 
1.8.5.2.500.g8060133
