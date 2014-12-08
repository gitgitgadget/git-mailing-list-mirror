From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Mon, 8 Dec 2014 17:15:32 +0100 (CET)
Message-ID: <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0yN-0006Rq-OI
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934AbaLHQPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:60520 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755928AbaLHQPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:37 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LvENG-1Xpagp1AW2-010JHn;
 Mon, 08 Dec 2014 17:15:33 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:PpNFuwwnjTOcL96hDwXrNdwuYm2cc9QktpJ4GbYP18b+zUTYqpG
 Z/QTcGeHmjIBDp/MLTtk9t3NZcFB+Xx4Z0zkl2zsypynmJjbwlOvduIm07xD8PY7qY5OZ0t
 rpK8oH2+1mibHqy4HEYDYix+ymE1p23VNLMhluGq/+J93roo11mMWJ5tiYAFYIQ9ud8ohIo
 FYaiRx0NUq7lDOBgemA+g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261068>

We already have support in `git receive-pack` to deal with some legacy
repositories which have non-fatal issues.

Let's make `git fsck` itself useful with such repositories, too, by
allowing users to ignore known issues, or at least demote those issues
to mere warnings.

Example: `git -c fsck.missing-email=ignore fsck` would hide problems with
missing emails in author, committer and tagger lines.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 13 +++++++++++++
 builtin/fsck.c           | 15 +++++++++++++++
 t/t1450-fsck.sh          | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b3276ee..fa58c26 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1192,6 +1192,19 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
 
+fsck.*::
+	With these options, fsck errors can be switched to warnings and
+	vice versa by setting e.g. `fsck.bad-name` to `warn` or `error`
+	(or `ignore` to hide those errors completely). For convenience,
+	fsck prefixes the error/warning with the name of the option, e.g.
+	"missing-email: invalid author/committer line - missing email"
+	means that setting `fsck.missing-email` to `ignore` will hide that
+	issue.  For convenience, camelCased options are accepted, too (e.g.
+	`fsck.missingEmail`).
++
+This feature is intended to support working with legacy repositories
+which cannot be repaired without disruptive changes.
+
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99d4538..2b8faa4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -46,6 +46,19 @@ static int show_dangling = 1;
 #define DIRENT_SORT_HINT(de) ((de)->d_ino)
 #endif
 
+static int fsck_config(const char *var, const char *value, void *cb)
+{
+	if (starts_with(var, "fsck.")) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, "%s=%s", var + 5, value ? value : "error");
+		fsck_strict_mode(&fsck_obj_options, sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 static void objreport(struct object *obj, const char *severity,
                       const char *err)
 {
@@ -638,6 +651,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		include_reflogs = 0;
 	}
 
+	git_config(fsck_config, NULL);
+
 	fsck_head_link();
 	fsck_object_dir(get_object_directory());
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 019fddd..d74df19 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -283,6 +283,17 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 	grep -q "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
 '
 
+test_expect_success 'force fsck to ignore double author' '
+	git cat-file commit HEAD >basis &&
+	sed "s/^author .*/&,&/" <basis | tr , \\n >multiple-authors &&
+	new=$(git hash-object -t commit -w --stdin <multiple-authors) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	test_must_fail git fsck &&
+	git -c fsck.multiple-authors=ignore fsck
+'
+
 _bz='\0'
 _bz5="$_bz$_bz$_bz$_bz$_bz"
 _bz20="$_bz5$_bz5$_bz5$_bz5"
-- 
2.0.0.rc3.9669.g840d1f9
