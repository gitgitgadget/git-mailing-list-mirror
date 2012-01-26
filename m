From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] config: allow including config from repository blobs
Date: Thu, 26 Jan 2012 02:42:08 -0500
Message-ID: <20120126074208.GD30474@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 08:42:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqJyL-0008P7-HN
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 08:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab2AZHmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 02:42:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45008
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475Ab2AZHmM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 02:42:12 -0500
Received: (qmail 24049 invoked by uid 107); 26 Jan 2012 07:49:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 02:49:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 02:42:08 -0500
Content-Disposition: inline
In-Reply-To: <20120126073547.GA28689@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189144>

One often-requested feature is to allow projects to ship
suggested config to people who clone. The most obvious way
of implementing this would be to respect .gitconfig files
within the working tree. However, this has two problems:

  1. Because git configuration can cause the execution of
     arbitrary code, that creates a potential security problem.
     While you may be comfortable running "make" on a newly
     cloned project, you at least have the opportunity to
     inspect the downloaded contents.  But by automatically
     respecting downloaded git configuration, you cannot
     even safely use git to inspect those contents!

  2. Configuration options tend not to be tied to a specific
     version of the project. So if you are using "git
     checkout" to sight-see to an older revision, you
     probably still want to be using the most recent version
     of the suggested config.

Instead, this patch lets you include configuration directly
from a blob in the repository (using the usual object name
lookup rules). This avoids (2) by pointing directly to a tag
or branch tip. It is still possible to be dangerous as in
(1) above, but the danger can be avoided by not pointing
directly into remote blobs (and the documentation warns of
this and gives a safe example).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt  |   41 ++++++++++++++++++++++++++++++++++++++++-
 config.c                  |   25 ++++++++++++++++++++++++-
 t/t1305-config-include.sh |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e55dae1..38e83df 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -93,7 +93,14 @@ included file is expanded immediately, as if its contents had been
 found at the location of the include directive. If the value of the
 `include.path` variable is a relative path, the path is considered to be
 relative to the configuration file in which the include directive was
-found. See below for examples.
+found.
+
+You can also include configuration from a blob stored in your repository
+by setting the special `include.ref` variable to the name of an object
+containing your configuration data (in the same format as a regular
+config file).
+
+See below for examples.
 
 Example
 ~~~~~~~
@@ -120,6 +127,38 @@ Example
 	[include]
 		path = /path/to/foo.inc ; include by absolute path
 		path = foo ; expand "foo" relative to the current file
+		ref = config:.gitconfig ; look on "config" branch
+		ref = origin/master:.gitconfig ; this is unsafe! see below
+
+
+Security Considerations
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Because git configuration may cause git to execute arbitrary shell
+commands, it is important to verify any configuration you receive over
+the network. In particular, it is not a good idea to point `include.ref`
+directly at a remote tracking branch like `origin/master:shared-config`.
+After a fetch, you have no way of inspecting the shared-config you have
+just received without running git (and thus respecting the downloaded
+config). Instead, you can create a local tag representing the last
+verified version of the config, and only update the tag after inspecting
+any new content.
+
+For example:
+
+	# initially, look at their suggested config
+	git show origin/master:shared-config
+
+	# if it looks good to you, point a local ref at it
+	git tag config origin/master
+	git config include.ref config:shared-config
+
+	# much later, fetch any changes and examine them
+	git fetch origin
+	git diff config origin/master -- shared-config
+
+	# If the changes look OK, update your local version
+	git tag -f config origin/master
 
 Variables
 ~~~~~~~~~
diff --git a/config.c b/config.c
index 49a3d1a..c41fb3b 100644
--- a/config.c
+++ b/config.c
@@ -941,7 +941,7 @@ static int handle_path_include(const char *path, void *data)
 	 */
 	if (!is_absolute_path(path)) {
 		char *slash;
-		if (!cf)
+		if (!cf || !cf->f)
 			return error("relative config includes must come from files");
 		strbuf_addstr(&buf, absolute_path(cf->name));
 		slash = find_last_dir_sep(buf.buf);
@@ -958,6 +958,27 @@ static int handle_path_include(const char *path, void *data)
 	return ret;
 }
 
+static int handle_ref_include(const char *ref, void *data)
+{
+	unsigned char sha1[20];
+	char *buf;
+	unsigned long size;
+	enum object_type type;
+	int ret;
+
+	if (get_sha1(ref, sha1))
+		return 0;
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("unable to read include ref '%s'", ref);
+	if (type != OBJ_BLOB)
+		return error("include ref '%s' is not a blob", ref);
+
+	ret = git_config_from_buffer(git_config_include, data, ref, buf, size);
+	free(buf);
+	return ret;
+}
+
 int git_config_include(const char *name, const char *value, void *vdata)
 {
 	const struct git_config_include_data *data = vdata;
@@ -978,6 +999,8 @@ int git_config_include(const char *name, const char *value, void *vdata)
 
 	if (!strcmp(type, "path"))
 		ret = handle_path_include(value, vdata);
+	else if (!strcmp(type, "ref"))
+		ret = handle_ref_include(value, vdata);
 
 	return ret;
 }
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 4db3091..31d3b9b 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -95,4 +95,42 @@ test_expect_success 'relative includes from command line fail' '
 	test_must_fail git -c include.path=one config test.one
 '
 
+test_expect_success 'include from ref' '
+	echo "[test]one = 1" >one &&
+	git add one &&
+	git commit -m one &&
+	rm one &&
+	echo "[include]ref = HEAD:one" >base &&
+	echo 1 >expect &&
+	git config -f base test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'relative file include from ref fails' '
+	echo "[test]two = 2" >two &&
+	echo "[include]path = two" >one &&
+	git add one &&
+	git commit -m one &&
+	echo "[include]ref = HEAD:one" >base &&
+	test_must_fail git config -f base test.two
+'
+
+test_expect_success 'non-existent include refs are ignored' '
+	cat >base <<-\EOF &&
+	[include]ref = my-missing-config-branch:foo.cfg
+	[test]value = yes
+	EOF
+	echo yes >expect &&
+	git config -f base test.value >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'non-blob include refs fail' '
+	cat >base <<-\EOF &&
+	[include]ref = HEAD
+	[test]value = yes
+	EOF
+	test_must_fail git config -f base test.value
+'
+
 test_done
-- 
1.7.9.rc2.293.gaae2
