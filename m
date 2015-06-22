From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 16/19] fsck: Support demoting errors to warnings
Date: Mon, 22 Jun 2015 17:27:06 +0200
Organization: gmx
Message-ID: <2a2659daa5bd676d68cd9b82fe630dbadcf9e360.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:27:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73d8-0007VW-Gz
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbbFVP1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 11:27:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:58529 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbbFVP1N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:27:13 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M4nt7-1YtFfb43C9-00yyFg; Mon, 22 Jun 2015 17:27:07
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:0caOXwMRFMMZnHADM4a5IHQPv6OceDBT3q6mb1DPz/vi4+w//hK
 2dUXKHOEQ/A4Uffm86+rIY1kYEhL6rv+XuV1+MFVn88cyh1N3QHj6WkSZrMVHcNfT7z+8Ut
 tthhAYwJihYCrBdzIcqPBht/9iBFcVyX6VYDcc1OQD4U7fuZwKgz6pOkcVP3VehWvaGZ32O
 G/uAWm+2U0CoOyHrqEEIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jI8Ls6WYRwI=:NwRooMDV8mHLadeO8iv7Fu
 0ED/YIaB2dzVuKtukb6wUUEIk7yKaknL2yf2jNdBaXpdx9ew1wZQ9E9m2GR73MFlfxWftsM6k
 uwRn1fDffVHa+18Ph8hGtWvOF2gSP2prH7spdtbMxfKHRx5zqq1pHwS7TLTOYIAUGKNgroyvl
 cXq+nb4hByJOWraHWew1xspUGm9ZFL22Ryqm9O1wC6ITIpqlh+PFZ2o/L0mbS0kahD+iBHXuW
 NnUw5e287O42Tb85di4wWWZMBaC9p/hwtYZgQSVtsqhOqTlqeVzDFQJMuB7lXVTl+S3QHodEx
 o3IZ4lDNpv6iWnxATrLUfHLPkf/vAmzQ9iyFHDJeMt0X/KE3aABeAOqpn/FY6Wieq8+Mg/plj
 hB7dAnjiSCa1JzBeQUxyx4Td/eGiwVL0bgPYhd86FALJqHcJL6Bvj9zMdHR2zprsUms0q64PD
 bBVbXl4v41ZTqkClnKk5WtoVxOU/etGoOwcQpLNk9AQkbS4pby9kzLtI/UBvXo5zOetE1F9iM
 Q04Jg2ROzAqZA3/5CBzLvxkCrPy1t1f4HE7Y9WwcJ2QCgD/Bog8chUCbwTC5KzhcAiSooa33R
 RPu/tOraMnIXmdRXzhydC7HVSmui1roX/wUZkkopot5kCIY+uQuyoVCRVUFaSXjo/xejUCPQG
 I/wBPWU0ufg27U3KlU/gFD1yfNxdJwhSXhTZIthy9JxsjfqFYm+cpAcy+ijHW7DOu6Ik=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272387>

We already have support in `git receive-pack` to deal with some legacy
repositories which have non-fatal issues.

Let's make `git fsck` itself useful with such repositories, too, by
allowing users to ignore known issues, or at least demote those issues
to mere warnings.

Example: `git -c fsck.missingEmail=3Dignore fsck` would hide
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
index 4e5fbea..bfccd2b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1250,6 +1250,17 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
=20
+fsck.<msg-id>::
+	Allows overriding the message type (error, warn or ignore) of a
+	specific message ID such as `missingEmail`.
++
+For convenience, fsck prefixes the error/warning with the message ID,
+e.g.  "missingEmail: invalid author/committer line - missing email" me=
ans
+that setting `fsck.missingEmail =3D ignore` will hide that issue.
++
+This feature is intended to support working with legacy repositories
+which cannot be repaired without disruptive changes.
+
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/builtin/fsck.c b/builtin/fsck.c
index fff38fe..adaa802 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -46,6 +46,16 @@ static int show_dangling =3D 1;
 #define DIRENT_SORT_HINT(de) ((de)->d_ino)
 #endif
=20
+static int fsck_config(const char *var, const char *value, void *cb)
+{
+	if (skip_prefix(var, "fsck.", &var)) {
+		fsck_set_msg_type(&fsck_obj_options, var, value);
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
index 7c5b3d5..1727129 100755
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
+	git -c fsck.multipleAuthors=3Dignore fsck
+'
+
 _bz=3D'\0'
 _bz5=3D"$_bz$_bz$_bz$_bz$_bz"
 _bz20=3D"$_bz5$_bz5$_bz5$_bz5"
--=20
2.3.1.windows.1.9.g8c01ab4
