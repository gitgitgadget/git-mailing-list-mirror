From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] add uploadarchive.allowUnreachable option
Date: Fri, 28 Feb 2014 05:04:19 -0500
Message-ID: <20140228100418.GA18092@sigill.intra.peff.net>
References: <20140228095619.GA11803@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Scott J. Goldman" <scottjg@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 11:04:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJKIv-0001v4-F9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 11:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbaB1KEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 05:04:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:58655 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750907AbaB1KEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 05:04:21 -0500
Received: (qmail 23681 invoked by uid 102); 28 Feb 2014 10:04:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 04:04:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 05:04:19 -0500
Content-Disposition: inline
In-Reply-To: <20140228095619.GA11803@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242935>

From: Scott J. Goldman <scottjg@github.com>

In commit ee27ca4, we started restricting remote git-archive
invocations to only accessing reachable commits. This
matches what upload-pack allows, but does restrict some
useful cases (e.g., HEAD:foo). We loosened this in 0f544ee,
which allows `foo:bar` as long as `foo` is a ref tip.
However, that still doesn't allow many useful things, like:

  1. Commits accessible from a ref, like `foo^:bar`, which
     are reachable

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

This patch adds a new config option to disable the
restrictions added in ee27ca4. It defaults to off, meaning
there is no change in behavior by default.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt             |  7 +++++++
 Documentation/git-upload-archive.txt |  6 ++++++
 archive.c                            | 13 +++++++++++--
 t/t5000-tar-tree.sh                  |  9 +++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 040197b..62f0a4e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2334,6 +2334,13 @@ transfer.unpackLimit::
 	not set, the value of this variable is used instead.
 	The default value is 100.
 
+uploadarchive.allowUnreachable::
+	If true, allow clients to use `git archive --remote` to request
+	any tree, whether reachable from the ref tips or not. See the
+	discussion in the `SECURITY` section of
+	linkgit:git-upload-archive[1] for more details. Defaults to
+	`false`.
+
 uploadpack.hiderefs::
 	String(s) `upload-pack` uses to decide which refs to omit
 	from its initial advertisement.  Use more than one
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index 8ae65d8..cbef61b 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -46,6 +46,12 @@ implications. These rules are subject to change in future versions of
 git, and the server accessed by `git archive --remote` may or may not
 follow these exact rules.
 
+If the config option `uploadArchive.allowUnreachable` is true, these
+rules are ignored, and clients may use arbitrary sha1 expressions.
+This is useful if you do not care about the privacy of unreachable
+objects, or if your object database is already publicly available for
+access via non-smart-http.
+
 OPTIONS
 -------
 <directory>::
diff --git a/archive.c b/archive.c
index 346f3b2..7d0976f 100644
--- a/archive.c
+++ b/archive.c
@@ -17,6 +17,7 @@ static char const * const archive_usage[] = {
 static const struct archiver **archivers;
 static int nr_archivers;
 static int alloc_archivers;
+static int remote_allow_unreachable;
 
 void register_archiver(struct archiver *ar)
 {
@@ -257,7 +258,7 @@ static void parse_treeish_arg(const char **argv,
 	unsigned char sha1[20];
 
 	/* Remotes are only allowed to fetch actual refs */
-	if (remote) {
+	if (remote && !remote_allow_unreachable) {
 		char *ref = NULL;
 		const char *colon = strchr(name, ':');
 		int refnamelen = colon ? colon - name : strlen(name);
@@ -401,6 +402,14 @@ static int parse_archive_args(int argc, const char **argv,
 	return argc;
 }
 
+static int git_default_archive_config(const char *var, const char *value,
+				      void *cb)
+{
+	if (!strcmp(var, "uploadarchive.allowunreachable"))
+		remote_allow_unreachable = git_config_bool(var, value);
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
index 05f011d..1cf0a4e 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -213,6 +213,15 @@ test_expect_success 'clients cannot access unreachable commits' '
 	test_must_fail git archive --remote=. $sha1 >remote.tar
 '
 
+test_expect_success 'upload-archive can allow unreachable commits' '
+	test_commit unreachable1 &&
+	sha1=`git rev-parse HEAD` &&
+	git reset --hard HEAD^ &&
+	git archive $sha1 >remote.tar &&
+	test_config uploadarchive.allowUnreachable true &&
+	git archive --remote=. $sha1 >remote.tar
+'
+
 test_expect_success 'setup tar filters' '
 	git config tar.tar.foo.command "tr ab ba" &&
 	git config tar.bar.command "tr ab ba" &&
-- 
1.8.5.2.500.g8060133
