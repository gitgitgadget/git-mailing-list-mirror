From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 16/19] fsck: Support demoting errors to warnings
Date: Thu, 18 Jun 2015 22:09:50 +0200
Organization: gmx
Message-ID: <d6eb0210ac56de264c528887f5ba0f5c67f59d08.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:10:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g8e-0004JY-PU
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbbFRUKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 16:10:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:51184 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932652AbbFRUKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:10:03 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MdKDb-1ZMWSa16g7-00IT66; Thu, 18 Jun 2015 22:09:51
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:f0YuwU32kf5OS/KQ4PjdJjxL22Q9bbd8+/gy4HUQdGSwhfJYxsf
 aSIXnYdPcBsWzDXmYdfeNugtus7gDo6lfKzVduQwmRVrXiKJ8JVI2TRXx2L356XLD6lY0Xs
 BKbrKooW5OdD3a1Mwzp0XM8c771HJgIFZNJEwrAOJvF4mezt0VLcUyDfqp7FoLCcR6tIWt8
 rWuzTpqhE696FAYVrMtAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aFNxsKznrcc=:eVIGcC6XMb93atSQ9U084U
 gI9W4uK+262g3xPe3lXiy+8CQdvSdo5eqShvZdr0URwIwsmF+0lgK6krVLvVWczCc5cwGShem
 SJcKLrj0gF4PYEDMG+scdlSVt2GsRBeHR04pQ1j7B32keFAgfhStiRsDqvFZdNgr/qhzkLVCU
 6T5P74U7qCBd4arConLSkOJOSM8yCWY7yno8kqKIChL2SYTAwX+QvZyaABG7IejhiBiLAJRI6
 XfXtjOnHjAsfDfbBa5cJmiWRlV4LHz+3BbRalSp/3KlRH4qgt05B1djupGdzIsQ1W3S1JcegO
 ZkxIQ1Odb5HPJ0kpFh6Jom1vpyFvtgMbeVAfZ2h3Xjd5uMYYkdxE/fesaSz0hS7TbYS/2Dfzr
 9hB9U3byLMZbS1k11BbdS9QVt648Tj+C2Djaaxgtvr+ysqQTBNNOQ/H0udNHv9jgQ7OBkvatF
 O6H+xdlRsM4Wk+kaU5hzW5d08CzJc6x1gu4XAT0Y1pw9TT+sQ0on3THz3mighcrcJpwbxmm80
 eWPA/19aMFtqQmsbYEceuSuNcY1A1J0SWNVvUYkz3mxVM2kbRuIrLX9E4l3YaSqcB1XW1sEcr
 m7M0n7zSrytGBA94l9a4SDj+v0n/YyogXdksB6ns8Ucn0TOt5NV5mDLw2vtDR1abZSosdWDe9
 QdKpXNu4L+Bl+EfnM6rEdXjWGIg89/7or+QvacyRBSMxQHtLKQYkKn4NXSASJyQxvJnQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272057>

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
index 286a643..fe4bb03 100755
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
