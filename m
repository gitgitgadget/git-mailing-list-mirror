From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 16/19] fsck: Support demoting errors to warnings
Date: Fri, 19 Jun 2015 15:35:12 +0200
Organization: gmx
Message-ID: <770c9e16cddb803296bfb75d3067f0cf238f0221.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:36:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wTG-00024I-BK
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbbFSNfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 09:35:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:52935 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932153AbbFSNfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:35:16 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M9s2y-1ZGy0v1sUK-00B7w2; Fri, 19 Jun 2015 15:35:13
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Y5oc2mEK9OprudxC1wAb0AoWc2BKcMo9zgW/hb+VV4nFpwq+6d8
 kC+mzufE+PljL0nJCuZEJ7dH3Hke7eKNnrP8JZcS+9dgZVgV0Ks6fEfdk2x/6LCQsemR/kp
 Q2ncveJDiGOKA2GR+/7x3Qxc9GXTikFTWK+gN9U5fJzFUbmDndFJ33sOtKITk/pqCgRUHol
 YdBUfcFumOnPy2Hc0dW9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cTM1iDTCfyI=:dGjFvhh6CPuuq42NPcTfDY
 HQSeOSq8hQprnremgWQyMR6T9nvVoik3uXeajYXFNMxByYESWXxUgtTlw44MrO9DvP6DF9KCS
 QdTTdqYOCbqNvzFPb8dTyQWGG07mwCwzUwmPKX0xOX1bVYIefRqt8P8eaZ0zMslEH4QEUgOGv
 +QYdayVkkWMSErcRYCHj9+AEMvdIhmV0cPdrO9t31Zp8bSkl5nh8vBhUla32/GO/5pmgswjs2
 wDyxYeeMH1iAgQjxSBK0ACMzjXkSBJlev7F3w8R9cwi9NutmWIh2tonqmfkdsG4x3YIDXU2zq
 TG/VVDRav13555RezZ7bgKqN9ATFmMslxkYHXA+OVSrCNNwj56QzXaUoUvCn78BOL6xLGk0jT
 Hdf0+pNrez0Kd4vpaT6y4MmlBbjM7leNcx0gSfuPjupG4iuRpJIlxjo0hw3TCaiWvl92besBy
 abohd6OszQGiPjvRCf3BCpTH3cB4FuKyWdAod9t3hzvFN/pVV8bF4G8Lij8Y3gN0rUWF8Ly5p
 Hp7EPY/UEbjJhicBsMIx2voiLo6cCdwcXvLh1QsAbooJ2TlS4tXu9kQ+UuKQ83xBYYjCQZdzp
 kvFoG08aZKUs7upuyL2lun+174OULNj0OSZONfc9YwmHQgdwlmL9TMm0kGfHIRodgc7XIo/u/
 neVD/P8hqLSm0s5jtlTeMa2EJ2CTqNLUkVrxOMWE2PSrD3eia9d2V+RB22D8BJiiF2Dg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272154>

We already have support in `git receive-pack` to deal with some legacy
repositories which have non-fatal issues.

Let's make `git fsck` itself useful with such repositories, too, by
allowing users to ignore known issues, or at least demote those issues
to mere warnings.

Example: `git -c fsck.missingemail=3Dignore fsck` would hide
problems with missing emails in author, committer and tagger lines.

In the same spirit that `git receive-pack`'s usage of the fsck machiner=
y
differs from `git fsck`'s =E2=80=93 some of the non-fatal warnings in `=
git fsck`
are fatal with `git receive-pack` when receive.fsckObjects =3D true, fo=
r
example =E2=80=93 we strictly separate the fsck.<msg-id> from the
receive.fsck.<msg-id> settings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 11 +++++++++++
 builtin/fsck.c           | 12 ++++++++++++
 t/t1450-fsck.sh          | 11 +++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 306ab7a..41fd460 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1250,6 +1250,17 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
=20
+fsck.<msg-id>::
+	Allows overriding the message type (error, warn or ignore) of a
+	specific message ID such as `missingemail`.
++
+For convenience, fsck prefixes the error/warning with the message ID,
+e.g.  "missingemail: invalid author/committer line - missing email" me=
ans
+that setting `fsck.missingemail =3D ignore` will hide that issue.
++
+This feature is intended to support working with legacy repositories
+which cannot be repaired without disruptive changes.
+
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/builtin/fsck.c b/builtin/fsck.c
index fff38fe..6de9f3e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -46,6 +46,16 @@ static int show_dangling =3D 1;
 #define DIRENT_SORT_HINT(de) ((de)->d_ino)
 #endif
=20
+static int fsck_config(const char *var, const char *value, void *cb)
+{
+	if (skip_prefix(var, "fsck.", &var)) {
+		fsck_set_msg_type(&fsck_obj_options, var, -1, value, -1);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 static void objreport(struct object *obj, const char *msg_type,
 			const char *err)
 {
@@ -646,6 +656,8 @@ int cmd_fsck(int argc, const char **argv, const cha=
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
index d6d3b13..922c346 100755
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
+	git -c fsck.multipleauthors=3Dignore fsck
+'
+
 _bz=3D'\0'
 _bz5=3D"$_bz$_bz$_bz$_bz$_bz"
 _bz20=3D"$_bz5$_bz5$_bz5$_bz5"
--=20
2.3.1.windows.1.9.g8c01ab4
