From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 10/11] git-p4: test and document --use-client-spec
Date: Sat, 24 Dec 2011 21:07:39 -0500
Message-ID: <1324778860-4821-11-git-send-email-pw@padd.com>
References: <1324778860-4821-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 03:11:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RedYM-0001Ja-7J
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 03:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758054Ab1LYCLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 21:11:05 -0500
Received: from honk.padd.com ([74.3.171.149]:51322 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab1LYCLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 21:11:04 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 5F3BE31BF;
	Sat, 24 Dec 2011 18:11:03 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 274C4315E1; Sat, 24 Dec 2011 21:11:01 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.398.gf9d11
In-Reply-To: <1324778860-4821-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187673>

The depot path is required, even with this option.  Make sure
git-p4 fails and exits with non-zero.

Contents in the specified depot path will be rearranged according
to the client spec.  Test this and add a note in the docs.

Leave an XXX suggesting that this is somewhat confusing behavior
that might be good to fix later.

Function stripRepoPath() looks at self.useClientSpec.  Make sure
this is set both for command-line option --use-client-spec and
for configuration variable git-p4.useClientSpec.  Test this.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt   |    5 +++-
 contrib/fast-import/git-p4 |    6 ++++-
 t/t9806-git-p4-options.sh  |   46 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 2885b82..3092571 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -232,7 +232,10 @@ git repository:
 	Use a client spec to find the list of interesting files in p4.
 	The client spec is discovered using 'p4 client -o' which checks
 	the 'P4CLIENT' environment variable and returns a mapping of
-	depot files to workspace files.
+	depot files to workspace files.  Note that a depot path is
+	still required, but files found in the path that match in
+	the client spec view will be laid out according to the client
+	spec.
 
 Clone options
 ~~~~~~~~~~~~~
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d0a9b0d..5420bf1 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1951,7 +1951,10 @@ class P4Sync(Command, P4UserMap):
             if not gitBranchExists(self.refPrefix + "HEAD") and self.importIntoRemotes and gitBranchExists(self.branch):
                 system("git symbolic-ref %sHEAD %s" % (self.refPrefix, self.branch))
 
-        if self.useClientSpec or gitConfig("git-p4.useclientspec") == "true":
+        if not self.useClientSpec:
+            if gitConfig("git-p4.useclientspec", "--bool") == "true":
+                self.useClientSpec = True
+        if self.useClientSpec:
             self.getClientSpec()
 
         # TODO: should always look at previous commits,
@@ -2380,6 +2383,7 @@ def main():
 
     if not cmd.run(args):
         parser.print_help()
+        sys.exit(2)
 
 
 if __name__ == '__main__':
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 6b288ac..1f1952a 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -117,6 +117,52 @@ test_expect_success 'clone --keep-path' '
 	)
 '
 
+# clone --use-client-spec must still specify a depot path
+# if given, it should rearrange files according to client spec
+# when it has view lines that match the depot path
+# XXX: should clone/sync just use the client spec exactly, rather
+# than needing depot paths?
+test_expect_success 'clone --use-client-spec' '
+	(
+		# big usage message
+		exec >/dev/null &&
+		test_must_fail "$GITP4" clone --dest="$git" --use-client-spec
+	) &&
+	cli2="$TRASH_DIRECTORY/cli2" &&
+	mkdir -p "$cli2" &&
+	test_when_finished "rmdir \"$cli2\"" &&
+	(
+		cd "$cli2" &&
+		p4 client -i <<-EOF
+		Client: client2
+		Description: client2
+		Root: $cli2
+		View: //depot/sub/... //client2/bus/...
+		EOF
+	) &&
+	P4CLIENT=client2 &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" --use-client-spec //depot/... &&
+	(
+		cd "$git" &&
+		test_path_is_file bus/dir/f4 &&
+		test_path_is_file file1
+	) &&
+	cleanup_git &&
+
+	# same thing again, this time with variable instead of option
+	mkdir "$git" &&
+	(
+		cd "$git" &&
+		git init &&
+		git config git-p4.useClientSpec true &&
+		"$GITP4" sync //depot/... &&
+		git checkout -b master p4/master &&
+		test_path_is_file bus/dir/f4 &&
+		test_path_is_file file1
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.8.534.g03ab.dirty
