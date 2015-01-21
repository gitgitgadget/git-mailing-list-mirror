From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 16/19] fsck: Support demoting errors to warnings
Date: Wed, 21 Jan 2015 20:27:15 +0100
Organization: gmx
Message-ID: <c597de0fd5d5341c749139fd3057c0f51b477250.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0vz-0003YU-KA
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbbAUT1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2015 14:27:21 -0500
Received: from mout.gmx.net ([212.227.17.20]:55157 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbbAUT1T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:27:19 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MGEv5-1Xypqm2VBX-00F9us; Wed, 21 Jan 2015 20:27:15
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:caa8bjrguTGFQloIbQU78ucNsxnJTQhhA7cUtYxqRqLQWdfYW+v
 2DgTwqGeusAl1/NViVO7bioGvEJ7qXg9JRVObdruVHiGV6twlexV8WHf9Tv469NilkKS4yr
 rYXay57+1RADyc1K4IuPXon55EROYK82v1nWUobm4TkdBalo5Ya1jqcttV/zpAwmX92lLIU
 WvgrTE3cwbm5IiHvxSc3w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262761>

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
 Documentation/config.txt | 15 +++++++++++++++
 builtin/fsck.c           | 15 +++++++++++++++
 t/t1450-fsck.sh          | 11 +++++++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cc4cd91..115811c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1208,6 +1208,21 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
=20
+fsck.error::
+fsck.warn::
+fsck.ignore::
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
index 99d4538..6f5e671 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -46,6 +46,19 @@ static int show_dangling =3D 1;
 #define DIRENT_SORT_HINT(de) ((de)->d_ino)
 #endif
=20
+static int fsck_config(const char *var, const char *value, void *cb)
+{
+	if (skip_prefix(var, "fsck.", &var)) {
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_addf(&sb, "%s=3D%s", var, value);
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
2.2.0.33.gc18b867
