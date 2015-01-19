From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 16/18] fsck: Support demoting errors to warnings
Date: Mon, 19 Jan 2015 16:51:51 +0100
Organization: gmx
Message-ID: <f038d7576de0052df1622bd833f31512f69a52a8.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 16:59:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEjx-0006J3-0m
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbbASP7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2015 10:59:40 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751744AbbASP7i (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:38 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFppWS026471;
	Mon, 19 Jan 2015 16:51:51 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFppwU026470;
	Mon, 19 Jan 2015 16:51:51 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262626>

We already have support in `git receive-pack` to deal with some legacy
repositories which have non-fatal issues.

Let's make `git fsck` itself useful with such repositories, too, by
allowing users to ignore known issues, or at least demote those issues
to mere warnings.

Example: `git -c fsck.ignore=3Dmissing-email fsck` would hide problems =
with
missing emails in author, committer and tagger lines.

In the same spirit that `git receive-pack`'s usage of the fsck machiner=
y
differs from `git fsck`'s =E2=80=93 some of the non-fatal warnings in `=
git fsck`
are fatal with `git receive-pack` when receive.fsckObjects =3D true, fo=
r
example =E2=80=93 we strictly separate the fsck.* from the receive.fsck=
=2E*
settings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 13 +++++++++++++
 builtin/fsck.c           | 15 +++++++++++++++
 t/t1450-fsck.sh          | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7371a5f..0daba8a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1208,6 +1208,19 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
=20
+fsck.*::
+	The `fsck.error`, `fsck.warn` and `fsck.ignore` settings specify
+	comma-separated lists of fsck message IDs which should trigger
+	fsck to error out, to print the message and continue, or to ignore
+	said messages, respectively.
++
+For convenience, fsck prefixes the error/warning with the name of the =
option,
+e.g.  "missing-email: invalid author/committer line - missing email" m=
eans
+that setting `fsck.ignore =3D missing-email` will hide that issue.
++
+This feature is intended to support working with legacy repositories
+which cannot be repaired without disruptive changes.
+
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99d4538..d5403c4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -46,6 +46,19 @@ static int show_dangling =3D 1;
 #define DIRENT_SORT_HINT(de) ((de)->d_ino)
 #endif
=20
+static int fsck_config(const char *var, const char *value, void *cb)
+{
+	if (starts_with(var, "fsck.")) {
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_addf(&sb, "%s=3D%s", var + 5, value);
+		fsck_set_severity(&fsck_obj_options, sb.buf);
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
@@ -638,6 +651,8 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
 		include_reflogs =3D 0;
 	}
=20
+	git_config(fsck_config, NULL);
+
 	fsck_head_link();
 	fsck_object_dir(get_object_directory());
=20
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index ea0f216..a79ff9f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -287,6 +287,17 @@ test_expect_success 'rev-list --verify-objects wit=
h bad sha1' '
 	grep -q "error: sha1 mismatch 63fffffffffffffffffffffffffffffffffffff=
f" out
 '
=20
+test_expect_success 'force fsck to ignore double author' '
+	git cat-file commit HEAD >basis &&
+	sed "s/^author .*/&,&/" <basis | tr , \\n >multiple-authors &&
+	new=3D$(git hash-object -t commit -w --stdin <multiple-authors) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	test_must_fail git fsck &&
+	git -c fsck.ignore=3Dmultiple-authors fsck
+'
+
 _bz=3D'\0'
 _bz5=3D"$_bz$_bz$_bz$_bz$_bz"
 _bz20=3D"$_bz5$_bz5$_bz5$_bz5"
--=20
2.0.0.rc3.9669.g840d1f9
