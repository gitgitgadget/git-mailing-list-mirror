From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 16/19] fsck: Support demoting errors to warnings
Date: Sat, 31 Jan 2015 22:06:44 +0100
Organization: gmx
Message-ID: <5e2a68e7e8de3d66f91b95408344c50cfb9b4b6c.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:06:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfFk-00059R-1O
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbbAaVGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jan 2015 16:06:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:51290 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbbAaVGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:06:47 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Me8ws-1Y1fsA2oqE-00PwiV; Sat, 31 Jan 2015 22:06:44
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:UxhU9gSrUzGfUPNxH8JzKQPDY+aXeogf5PZvalOEvuQT3yx6ILT
 d63IS2ZiSdbb0b5lS2quRoqbU34TAccL7P0aUK+vrL/dqTxmM96dFDRz5NC7KfUpZfj6sGR
 gzzWxrfVoFR8uXEFN+YIR32mC99mDUOdqBRZkUWRMLjw6PTOrxnA1Oo45j3iCra+ZAuEDcc
 Sj3KghY7gQPxgQsoaZH7w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263226>

We already have support in `git receive-pack` to deal with some legacy
repositories which have non-fatal issues.

Let's make `git fsck` itself useful with such repositories, too, by
allowing users to ignore known issues, or at least demote those issues
to mere warnings.

Example: `git -c fsck.severity=3Dmissing-email=3Dignore fsck` would hid=
e
problems with missing emails in author, committer and tagger lines.

In the same spirit that `git receive-pack`'s usage of the fsck machiner=
y
differs from `git fsck`'s =E2=80=93 some of the non-fatal warnings in `=
git fsck`
are fatal with `git receive-pack` when receive.fsckObjects =3D true, fo=
r
example =E2=80=93 we strictly separate the fsck.severity from the
receive.fsck.severity settings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 12 ++++++++++++
 builtin/fsck.c           | 12 ++++++++++++
 t/t1450-fsck.sh          | 11 +++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f893492..4c0a13d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1208,6 +1208,18 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
=20
+fsck.severity::
+	A comma-separated lists of of the form `<id>=3D<level>` where `<id>`
+	denotes a fsck message ID such as `missing-email` and `<level>` is
+	one of `error`, `warn` and `ignore`.
++
+For convenience, fsck prefixes the error/warning with the message ID,
+e.g.  "missing-email: invalid author/committer line - missing email" m=
eans
+that setting `fsck.severity =3D missing-email=3Dignore` will hide that=
 issue.
++
+This feature is intended to support working with legacy repositories
+which cannot be repaired without disruptive changes.
+
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1f7944c..9e5cc31 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -46,6 +46,16 @@ static int show_dangling =3D 1;
 #define DIRENT_SORT_HINT(de) ((de)->d_ino)
 #endif
=20
+static int fsck_config(const char *var, const char *value, void *cb)
+{
+	if (strcmp(var, "fsck.severity") =3D=3D 0) {
+		fsck_set_severity(&fsck_obj_options, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 static void objreport(struct object *obj, const char *severity,
                       const char *err)
 {
@@ -638,6 +648,8 @@ int cmd_fsck(int argc, const char **argv, const cha=
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
index ea0f216..0f15b74 100755
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
+	git -c fsck.severity=3Dmultiple-authors=3Dignore fsck
+'
+
 _bz=3D'\0'
 _bz5=3D"$_bz$_bz$_bz$_bz$_bz"
 _bz20=3D"$_bz5$_bz5$_bz5$_bz5"
--=20
2.2.0.33.gc18b867
